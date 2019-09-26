//
//  ConversactionModel.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationModel : NSObject
@property (nonatomic, strong) Message * message;
@property (nonatomic) NSInteger conversationID;
@property (nonatomic, strong) NSArray <User *> * arrUsers;
@property (nonatomic) NSInteger  countNewMessage;
@property (nonatomic) NSString *nameConversation;
@property (nonatomic) BOOL  isGroupConversation;

@end

NS_ASSUME_NONNULL_END
