//
//  Message.h
//  bacsicObjC
//
//  Created by Steve on 9/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"https://bstyle.vn/wp-content/uploads/2018/11/bill-gates.jpg

NS_ASSUME_NONNULL_BEGIN

@interface Message : NSObject
@property (nonatomic) NSInteger messageId;
@property (nonatomic) NSInteger conversationId;
@property (nonatomic, strong) NSString * contentMessage;
@property (nonatomic, strong) NSString *time;
@property (nonatomic,strong) User * user;
@property (nonatomic) BOOL isSender;



@end

NS_ASSUME_NONNULL_END
