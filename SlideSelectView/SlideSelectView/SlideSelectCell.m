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
        _titleLabel.hidden = YES;
        [_titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _titleLabel;
}

#pragma mark 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        NSString *text = (NSString *)change[@"new"];
        if (text.length>0) {
            self.titleLabel.hidden = NO;
        }else{
            self.titleLabel.hidden = YES;
        }

    }
}

- (void)dealloc{
    [_titleLabel removeObserver:self forKeyPath:@"text"];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGPoint newPoint = [self convertPoint:point toView:self];
    if (self.titleLabel.hidden == YES) {
        return  [super hitTest:point withEvent:event];
    }else{
        if ([self.titleLabel pointInside:newPoint withEvent:event]) {
            return self;
        }else{
            return  [super hitTest:point withEvent:event];
        }
    
    }
}
@end
