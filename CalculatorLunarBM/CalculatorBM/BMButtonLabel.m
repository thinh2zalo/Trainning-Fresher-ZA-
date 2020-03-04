//
//  SolarMonthYearView.m
//  CalculatorBM
//
//  Created by vincent on 3/3/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMButtonLabel.h"
@interface BMButtonLabel()
@property (nonatomic, strong) UILabel * solarMonthAndYearLabel;
@property (nonatomic,strong) UIView *backgroundView;

@end
@implementation BMButtonLabel

-(void)setLabelText:(NSString *)text {
    self.solarMonthAndYearLabel.text = text;
}

- (void)loadDateWithInput:(BMDate *)date {
      self.solarMonthAndYearLabel.text = [NSString stringWithFormat:@"Tháng %tu năm %tu", [date getSolarMonth], [date getSolarYear]];
}

- (void)layoutSubviews {
    self.backgroundView.frame = self.bounds;
    self.solarMonthAndYearLabel.frame = self.bounds;
}

- (UILabel *)solarMonthAndYearLabel{
    if (!_solarMonthAndYearLabel) {
           _solarMonthAndYearLabel = UILabel.new;
           [_solarMonthAndYearLabel setFont:[UIFont boldSystemFontOfSize:17]];
                                                _solarMonthAndYearLabel.textColor = [UIColor blackColor];
                                                _solarMonthAndYearLabel.textAlignment = NSTextAlignmentCenter;
        _solarMonthAndYearLabel.text = @"Tháng 2 năm 2020";
           [self addSubview:_solarMonthAndYearLabel];
       }
       return _solarMonthAndYearLabel;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = UIView.new;
        _backgroundView.frame = self.bounds;
        [_backgroundView setAlpha:0.5];
        
        _backgroundView.layer.cornerRadius = 15;
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_backgroundView.bounds cornerRadius:_backgroundView.layer.cornerRadius].CGPath;
        _backgroundView.layer.shadowColor = UIColor.blackColor.CGColor;
        _backgroundView.layer.shadowOpacity = 0.5;
        _backgroundView.layer.shadowOffset = CGSizeMake(2, 2);
        _backgroundView.layer.shadowRadius = 1;
        _backgroundView.layer.masksToBounds = false;
        [self insertSubview:_backgroundView atIndex:0];
    }
    return _backgroundView;
}

@end
