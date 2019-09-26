//
//  ContactCell.h
//  bacsicObjC
//
//  Created by Steve on 9/26/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../ModelMessage/User.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContactCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameContactLabel;
@property (nonatomic, strong) UIImageView * avatarImg;
- (void) updateContactCell:(User *) user;

@end

NS_ASSUME_NONNULL_END
