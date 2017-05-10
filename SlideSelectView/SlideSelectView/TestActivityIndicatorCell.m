//
//  TestActivityIndicatorCell.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/10.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "TestActivityIndicatorCell.h"

@implementation TestActivityIndicatorCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews{
    UIActivityIndicatorView* activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:self.bounds];
    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhite;
    [activityIndicatorView startAnimating];
    [self addSubview:activityIndicatorView];
}

@end
