//
//  ConversactionModel.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationModel : NSObject
@property (nonatomic, strong) NSString * lastMessage;
@property (nonatomic) NSInteger conversationID;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) Friend * user;
@property (nonatomic) NSInteger  countNewMessage;
@property (nonatomic) BOOL  isGroupConversation;
@end

NS_ASSUME_NONNULL_END
