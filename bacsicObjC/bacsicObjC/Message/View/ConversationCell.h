//
//  ConversationCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HEIGHT_BIG_IMG  100

NS_ASSUME_NONNULL_BEGIN

@interface ConversationCell : UITableViewCell
@property (nonatomic, strong) UIStackView * conversactionStackView;
@property (nonatomic, strong) UILabel * lastMessageLab;
@property (nonatomic, strong) UILabel * timeLab;
@property (nonatomic, strong) UILabel * nameUserLab;
@property (nonatomic, strong) UIImageView * statusAvailableImg;
@property (nonatomic, strong) UILabel * countNewMessageLab;
@property (nonatomic, strong) UIView * nameAndContentView;
@property (nonatomic, strong) UIView * timeAndCountNewMesView;
@end

NS_ASSUME_NONNULL_END
