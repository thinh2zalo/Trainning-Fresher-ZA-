//
//  UIView+ZBMAutoLayout.h
//  SimpleMessage
//
//  Created by Steve on 9/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZBMAutoLayout)
#pragma mark Generic constraint methods for two views

/// Align an attribute of one view to another.
- (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(id)view predicate:(NSString *)predicate;
+ (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute ofViews:(UIView *)ofViews toViews:(UIView *)toViews predicate:(NSString *)predicate ;

#pragma mark Constraining multiple edges of two views

/// Aligns all 4 edges to another view
- (NSArray <NSLayoutConstraint *> *)alignToView:(id)view;

/// Aligns all 4 edges to another view with different offset
+ (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)attribute ofViews:(UIView *)views toAttribute:(NSLayoutAttribute)toAttribute ofViews:(UIView *)toViews predicate:(NSString *)predicate;


/// Aligns the top and leading edges to another view
- (NSArray <NSLayoutConstraint *> *)alignTop:(NSString *)top leading:(NSString *)leading toView:(id)view;

/// Aligns the bottom and trailing edges to another view
- (NSArray <NSLayoutConstraint *> *)alignBottom:(NSString *)bottom trailing:(NSString *)trailing toView:(id)view;

/// Aligns the top and bottom edges to another view
- (NSArray <NSLayoutConstraint *> *)alignTop:(NSString *)top bottom:(NSString *)bottom toView:(id)view;

/// Aligns the leading and trailing edges to another view
- (NSArray <NSLayoutConstraint *> *)alignLeading:(NSString *)leading trailing:(NSString *)trailing toView:(id)view;


#pragma mark Constraining one edge of two views

/// Align the leading edge of this view to another
- (NSLayoutConstraint *)alignLeadingEdgeWithView:(id)view predicate:(NSString *)predicate;

/// Align the trailing edge of this view to another
- (NSLayoutConstraint *)alignTrailingEdgeWithView:(id)view predicate:(NSString *)predicate;

/// Align the top edge of this view to another
- (NSLayoutConstraint *)alignTopEdgeWithView:(id)view predicate:(NSString *)predicate;

/// Align the top edge of this view to another
- (NSLayoutConstraint *)alignBottomEdgeWithView:(id)view predicate:(NSString *)predicate;

/// Aligns the baseline edge of this view to another
- (NSLayoutConstraint *)alignBaselineWithView:(id)view predicate:(NSString *)predicate;

/// Aligns the center of X of this view to another
- (NSLayoutConstraint *)alignCenterXWithView:(id)view predicate:(NSString *)predicate;

/// Aligns the center of Y of this view to another
- (NSLayoutConstraint *)alignCenterYWithView:(id)view predicate:(NSString *)predicate;

/// Aligns the center of X and Y of this view to another
- (NSArray <NSLayoutConstraint *> *)alignCenterWithView:(id)view;


#pragma mark Constrain width & height of a view

/// Constrain both the width and height of self
- (NSArray <NSLayoutConstraint *> *)constrainWidth:(NSString *)widthPredicate height:(NSString *)heightPredicate;

/// Constrain the width of self
- (NSLayoutConstraint *)constrainWidth:(NSString *)widthPredicate;

/// Constrain the height of self
- (NSLayoutConstraint *)constrainHeight:(NSString *)heightPredicate;

/// Constrain the width of self to another view
- (NSLayoutConstraint *)constrainWidthToView:(id)view predicate:(NSString *)predicate;

/// Constrain the height of self to another view
- (NSLayoutConstraint *)constrainHeightToView:(id)view predicate:(NSString *)predicate;

/// Constrain the aspect ratio of self
- (NSLayoutConstraint *)constrainAspectRatio:(NSString *)predicate;


#pragma mark Spacing out two views

/// Attach self to flow horizontally _after_ `view`, self.trailing to view.leading
- (NSLayoutConstraint *)constrainLeadingSpaceToView:(id)view predicate:(NSString *)predicate;

/// Attach self to flow horizontally _before_ `view`, self.leading to view.trailing
- (NSLayoutConstraint *)constrainTrailingSpaceToView:(id)view predicate:(NSString *)predicate;

/// Attach self to flow vertically _after_ `view`, self.top to view.bottom
- (NSLayoutConstraint *)constrainTopSpaceToView:(id)view predicate:(NSString *)predicate;

/// Attach self to flow vertically _before_ `view`, self.bottom to view.top
- (NSLayoutConstraint *)constrainBottomSpaceToView:(id)view predicate:(NSString *)predicate;

@end

NS_ASSUME_NONNULL_END
