//
//  UIView+ZBMAutoLayout.m
//  SimpleMessage
//
//  Created by Steve on 9/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "UIView+ZBMAutoLayout.h"
#import "UIView+ZBMAutoLayoutPredicate.h"

@implementation UIView (ZBMAutoLayout)


#pragma mark Generic constraint methods for two views

- (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute toView:(id)view predicate:(NSString *)predicate
{
    UIView *views = view ? view : nil;
    
    return [UIView alignAttribute:attribute ofViews:self toViews:views predicate:predicate];
}

- (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(id)view predicate:(NSString *)predicate
{
    UIView *views = view ? view : nil;
    return [UIView alignAttribute:attribute ofViews:self toAttribute:toAttribute ofViews:views predicate:predicate];
}

#pragma mark Constrain multiple edges of two views

- (NSArray <NSLayoutConstraint *> *)alignToView:(id)view
{
    return [self alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:view];
}

- (NSArray <NSLayoutConstraint *> *)alignTop:(NSString *)top bottom:(NSString *)bottom toView:(id)view
{
    NSLayoutConstraint *topConstraints = [self alignTopEdgeWithView:view predicate:top];
    NSLayoutConstraint *bottomConstraints = [self alignBottomEdgeWithView:view predicate:bottom];
    return @[topConstraints, bottomConstraints];
}
- (NSArray <NSLayoutConstraint *> *)alignLeading:(NSString *)leading trailing:(NSString *)trailing toView:(id)view
{
    NSLayoutConstraint *leadingConstraints = [self alignLeadingEdgeWithView:view predicate:leading];
    NSLayoutConstraint *trailingConstraints = [self alignTrailingEdgeWithView:view predicate:trailing];
    return @[leadingConstraints, trailingConstraints];
}

- (NSArray <NSLayoutConstraint *> *)alignTop:(NSString *)top leading:(NSString *)leading bottom:(NSString *)bottom trailing:(NSString *)trailing toView:(id)view
{
    NSArray <NSLayoutConstraint *> *topLeadingConstraints = [self alignTop:top leading:leading toView:view];
    NSArray <NSLayoutConstraint *> *bottomTrailingConstraints = [self alignBottom:bottom trailing:trailing toView:view];
    return [topLeadingConstraints arrayByAddingObjectsFromArray: bottomTrailingConstraints];
}

- (NSArray <NSLayoutConstraint *> *)alignTop:(NSString *)top leading:(NSString *)leading toView:(id)view
{
    NSLayoutConstraint *topConstraints = [self alignTopEdgeWithView:view predicate:top];
    NSLayoutConstraint *leadingConstraints = [self alignLeadingEdgeWithView:view predicate:leading];
    return @[topConstraints, leadingConstraints];
}

- (NSArray <NSLayoutConstraint *> *)alignBottom:(NSString *)bottom trailing:(NSString *)trailing toView:(id)view
{
    NSLayoutConstraint *bottomConstraints = [self alignBottomEdgeWithView:view predicate:bottom];
    NSLayoutConstraint *trailingConstraints = [self alignTrailingEdgeWithView:view predicate:trailing];
    return @[bottomConstraints, trailingConstraints];
}


#pragma mark Constraining one edge of two views

- (NSLayoutConstraint *)alignLeadingEdgeWithView:(id)view predicate:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeLeading toView:view predicate:predicate];
}

- (NSLayoutConstraint *)alignTrailingEdgeWithView:(id)view predicate:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeTrailing toView:view predicate:predicate];
}

- (NSLayoutConstraint *)alignTopEdgeWithView:(id)view predicate:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeTop toView:view predicate:predicate];
}

- (NSLayoutConstraint *)alignBottomEdgeWithView:(id)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeBottom toView:view predicate:predicate];
}

- (NSLayoutConstraint *)alignBaselineWithView:(id)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeBaseline toView:view predicate:predicate];
}

- (NSLayoutConstraint *)alignCenterXWithView:(id)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeCenterX toView:view predicate:predicate];
}

- (NSLayoutConstraint *)alignCenterYWithView:(id)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeCenterY toView:view predicate:predicate];
}

- (NSArray <NSLayoutConstraint *> *)alignCenterWithView:(id)view
{
    NSLayoutConstraint *centerXConstraints = [self alignCenterXWithView:view predicate:@"0"];
    NSLayoutConstraint *centerYConstraints = [self alignCenterYWithView:view predicate:@"0"];
    return @[centerXConstraints, centerYConstraints];
}


#pragma mark Constrain width & height of a view

- (NSArray <NSLayoutConstraint *> *)constrainWidth:(NSString *)widthPredicate height:(NSString *)heightPredicate
{
    NSLayoutConstraint *widthConstraints = [self constrainWidth:widthPredicate];
    NSLayoutConstraint *heightConstraints = [self constrainHeight:heightPredicate];
    return @[widthConstraints, heightConstraints];
}

- (NSLayoutConstraint *)constrainWidth:(NSString *)widthPredicate
{
    return [self alignAttribute:NSLayoutAttributeWidth toView:nil predicate:widthPredicate];
}

- (NSLayoutConstraint *)constrainHeight:(NSString *)heightPredicate
{
    return [self alignAttribute:NSLayoutAttributeHeight toView:nil predicate:heightPredicate];
}

- (NSLayoutConstraint *)constrainWidthToView:(id)view predicate:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeWidth toView:view predicate:predicate];
}

- (NSLayoutConstraint *)constrainHeightToView:(id)view predicate:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeHeight toView:view predicate:predicate];
}

- (NSLayoutConstraint *)constrainAspectRatio:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeWidth toAttribute:NSLayoutAttributeHeight ofView:self predicate:predicate];
}


#pragma mark Spacing out two views

- (NSLayoutConstraint *)constrainLeadingSpaceToView:(id)view predicate:(NSString *)predicate
{
    return [self alignAttribute:NSLayoutAttributeLeading toAttribute:NSLayoutAttributeTrailing ofView:view predicate:predicate];
}

-(NSLayoutConstraint *)constrainTrailingSpaceToView:(UIView *)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeTrailing toAttribute:NSLayoutAttributeLeading ofView:view predicate:predicate];
}

- (NSLayoutConstraint *)constrainTopSpaceToView:(id)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofView:view predicate:predicate];
}

- (NSLayoutConstraint *)constrainBottomSpaceToView:(id)view predicate:(NSString *)predicate {
    return [self alignAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeTop ofView:view predicate:predicate];
}
#pragma mark Generic constraint methods for multiple views

+ (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute ofViews:(UIView *)ofViews toViews:(UIView *)toViews predicate:(NSString *)predicate {
    return [self alignAttribute:attribute ofViews:ofViews toAttribute:attribute ofViews:toViews predicate:predicate];
    
}

+ (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute ofViews:(UIView *)views toAttribute:(NSLayoutAttribute)toAttribute ofViews:(UIView *)toViews predicate:(NSString *)predicate {
     ZBMAutoLayoutPredicate predicatEmlement= ZBMAutoLayoutPredicateMake(NSLayoutRelationEqual, 1, [predicate floatValue], 0);
    return [views applyPredicate:predicatEmlement toView:toViews fromAttribute:attribute toAttribute:toAttribute];

}

@end
