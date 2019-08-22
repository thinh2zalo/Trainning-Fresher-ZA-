//
//  ContainerCellTableViewCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "BigListContainerCell.h"

@implementation BigListContainerCell


- (void)layoutSubviews {
    self.backgroundColor = [UIColor grayColor];
    self.thumnailImg.frame = CGRectMake(PADDING, PADDING, SCREEN_MAIN_WIDTH - PADDING * 2, (CELL_HEIGHT / 3) * 2);
    self.titleLab.frame = CGRectMake(PADDING * 2 , self.thumnailImg.frame.origin.y + self.thumnailImg.frame.size.height + PADDING , CELL_WIDTH - 2 * PADDING ,((CELL_HEIGHT / 3) / 3) * 2);
    [self.titleLab setNumberOfLines:2];
    [self.titleLab sizeToFit];
    NSLog(@"%f", self.titleLab.frame.size.height);
    NSLog(@"%f", self.titleLab.frame.origin.y);
    NSLog(@"%f", self.timeLab.frame.origin.y);
    self.timeLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + 15 , CELL_WIDTH / 2 , (CELL_HEIGHT / 3) / 3);
    [self.timeLab setNumberOfLines:2];
    [self.timeLab sizeToFit];
   
}
- (void)updateContentInsideContainerView:(Content *)content{
    self.titleLab.text = content.title;
    
//    _ContentID = content.contentId;
//
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSURL *url = content.avatarURL;
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        if (data == nil){
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumnailImg.image = [UIImage imageWithData: data];
        });
        
    });
    self.timeLab.text = [NSString compareTimeStamp:content.date];
    
}


- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textColor = [UIColor darkGrayColor];
         [_timeLab setFont:[UIFont systemFontOfSize:13]];
         _timeLab.backgroundColor = [UIColor whiteColor];
        [self addSubview:_timeLab];
    }
    return _timeLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
           _titleLab.backgroundColor = [UIColor whiteColor];
        _titleLab.textColor = [UIColor blackColor];
        [_titleLab setNumberOfLines:3];
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIImageView *)thumnailImg{
    if (!_thumnailImg) {
        _thumnailImg = UIImageView.new;
        _thumnailImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _thumnailImg.layer.masksToBounds = true;
        _thumnailImg.layer.borderWidth = 2.0f;
        _thumnailImg.layer.cornerRadius = 6.0f;
        
        _thumnailImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_thumnailImg];
    }
    return _thumnailImg;

}





@end
