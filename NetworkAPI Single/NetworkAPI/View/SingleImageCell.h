//
//  SingleImageCell.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentCell.h"
#import <SDWebImage/SDWebImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface SingleImageCell :  ParentCell
//@property (nonatomic, strong) UIImageView * thumbnailImg;
+ (float)heightOfCell;
@end

NS_ASSUME_NONNULL_END
