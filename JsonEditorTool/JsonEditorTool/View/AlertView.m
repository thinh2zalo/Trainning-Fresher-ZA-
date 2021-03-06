//
//  AlertView.m
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "AlertView.h"
#import "../Model/JsonModekFactory.h"
#import "../Categories/UILabel+Caculation.h"
#import "../DLRadioButton/DLRadioButton.h"
#import "../Model/EnumTypeValueJson.h"
#import "JETViewController.h"
#import "InforJsonCell.h"

@interface AlertView ()

@property (nonatomic, strong) DLRadioButton *groupRadioBtn;
@property (nonatomic) TypeValue typeValue;

@property (nonatomic, strong) DLRadioButton * firstRadioBtn;


@end


@implementation AlertView


- (void)layoutSubviews {
    [super layoutSubviews];
  
    
//    
    self.typeAlert.frame = CGRectMake(150, 70, 40, 20);
    self.typeAlert.center = CGPointMake(self.frame.size.width  / 2,
                                        20);
    
    
    
    self.cancelBtn.frame = CGRectMake(10, self.typeAlert.frame.origin.y, self.frame.size.width / 5, 25);
    self.saveBtn.frame = CGRectMake(self.frame.size.width - 80, self.cancelBtn.frame.origin.y, self.cancelBtn.frame.size.width, self.cancelBtn.frame.size.height);
    _separatorHeight = (1 / [UIScreen mainScreen].scale);
    
   CGRect  frameSeparator1 = CGRectMake(0,
                                           50,
                                           CGRectGetWidth(self.bounds),
                                           _separatorHeight);
    
    
    [self createSeperateLineWithFrame:frameSeparator1];
    
   
    
    CGRect  frameSeparator2 = CGRectMake(0,
                                         120,
                                         CGRectGetWidth(self.bounds),
                                         _separatorHeight);
    [self createSeperateLineWithFrame:frameSeparator2];
    
    
    // set selection state programmatically
    self.keyAlertLabel.frame = CGRectMake(10, frameSeparator2.origin.y + 10 , 50, 20);
    self.valueAlertLabel.frame = CGRectMake(10, 10 + self.keyAlertLabel.frame.origin.y + 40 , 50, 20);
    
    CGRect  frameSeparator3 = CGRectMake(20,
                                         170,
                                         CGRectGetWidth(self.bounds) - 20,
                                         _separatorHeight);
    [self createSeperateLineWithFrame:frameSeparator3];
    self.keyTextField.frame = CGRectMake(self.frame.size.width / 3 - 20 , self.keyAlertLabel.frame.origin.y , (self.frame.size.width / 3 ) * 2 , 30 );
    
    self.valueTextView.frame = CGRectMake(self.keyTextField.frame.origin.x,self.valueAlertLabel.frame.origin.y , (self.frame.size.width / 3 ) * 2, 120);
    [self ruleOfTextView:_JSOld.typeValue];

    self.errorLable.frame = CGRectMake(0, self.frame.size.height - 30,  166, 30);
    self.errorLable.center = CGPointMake(self.frame.size.width/2,  self.frame.size.height - 10);
}


- (void)ruleOfTextView:(TypeValue)typeValue {
    
    switch (_parentJsonModel.getTypeValue) {
        case typeValueArray:
            self.keyTextField.text = @"";
            self.keyTextField.placeholder = _JSOld.key;
            [self.keyTextField setUserInteractionEnabled:NO];
            break;
            
        default:
            break;
    }
    switch (typeValue) {
        case typeValueBool:
            [self.valueAlertLabel setHidden:NO];
            [self.valueTextView setHidden:NO];
            
            break;
        case typeValueNumber:
            [self.valueAlertLabel setHidden:NO];
            [self.valueTextView setHidden:NO];
            self.valueTextView.keyboardType = UIKeyboardTypeTwitter;
            break;
        case typeValueString:
            [self.valueAlertLabel setHidden:NO];
            [self.valueTextView setHidden:NO];
            self.valueTextView.keyboardType = UIKeyboardTypeDefault;

            break;
        case typeValueArray:
            [self.valueAlertLabel setHidden:YES];
            [self.valueTextView setHidden:YES];
            self.valueTextView.keyboardType = UIKeyboardTypeDefault;

            break;
        case typeValueDictionary:
            [self.valueAlertLabel setHidden:YES];
            [self.valueTextView setHidden:YES];
            
            break;
        case typeValueNull:
            [self.valueAlertLabel setHidden:YES];
            [self.valueTextView setHidden:YES];
        
    }

}

