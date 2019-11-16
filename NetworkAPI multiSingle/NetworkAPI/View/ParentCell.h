//
//  ParentCell.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Define.h"
#import "../Model/ContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParentCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * timestampAndPublisherLable;
+ (CGFloat) thumbnailHeight;
+ (CGFloat) thumbnailWidth;
- (void) updateContentInsideCell:(Content *)contentToUpdate;
+ (ParentCell *) shareInstance;

@end

NS_ASSUME_NONNULL_END
