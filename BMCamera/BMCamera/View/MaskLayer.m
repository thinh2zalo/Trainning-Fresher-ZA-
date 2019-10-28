//
//  MaskLayer.m
//  BMCamera
//
//  Created by Steve on 10/21/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "MaskLayer.h"

@interface MaskLayer()
@property (nonatomic) CGRect layerFrame;

@end

@implementation MaskLayer

- (void)layoutSublayers {
    self.frame = _layerFrame;

}

- (instancetype) initWithFrame:(CGRect) frame {
    self = [MaskLayer layer];
    if (self) {
        _layerFrame = frame;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path appendPath:[self squarePathWithCenter:CGPointMake(frame.size.width/2, frame.size.width/2) size:frame.size.width]];

         [path appendPath:[self circlePathWithCenter:CGPointMake(frame.size.width/2, frame.size.width/2) radius:frame.size.width/2]];
        self.path = path.CGPath;
//        self.fillColor = [UIColor clearColor].CGColor;
        self.fillRule = kCAFillRuleEvenOdd;
        self.opacity = 0.3;
//        self.backgroundColor  = ([UIColor whiteColor]).CGColor;


        
      
    }
    return self;
}

- (UIBezierPath *)squarePathWithCenter:(CGPoint)center size:(CGFloat)size   {
    CGFloat startX = center.x-size/2;
    CGFloat startY = center.y-size/2;

    UIBezierPath *squarePath = [UIBezierPath bezierPath];
    [squarePath moveToPoint:CGPointMake(startX, startY)];
    [squarePath addLineToPoint:CGPointMake(startX+size, startY)];
    [squarePath addLineToPoint:CGPointMake(startX+size, startY+size)];
    [squarePath addLineToPoint:CGPointMake(startX, startY+size)];
    [squarePath closePath];
    return squarePath;
  
}


- (UIBezierPath *)circlePathWithCenter:(CGPoint)center radius:(CGFloat)radius   {
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2)];
}



@end
