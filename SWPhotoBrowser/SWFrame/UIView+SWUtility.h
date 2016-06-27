//
//  UIView+SWUtility.h
//
//  Created by shuaiWai on 28/7/15.
//  Copyright (c) 2015年 wai. All rights reserved.
//


#import <UIKit/UIKit.h>


#define sWSrceen_WIDTH [UIScreen mainScreen].bounds.size.width
#define sWSrceen_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UIView (SWUtility)

@property (nonatomic, assign) CGFloat sw_x;
@property (nonatomic, assign) CGFloat sw_y;
@property (nonatomic, assign) CGFloat sw_centerX;
@property (nonatomic, assign) CGFloat sw_centerY;
@property (nonatomic, assign) CGFloat sw_width;
@property (nonatomic, assign) CGFloat sw_height;
@property (nonatomic, assign) CGSize sw_size;
@property (nonatomic, assign) CGPoint sw_origin;

/** 设置锚点 */
- (CGPoint)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;
@end
