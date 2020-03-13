//
//  LunarView.m
//  CalculatorBM
//
//  Created by vincent on 2/12/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "LunarCalendarView.h"
#import "define.h"
@interface LunarCalendarView()
@property (nonatomic, strong) UILabel * lunarHourTitleLabel;
@property (nonatomic, strong) UILabel * hourLabel;
@property (nonatomic, strong) UILabel * hourCanChiLabel;
@property (nonatomic, strong) UIView * hourView;

@property (nonatomic, strong) UILabel * lunarDayTitleLabel;
@property (nonatomic, strong) UILabel * lunarDayLabel;
@property (nonatomic, strong) UILabel * canChiDayLabel;
@property (nonatomic, strong) UIView * lunarDayView;

@property (nonatomic, strong) UILabel * lunarMonthTitleLabel;
@property (nonatomic, strong) UILabel * lunarMonthLabel;
@property (nonatomic, strong) UILabel * canChiMonthLabel;
@property (nonatomic, strong) UILabel * canChiYearLabel;

@property (nonatomic, strong) UIView * lunarMonthView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIView *separatorView2;
@property (nonatomic, strong) UIView *backgroundView;



@end
@implementation LunarCalendarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)layoutSubviews {
   self.backgroundView.frame = self.bounds;

    // hourView
    CGFloat heightLabel = self.frame.size.height/4;
    self.hourView.frame = CGRectMake(0, 0 , self.frame.size.width/3, self.frame.size.height);
    self.lunarHourTitleLabel.frame = CGRectMake(self.hourView.frame.origin.x, self.hourView.frame.origin.y, self.hourView.frame.size.width, heightLabel);
    
    self.hourLabel.frame = CGRectMake(0, self.lunarHourTitleLabel.frame.size.height, self.hourView.frame.size.width, heightLabel);
    
      self.hourCanChiLabel.frame = CGRectMake(0, self.lunarHourTitleLabel.frame.size.height * 3, self.hourView.frame.size.width, heightLabel);
    
    // lunarDayView
    self.lunarDayView.frame = CGRectMake(self.frame.size.width/3, self.hourView.frame.origin.y, self.hourView.frame.size.width, self.frame.size.height);
    
    self.lunarDayTitleLabel.frame = CGRectMake(0, self.lunarDayView.frame.origin.y, self.lunarDayView.frame.size.width,heightLabel);
    
    self.lunarDayLabel.frame = CGRectMake(self.lunarDayTitleLabel.frame.origin.x, heightLabel, self.lunarDayView.frame.size.width,heightLabel);
    
     self.canChiDayLabel.frame = CGRectMake(self.lunarDayTitleLabel.frame.origin.x, heightLabel * 3 , self.lunarDayView.frame.size.width,heightLabel);
    
    // lunarMonthView
    self.lunarMonthView.frame = CGRectMake((self.frame.size.width/3) * 2, self.hourView.frame.origin.y , self.hourView.frame.size.width, self.frame.size.height);
    
    self.lunarMonthTitleLabel.frame = CGRectMake(0, 0, self.lunarMonthView.frame.size.width, heightLabel);
    
     self.lunarMonthLabel.frame = CGRectMake(0, heightLabel, self.lunarMonthView.frame.size.width, heightLabel);

     self.canChiMonthLabel.frame = CGRectMake(0,  heightLabel * 2 + 10, self.lunarMonthView.frame.size.width, heightLabel);

     self.canChiYearLabel.frame = CGRectMake(0,  heightLabel * 3, self.lunarMonthView.frame.size.width, heightLabel);
    
    self.separatorView.frame = CGRectMake(self.frame.size.width/3,
                                          0,
                                          2,
                                          self.frame.size.height);
    
    self.separatorView2.frame = CGRectMake((self.frame.size.width/3) * 2,
                                            0,
                                            2,
                                            self.frame.size.height);
}

- (void)loadDateWithInput:(BMDate *)date {
    self.lunarDayLabel.text =  [NSString stringWithFormat:@"%tu", [date getLunarDay]];
    self.canChiDayLabel.text = [date getNgayCanChi];
    self.lunarMonthLabel.text = [NSString stringWithFormat:@"%tu", [date getLunarMonth]];
    self.canChiMonthLabel.text = [date getThangCanChi];
    self.canChiYearLabel.text = [date getNamCanChi];
}



// hourView
- (UIView *) hourView {
    if (!_hourView) {
        _hourView = UIView.new;
        [self addSubview:_hourView];
    }
    return _hourView;
}

- (UILabel *)hourCanChiLabel {
    if (!_hourCanChiLabel) {
        _hourCanChiLabel = UILabel.new;
        
        _hourCanChiLabel.textColor = [UIColor whiteColor];
        [_hourCanChiLabel setFont:[UIFont boldSystemFontOfSize:14]];

        _hourCanChiLabel.textAlignment = NSTextAlignmentCenter;
        _hourCanChiLabel.text = @"Can Chi";
        [self.hourView addSubview:_hourCanChiLabel];
    }
    return _hourCanChiLabel;
}

