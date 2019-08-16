//
//  Contrainner.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "Container.h"
@interface Container()

@end
@implementation Container
-(instancetype)init{
    self = [super init];
    if(self){
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3.0f;
        _button = self.button;
        _label = self.label;
        
    }
    return self;
}
-(UILabel *)label{
    if (!_label){
        _label = UILabel.new;
        _label.textColor = [UIColor blueColor];
        NSLog(@"%f",self.frame.size.width);
    
        _label.frame = CGRectMake(WIDTH_VIEW , 0, WITDTH_LAB, LENGTH_LAB); 
         [self addSubview:_label];
    }
    return _label;
}

-(UIButton *)button{
    if (!_button){
        _button = UIButton.new;
        _button.backgroundColor = [UIColor blueColor];
        _button.frame = CGRectMake(10 , 10 , WITDTH_BTN , LENGTH_BTN);
        [self addSubview:_button];
    }
    return _button;
}





@end
