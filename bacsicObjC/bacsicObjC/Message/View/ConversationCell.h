//
//  ConversationCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ModelMessage/ConversationModel.h"
#import "../define.h"
#import "MessageCell.h"
#define HEIGHT_BIG_IMG  100

NS_ASSUME_NONNULL_BEGIN

@interface ConversationCell : UITableViewCell
@property (nonatomic, strong) UIStackView * conversationStackView;
@property (nonatomic, strong) UILabel * lastMessageLab;
@property (nonatomic, strong) UILabel * timeLab;
@property (nonatomic, strong) UILabel * nameUserLab;
@property (nonatomic, strong) UIView * usersView;
@property (nonatomic) BOOL isSender;
@property (nonatomic, strong) UIImageView * avatarUserImg;
@property (nonatomic, strong) UILabel * countNewMessageLab;
@property (nonatomic, strong) UIView * nameAndContentView;
@property (nonatomic, strong) UIView * availableView;
@property (nonatomic, strong) UIView * timeAndCountNewMesView;
-(void)updateContentInsideCell:(ConversationModel *) conversationModel;
@end

NS_ASSUME_NONNULL_END
