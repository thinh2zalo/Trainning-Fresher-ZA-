//
//  Contrainner.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ContainerView.h"

@implementation ContainerView

-(ContainerView *)initWithFrame:(CGRect) size{
    self = [super initWithFrame:size];
    if (self) {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 4.0f;
        _timeStamp = self.timeStamp;
        _thumbnail = self.thumbnail;
        _label = self.label;
        
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delegateForRoot)];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.thumbnail.frame = CGRectMake(10, 10, WITDTH_IMG, HEIGHT_IMG);
     NSInteger originXOftimeStamp = self.thumbnail.frame.origin.x + 10 + self.thumbnail.bounds.size.width;
    self.timeStamp.frame = CGRectMake(originXOftimeStamp, HEIGHT_VIEW - 30, WIDTH_TIMESTAMP, HEIGHT_TIMESTAMP);
    float originXOfLabel = self.thumbnail.frame.origin.x + 10 + self.thumbnail.bounds.size.width;
    self.label.frame = CGRectMake(originXOfLabel , self.thumbnail.frame.origin.y, WIDTH_VIEW - originXOfLabel - 10 , HEIGHT_LAB);
    [self.label sizeToFit];
    
}

- (void)updateContentInsideContainerView:(Content *)content{
    self.label.text = content.title;

    [self.label sizeToFit];
    _ContentID = content.contentId;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
       
        NSURL *url = content.avatarURL;
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        if (data == nil){
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnail.image = [UIImage imageWithData: data];
        });
        
    });
     self.timeStamp.text = [NSString compareTimeStamp:content.date];
}

- (UILabel *)timeStamp{
    if (!_timeStamp) {
        _timeStamp = UILabel.new;
        [_timeStamp setFont:[UIFont systemFontOfSize:13]];
        
        [self addSubview:_timeStamp];
    }
    return _timeStamp;
    
}

-(UILabel *)label{
    if (!_label){       
        _label = UILabel.new;
        _label.textColor = [UIColor darkGrayColor];
        [_label setNumberOfLines:3];
        [self addSubview:_label];
      
    }
    return _label;
}

-(UIImageView *)thumbnail{
    if (!_thumbnail){
        _thumbnail = UIImageView.new;
        _thumbnail.layer.borderColor = CFBridgingRetain([UIColor whiteColor]);
        _thumbnail.layer.masksToBounds = true;
        _thumbnail.layer.borderWidth = 2.0f;
        _thumbnail.layer.cornerRadius = 6.0f;
       
        _thumbnail.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_thumbnail];
    }
    return _thumbnail;
}

-(void)delegateForRoot{
    if (_delagte)
        [_delagte onTouched:self];
}
- (CGSize)sizeThatFits:(CGSize)size{
    CGSize res = [super sizeThatFits:size];
    
    return CGSizeMake(size.width, res.height);
}
@end
