//
//  SlideSelectView.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/5.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "SlideSelectView.h"
#import "UIView+frame.h"

#define K_DefaultBorderSpace  12
#define K_DefaultItemSpace  20


#define K_DefaultColumnTag 123456
#define K_DefaultItemTag   100

#define CornerRadius(view,radius) view.layer.cornerRadius = radius;

@interface SlideSelectView ()

@property (nonatomic,strong)UIScrollView *slideSelectScrollView;

@property (nonatomic,strong)NSMutableArray *groupIndexArray;
//存放所有contentView的字典
@property (nonatomic,strong)NSMutableDictionary *contentViewDic;
//存放所有headerView的字典
@property (nonatomic,strong)NSMutableDictionary *headerViewDic;

@end

@implementation SlideSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.slideSelectScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.slideSelectScrollView.showsVerticalScrollIndicator = YES;
        [self addSubview:self.slideSelectScrollView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self setupSubviews];
}

- (void)setupSubviews{
    CGFloat headerTop;
    NSInteger group;
    //获取组数
    if ([self.dataSource respondsToSelector:@selector(numberOfGroupsInSlideSelectView:)]) {
        group = [self.dataSource numberOfGroupsInSlideSelectView:self];
    }else{
        group = 1;
    }
    for (int i =0 ; i<group; i++) {                     //group
        NSInteger columnNum = [self.dataSource slideSelectView:self numberOfColumnsInGroup:i];
        NSMutableArray *columnIndexArray = [NSMutableArray array];
        for (int j = 0; j<columnNum; j++) {             //column
            SlideSelectIndex *columnIndex = [SlideSelectIndex slideSelectIndexWithGroup:i column:j item:0];
            [columnIndexArray addObject:columnIndex];
        }
        //将每一组的column元素存入group
        [self.groupIndexArray addObject:columnIndexArray];
        
        CGFloat columnHeight;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSelectView:heightForColumnAtIndex:)]) {
            //获取column元素的高度，只考虑一样的情况。
            columnHeight = [self.delegate slideSelectView:self heightForColumnAtIndex:columnIndexArray[0]];
        }
        //创建headerview,并且要将column元素加上去,需要给column元素添加点击事件，点击后可以刷新下面的contentview。
        UIScrollView *headerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headerTop, self.width,K_DefaultBorderSpace*2+ columnHeight)];
        headerView.userInteractionEnabled = YES;
        headerView.showsHorizontalScrollIndicator = YES;
        //计算contentsize
        headerView.contentSize = CGSizeMake([self contentWidthOfHeaderViewAtIndex:self.groupIndexArray[i][0]], K_DefaultBorderSpace*2+ columnHeight);
        headerView.backgroundColor = [UIColor whiteColor];
        [self.headerViewDic setObject:headerView forKey:[NSString stringWithFormat:@"%d",i]];
        [self.slideSelectScrollView addSubview:headerView];
        /*
         创建headerview的内容，从代理中获取相关参数。并且需要添加点击事件，以及开放更新接口。
         */
        [self configHeaderView:headerView atIndex:self.groupIndexArray[i][0]];
        
        //计算contentview区域的高度
        CGFloat contentSizeHeight = [self heightOfContentViewAtIndex:self.groupIndexArray[i][0]];
        CGFloat viewHeight;

        //创建contentview，并且将item元素加上去
        if ([self.delegate respondsToSelector:@selector(slideSelectView:heightForContentViewAtIndex:)]) {
            viewHeight = [self.delegate slideSelectView:self heightForContentViewAtIndex:self.groupIndexArray[i][0]];
        }else{
            viewHeight = 200;
        }
        
        UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.bottom, self.width, viewHeight)];
        contentView.contentSize = CGSizeMake(self.width, contentSizeHeight);
        //保存contentViewDic
        [self.contentViewDic setObject:contentView forKey:[NSString stringWithFormat:@"%d",i]];
        
        contentView.backgroundColor = [UIColor blackColor];
        [self.slideSelectScrollView addSubview:contentView];
        [self configContentView:contentView atIndex:self.groupIndexArray[i][0]];
        headerTop += headerView.height+contentView.height;
    }
    self.slideSelectScrollView.contentSize = CGSizeMake(self.width, headerTop);
}