- (UILabel *)lunarHourTitleLabel {
    if (!_lunarHourTitleLabel) {
        
        _lunarHourTitleLabel = UILabel.new;
        [_lunarHourTitleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        _lunarHourTitleLabel.textColor = [UIColor whiteColor];
        _lunarHourTitleLabel.textAlignment = NSTextAlignmentCenter;
        _lunarHourTitleLabel.text = @"Giờ";
        [self.hourView addSubview:_lunarHourTitleLabel];
    }
    return _lunarHourTitleLabel;
}

- (UILabel *)hourLabel {
    if (!_hourLabel) {
        _hourLabel = UILabel.new;
        _hourLabel.textColor = [UIColor whiteColor];
        [_hourLabel setFont:[UIFont boldSystemFontOfSize:17]];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.text = @"13:54";
        [self.hourView addSubview:_hourLabel];
    }
    return _hourLabel;
}

// lunarDayView
- (UIView *)lunarDayView {
    if (!_lunarDayView) {
        _lunarDayView = UIView.new;
        [self addSubview:_lunarDayView];
    }
    return _lunarDayView;
    
}

- (UILabel *)lunarDayTitleLabel {
    if (!_lunarDayTitleLabel) {
        _lunarDayTitleLabel = UILabel.new;
        [_lunarDayTitleLabel setFont:[UIFont boldSystemFontOfSize:17]];
               _lunarDayTitleLabel.textColor = [UIColor whiteColor];
               _lunarDayTitleLabel.textAlignment = NSTextAlignmentCenter;
        _lunarDayTitleLabel.text = @"Ngày";
        [self.lunarDayView addSubview:_lunarDayTitleLabel];
    }
    return _lunarDayTitleLabel;
}

- (UILabel *)canChiDayLabel {
    if (!_canChiDayLabel) {
        _canChiDayLabel = UILabel.new;
        [_canChiDayLabel setFont:[UIFont boldSystemFontOfSize:14]];
                      _canChiDayLabel.textColor = [UIColor whiteColor];
                      _canChiDayLabel.textAlignment = NSTextAlignmentCenter;
               _canChiDayLabel.text = @"Can Chi";
        [self.lunarDayView addSubview:_canChiDayLabel];
    }
    return _canChiDayLabel;
}

- (UILabel *)lunarDayLabel {
    if (!_lunarDayLabel) {
        _lunarDayLabel = UILabel.new;
        [_lunarDayLabel setFont:[UIFont boldSystemFontOfSize:24]];
               _lunarDayLabel.textColor = [UIColor whiteColor];
               _lunarDayLabel.textAlignment = NSTextAlignmentCenter;
        _lunarDayLabel.text = @"19";
        [self.lunarDayView addSubview:_lunarDayLabel];
    }
    return _lunarDayLabel;
}

// monthView
- (UIView *)lunarMonthView {
    if (!_lunarMonthView) {
        _lunarMonthView = UIView.new;
        [self addSubview:_lunarMonthView];
    }
    return _lunarMonthView;
}

- (UILabel *)lunarMonthTitleLabel {
    if (!_lunarMonthTitleLabel) {
        _lunarMonthTitleLabel = UILabel.new;
        [_lunarMonthTitleLabel setFont:[UIFont boldSystemFontOfSize:17]];
                      _lunarMonthTitleLabel.textColor = [UIColor whiteColor];
                      _lunarMonthTitleLabel.textAlignment = NSTextAlignmentCenter;
               _lunarMonthTitleLabel.text = @"Tháng";
        [self.lunarMonthView addSubview:_lunarMonthTitleLabel];
    }
    return _lunarMonthTitleLabel;
}

- (UILabel *)lunarMonthLabel {
    if (!_lunarMonthLabel) {
        _lunarMonthLabel = UILabel.new;
        [_lunarMonthLabel setFont:[UIFont boldSystemFontOfSize:17]];
                             _lunarMonthLabel.textColor = [UIColor whiteColor];
                             _lunarMonthLabel.textAlignment = NSTextAlignmentCenter;
                      _lunarMonthLabel.text = @"4";
        [self.lunarMonthView addSubview:_lunarMonthLabel];
    }
    return _lunarMonthLabel;
}

- (UILabel *)canChiMonthLabel {
    if (!_canChiMonthLabel) {
        _canChiMonthLabel = UILabel.new;
        [_canChiMonthLabel setFont:[UIFont boldSystemFontOfSize:14]];
                                   _canChiMonthLabel.textColor = [UIColor whiteColor];
                                   _canChiMonthLabel.textAlignment = NSTextAlignmentCenter;
                            _canChiMonthLabel.text = @"Can Chi Month";
        [self.lunarMonthView addSubview:_canChiMonthLabel];
    }
    return _canChiMonthLabel;
}

- (UILabel *)canChiYearLabel {
    if (!_canChiYearLabel) {
        _canChiYearLabel = UILabel.new;
        [_canChiYearLabel setFont:[UIFont boldSystemFontOfSize:14]];
                                        _canChiYearLabel.textColor = [UIColor whiteColor];
                                        _canChiYearLabel.textAlignment = NSTextAlignmentCenter;
                                 _canChiYearLabel.text = @"Can Chi Year";
        [self.lunarMonthView addSubview:_canChiYearLabel];
    }
    return _canChiYearLabel;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        [self addSubview:_separatorView];
    }
    return _separatorView;
    
}
- (UIView *)separatorView2 {
    if (!_separatorView2) {
        _separatorView2 = [[UIView alloc] init];
        _separatorView2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        [self addSubview:_separatorView2];
    }
    return _separatorView2;
    
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = UIView.new;
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView setAlpha:0.3];
        [self insertSubview:_backgroundView atIndex:0];
    }
    return _backgroundView;
}



@end
