//
//  GroupConversationCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ConversationCell.h"
#import "GroupAvatarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupConversationCell : ConversationCell
@property (nonatomic, strong) GroupAvatarView * groupAvatarView;
@end

NS_ASSUME_NONNULL_END
