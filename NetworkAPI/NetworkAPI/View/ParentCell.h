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

@interface ParentCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * timestampAndPublisherLabel;

- (void) updateContentInsideCell:(Content *)contentToUpdate;
+ (ParentCell *) shareInstance;
+ (CGFloat) thumbnailHeight;
+ (CGFloat) thumbnailWidth;
@end

NS_ASSUME_NONNULL_END
