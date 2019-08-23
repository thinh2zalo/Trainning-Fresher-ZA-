//
//  ContainerCellTableViewCell.h
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ParentsCell.h"


NS_ASSUME_NONNULL_BEGIN


@interface BigImageCell : ParentsCell
@property (nonatomic, strong) UIImageView *centerImg;
@property (nonatomic, strong) UIImageView *rightImg;
@end

NS_ASSUME_NONNULL_END
