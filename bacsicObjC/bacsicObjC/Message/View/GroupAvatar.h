//
//  GroupAvatar.h
//  bacsicObjC
//
//  Created by Steve on 9/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupAvatar : UIView
@property (nonatomic, strong) UIImageView * fristAvatar;
@property (nonatomic, strong) UIImageView * secondAvatar;
@property (nonatomic, strong) UIImageView * thirdAvatar;
@property (nonatomic, strong) UIImageView * fourthAvatar;
@property (nonatomic, strong) UILabel * remainingAmountLabel;
@property (nonatomic, strong) NSMutableArray <UIView *> * arrAvatarView;
@end

NS_ASSUME_NONNULL_END
