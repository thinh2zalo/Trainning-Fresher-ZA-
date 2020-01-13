//
//  JETCell.m
//  JsonEditorTool
//
//  Created by Steve on 1/13/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "JETCell.h"

@interface JETCell()

@property (nonatomic, strong) UIPanGestureRecognizer * panGesture;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;
@property (nonatomic) float  currentOffset;
@property (nonatomic, strong) UIView * actionView;

@end
@implementation JETCell
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture == nil) {
        return;
    }
    JETCell * thisCell = (JETCell *) panGesture.view;
    CGPoint translation = [panGesture translationInView:self];
    NSLog(@"translation :%f", translation.x);
    if (translation.x <= 0 || self.state == JETSwipeStateLeft) {
        switch (panGesture.state) {
              case UIGestureRecognizerStateBegan: {
                  
                  if (thisCell.state == JETSwipeStateCenter) {
                      [self configureActionsView];
                  }
              }
                  
                  break;
              case UIGestureRecognizerStateChanged:{
                  CGPoint translation = [panGesture translationInView:self];
                  float currentOffset = 0;
                  if (self.state == JETSwipeStateLeft) {
                      currentOffset = 80;
                  }
                  self.contentView.frame = CGRectMake(translation.x - currentOffset, 0, self.frame.size.width, self.frame.size.height);
                  self.actionView.frame = CGRectMake(self.frame.size.width - currentOffset + translation.x, 0, self.frame.size.width, self.frame.size.height);
                  }
                  break;
                  
              case UIGestureRecognizerStateEnded:{
                  
                  self.currentOffset = self.frame.size.width - self.actionView.frame.origin.x;
                  if (self.currentOffset > 0) {
                      self.contentView.frame = CGRectMake(-80, 0, self.frame.size.width, self.frame.size.height);
                      self.actionView.frame = CGRectMake(self.frame.size.width - 80, 0, self.frame.size.width, self.frame.size.height);
                      thisCell.state = JETSwipeStateLeft;
                  }
                  
                  
                  CGPoint velocity = [panGesture velocityInView:panGesture.view];
                  CGPoint translateion = [panGesture translationInView:self];
                  if (velocity.x > 0  || translateion.x - 80 >= 0) {
                      [self hideSwipeCell];
                      
                  }
              }
                  
                  break;
              default:
                  break;
          }
    }
  
}


- (void)setEnableGesture:(BOOL)enable{
    for (UIGestureRecognizer * gesture in [(UICollectionView *) self.superview gestureRecognizers]) {
        if (gesture != self.panGesture) {
            [gesture setEnabled:enable];
        }
    }
}

- (void)configureActionsView{
    self.actionView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.height, self.frame.size.height);
    
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self hideSwipeCell];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"pointInside, %f", point.y);
    UICollectionView * parentView = (UICollectionView *)self.superview;
    CGPoint pointInSuperView = [self convertPoint:point toView:self.superview];
    for (UIView *cell in [parentView visibleCells]) {
        
        JETCell *collectionViewCell = (JETCell *)cell;
        if (collectionViewCell.state == JETSwipeStateLeft && ![collectionViewCell containsPoint:pointInSuperView]) {
            for (JETCell * cell in [parentView visibleCells]) {
                [cell hideSwipeCell];
            }
            
            return NO;
        }
    }
    
    
    return [self containsPoint:pointInSuperView];
}
- (void)hideSwipeCell {
    if (self.state != JETSwipeStateLeft) {
        return;
    }
    self.state = JETSwipeStateAnimatingToCenter;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.contentView.frame = CGRectMake(0, 0, weakSelf.frame.size.width, weakSelf.frame.size.height);
        weakSelf.actionView.frame = CGRectMake(self.frame.size.width, 0, weakSelf.frame.size.height, weakSelf.frame.size.height);
    } completion:^(BOOL finished) {
        weakSelf.currentOffset = 0;
        [weakSelf.actionView removeFromSuperview];
        weakSelf.actionView = nil;
        weakSelf.state = JETSwipeStateCenter;
        [self setEnableGesture:YES];
    }];
}
- (BOOL)containsPoint:(CGPoint)point {
    return point.y > CGRectGetMinY(self.frame) && point.y < CGRectGetMaxY(self.frame);
}

- (void)setup {
    self.currentOffset = 0;
    self.state = JETSwipeStateCenter;
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    
    _panGesture.delegate = self;
    _tapGesture.delegate = self;
    
    self.clipsToBounds = NO;
    
    [self addGestureRecognizer:self.panGesture];
    [self addGestureRecognizer:self.tapGesture];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.tapGesture) {
        for (UIView *cell in [(UICollectionView *)self.superview visibleCells]) {
            JETCell *collectionViewCell = (JETCell *)cell;
            if (collectionViewCell.state != JETSwipeStateCenter) {
                return YES;
            }
        }
        return NO;
    }
    
    if (gestureRecognizer == self.panGesture && gestureRecognizer.view && [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIView *view = gestureRecognizer.view;
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:view];
        return fabs(translation.y) <= fabs(translation.x);
    }
    
    return YES;
}


- (void)prepareForReuse {
    [self.actionView removeFromSuperview];
    self.actionView = nil;
}

- (UIView *)actionView {
    if (!_actionView) {
        _actionView = UIView.new;
        UITapGestureRecognizer * deleteAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteCell)];
        [_actionView addGestureRecognizer:deleteAction];
        _actionView.backgroundColor = [UIColor redColor];
        [self insertSubview:_actionView aboveSubview:self.contentView];
    }
    return _actionView;
}
@end
