//
//  InforJSonCell.m
//  JsonEditorTool
//
//  Created by Steve on 12/4/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "InforJsonCell.h"
#import "../Define.h"
#import "../Model/JsonModel.h"
#import "../Categories/UILabel+Caculation.h"

@interface InforJsonCell()
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, strong) UIImageView *forwardIcon;
@end

@implementation InforJsonCell




- (void)updateContentInsideCell:(JsonModel *)jsonModel {
    self.keyLable.text = jsonModel.key;
    NSString * typeValue;
    switch ([jsonModel getTypeValue]) {
        case typeValueArray:
            self.valueLabel.text = [NSString stringWithFormat:@"%tu keys", [jsonModel.value count]];
            typeValue = @"Array";
            break;
            
        case typeValueDictionary:
            self.valueLabel.text = [NSString stringWithFormat:@"%tu keys", [jsonModel.value count]];
            typeValue = @"Dictionary";
            break;
            
        case typeValueString:
            self.valueLabel.text = jsonModel.value;
            typeValue = @"String";
            break;
            
        case typeValueNumber:
            if ([jsonModel.value isKindOfClass:NSNumber.class]) {
                self.valueLabel.text = [(NSNumber *)jsonModel.value stringValue];
            }
            typeValue = @"Number";
            break;
            
        case typeValueNull:
            self.valueLabel.text = @"Null";
            typeValue = @"Null";

            break;
        case typeValueBool:
            self.valueLabel.text = [NSString stringWithFormat:@"%@", jsonModel ? @"YES" : @"NO"];
            typeValue = @"Bool";
    }
    self.typeValueLabel.text = typeValue;
    
}

- (void)prepareForReuse {

    CGSize maxSize =  CGSizeMake(SCREEN_MAIN_WIDTH / 2, 99999);
    self.valueLabel.frame = CGRectMake(SCREEN_MAIN_WIDTH - [UILabel widthOfLabel:self.valueLabel withBoundingRect:maxSize] - 10, 0, [UILabel widthOfLabel:self.valueLabel withBoundingRect:maxSize] + 40, 40);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.keyLable.frame = CGRectMake(20, 0, (SCREEN_MAIN_WIDTH - 60 ) / 2, 20);
    self.typeValueLabel.frame = CGRectMake(60, 25, 200, 20);
    
    CGSize maxSize =  CGSizeMake((SCREEN_MAIN_WIDTH - 60) / 2 , 99999);
    self.valueLabel.frame = CGRectMake(SCREEN_MAIN_WIDTH - [UILabel widthOfLabel:self.valueLabel withBoundingRect:maxSize] - 35, 0, [UILabel widthOfLabel:self.valueLabel withBoundingRect:maxSize] , 40);
    self.forwardIcon.frame = CGRectMake(self.valueLabel.frame.origin.x + self.valueLabel.frame.size.width + 5 , self.valueLabel.frame.origin.y + 10, 15, 20);
    
    _separatorHeight = (1 / [UIScreen mainScreen].scale);
    self.separatorView.frame = CGRectMake(0,
                                          CGRectGetHeight(self.bounds) - _separatorHeight,
                                          CGRectGetWidth(self.bounds),
                                          _separatorHeight);
}

- (UIImageView *)forwardIcon {
    if (!_forwardIcon) {
        _forwardIcon = UIImageView.new;
        _forwardIcon.image = [UIImage imageNamed:@"forward_icon"];
        _forwardIcon.alpha = 0.4;
        [self addSubview:_forwardIcon];
    }
    return _forwardIcon;
}

- (UILabel *)typeValueLabel {
    if (!_typeValueLabel) {
        _typeValueLabel = UILabel.new;
        [_typeValueLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_typeValueLabel];
    }
    return _typeValueLabel;
}

- (UILabel *)keyLable {
    if (!_keyLable) {
        _keyLable = UILabel.new;
        [self addSubview:_keyLable];
    }
    return _keyLable;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = UILabel.new;
        [_valueLabel setFont:[UIFont systemFontOfSize:18]];
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}


- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        [self addSubview:_separatorView];
    }
    return _separatorView;
    
}

@end
