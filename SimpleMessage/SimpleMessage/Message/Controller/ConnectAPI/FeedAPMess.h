//
//  FeedAPI.h
//  bacsicObjC
//
//  Created by Steve on 9/17/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../ModelMessage/User.h"
#import "../../ModelMessage/ConversationModel.h"
#import "../../ModelMessage/ConversationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FeedAPIMess : NSObject
- (NSArray <ConversationModel *> *)setupData;
- (NSArray *) setUpdataMessage: (NSInteger) conversationID;
@end

NS_ASSUME_NONNULL_END
