//
//  SingleImageCell.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SingleImageCell.h"
#import "../Categories/UILabel+Caculation.h"
#import "../Model/ImageModel.h"
#import "ThumnailImage.h"


@interface SingleImageCell ()
@property (nonatomic , strong) ThumnailImage * thumbnailImg;

@end
@implementation SingleImageCell



- (void)layoutSubviews {
    [super layoutSubviews];
   
    self.thumbnailImg.frame = CGRectMake(MARGIN, MARGIN, self.thumbnailWidth, self.thumbnailHeight);
    self.titleLabel.frame = CGRectMake(MARGIN +  self.thumbnailWidth + MARGIN, self.thumbnailImg.frame.origin.y, self.frame.size.width - 3 * MARGIN - self.thumbnailWidth , self.thumbnailHeight);
    
    CGFloat timestampHeight = [UILabel heightOf1LineWithFrontSize:self.titleLabel];
    
    self.timestampAndPublisherLable.frame = CGRectMake(self.titleLabel.frame.origin.x, self.thumbnailImg.frame.origin.y + self.thumbnailImg.frame.size.height - timestampHeight, self.titleLabel.frame.size.width, timestampHeight);
    [self.titleLabel sizeToFit];
}

- (void)updateContentInsideCell:(Content *)contentToUpdate {
    [super updateContentInsideCell:contentToUpdate];
    if ([contentToUpdate.images isKindOfClass:NSMutableArray.class] && contentToUpdate.avatarURL) {

        
        [self.thumbnailImg sd_setImageWithURL:contentToUpdate.avatarURL
                              placeholderImage:[UIImage imageNamed:@"Placeholder"]];
        
    } else {
            [self.thumbnailImg setImage:[UIImage imageNamed:@"Placeholder"]];
        
    }
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.thumbnailImg.image = nil;
}

- (ThumnailImage *)thumbnailImg{
    if (!_thumbnailImg) {
        _thumbnailImg = ThumnailImage.new;
        [self  addSubview:_thumbnailImg];
    }
    return _thumbnailImg;
}

+ (float)heightOfCell {
    return ParentCell.shareInstance.thumbnailHeight + 2 * MARGIN;
    
}


@end
