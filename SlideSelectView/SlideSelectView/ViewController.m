//
//  ViewController.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/5.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "ViewController.h"
#import "SlideSelectView.h"

//Test
#import "TestCell.h"
#import "TestActivityIndicatorCell.h"

#import <SVProgressHUD/SVProgressHUD.h>
#define WIDTH  ([[UIScreen mainScreen]bounds].size.width)
#define HEIGHT ([[UIScreen mainScreen]bounds].size.height)

@interface ViewController ()<SlideSelectViewDelegate,SlideSelectViewDataSource>
{

    SlideSelectView *slideSelectView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    slideSelectView = [[SlideSelectView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT)];
    slideSelectView.delegate = self;
    slideSelectView.dataSource = self;
    slideSelectView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:slideSelectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark SlideViewDataSource
/**
 组的header上有多少列
 
 @param view view description
 @param group group description
 @return return value description
 */
- (NSInteger)slideSelectView:(SlideSelectView *)view numberOfColumnsInGroup:(NSInteger)group{
    if (group == 0) {
        return 20;
    }
        return 7;
}

/**
 每一列对应有多少item
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSInteger)slideSelectView:(SlideSelectView *)view numberOfItemsAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        if (index.column == 0) {
            return 20;
        }else if (index.column == 1){
            return 10;
        }else if (index.column == 2){
            return 5;
        }else{
            return 15;
        }
    }else{
        if (index.column == 0) {
            return 200;
        }else if (index.column == 1){
            return 10;
        }else if (index.column == 2){
            return 5;
        }else{
            return 15;
        }
    }
}
/**
 一共有多少组
 
 @param view view description
 @return return value description
 */

- (NSInteger)numberOfGroupsInSlideSelectView:(SlideSelectView *)view{
    return 3;
}


/**
 返回header上列的标题
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSString *)slideSelectView:(SlideSelectView *)view titleForColumnAtIndex:(SlideSelectIndex *)index{
    return @"北京";
}

- (SlideSelectCell *)slideSelectView:(SlideSelectView *)view cellForItemAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
#warning 这里的selectCell的宽度与高度必须与代理方法中给出的一致
        if (index.item%2 == 1) {
            TestActivityIndicatorCell *cell = [[TestActivityIndicatorCell alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            return cell;
        }else{
            SlideSelectCell *cell = [[SlideSelectCell alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
            cell.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.text = [NSString stringWithFormat:@"%ld",index.item];
            return cell;
        }
        
    }else if(index.group == 1){
        TestCell *cell = [[TestCell alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        return cell;

//        if (index.item%2==0) {
//#warning 这里的TestCell的frame可以不设置的，可以直接从代理中获得。
//            
//            TestCell *cell = [[TestCell alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//            return cell;
//        }else{
//            SlideSelectCell *cell = [[SlideSelectCell alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
//            cell.backgroundColor = [UIColor whiteColor];
//            cell.titleLabel.text = [NSString stringWithFormat:@"%ld",index.item];
//
//            //    cell.titleLabel.textColor = [UIColor whiteColor];
//            return cell;
//        }

    }else{
        SlideSelectCell *cell = [[SlideSelectCell alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.cornerRadius = 2;
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld",index.item];
        //    cell.titleLabel.textColor = [UIColor whiteColor];
        return cell;
    }
}


#pragma mark SlideViewDelegate

/**
 返回每个column元素的宽度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view widthForColumnAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        return 40;
    }
    return 80;
}

/**
 返回每个column元素的高度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view heightForColumnAtIndex:(SlideSelectIndex *)index
{
    return 20;
}

- (CGFloat)slideSelectView:(SlideSelectView *)view heightForContentViewAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        return 150;
    }else{
        return 300;
    }
}

- (CGFloat)slideSelectView:(SlideSelectView *)view verticalSpaceBetweenItemsAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        return 20;
    }else if (index.group == 1){
        return 25;
    }else{
        return 15;
    }
}


/**
 返回column元素之间的间隔距离
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view spaceBetweenColumnAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        return 15;
    }
        return 30;
}

/**
 返回每行row的默认item数量
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSInteger)slideSelectView:(SlideSelectView *)view defaultItemNumsOfEveryRowAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        return 4;
    }else if (index.group == 1){
        return 10;
    }else{
        return 5;
    }
}

/**
 返回每个item的高度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view heightForItemAtIndex:(SlideSelectIndex *)index{
    if (index.group == 1) {
        return 20;
        if (index.item%2==0) {
            return 20;
        }else{
            return 25;
        }
    }else if(index.group == 0){
        if (index.group%2==1) {
            return 20;
        }else{
            return 25;
        }
    }else{
        return 25;
    }
}

/**
 返回每个item的宽度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view widthForItemAtIndex:(SlideSelectIndex *)index{
    if (index.group == 1) {
        return 20;
        
        if (index.item%2==0) {
            return 20;
        }else{
            return 40;
        }
        
    }else if(index.group == 0 ){
        if (index.item%2==1) {
            return 20;
        }else{
            return 40;
        }
        
    }else{
        return 40;
    }
}
/**
 选中某一个item
 
 @param view view description
 @param index index description
 */

- (void)slideSelectView:(SlideSelectView *)view didSelectItemAtIndex:(SlideSelectIndex *)index{
    NSLog(@"group:%ld \ncolumn:%ld \nitem:%ld\n",index.group,index.column,index.item);
    [SVProgressHUD showSuccessWithStatus: [NSString stringWithFormat:@"select item ---> group=%ld\ncolumn=%ld\nitem=%ld",index.group,index.column,index.item]];
}

/**
 返回item所对应的标题
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSString *)slideSelectView:(SlideSelectView *)view titleForItemAtIndex:(SlideSelectIndex *)index{
    return @"武汉";
}
@end
