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
//    [self.titleTopConstraint.heightAnchor constraintEqualToConstant:20];
//    [self.titleTopConstraint.widthAnchor constraintEqualToConstant:100];
//    [self.titleBotConstraint.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = true;
//    [self.titleTopConstraint.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-30
//     ].active = true;

    [self.titleBotConstraint.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = true;
}
- (UILabel *)titleBotConstraint {
    if (!_titleBotConstraint) {
        _titleBotConstraint = UILabel.new;
        [_titleBotConstraint setFont:[UIFont boldSystemFontOfSize:44]];

        _titleBotConstraint.translatesAutoresizingMaskIntoConstraints = false;
        _titleBotConstraint.text = @"MESSAGE";
        [self addSubview:_titleBotConstraint];
    }
    return  _titleBotConstraint;
}

- (UILabel *)titleTopConstraint {
    if (!_titleTopConstraint) {
        _titleTopConstraint = UILabel.new;
        [_titleTopConstraint setFont:[UIFont boldSystemFontOfSize:30]];
        
        _titleTopConstraint.translatesAutoresizingMaskIntoConstraints = false;
        _titleTopConstraint.text = @"Message";
        [self addSubview:_titleTopConstraint];
    }
    return  _titleTopConstraint;
}

@end
