#import "CameraFocusLayer.h"


@interface CameraFocusLayer()
@property (nonatomic) CGRect layerFrame;
@end

@implementation CameraFocusLayer

- (void)layoutSublayers {
    self.frame = _layerFrame;
}




- (instancetype) initWithFrame:(CGRect) frame {
    self = CameraFocusLayer.new;
    if (self) {
                [self setBorderWidth:1.0];
                [self setBorderColor:[UIColor whiteColor].CGColor];
                _layerFrame = frame;
                CGSize size =   frame.size;
                CGRect rect = CGRectMake(0, 0, size.width, size.height);

                UIBezierPath *endPath = [UIBezierPath bezierPath];
                [endPath moveToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMinY(rect))];
                [endPath addLineToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMinY(rect) + 5.0)];
                [endPath moveToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + size.height / 2.0)];
                [endPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - 5.0, CGRectGetMinY(rect) + size.height / 2.0)];

                [endPath moveToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMaxY(rect))];
                [endPath addLineToPoint:CGPointMake(CGRectGetMinX(rect) + size.width / 2.0, CGRectGetMaxY(rect) - 5.0)];
                [endPath moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + size.height / 2.0)];
                [endPath addLineToPoint:CGPointMake(CGRectGetMinX(rect) + 5.0, CGRectGetMinY(rect) + size.height / 2.0)];

                CAShapeLayer *extraLayer = [CAShapeLayer layer];
                extraLayer.path = endPath.CGPath;
                extraLayer.fillColor = [UIColor redColor].CGColor;
                extraLayer.strokeColor = [UIColor redColor].CGColor;
                extraLayer.lineWidth = 1.0;
                [self addSublayer:extraLayer];
                [self animationForLayer];
        
    }
    return self;
}

- (void)animationForLayer{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSNumber numberWithFloat:2.0f];
    scale.toValue = [NSNumber numberWithFloat:1.0f];
    scale.duration = 0.2;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 4;
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.5f];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    [self addAnimation:animation forKey:@"opacityOUT"];
    [self addAnimation:scale forKey:@"transform.scale"];
    
    CABasicAnimation* selectionAnimation = [CABasicAnimation
                                            animationWithKeyPath:@"borderColor"];
    selectionAnimation.toValue = (id)[UIColor colorWithRed:1.0 green:0.83 blue:0 alpha:0.95].CGColor;
    selectionAnimation.repeatCount = 8;
    [self addAnimation:selectionAnimation
                forKey:@"selectionAnimation"];
}


@end


