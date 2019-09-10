//
//  ConversactionModel.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConversactionModel : UIView
@property (nonatomic, strong) NSString * lastMessageLab;
@property (nonatomic, strong) NSString * timeLab;
@property (nonatomic, strong) NSString * nameUserLab;
@property (nonatomic, strong) NSURL * statusAvailableImg;
@property (nonatomic) NSInteger  countNewMessageLab;
@property (nonatomic) BOOL  isGroupConversation;
@end

NS_ASSUME_NONNULL_END
