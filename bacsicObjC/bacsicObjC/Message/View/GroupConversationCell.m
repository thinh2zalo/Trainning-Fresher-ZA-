//
//  GroupConversationCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "GroupConversationCell.h"

@implementation GroupConversationCell

- (GroupAvatarView *)groupAvatarView {
    if (!_groupAvatarView) {
        _groupAvatarView = GroupAvatarView.new;
        
    }
    return _groupAvatarView;
}

@end
