//
//  AlertView.m
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "AlertView.h"
@interface AlertView ()
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorHeight;

@property (nonatomic, strong) UILabel * keyAlertLabel;
@property (nonatomic, strong) UILabel * valueAlertLabel;
@property (nonatomic, strong) TextField * keyTextField;
@property (nonatomic, strong) UITextView * valueTextView;
@property (nonatomic, strong) UILabel * typeAlert;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UIButton * saveBtn ;

@end

@implementation AlertView


- (void)layoutSubviews {
    self.typeAlert.frame = CGRectMake(150, 70, 40, 20);
     self.typeAlert.center = CGPointMake(self.frame.size.width  / 2,
                                      20);
    _separatorHeight = (1 / [UIScreen mainScreen].scale);
    self.separatorView.frame = CGRectMake(0,
                                          40,
                                          CGRectGetWidth(self.bounds),
                                          _separatorHeight);
    self.keyAlertLabel.frame = CGRectMake(10, 10 + self.separatorView.frame.origin.y , 50, 20);
    self.valueAlertLabel.frame = CGRectMake(10, 10 + self.keyAlertLabel.frame.origin.y + 40 , 50, 20);
    
    self.keyTextField.frame = CGRectMake(self.frame.size.width / 3 - 20 , self.keyAlertLabel.frame.origin.y , (self.frame.size.width / 3 ) * 2 , 30 );
    self.valueTextView.frame = CGRectMake(self.keyTextField.frame.origin.x,self.valueAlertLabel.frame.origin.y , (self.frame.size.width / 3 ) * 2, 30);
    
    self.cancelBtn.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width / 2, 40);
    self.saveBtn.frame = CGRectMake(self.cancelBtn.frame.size.width, self.cancelBtn.frame.origin.y, self.cancelBtn.frame.size.width, self.cancelBtn.frame.size.height);

}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        _cancelBtn.backgroundColor = [UIColor redColor];
        _cancelBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.layer.cornerRadius = 3.0f;
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = UIButton.new;
        _saveBtn.backgroundColor = [UIColor blueColor];
        _saveBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _saveBtn.layer.cornerRadius = 3.0f;
        [self addSubview:_saveBtn];
    }
    return _saveBtn;
}

- (UILabel *)typeAlert {
    if (!_typeAlert) {
        _typeAlert = UILabel.new;
        _typeAlert.text = @"Edit ";
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
        _valueAlertLabel.text = @"value";

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

@end
