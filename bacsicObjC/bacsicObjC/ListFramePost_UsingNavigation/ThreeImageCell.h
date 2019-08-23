//
//  threeImageCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#define WITDTH_IMG 120.0
#define HEIGHT_IMG 80.0

#import "ParentsCell.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreeImageCell : ParentsCell
@property (nonatomic, strong) UIImageView * centerImg;
@property (nonatomic, strong) UIImageView * rightImg;
@end

NS_ASSUME_NONNULL_END
