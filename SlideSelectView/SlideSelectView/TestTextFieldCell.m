//
//  TestTextFieldCell.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/10.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "TestTextFieldCell.h"

@implementation TestTextFieldCell

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
    UITextField *textField = [[UITextField alloc]initWithFrame:self.bounds];
    textField.placeholder = @"请输入";
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    textField.layer.borderWidth = 0.5;
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor whiteColor];
    [self addSubview:textField];
    
}


@end
