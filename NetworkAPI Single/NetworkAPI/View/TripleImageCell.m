//
//  TripleImageCell.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "TripleImageCell.h"
#import "../Categories/UILabel+Caculation.h"
#import "ThumnailImage.h"

@interface TripleImageCell()

@property (nonatomic , strong) ThumnailImage * leftImg;
@property (nonatomic , strong) ThumnailImage * rightImg;
@property (nonatomic , strong) ThumnailImage * centerImg;


@end

@implementation TripleImageCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize bounddingRect = CGSizeMake(self.frame.size.width - 2 * MARGIN, FLT_MAX);
    self.titleLabel.frame = CGRectMake(MARGIN,MARGIN , self.frame.size.width - 2 * MARGIN, [UILabel heightOfLabel:self.titleLabel withBoundingRect:bounddingRect]);

    // layout for three image
    self.leftImg.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y +  self.titleLabel.frame.size.height + MARGIN, TripleImageCell.thumbnailWidth , TripleImageCell.thumbnailHeight);
    self.centerImg.frame = CGRectMake(self.leftImg.frame.origin.x + self.leftImg.frame.size.width + MARGIN ,self.leftImg.frame.origin.y, TripleImageCell.thumbnailWidth , TripleImageCell.thumbnailHeight);
    self.rightImg.frame = CGRectMake(self.centerImg.frame.origin.x + self.centerImg.frame.size.width + MARGIN ,self.leftImg.frame.origin.y, TripleImageCell.thumbnailWidth , TripleImageCell.thumbnailHeight);
    
    self.timestampAndPublisherLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.leftImg.frame.origin.y + self.leftImg.frame.size.height + MARGIN , self.titleLabel.frame.size.width, [UILabel heightOf1LineWithFrontSize:self.timestampAndPublisherLabel]);
    
    [self.titleLabel sizeToFit];
}

- (void)updateContentInsideCell:(Content *)contentToUpdate {
    [super updateContentInsideCell:contentToUpdate];
    if ([contentToUpdate.images isKindOfClass:NSArray.class] && [contentToUpdate.images count]  >= 3) {
    [self.leftImg sd_setImageWithURL:[(Image *) contentToUpdate.images[0] url]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.centerImg sd_setImageWithURL:[(Image *) contentToUpdate.images[1] url]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.rightImg sd_setImageWithURL:[(Image *) contentToUpdate.images[2] url]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = ThumnailImage.new;
        [self addSubview:_leftImg];
    }
    return _leftImg;
}

- (UIImageView *)centerImg {
    if (!_centerImg) {
        _centerImg = ThumnailImage.new;
        _centerImg.layer.masksToBounds = true;
        [self addSubview:_centerImg];
    }
    return _centerImg;
}


- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = ThumnailImage.new;
        [self addSubview:_rightImg];
    }
    return _rightImg;
}

+ (float)heightOfCellWithTitle:(NSString *)titleLabel timestampAndPublisher:(NSString *) timestampAndPublisher  {
    if ([titleLabel isKindOfClass:NSString.class] && [timestampAndPublisher isKindOfClass:NSString.class] ) {
        
        ParentCell.shareInstance.titleLabel.text = titleLabel;
        ParentCell.shareInstance.timestampAndPublisherLabel.text = timestampAndPublisher;
        
        float heightOfTitleLabel = [UILabel heightOfLableWithMaxLine:ParentCell.shareInstance.titleLabel numberLine:3 withBoundingRect:CGSizeMake (SCREEN_MAIN_WIDTH - 2 * MARGIN, FLT_MAX)];
        float heightOfTimestampAndPublisher = [UILabel heightOf1LineWithFrontSize:ParentCell.shareInstance.timestampAndPublisherLabel];

        float heightOfCell = heightOfTitleLabel + heightOfTimestampAndPublisher + TripleImageCell.thumbnailHeight + 4 * MARGIN;
        if (heightOfTitleLabel == 0) {
            return heightOfCell - MARGIN;
        }
        NSLog(@"%f heightOfTitleLabel ", heightOfTitleLabel);
        
        return heightOfCell;
    } else return 0;
}

@end
