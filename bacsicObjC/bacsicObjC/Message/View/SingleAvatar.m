//
//  SingleAvatar.m
//  bacsicObjC
//
//  Created by Steve on 9/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "SingleAvatar.h"

@implementation SingleAvatar

- (void)layoutSubviews {
    self.availableView.frame = CGRectMake(0, 0, 15  , 15);
    self.availableView.layer.cornerRadius = self.availableView.frame.size.width / 2.0f;
    self.availableView.center = CGPointMake(0, self.center.y);
    
    self.avatarUserImg.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
    self.avatarUserImg.layer.cornerRadius = self.frame.size.width / 2.0f;
    self.avatarUserImg.clipsToBounds = true;
}

- (UIImageView *)avatarUserImg {
    if (!_avatarUserImg)    {
        _avatarUserImg = UIImageView.new;
        [self addSubview:_avatarUserImg];
    }
    return _avatarUserImg;
}

- (UIView *)availableView {
    if (!_availableView) {
        _availableView = UIView.new;
        _availableView.layer.borderWidth = 3.0f;
        _availableView.backgroundColor = [UIColor greenColor];
        _availableView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self insertSubview:_availableView aboveSubview:self.avatarUserImg];
    }
    return _availableView;
}

@end
