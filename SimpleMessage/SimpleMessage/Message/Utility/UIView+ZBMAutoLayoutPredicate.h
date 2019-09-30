//
//  UIView+ZBMAutoLayoutPredicate.h
//  SimpleMessage
//
//  Created by Steve on 9/30/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct {
    NSLayoutRelation relation;
    CGFloat multiplier;
    CGFloat constant;
    UILayoutPriority priority;
} ZBMAutoLayoutPredicate;

 ZBMAutoLayoutPredicate ZBMAutoLayoutPredicateMake(NSLayoutRelation relation, CGFloat multiplier, CGFloat constant, UILayoutPriority priority);

@interface UIView (ZBMAutoLayoutPredicate)

- (NSLayoutConstraint *)applyPredicate:(ZBMAutoLayoutPredicate)predicate toView:(id)viewOrLayoutGuide attribute:(NSLayoutAttribute)attribute;
- (NSLayoutConstraint *)applyPredicate:(ZBMAutoLayoutPredicate)predicate toView:(id)viewOrLayoutGuide fromAttribute:(NSLayoutAttribute)fromAttribute toAttribute:(NSLayoutAttribute)toAttribute;

@end