- (void)updateContentInside:(JsonModel *) jsonModel withAlert:(nonnull NSString *)typeAlert{
    [self.errorLable setHidden:YES];
    NSString * value;
    _JSOld = jsonModel;
    _typeValue = jsonModel.typeValue;
    switch ([jsonModel getTypeValue]) {
        case typeValueBool:
            value = [jsonModel.value stringValue];
            break;
        case typeValueString:
            value = jsonModel.value;
            break;
        case typeValueNumber:
            value = [jsonModel.value stringValue];
            break;
        case typeValueArray:
        default: break;
            
    }
    self.typeAlert.text = typeAlert;
    [self.keyTextField setText:jsonModel.key];
    [self.valueTextView setText:value];
    self.groupRadioBtn = DLRadioButton.new;
        CGRect  frameSeparator1 = CGRectMake(0,
                                                  50,
                                                  CGRectGetWidth(self.bounds),
                                                  _separatorHeight);
           
       CGRect frame = CGRectMake(10, frameSeparator1.origin.y + 10 , 100, 30);
       self.firstRadioBtn = [self createRadioButtonWithFrame:frame Title:@"Bool" Color:[UIColor blackColor]];
       
       self.firstRadioBtn.typeValue = typeValueBool;
       
       // other buttons
       NSArray *nameType = @[@"Number", @"String", @"Array", @"Dictionary", @"Null"];
       
       NSInteger i = 1;
       
       NSMutableArray *otherButtons = [NSMutableArray new];
       [otherButtons addObject:self.firstRadioBtn];
       
       for (NSString * type in nameType) {
           float originX = 10, originY = frameSeparator1.origin.y + 10;
           if (i > 2) {
               originX = originX -  3 * 130;
               originY = originY + 30;
           }
           
           
           CGRect frame = CGRectMake(originX + 130 * i, originY , 180, 30);
           DLRadioButton *radioButton = [self createRadioButtonWithFrame:frame Title:type Color:[UIColor blackColor]];
           
           [otherButtons addObject:radioButton];
           i++;
       }
       self.groupRadioBtn.otherButtons = otherButtons;
    self.groupRadioBtn.otherButtons[jsonModel.typeValue].selected = YES;
}

- (void)cancelAlert {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelAlert:)]) {
        [self.delegate cancelAlert:self];
    }
}

- (void)saveAfterConfig {
    id value;
    NSNumberFormatter *f;
    if (![self.keyTextField.text isEqualToString:@""]) {
        switch (_typeValue) {
            case typeValueBool:
                {
                    if ([self.valueTextView.text isEqualToString:@"0"] || [[self.valueTextView.text lowercaseString] isEqualToString:@"false"]) {
                        value = [NSNumber numberWithBool:0];
                    } else if([self.valueTextView.text isEqualToString:@"1"] ||
                              [[self.valueTextView.text lowercaseString] isEqualToString:@"true"]) {
                        value = [NSNumber numberWithBool:1];
                    }
                }
                break;
            case typeValueNumber:
                if (![self.keyTextField.text isEqualToString:@""]) {
                    f = [[NSNumberFormatter alloc] init];
                    f.numberStyle = NSNumberFormatterDecimalStyle;
                    value = [f numberFromString:self.valueTextView.text];
                }
                break;
            case typeValueDictionary:
                if (self.JSOld.getTypeValue == typeValueDictionary) {
                    value = [self.JSOld toOrderDictionary];
                } else {
                    value = NSDictionary.new;
                }
                
                break;
            case typeValueArray:
                value = NSArray.new;
                break;
            case typeValueNull:
                value = NSNull.new;
                break;
            default:
                value = self.valueTextView.text;
        }
        
    }
    if (value) {
        _JSNew  = [JsonModelFactory getJsonModel:value andKey:self.keyTextField.text];
        if (self.JSOld) {
            _JSNew.parrent = self.JSOld.parrent;
            
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(performUpdate:)]) {
            [self.delegate performUpdate:self];
        }
    } else {
        self.errorLable.text = @"input is invalid type";
        [self.errorLable setHidden:NO];
    }
    
}



