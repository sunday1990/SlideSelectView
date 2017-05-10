//
//  TestCell.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/10.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = self.bounds;
    
    [btn setImage:[UIImage imageNamed:@"house"] forState:UIControlStateSelected];
    
    [btn setImage:[UIImage imageNamed:@"house_blue"] forState:UIControlStateNormal];
    
    btn.contentMode = UIViewContentModeScaleAspectFill;
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];

}

- (void)btnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
}



@end
