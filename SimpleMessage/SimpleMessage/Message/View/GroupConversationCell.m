//
//  GroupConversationCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "GroupConversationCell.h"
@implementation GroupConversationCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.groupAvatarView.frame = CGRectMake(0, 0, self.usersView.frame.size.width, self.usersView.frame.size.height);
}

- (void)updateContentInsideCell:(ConversationModel *)conversationModel {
    [super updateContentInsideCell:conversationModel];
    self.nameUserLab.text = conversationModel.nameConversation;
    
    
    
    if ([conversationModel.arrUsers count] <= 4) {
        int index = 0;
        
        for (User * user in conversationModel.arrUsers) {
            NSURL *url = user.avatarUrl;
            [self.groupAvatarView.arrAvatarView[index] sd_setImageWithURL:[NSURL URLWithString:url.absoluteString]
                                               placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

            index = index + 1;
            
        }
    } else {
        for (int i = 0; i < 3 ; i ++) {
            NSURL *url = conversationModel.arrUsers[i].avatarUrl;

            [self.groupAvatarView.arrAvatarView[i] sd_setImageWithURL:[NSURL URLWithString:url.absoluteString]
                                                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
          
        }
        if ( [conversationModel.arrUsers count] < 5 ) {
            self.groupAvatarView.remainingAmountLabel.text = [NSString stringWithFormat:@"%tu", [conversationModel.arrUsers count] - 3 ];
        } else {
            self.groupAvatarView.remainingAmountLabel.text = @"5+";
        }
        
    }
    
}

- (GroupAvatarView *)groupAvatarView {
    if (!_groupAvatarView) {
        
        _groupAvatarView = GroupAvatarView.new;
        [self.usersView addSubview:_groupAvatarView];
        
    }
    return _groupAvatarView;
}

@end
