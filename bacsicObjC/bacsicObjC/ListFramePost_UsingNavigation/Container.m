//
//  Contrainner.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Container.h"

@implementation Container

-(Container *)initWithFrame:(CGRect) size{
    self = [super initWithFrame:size];
    if(self){
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 4.0f;
        _button = self.button;
        _label = self.label;
    }
    return self;
}

-(UILabel *)label{
    if (!_label){       
        _label = UILabel.new;
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delegateForRootVC)];
        [_label setUserInteractionEnabled:YES];
        [_label addGestureRecognizer:gesture];
        _label.textColor = [UIColor blueColor];
        
        NSInteger originXOfLabel = self.button.frame.origin.x + 10 + self.button.bounds.size.width ;
        _label.frame = CGRectMake(originXOfLabel , self.button.frame.origin.y, WIDTH_VIEW - originXOfLabel , 100);
       
        [self addSubview:_label];
      
    }
    return _label;
}

-(UIButton *)button{
    if (!_button){
        _button = UIButton.new;
        _button.backgroundColor = [UIColor grayColor];
        _button.frame = CGRectMake(10 , 10 , WITDTH_BTN , LENGTH_BTN);
        [self addSubview:_button];
    }
    return _button;
}

-(void)delegateForRootVC{
    if (_delagte)
  
        [_delagte callSencondVC:self];
}

@end
