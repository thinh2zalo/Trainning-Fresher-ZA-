#import "CameraFocusView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CameraFocusView


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
//- (instancetype)init {

//        [self setBorderWidth:1.0];
//        [self setBorderColor:[UIColor whiteColor].CGColor];
//        CGSize size = self.frame.size;
//        CGRect rect = CGRectMake(0, 0, size.width, size.height);
//        UIBezierPath *endPath = [UIBezierPath bezierPath];
//        [endPath moveToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMinY(rect))];
//        [endPath addLineToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMinY(rect) + 5.0)];
//        [endPath moveToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + size.height / 2.0)];
//        [endPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - 5.0, CGRectGetMinY(rect) + size.height / 2.0)];
//        
//        [endPath moveToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMaxY(rect))];
//        [endPath addLineToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMaxY(rect) - 5.0)];
//        [endPath moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + size.height / 2.0)];
//        [endPath addLineToPoint:CGPointMake(CGRectGetMinX(rect) + 5.0, CGRectGetMinY(rect) + size.height / 2.0)];
//        
//        CAShapeLayer *extraLayer = [CAShapeLayer layer];
////        extraLayer.path = endPath.CGPath;
//        extraLayer.fillColor = [UIColor redColor].CGColor;
//        extraLayer.strokeColor = [UIColor redColor].CGColor;
//        extraLayer.lineWidth = 1.0;
////        [self addSublayer:extraLayer];
//    
//        CABasicAnimation* selectionAnimation = [CABasicAnimation
//                                                animationWithKeyPath:@"borderColor"];
//        selectionAnimation.toValue = (id)[UIColor colorWithRed:1.0 green:0.83 blue:0 alpha:0.95].CGColor;
//        selectionAnimation.repeatCount = 8;
//        [self addAnimation:selectionAnimation
//                          forKey:@"selectionAnimation"];
//        
    
//    return self;
//}
//@end

