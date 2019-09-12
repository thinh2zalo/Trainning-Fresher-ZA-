//
//  ConversactionModel.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConversationModel : UIView
@property (nonatomic, strong) NSString * lastMessage;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * nameUser;
@property (nonatomic, strong) NSURL * avatarUser;
@property (nonatomic) NSInteger  countNewMessage;
@property (nonatomic) BOOL  isGroupConversation;
@end

NS_ASSUME_NONNULL_END
