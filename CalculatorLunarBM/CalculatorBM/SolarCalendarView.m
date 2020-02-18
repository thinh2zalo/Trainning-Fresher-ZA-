//
//  SolarCalenDarView.m
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "SolarCalendarView.h"

@interface SolarCalendarView()
@property (nonatomic, strong) UILabel * solarDayLabel;
@property (nonatomic, strong) UILabel * solarMonthLabel;
@property (nonatomic, strong) UILabel * solarMonthAndYearLabel;

@property (nonatomic, strong) UILabel * solarYearLabel;
@property (nonatomic, strong) UILabel * dayOfWeekLabel;

@end
@implementation SolarCalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    self.solarMonthAndYearLabel.frame = CGRectMake(0, 0, 200, 40);
    self.solarMonthAndYearLabel.center = CGPointMake(self.frame.size.width/2, 100);
    self.solarDayLabel.frame = CGRectMake(0, 0, 200, 200);
    self.solarDayLabel.center = CGPointMake(self.frame.size.width/2, 180);
    self.dayOfWeekLabel.frame = CGRectMake(0, 0, 150, 40);
    self.dayOfWeekLabel.center = CGPointMake(self.frame.size.width/2, 270);
}

- (void)loadDateWithInput:(BMDate *)date {
    self.solarMonthAndYearLabel.text = [NSString stringWithFormat:@"Tháng %tu năm %tu", [date getSolarMonth], [date getSolarYear]];
    self.solarDayLabel.text = [NSString stringWithFormat:@"%tu", [date getSolarDay]];
    self.dayOfWeekLabel.text = [date dayOfWeek];
}


- (UILabel *)solarMonthAndYearLabel{
    if (!_solarMonthAndYearLabel) {
           _solarMonthAndYearLabel = UILabel.new;
           [_solarMonthAndYearLabel setFont:[UIFont boldSystemFontOfSize:20]];
                                                _solarMonthAndYearLabel.textColor = [UIColor whiteColor];
                                                _solarMonthAndYearLabel.textAlignment = NSTextAlignmentCenter;
        _solarMonthAndYearLabel.text = @"Tháng 2 năm 2020";
           [self addSubview:_solarMonthAndYearLabel];
       }
       return _solarMonthAndYearLabel;
    
}

- (UILabel *)solarDayLabel {
    if (!_solarDayLabel) {
        _solarDayLabel = UILabel.new;
        [_solarDayLabel setFont:[UIFont boldSystemFontOfSize:140]];
                                             _solarDayLabel.textColor = [UIColor whiteColor];
                                             _solarDayLabel.textAlignment = NSTextAlignmentCenter;
                                      _solarDayLabel.text = @"17";
        [self addSubview:_solarDayLabel];
    }
    return _solarDayLabel;
}
- (UILabel *)dayOfWeekLabel {
    if (!_dayOfWeekLabel) {
        _dayOfWeekLabel = UILabel.new;
        [_dayOfWeekLabel setFont:[UIFont boldSystemFontOfSize:30]];
                                                    _dayOfWeekLabel.textColor = [UIColor whiteColor];
                                                    _dayOfWeekLabel.textAlignment = NSTextAlignmentCenter;
                                             _dayOfWeekLabel.text = @"Thứ 7";
        [self addSubview:_dayOfWeekLabel];
    }
    return _dayOfWeekLabel;
}


@end
