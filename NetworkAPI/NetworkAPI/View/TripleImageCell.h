//
//  TripleImageCell.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ParentCell.h"
#import <SDWebImage/SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface TripleImageCell : ParentCell

+ (float)heightOfCellWithTitle:(NSString *)titleLabel timestampAndPublisher:(NSString *) timestampAndPublisher;
@end

NS_ASSUME_NONNULL_END
