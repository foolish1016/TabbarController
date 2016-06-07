//
//  LCBigTabBarItem.m
//  IEmpolyeePorject
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 com. All rights reserved.
//

#import "LCBigTabBarItem.h"

@implementation LCBigTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel removeFromSuperview];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,2, 64, 64);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectZero;
}
@end
