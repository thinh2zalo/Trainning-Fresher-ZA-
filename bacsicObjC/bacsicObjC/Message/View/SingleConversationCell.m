//
//  SingleConversationCellTableViewCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "SingleConversationCell.h"

@implementation SingleConversationCell

- (void)layoutSubviews {
    
}

- (UIImageView *)avatarImg {
    if (!_avatarImg) {
        _avatarImg = UIImageView.new;
        [self.conversactionStackView addArrangedSubview:_avatarImg];
    }
    return _avatarImg;
}

@end
