//
//  ParentCell.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ParentCell.h"
#import "../Categories/NSString+CompareTimeStamp.h"


@implementation ParentCell



+ (ParentCell *)shareInstance {
    static ParentCell * cell = nil;
    if (!cell) {
        cell = ParentCell.new;
    }
    return  cell;
}


- (void)updateContentInsideCell:(Content *)contentToUpdate {
    NSString * time = [NSString convertTimestamp:contentToUpdate.date];
    self.timestampAndPublisherLabel.text = [NSString stringWithFormat:@"%@ + %@", contentToUpdate.publicsherName, time];
    self.titleLabel.text = contentToUpdate.title;
}


+ (CGFloat)thumbnailWidth {
    return  (SCREEN_MAIN_WIDTH - 4 * MARGIN ) / 3;
    
}

+ (CGFloat)thumbnailHeight {
     return (ParentCell.thumbnailWidth * 3 ) /  4 ;
}



- (UILabel *)timestampAndPublisherLabel {
    if (!_timestampAndPublisherLabel) {
        _timestampAndPublisherLabel = UILabel.new;
        _timestampAndPublisherLabel.textColor = RGB(212, 212, 212);
        [_timestampAndPublisherLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_timestampAndPublisherLabel];
    }
    return _timestampAndPublisherLabel;
    
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        [_titleLabel setNumberOfLines:3];
        
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}





@end
