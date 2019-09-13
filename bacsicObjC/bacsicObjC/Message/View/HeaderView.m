//
//  HeaderView.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/13/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()


@end

@implementation HeaderView
- (void)layoutSubviews {
    [self.titleTopConstraint.heightAnchor constraintEqualToConstant:20];
    [self.titleTopConstraint.widthAnchor constraintEqualToConstant:100];
    [self.titleTopConstraint.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
}
- (UILabel *)titleTopConstraint {
    if (!_titleTopConstraint) {
        _titleTopConstraint = UILabel.new;
        _titleTopConstraint.translatesAutoresizingMaskIntoConstraints = false;
        _titleTopConstraint.text = @"MESSAGE";
        [self addSubview:_titleTopConstraint];
    }
    return  _titleTopConstraint;
}

- (UILabel *)titleLogoConstraint {
    if (!_titleLogoConstraint) {
        _titleLogoConstraint = UILabel.new;
    }
    return  _titleLogoConstraint;
}

@end