- (UIView * )createSeperateLineWithFrame:(CGRect)rect {
    
    UIView * separatorView = [[UIView alloc] initWithFrame:rect];
    separatorView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [self addSubview:separatorView];
    return separatorView;
}


- (void)logSelectedButton:(DLRadioButton *)radioButton {
    if (radioButton.isMultipleSelectionEnabled) {
        for (DLRadioButton *button in radioButton.selectedButtons) {
            NSLog(@"%@ is selected.\n", button.titleLabel.text);
        }
    } else {
        _typeValue = radioButton.typeValue;
        [self ruleOfTextView:radioButton.typeValue];
        
    }
    self.groupRadioBtn.otherButtons[_typeValue].selected = YES;

}



- (Button *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = Button.new;
        _cancelBtn.backgroundColor = [UIColor blueColor];
        [_cancelBtn addTarget:self action:@selector(cancelAlert) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (Button *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = Button.new;
        _saveBtn.backgroundColor = [UIColor blueColor];
        [_saveBtn addTarget:self action:@selector(saveAfterConfig) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitle:@"save" forState:UIControlStateNormal];
        [self addSubview:_saveBtn];
    }
    return _saveBtn;
}

- (UILabel *)errorLable {
    if (!_errorLable) {
        _errorLable = UILabel.new;
        [_errorLable setTextColor:[UIColor redColor]];
        [self insertSubview:_errorLable aboveSubview:self.valueTextView];
    }
    return _errorLable;
}

- (UILabel *)typeAlert {
    if (!_typeAlert) {
        _typeAlert = UILabel.new;
        [self addSubview:_typeAlert];
    }
    return _typeAlert;
}

- (UILabel *)keyAlertLabel {
    if (!_keyAlertLabel) {
        _keyAlertLabel = UILabel.new;
        _keyAlertLabel.text = @"key :";
        
        [self addSubview:_keyAlertLabel];
    }
    return _keyAlertLabel;
}

- (UILabel *)valueAlertLabel {
    if (!_valueAlertLabel) {
        _valueAlertLabel = UILabel.new;
        _valueAlertLabel.text = @"value :";
        
        [self addSubview:_valueAlertLabel];
        
    }
    return _valueAlertLabel;
}

- (UITextView *)valueTextView {
    if (!_valueTextView) {
        _valueTextView = UITextView.new;
        [self addSubview:_valueTextView];
    }
    return _valueTextView;
}


- (TextField *)keyTextField {
    if (!_keyTextField) {
        _keyTextField = TextField.new;
        [self addSubview:_keyTextField];
    }
    return _keyTextField;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        [self addSubview:_separatorView];
    }
    return _separatorView;
    
}

- (DLRadioButton *)createRadioButtonWithFrame:(CGRect) frame Title:(NSString *)title Color:(UIColor *)color
{
    DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
    radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:color forState:UIControlStateNormal];
    radioButton.iconColor = color;
    radioButton.typeValue = [DLRadioButton getType:title];
    
    radioButton.indicatorColor = color;
    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:radioButton];
    
    return radioButton;
}

@end

