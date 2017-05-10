//
//  ViewController.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/5.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "ViewController.h"
#import "SlideSelectView.h"
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
            return 20;
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
        return 3;
    }else{
        return 2;
    }
}

/**
 返回每个item的高度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view heightForItemAtIndex:(SlideSelectIndex *)index{

    return 25;
}

/**
 返回每个item的宽度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view widthForItemAtIndex:(SlideSelectIndex *)index{
    if (index.group == 0) {
        return 50;
    }else{
        return 100;
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
