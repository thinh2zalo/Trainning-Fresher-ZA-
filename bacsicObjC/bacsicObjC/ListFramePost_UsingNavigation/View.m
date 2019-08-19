//
//  Contrainner.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "View.h"

@implementation View

-(View *)initWithFrame:(CGRect) size{
    self = [super initWithFrame:size];
    if(self){
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 4.0f;
        
        _timeStamp = self.timeStamp;
        _thumbnail = self.thumbnail;
        _label = self.label;
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchView)];
        [self addGestureRecognizer:singleTap];
       
    }
    return self;
}

- (UILabel *)timeStamp{
    if(!_timeStamp){
        _timeStamp = UILabel.new;
        [_timeStamp setFont:[UIFont systemFontOfSize:13]];
        
        NSInteger originXOftimeStamp = self.thumbnail.frame.origin.x + 10 + self.thumbnail.bounds.size.width;
        _timeStamp.frame = CGRectMake(originXOftimeStamp, HEIGHT_VIEW - 30, WIDTH_TIMESTAMP, HEIGHT_TIMESTAMP);
        [self addSubview:_timeStamp];
    }
    return _timeStamp;
    
}

-(UILabel *)label{
    if (!_label){       
        _label = UILabel.new;
        _label.textColor = [UIColor darkGrayColor];
        [_label setNumberOfLines:3];
        [_label setFont:[UIFont fontWithName:@"RobotoMono-Medium" size:15]];
        NSInteger originXOfLabel = self.thumbnail.frame.origin.x + 10 + self.thumbnail.bounds.size.width ;
        _label.frame = CGRectMake(originXOfLabel , self.thumbnail.frame.origin.y, WIDTH_VIEW - originXOfLabel , 100);
       
        [self addSubview:_label];
      
    }
    return _label;
}

-(UIImageView *)thumbnail{
    if (!_thumbnail){
        _thumbnail = UIImageView.new;
        _thumbnail.frame = CGRectMake(10, 10, WITDTH_IMG, HEIGHT_IMG);
        [self addSubview:_thumbnail];
    }
    return _thumbnail;
}

-(void)touchView{
    if (_delagte)
        [_delagte allText:self];
}

@end
