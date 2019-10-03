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
    [super layoutSubviews];
    self.singleAvatar.frame = CGRectMake(0, 0, self.usersView.frame.size.width, self.usersView.frame.size.height);
    
   
}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    [super updateContentInsideCell:conversationModel];
    NSURL *url = conversationModel.arrUsers[0].avatarUrl;
    [self.singleAvatar.avatarUserImg sd_setImageWithURL:[NSURL URLWithString:url.absoluteString]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

}

- (SingleAvatar *)singleAvatar {
    if (!_singleAvatar) {
        _singleAvatar = SingleAvatar.new;
        [self.usersView addSubview:_singleAvatar];
    }
    return _singleAvatar;
}

@end
