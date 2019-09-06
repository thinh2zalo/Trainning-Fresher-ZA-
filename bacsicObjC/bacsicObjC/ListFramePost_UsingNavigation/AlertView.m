//
//  AlertView.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/6/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "AlertView.h"

@interface  AlertView()


@end

@implementation AlertView

- (void)layoutSubviews {
    self.titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.titleLab sizeToFit];
    
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        
        _titleLab = UILabel.new;
        [_titleLab setNumberOfLines:3];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        _cancelBtn.backgroundColor = [UIColor darkGrayColor];
        _cancelBtn.titleLabel.text = @"CANCEL";
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}
@end
