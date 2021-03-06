//
//  GroupAvatarView.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "GroupAvatarView.h"

@implementation GroupAvatarView


- (void)layoutSubviews {
    [super layoutSubviews];
    float heightOfEachAvatarView = self.frame.size.height /2;
    float widthOfEachAvatarView = self.frame.size.width /2;
    self.arrAvatarView[0].frame = CGRectMake(0, 0, widthOfEachAvatarView, heightOfEachAvatarView);
    
    self.arrAvatarView[1].frame = CGRectMake(widthOfEachAvatarView, 0 , widthOfEachAvatarView, heightOfEachAvatarView);
    self.arrAvatarView[2].frame = CGRectMake(0, heightOfEachAvatarView , widthOfEachAvatarView, heightOfEachAvatarView);
    self.arrAvatarView[3].frame = CGRectMake(widthOfEachAvatarView, heightOfEachAvatarView , widthOfEachAvatarView, heightOfEachAvatarView);
    self.remainingAmountLabel.frame = CGRectMake(widthOfEachAvatarView, heightOfEachAvatarView , widthOfEachAvatarView, heightOfEachAvatarView);
    self.remainingAmountLabel.layer.cornerRadius = self.remainingAmountLabel.frame.size.width / 2;

    for ( int i = 0 ; i <= 3 ; i ++) {
        self.arrAvatarView[i].layer.cornerRadius = self.arrAvatarView.firstObject.frame.size.width / 2;
        self.arrAvatarView[i].layer.borderWidth = 3.0f;
        self.arrAvatarView[i].layer.borderColor = [UIColor whiteColor].CGColor;
        self.arrAvatarView[i].clipsToBounds = true;
    }
    
    
    
    
}

- (NSMutableArray<UIImageView *> *)arrAvatarView {
    if (!_arrAvatarView) {
        _arrAvatarView = NSMutableArray.new;
        for (int i = 0 ; i <=3 ; i ++) {
            _arrAvatarView[i] = UIImageView.new;
            [self addSubview:_arrAvatarView[i]];
        }
    }
    return _arrAvatarView;
    
}

- (UILabel *)remainingAmountLabel {
    if (!_remainingAmountLabel) {
        _remainingAmountLabel = UILabel.new;
        _remainingAmountLabel.textColor = [UIColor whiteColor];
        _remainingAmountLabel.backgroundColor = [UIColor redColor];
        _remainingAmountLabel.layer.masksToBounds = true;
        
        _remainingAmountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_remainingAmountLabel];
    }
    return _remainingAmountLabel;
}

@end
