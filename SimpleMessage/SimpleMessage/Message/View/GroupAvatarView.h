//
//  GroupAvatarView.h
//  bacsicObjC
//
//  Created by CPU11606 on 9/10/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupAvatarView : UIView

@property (nonatomic, strong) UILabel * remainingAmountLabel;
@property (nonatomic, strong) NSMutableArray <UIImageView *> * arrAvatarView;
@end

NS_ASSUME_NONNULL_END
