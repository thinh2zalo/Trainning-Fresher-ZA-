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
#import "../View/AlertView.h"
#import "../Categories/UILabel+Caculation.h"

@interface InforJsonCell() 
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, strong) UIImageView *forwardIconImg;
@property (nonatomic, strong) UIImageView *iconTypeImg;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIStackView  * stackView;
@property (nonatomic, strong) JsonModel  * jsonModel;
@property (nonatomic, strong) UIView * visibleContainerView;
@property (nonatomic, strong) UIView * hiddenContainerView;



typedef NS_ENUM(NSInteger, ActionOrientation) {
    kActionOrientationLeft = 0,
    kActionOrientationRight = 1
};

@end

@implementation InforJsonCell



- (void)updateContentInsideCell:(JsonModel *)jsonModel  isSearching:(BOOL)isSearching{
    self.jsonModel = jsonModel;
    self.keyLable.text = jsonModel.key;
    NSString * typeValue;
    switch ([jsonModel getTypeValue]) {
        case typeValueArray:
            self.valueLabel.text = [NSString stringWithFormat:@"%tu keys", [jsonModel.value count]];
            self.iconTypeImg.image = [UIImage imageNamed:@"Array"];
            typeValue = @"Array";
            break;
            
        case typeValueDictionary:
            self.valueLabel.text = [NSString stringWithFormat:@"%tu keys", [jsonModel.value count]];
            self.iconTypeImg.image = [UIImage imageNamed:@"Dictionary"];
            
            typeValue = @"Dictionary";
            break;
            
        case typeValueString:
            self.iconTypeImg.image = [UIImage imageNamed:@"String"];
            
            self.valueLabel.text = jsonModel.value;
            typeValue = @"String";
            break;
            
        case typeValueNumber:
            self.iconTypeImg.image = [UIImage imageNamed:@"Number"];
            
            if ([jsonModel.value isKindOfClass:NSNumber.class]) {
                self.valueLabel.text = [(NSNumber *)jsonModel.value stringValue];
            }
            typeValue = @"Number";
            break;
            
        case typeValueNull:
            self.iconTypeImg.image = [UIImage imageNamed:@"Null"];
            
            self.valueLabel.text = @"Null";
            typeValue = @"Null";
            
            break;
        case typeValueBool:
            self.iconTypeImg.image = [UIImage imageNamed:@"Bool"];
            self.valueLabel.text = [NSString stringWithFormat:@"%@", [jsonModel.value  isEqual: @(1)] ? @"YES" : @"NO"];
            typeValue = @"Bool";
    }
    
    self.typeValueLabel.text = typeValue;
    if (isSearching) {
        [self.hierarchiLabel setHidden:NO];
        JsonModel * js = jsonModel;
        NSString * levelJSontext = NSString.new;
        NSMutableArray <NSString *> *levelJson = NSMutableArray.new;
        while (js.parrent) {
            [levelJson addObject:js.parrent.key];
            js = js.parrent;
        }
        for (NSInteger i = levelJson.count - 1 ; i >= 0 ; i --) {
            if (levelJson[i].length > 12) {
                levelJson[i] = [levelJson[i] substringToIndex:12];
                levelJson[i] = [NSString stringWithFormat:@"%@...",levelJson[i]];
            }
            levelJSontext = [NSString stringWithFormat:@"%@ > %@ ", levelJSontext, levelJson[i]];
        }
        levelJSontext = [levelJSontext substringFromIndex:11];
        if ([levelJSontext isEqualToString:@""]) {
            levelJSontext = @">";
        }
        self.hierarchiLabel.text = levelJSontext;
    } else {
        [self.hierarchiLabel setHidden:YES];
        
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    self.keyLable.frame = CGRectMake(20, 15, (SCREEN_MAIN_WIDTH - 60 ) / 2, 20);
    self.typeValueLabel.frame = CGRectMake(45, 40, 200, 20);
    self.iconTypeImg.frame = CGRectMake(self.keyLable.frame.origin.x, 40, 20, 20);
    CGSize maxSize =  CGSizeMake((SCREEN_MAIN_WIDTH - 60) / 2 , 99999);
    self.valueLabel.frame = CGRectMake(SCREEN_MAIN_WIDTH - [UILabel widthOfLabel:self.valueLabel withBoundingRect:maxSize] - 50, 17, [UILabel widthOfLabel:self.valueLabel withBoundingRect:maxSize] + 20 , 40);
    self.forwardIconImg.frame = CGRectMake(self.valueLabel.frame.origin.x + self.valueLabel.frame.size.width  , self.valueLabel.frame.origin.y + 10, 15, 20);
    
    _separatorHeight = (1 / [UIScreen mainScreen].scale);
    self.separatorView.frame = CGRectMake(0,
                                          CGRectGetHeight(self.bounds) - _separatorHeight,
                                          CGRectGetWidth(self.bounds),
                                          _separatorHeight);
    self.hierarchiLabel.frame = CGRectMake(20, self.typeValueLabel.frame.origin.y + 30, 330, 20);
    
    
}

- (void)deleteCell {
    [self hideSwipeCell];
    [self.delegate deleteJson:self.jsonModel];
}


- (UIImageView *)forwardIconImg {
    if (!_forwardIconImg) {
        _forwardIconImg = UIImageView.new;
        _forwardIconImg.image = [UIImage imageNamed:@"forward_icon"];
        _forwardIconImg.alpha = 0.4;
        [self.contentView addSubview:_forwardIconImg];
    }
    return _forwardIconImg;
}

- (UIImageView *)iconTypeImg {
    if (!_iconTypeImg) {
        _iconTypeImg = UIImageView.new;
        [self.contentView addSubview:_iconTypeImg];
    }
    return _iconTypeImg;
}

- (UILabel *)typeValueLabel {
    if (!_typeValueLabel) {
        _typeValueLabel = UILabel.new;
        [_typeValueLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_typeValueLabel];
    }
    return _typeValueLabel;
}

- (UILabel *)keyLable {
    if (!_keyLable) {
        _keyLable = UILabel.new;
        [self.contentView addSubview:_keyLable];
    }
    return _keyLable;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = UILabel.new;
        [_valueLabel setFont:[UIFont systemFontOfSize:16]];
        [self.contentView addSubview:_valueLabel];
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
- (UILabel *)hierarchiLabel {
    if (!_hierarchiLabel) {
        _hierarchiLabel = UILabel.new;
        [_hierarchiLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_hierarchiLabel];
    }
    return _hierarchiLabel;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
        [_scrollView setPagingEnabled:true];
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.showsHorizontalScrollIndicator = false;
    }
    return _scrollView;
}

- (UIView *)visibleContainerView {
    if (!_visibleContainerView) {
        _visibleContainerView = UIView.new;
        [self addSubview:_visibleContainerView];
    }
    return _visibleContainerView;
}
- (UIView *)hiddenContainerView {
    if (!_hiddenContainerView) {
        _hiddenContainerView = UIView.new;
        [self addSubview:_hiddenContainerView];
    }
    return _hiddenContainerView;
}




@end
