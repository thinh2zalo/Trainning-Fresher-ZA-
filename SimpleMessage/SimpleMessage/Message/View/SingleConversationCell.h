//
//  SingleConversationCellTableViewCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#import <SDWebImage/SDWebImage.h>

#import "ConversationCell.h"
#import "SingleAvatar.h"
NS_ASSUME_NONNULL_BEGIN

@interface SingleConversationCell : ConversationCell
@property (nonatomic, strong) SingleAvatar * singleAvatar;

@end

NS_ASSUME_NONNULL_END
