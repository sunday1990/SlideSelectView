//
//  SlideSelectView.h
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/5.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideSelectCell.h"

@interface SlideSelectIndex : NSObject

/**
 组数（一个横向scrollview与一个竖向scrollview为一个组）
 */
@property (nonatomic, assign) NSInteger group;
/**
 横向scrollview上的的第几列
 */
@property (nonatomic, assign) NSInteger column;
/**
 纵向scrollview的第几个item
 */
@property (nonatomic, assign) NSInteger item;

+ (instancetype)slideSelectIndexWithGroup:(NSInteger)group
                                   column:(NSInteger)column
                                     item:(NSInteger)item;
@end


@class SlideSelectView;

@protocol SlideSelectViewDelegate <NSObject>

@optional

/**
 返回每个column元素的宽度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view widthForColumnAtIndex:(SlideSelectIndex *)index;

/**
 返回每个column元素的高度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view heightForColumnAtIndex:(SlideSelectIndex *)index;

/**
 返回contentView的固定高度

 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view heightForContentViewAtIndex:(SlideSelectIndex *)index;

/**
 返回column元素之间的间隔距离
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view spaceBetweenColumnAtIndex:(SlideSelectIndex *)index;


/**
 返回item元素之间的竖直间距
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view verticalSpaceBetweenItemsAtIndex:(SlideSelectIndex *)index;

/**
 返回每行row的默认item数量
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSInteger)slideSelectView:(SlideSelectView *)view defaultItemNumsOfEveryRowAtIndex:(SlideSelectIndex *)index;


/**
 返回每个item的高度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view heightForItemAtIndex:(SlideSelectIndex *)index;


/**
 返回每个item的宽度
 
 @param view view description
 @param index index description
 @return return value description
 */
- (CGFloat)slideSelectView:(SlideSelectView *)view widthForItemAtIndex:(SlideSelectIndex *)index;


/**
 选中某一个columm

 @param view view description
 @param index index description
 */
- (void)slideSelectView:(SlideSelectView *)view didSelectColumnAtIndex:(SlideSelectIndex *)index;

/**
 选中某一个item

 @param view view description
 @param index index description
 */
- (void)slideSelectView:(SlideSelectView *)view didSelectItemAtIndex:(SlideSelectIndex *)index;


@end


@protocol SlideSelectViewDataSource <NSObject>

@required

/**
 组的header上有多少列
 
 @param view view description
 @param group group description
 @return return value description
 */
- (NSInteger)slideSelectView:(SlideSelectView *)view numberOfColumnsInGroup:(NSInteger)group;

/**
 每一列对应有多少item
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSInteger)slideSelectView:(SlideSelectView *)view numberOfItemsAtIndex:(SlideSelectIndex *)index;
/**
 返回每个item所对应的元素view
 
 @param view view description
 @param index index description
 @return return value description
 */
- (SlideSelectCell *)slideSelectView:(SlideSelectView *)view cellForItemAtIndex:(SlideSelectIndex *)index;


@optional

/**
 返回header上列的标题
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSString *)slideSelectView:(SlideSelectView *)view titleForColumnAtIndex:(SlideSelectIndex *)index;

/**
 返回item所对应的标题
 
 @param view view description
 @param index index description
 @return return value description
 */
- (NSString *)slideSelectView:(SlideSelectView *)view titleForItemAtIndex:(SlideSelectIndex *)index;

/**
 一共有多少组
 
 @param view view description
 @return return value description
 */
- (NSInteger)numberOfGroupsInSlideSelectView:(SlideSelectView *)view;

@end

@interface SlideSelectView : UIView

@property (nonatomic, weak, nullable) id <SlideSelectViewDelegate> delegate;

@property (nonatomic, weak, nullable) id <SlideSelectViewDataSource> dataSource;

////- (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
//
//- (UIView *)dequeueReusableViewWithIdentifier:(NSString *)identifier;

/**
 回到起始状态
 */
- (void)reloadData;


/**
 会对一个headerView以及column所对应的contentView进行刷新,

 @param index index description
 */
- (void)reloadDataAtIndex:(SlideSelectIndex *)index;

@end
