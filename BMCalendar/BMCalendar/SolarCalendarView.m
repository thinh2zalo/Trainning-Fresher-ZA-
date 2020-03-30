//
//  SolarCalenDarView.m
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "SolarCalendarView.h"
#import "DateModel.h"

@interface SolarCalendarView()


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
    self.solarDayLabel.frame = CGRectMake(0, 0, 200, 250);
    self.solarDayLabel.center = CGPointMake(self.frame.size.width/2, 200);
    self.dayOfWeekLabel.frame = CGRectMake(0, 0, 150, 40);
    self.dayOfWeekLabel.center = CGPointMake(self.frame.size.width/2, 280);
    self.quoteLabel.frame = CGRectMake(0, 0, self.frame.size.width - 100, 200);
    self.quoteLabel.center = CGPointMake(self.frame.size.width/2,self.dayOfWeekLabel.frame.origin.y + self.dayOfWeekLabel.frame.size.height + 50);
}

- (void)loadDateWithInput:(DateModel *)dataModel {
    BMDate * date = [[BMDate alloc] initLocalDate:dataModel.jdn];
    self.solarMonthAndYearLabel.text = [NSString stringWithFormat:@"Tháng %tu năm %tu", [date getSolarMonth], [date getSolarYear]];
    self.solarDayLabel.text = [NSString stringWithFormat:@"%tu", [date getSolarDay]];
    self.dayOfWeekLabel.text = [date dayOfWeek];
    self.quoteLabel.text = dataModel.quote;
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

- (UILabel *)quoteLabel {
    if (!_quoteLabel) {
        _quoteLabel = UILabel.new;
        [_quoteLabel setNumberOfLines:5];
        _quoteLabel.textAlignment = NSTextAlignmentCenter;
        [_quoteLabel setFont:[UIFont boldSystemFontOfSize:15]];
                                                          _quoteLabel.textColor = [UIColor whiteColor];
        [self addSubview:_quoteLabel];
        
    }
    return _quoteLabel;
    
}

- (UIImageView *)image{
    if (!_image) {
        _image = UIImageView.new;
        [self addSubview:_image];
    }
    return _image;
}

@end
