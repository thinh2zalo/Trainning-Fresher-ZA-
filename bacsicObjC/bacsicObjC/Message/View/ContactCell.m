//
//  ContactCell.m
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)layoutSubviews {
    self.avatarImg.frame = CGRectMake(0, 0, self.frame.size.height   , self.frame.size.height );
    self.nameContactLabel.frame= CGRectMake(self.avatarImg.frame.origin.x + self.avatarImg.frame.size.width + 20, self.avatarImg.frame.origin.y, self.frame.size.width - self.nameContactLabel.frame.origin.y , self.avatarImg.frame.size.height);
    self.avatarImg.layer.cornerRadius = self.avatarImg.frame.size.width / 2.0f;
}

- (void) updateContactCell:(User *) user {
    self.nameContactLabel.text = user.userName;
}

- (UILabel *)nameContactLabel {
    if (!_nameContactLabel) {
        _nameContactLabel = UILabel.new;
        [self  addSubview:_nameContactLabel];
    }
    return _nameContactLabel;
}

- (UIImageView *)avatarImg {
    if (!_avatarImg) {
        _avatarImg = UIImageView.new;
        _avatarImg.backgroundColor = [UIColor blueColor];
        [self addSubview:_avatarImg];
    }
    return _avatarImg;
}

@end