//创建headerview的内容
- (void)configHeaderView:(UIScrollView *)scrollView atIndex:(SlideSelectIndex *)index{
    //获取对应group的column个数
    NSInteger columnNums = [self.dataSource slideSelectView:self numberOfColumnsInGroup:index.group];
    //获取column的宽度
    CGFloat columnWidth = [self.delegate slideSelectView:self widthForColumnAtIndex:index];
    
    //获取column的高度
    CGFloat columnHeight = [self.delegate slideSelectView:self heightForColumnAtIndex:index];
    
    //获取column之间的space
    
    CGFloat columnSpace = [self.delegate slideSelectView:self spaceBetweenColumnAtIndex:index];
    
    
    for (int i = 0; i<columnNums; i++) {
        //获取column标题
        NSString *columnTitle = [self.dataSource slideSelectView:self titleForColumnAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
//        btn.backgroundColor = [UIColor greenColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(K_DefaultBorderSpace+(columnSpace+columnWidth)*i, K_DefaultBorderSpace, columnWidth, columnHeight);
        
        btn.tag = K_DefaultColumnTag*(index.group+1) + i;
        
        [btn addTarget:self action:@selector(columnDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        CornerRadius(btn, btn.height/2);
        btn.layer.borderWidth = 0.2;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [btn setTitle:columnTitle forState:UIControlStateNormal];
        [scrollView addSubview:btn];
    }
}

#pragma mark 创建contentView的内容，先做的简单点，不考虑定制元素的情况。
- (void)configContentView:(UIScrollView *)scrollView atIndex:(SlideSelectIndex *)index{

    //每次移除都进行移除吧还是，因为每个column对应的item数目并不是固定的。
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    //获取column对应的总item数目
    NSInteger totalItemNums;
    totalItemNums = [self.dataSource slideSelectView:self numberOfItemsAtIndex:index];
    
    //获取单行的item数目
    NSInteger perRowItemNums;
    perRowItemNums = [self.delegate slideSelectView:self defaultItemNumsOfEveryRowAtIndex:index];
    
    //行数目
    NSInteger rowNums;
    rowNums = totalItemNums % perRowItemNums==0 ? totalItemNums/perRowItemNums : (totalItemNums/perRowItemNums)+1;
    
    //单个item高度
    CGFloat itemHeight;
    itemHeight = [self.delegate slideSelectView:self heightForItemAtIndex:index];
    
    //单个item宽度
    CGFloat itemWidth;
    itemWidth = [self.delegate slideSelectView:self widthForItemAtIndex:index];
    
    CGFloat itemSpace = ((self.width-2*K_DefaultBorderSpace)-perRowItemNums*itemWidth)/(perRowItemNums-1);
    for (int i = 0; i<rowNums; i++) {
        for (int j = 0; j<perRowItemNums; j++) {
            if (i*perRowItemNums+j == totalItemNums) {
                break;
            }
            NSString *itemTitle = [self.dataSource slideSelectView:self titleForItemAtIndex:index];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
//            btn.backgroundColor = [UIColor grayColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(K_DefaultBorderSpace+(itemSpace+itemWidth)*j, K_DefaultBorderSpace+(K_DefaultItemSpace+itemHeight)*i, itemWidth, itemHeight);
            [btn addTarget:self action:@selector(itemDidSelected:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag =K_DefaultColumnTag*(index.group + 1) + K_DefaultItemTag*(index.column)+i*perRowItemNums+j;
//            CornerRadius(btn, btn.height/2);
            [btn setTitle:itemTitle forState:UIControlStateNormal];
            [scrollView addSubview:btn];
        }
    }
    //高度
    CGFloat contentHeight;
    contentHeight = 2*K_DefaultBorderSpace + (rowNums - 1)*K_DefaultItemSpace+rowNums*itemHeight;
    scrollView.contentSize = CGSizeMake(self.width, contentHeight);
}


//返回headerView的高度
- (CGFloat)contentWidthOfHeaderViewAtIndex:(SlideSelectIndex *)index{
    //获取对应group的column个数
    NSInteger columnNums = [self.dataSource slideSelectView:self numberOfColumnsInGroup:index.group];
    //获取column的宽度
    CGFloat columnWidth = [self.delegate slideSelectView:self widthForColumnAtIndex:index];
    
    //获取column之间的space
    
    CGFloat columnSpace = [self.delegate slideSelectView:self spaceBetweenColumnAtIndex:index];
    
    return K_DefaultBorderSpace*2+columnNums*columnWidth+(columnNums-1)*columnSpace;
}

//返回contentView的高度
- (CGFloat)heightOfContentViewAtIndex:(SlideSelectIndex *)index{
    
    //获取column对应的总item数目
    NSInteger totalItemNums;
    totalItemNums = [self.dataSource slideSelectView:self numberOfItemsAtIndex:index];
    
    //获取单行的item数目
    NSInteger perRowItemNums;
    perRowItemNums = [self.delegate slideSelectView:self defaultItemNumsOfEveryRowAtIndex:index];
    
    //行数目
    NSInteger rowNums;
    rowNums = totalItemNums % perRowItemNums==0? totalItemNums/perRowItemNums : (totalItemNums/perRowItemNums+1);
    
    //单个item高度
    CGFloat itemHeight;
    itemHeight = [self.delegate slideSelectView:self heightForItemAtIndex:index];
    
    //高度
    CGFloat contentHeight;
    contentHeight = 2*K_DefaultBorderSpace + (rowNums - 1)*K_DefaultItemSpace+rowNums*itemHeight;
    
    return contentHeight;
}


#pragma mark 刷新指定Column对应的items
- (void)reloadItemsAtColumn:(SlideSelectIndex *)index{
    UIScrollView *scrollView = [self.contentViewDic objectForKey:[NSString stringWithFormat:@"%ld",index.group]];
    [self configContentView:scrollView atIndex:index];
}

#pragma mark column元素被点击
- (void)columnDidSelected:(UIButton *)columnBtn{
    NSInteger tag = columnBtn.tag;
    NSInteger group = tag/K_DefaultColumnTag-1;
    NSInteger column = tag%K_DefaultColumnTag;
    SlideSelectIndex *columnIndex = self.groupIndexArray[group][column];
    UIScrollView *scrollView = [self.contentViewDic objectForKey:[NSString stringWithFormat:@"%ld",columnIndex.group]];
    [self configContentView:scrollView atIndex:columnIndex];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(slideSelectView:didSelectColumnAtIndex:)]) {
        [self.delegate slideSelectView:self didSelectColumnAtIndex:columnIndex];
    }
}

#pragma mark item元素被点击
- (void)itemDidSelected:(UIButton *)itemBtn{
    NSInteger tag = itemBtn.tag;
    //通过tag求出group与column
    NSLog(@"itemTag:%ld",tag);
    NSInteger group = tag/K_DefaultColumnTag - 1;
    NSInteger column = (tag - K_DefaultColumnTag*(group+1))/K_DefaultItemTag;
    NSInteger item = (tag - K_DefaultColumnTag*(group+1))%K_DefaultItemTag;
    SlideSelectIndex *itemIndex = [SlideSelectIndex slideSelectIndexWithGroup:group column:column item:item];

    if (self.delegate && [self.delegate respondsToSelector:@selector(slideSelectView:didSelectItemAtIndex:)]) {
        [self.delegate slideSelectView:self didSelectItemAtIndex:itemIndex];
    }
    NSLog(@"group:%ld \ncolumn:%ld \nitem:%ld\n",group,column,item);
}

- (void)reloadData{
    //开发中
    
    
    
}

- (void)reloadDataAtIndex:(SlideSelectIndex *)index{
    //开发中

}


- (NSMutableArray *)groupIndexArray{
    if (!_groupIndexArray) {
        _groupIndexArray = [NSMutableArray array];
    }
    return _groupIndexArray;
}

- (NSMutableDictionary *)contentViewDic{
    if (!_contentViewDic) {
        _contentViewDic = [NSMutableDictionary dictionary];
    }
    return _contentViewDic;
}

- (NSMutableDictionary *)headerViewDic{
    if (!_headerViewDic) {
        _headerViewDic = [NSMutableDictionary dictionary];
    }
    return _headerViewDic;
}

@end

@implementation SlideSelectIndex

+ (instancetype)slideSelectIndexWithGroup:(NSInteger)group column:(NSInteger)column item:(NSInteger)item{
    SlideSelectIndex *index = [[SlideSelectIndex alloc]initWithGroup:group column:column item:item];
    return index;
}

- (instancetype)initWithGroup:(NSInteger)group column:(NSInteger)column item:(NSInteger)item{
    if (self = [super init]) {
        self.group = group;
        self.column = column;
        self.item = item;        
    }
    return self;
}
@end