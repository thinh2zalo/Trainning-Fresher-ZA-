//
//  UIView+ZBMAutoLayoutPredicate.m
//  SimpleMessage
//
//  Created by Steve on 9/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//
#import "UIView+ZBMAutoLayoutPredicate.h"

ZBMAutoLayoutPredicate ZBMAutoLayoutPredicateMake(NSLayoutRelation relation, CGFloat multiplier, CGFloat constant, UILayoutPriority priority) {
    ZBMAutoLayoutPredicate predicate;
    predicate.relation = relation;
    predicate.multiplier = multiplier;
    predicate.constant = constant;
    predicate.priority = priority;
    return predicate;
}


@implementation UIView (ZBMAutoLayoutPredicate)


- (NSLayoutConstraint *)applyPredicate:(ZBMAutoLayoutPredicate)predicate toView:(id)viewOrLayoutGuide attribute:(NSLayoutAttribute)attribute {
    return [self applyPredicate:predicate toView:viewOrLayoutGuide fromAttribute:attribute toAttribute:attribute];
}

- (NSLayoutConstraint *)applyPredicate:(ZBMAutoLayoutPredicate)predicate toView:(id)viewOrLayoutGuide fromAttribute:(NSLayoutAttribute)fromAttribute toAttribute:(NSLayoutAttribute)toAttribute {
    if (predicate.priority > UILayoutPriorityRequired) return nil;
    UIView *commonSuperview;
    commonSuperview = [self commonSuperviewWithView:viewOrLayoutGuide];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:fromAttribute
                                                                  relatedBy:predicate.relation
                                                                     toItem:viewOrLayoutGuide
                                                                  attribute:toAttribute
                                                                 multiplier:predicate.multiplier
                                                                   constant:predicate.constant];
    if (predicate.priority) {
        constraint.priority = predicate.priority;
    }
    
    [commonSuperview addConstraint:constraint];
    
    return constraint;
}

- (UIView *)commonSuperviewWithView:(UIView *)view {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
    if ([view isKindOfClass:[UILayoutGuide class]]) {
        UILayoutGuide *guide = (UILayoutGuide *)view;
        return guide.owningView;
    }
#endif
    
    if (!view || self == view) {
        return self;
    } else if (self.superview == view) {
        return view;
    } else if (self == view.superview) {
        return self;
    } else if (self.superview == view.superview) {
        return self.superview;
    } else {
        UIView *commonSuperview = [self traverseViewTreeForCommonSuperViewWithView:view];
        NSAssert(commonSuperview, @"Cannot find common superview of %@ and %@. Did you forget to call addSubview: before adding constraints?", self, view);
        return commonSuperview;
    }
}

- (UIView *)traverseViewTreeForCommonSuperViewWithView:(UIView *)view {
    NSMutableOrderedSet *selfSuperviews = [NSMutableOrderedSet orderedSet];
    UIView *selfSuperview = self;
    while (selfSuperview) {
        [selfSuperviews addObject:selfSuperview];
        selfSuperview = selfSuperview.superview;
    }
    UIView *superview = view;
    while (superview) {
        if ([selfSuperviews containsObject:superview]) {
            return superview;
        }
        superview = superview.superview;
    }
    return nil;
}

@end
