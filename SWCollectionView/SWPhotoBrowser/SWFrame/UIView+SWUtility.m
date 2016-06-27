//
//  UIView+ZUtility.m
//
//  Created by shuaiWai on 28/7/15.
//  Copyright (c) 2015年 wai. All rights reserved.

#import "UIView+SWUtility.h"

@implementation UIView (SWUtility)

-(void)setSw_x:(CGFloat)sw_x
{
    CGRect frame = self.frame;
    frame.origin.x = sw_x;
    self.frame = frame;
}

-(void)setSw_y:(CGFloat)sw_y
{
    CGRect frame = self.frame;
    frame.origin.y = sw_y;
    self.frame = frame;
}

-(CGFloat)sw_x
{
    return self.frame.origin.x;
}

-(CGFloat)sw_y
{
    return self.frame.origin.y;
}

-(void)setSw_centerX:(CGFloat)sw_centerX
{
    CGPoint center = self.center;
    center.x = sw_centerX;
    self.center = center;
}

- (CGFloat)sw_centerX
{
    return self.center.x;
}

- (void)setSw_centerY:(CGFloat)sw_centerY
{
    CGPoint center = self.center;
    center.y = sw_centerY;
    self.center = center;
}

-(CGFloat)sw_centerY
{
    return self.center.y;
}

-(void)setSw_width:(CGFloat)sw_width
{
    CGRect frame = self.frame;
    frame.size.width = sw_width;
    self.frame = frame;
}

-(void)setSw_height:(CGFloat)sw_height
{
    CGRect frame = self.frame;
    frame.size.height = sw_height;
    self.frame = frame;
}

- (CGFloat)sw_height
{
    return self.frame.size.height;
}

- (CGFloat)sw_width
{
    return self.frame.size.width;
}

-(void)setSw_size:(CGSize)sw_size
{
    CGRect frame = self.frame;
    frame.size = sw_size;
    self.frame = frame;
}

-(CGSize)sw_size
{
    return self.frame.size;
}

- (void)setSw_origin:(CGPoint)sw_origin
{
    CGRect frame = self.frame;
    frame.origin = sw_origin;
    self.frame = frame;
}

- (CGPoint)sw_origin
{
    return self.frame.origin;
}

/** 设置锚点 */
- (CGPoint)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
    return anchorPoint;
}

@end
