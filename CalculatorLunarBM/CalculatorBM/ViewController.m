//
//  ViewController.m
//  CalculatorBM
//
//  Created by vincent on 2/6/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "ViewController.h"
#import "BMYear.h"
#import "BMMonth.h"
#import "BMDay.h"
#import "BMDate.h"
#import "LunarUtils.h"
#import "LunarCalendarView.h"
#import "SolarCalendarView.h"
#import "LunarDatePickerView.h"

@interface ViewController ()
@property (nonatomic, strong) LunarCalendarView * lunarCalendarView;
@property (nonatomic, strong) SolarCalendarView * solarCalenDarView;

@property (nonatomic, strong) UIImageView * backgroundTemp;
@property (nonatomic, strong) UITextField * inputDateTF;
@property (nonatomic, strong) BMDate * date;

@property (nonatomic, strong) UIButton * commitBtn;
@property (nonatomic, strong) LunarDatePickerView * lunarDatePickerView;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];

         [self.view addGestureRecognizer:tap];
    BMDate * bmDate2 = [[BMDate alloc] initDate:3 :12 :2033 andTimeZone:7];
    
    
//        NSLog(@"month :%@", [BMDate getMonthArr:2033 andTypeCalendar:TypeCalendarAmLich]);
//    [LunarUtils convertSolarToLunar:11 mm:11 yy:1985 timeZone:7];
    [BMDate getDaysInYear:0 month:0 andTypeOfCalendar:TypeCalendarAmLich];
//    BMDate * bmDate3 = [BMDate getCurrentDateComponents];
//    NSLog(@"ngay am lich %tu", bmDate.getLunarDay);
//    NSLog(@"thang am lich %tu", bmDate.getLunarMonth);
//    NSLog(@"nam am lich %tu", bmDate.getlunarYear);
//    NSLog(@"thu %@", bmDate.dayOfWeek);
//
//    NSLog(@"ngay can chi %@", bmDate.getNgayCanChi);
//    NSLog(@"thang can chi %@", bmDate.getThangCanChi);
//    NSLog(@"nam can chi %@", bmDate.getNamCanChi);
    [self loadUI];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LunarDatePickerView *datePicker = LunarDatePickerView.new;
   
    datePicker.typeOfCalendar = TypeCalendarDuongLich;
    datePicker.selectDate = self.date;
    [datePicker show];
}

- (void)loadUI {
    self.backgroundTemp.frame = self.view.bounds;
    self.solarCalenDarView.frame = self.view.bounds;
    self.lunarCalendarView.frame = CGRectMake(0, HEIGHT_SCREEN - 160, WITDTH_SCREEN, 130);
    self.inputDateTF.frame = CGRectMake(0, 0, 200, 50);
    self.inputDateTF.center = self.view.center;
     self.commitBtn.frame = CGRectMake(0, 0, 100, 40);
    self.commitBtn.center = CGPointMake(self.view.frame.size.width/2, self.inputDateTF.frame.origin.y + 80);
  
}
- (void)commitDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    //dateFormatter.dateFormat = @"dd-MM-yyyy";

    NSDate *date = [dateFormatter dateFromString:self.inputDateTF.text];
    if(date == nil) {
        NSLog(@"incorrect format");
    } else {
        BMDate *newDate = [[BMDate alloc] initDate:self.inputDateTF.text andTimeZone:LOCAL_TIMEZONE];
        self.date = newDate;
                [self dismissKeyboard];
                [self.lunarCalendarView loadDateWithInput:self.date];
                [self.solarCalenDarView loadDateWithInput:self.date];
    }
}

-(void)dismissKeyboard {
    [self.inputDateTF resignFirstResponder];
}

- (UIImageView *)backgroundTemp {
    if (!_backgroundTemp) {
        _backgroundTemp = UIImageView.new;
//        _backgroundTemp.backgroundColor = [UIColor redColor];
        _backgroundTemp.image = [UIImage imageNamed:@"background"];
        [self.view addSubview:_backgroundTemp];
    }
    return _backgroundTemp;
}

- (UITextField *)inputDateTF {
    if (!_inputDateTF) {
        _inputDateTF = UITextField.new;
        _inputDateTF.placeholder = @"dd/mm/yy";
        _inputDateTF.layer.borderColor = [UIColor grayColor].CGColor;
     
        _inputDateTF.borderStyle = UITextBorderStyleRoundedRect;
        _inputDateTF.layer.masksToBounds = YES;
        _inputDateTF.layer.cornerRadius = 10;
        _inputDateTF.layer.borderWidth = 1.0f;
        [self.view addSubview:_inputDateTF];
    }
    return _inputDateTF;
    
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = UIButton.new;
        _commitBtn.backgroundColor = [UIColor blueColor];
        [_commitBtn setTitle:@"Commit" forState:UIControlStateNormal];
        _commitBtn.layer.cornerRadius = 5;
        [_commitBtn addTarget:self action:@selector(commitDate) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_commitBtn];
    }
    return _commitBtn;
}

- (SolarCalendarView *)solarCalenDarView {
    if (!_solarCalenDarView) {
        _solarCalenDarView = SolarCalendarView.new;
        [self.view addSubview:_solarCalenDarView];
    }
    return _solarCalenDarView;
}
- (LunarCalendarView *)lunarCalendarView {
    if (!_lunarCalendarView) {
        _lunarCalendarView = LunarCalendarView.new;
        
        [self.view addSubview:_lunarCalendarView];
    }
    return _lunarCalendarView;
}
 
- (LunarDatePickerView *)lunarDatePickerView {
    if (!_lunarDatePickerView) {
        _lunarDatePickerView = LunarDatePickerView.new;
        
    }
    return _lunarDatePickerView;
}
@end
