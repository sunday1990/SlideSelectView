//
//  SlideSelectCell.m
//  SlideSelectView
//
//  Created by ccSunday on 2017/5/10.
//  Copyright © 2017年 ccSunday. All rights reserved.
//

#import "SlideSelectCell.h"


@implementation SlideSelectCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.userInteractionEnabled = YES;
    }
    return _titleLabel;
}

@end
