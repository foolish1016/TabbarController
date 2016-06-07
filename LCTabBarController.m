//
//  LCTabBarController.m
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCTabBar.h"
#import "LCTabBarCONST.h"
#import "LCTabBarItem.h"

@interface LCTabBarController () <LCTabBarDelegate>
@property (nonatomic, strong) LCTabBar *lcTabBar;
@end
@implementation LCTabBarController
#pragma mark -

- (UIColor *)itemTitleColor {
    
    if (!_itemTitleColor) {
        
        _itemTitleColor = LCColorForTabBar(255, 255, 255);
    }
    return _itemTitleColor;
}

- (UIColor *)selectedItemTitleColor {
    
    if (!_selectedItemTitleColor) {
        
        _selectedItemTitleColor = LCColorForTabBar(255, 255, 255);
    }
    return _selectedItemTitleColor;
}

- (UIFont *)itemTitleFont {
    
    if (!_itemTitleFont) {
        
        _itemTitleFont = [UIFont systemFontOfSize:10.0f];
    }
    return _itemTitleFont;
}

- (UIFont *)badgeTitleFont {
    
    if (!_badgeTitleFont) {
        
        _badgeTitleFont = [UIFont systemFontOfSize:11.0f];
    }
    return _badgeTitleFont;
}

#pragma mark -

- (void)loadView {
    
    [super loadView];
    
    self.itemImageRatio = 0.70f;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //去掉tabbar的黑线
    [self.tabBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    [self.tabBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [self.tabBar addSubview:({
        LCTabBar *tabBar = [[LCTabBar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.backgroundColor =  [UIColor colorWithRed:(0x00)/255.0f green:(0xB3)/255.0f blue:(0xFF)/255.0f alpha:1.0f];
        tabBar.delegate  = self;
        self.lcTabBar = tabBar;
    })];
    
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//- (void)viewWillLayoutSubviews {
//    
//    [super viewWillLayoutSubviews];
//    
//    
//}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self removeOriginControls];
}

- (void)removeOriginControls {
    
    [self.tabBar.subviews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[UIControl class]]) {
            
            [obj removeFromSuperview];
        }
    }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    self.lcTabBar.badgeTitleFont         = self.badgeTitleFont;
    self.lcTabBar.itemTitleFont          = self.itemTitleFont;
    self.lcTabBar.itemImageRatio         = self.itemImageRatio;
    self.lcTabBar.itemTitleColor         = self.itemTitleColor;
    self.lcTabBar.selectedItemTitleColor = self.selectedItemTitleColor;
    self.lcTabBar.tabBarItemCount = viewControllers.count;
    for (NSInteger  index = 0; index < viewControllers.count; index++)
    {
        [self addChildViewController:viewControllers[index]];
        if (index == 2)
        {
            [self.lcTabBar addBigTabBarItem:((UIViewController*)viewControllers[index]).tabBarItem];
        }
        else
        {
            [self.lcTabBar addTabBarItem:((UIViewController*)viewControllers[index]).tabBarItem];

        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [super setSelectedIndex:selectedIndex];
    self.lcTabBar.selectedItem.selected = NO;
    self.lcTabBar.selectedItem = self.lcTabBar.tabBarItems[selectedIndex];
    self.lcTabBar.selectedItem.selected = YES;
}

#pragma mark - XXTabBarDelegate Method

- (void)tabBar:(LCTabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    if (self.selectedIndex == 2)
    {
    }
}

@end
