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
#import "BMDatePickerView.h"
#import "BMPageViewController.h"
#import "SolarViewController.h"

@interface ViewController () <BMDatePickerViewDelegate, BMPageViewControllerDelegate>
@property (nonatomic, strong) LunarCalendarView * lunarCalendarView;
@property (nonatomic, strong) SolarCalendarView * solarCalenDarView;

@property (nonatomic, strong) UIImageView * backgroundTemp;
@property (nonatomic, strong) UITextField * inputDateTF;
@property (nonatomic, strong) BMDate * date;
@property (nonatomic, strong) NSArray * arrVC;
@property (nonatomic, strong) UIButton * commitBtn;
@property (nonatomic, strong) BMDatePickerView * lunarDatePickerView;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tap];
       
    
    [self loadUI];

}

- (void)pageViewCurrentDate:(BMDate *)currentDate {
    [self.lunarCalendarView loadDateWithInput:currentDate];

}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    BMDatePickerView *datePicker = BMDatePickerView.new;
//   
//    datePicker.typeOfCalendar = TypeCalendarDuongLich;
//    datePicker.selectDate = self.date;
//    datePicker.delegate = self;
//    [datePicker show];
//}

// BMDatePickerViewDelegate
- (void)didSelectDate:(BMDate *)bmDate {
   [self.lunarCalendarView loadDateWithInput:bmDate];
   [self.solarCalenDarView loadDateWithInput:bmDate];
    
}


- (void)loadUI {
    self.backgroundTemp.frame = self.view.bounds;

    NSInteger currentJDN = [BMDate getCurrentJulianDayNumber];
    SolarViewController *vc1 = [[SolarViewController alloc] initWithJDN:currentJDN];
    SolarViewController *vc2 = [[SolarViewController alloc] init];
    SolarViewController *vc3 = [[SolarViewController alloc] init];
    
    self.arrVC = @[vc1,vc2,vc3];
    
    BMPageViewController * pageVC = [[BMPageViewController alloc] initWithFrame:self.view.bounds controllers:self.arrVC];
    
    [self addChildViewController:pageVC];
    pageVC.BMPaingdelegate  = self;
    [self.view addSubview:pageVC.view];
    [pageVC didMoveToParentViewController:self];
//    self.solarCalenDarView.frame = self.view.bounds;
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
        _inputDateTF.placeholder = @"dd/mm/yyyy";
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
 
- (BMDatePickerView *)lunarDatePickerView {
    if (!_lunarDatePickerView) {
        _lunarDatePickerView = BMDatePickerView.new;
    }
    return _lunarDatePickerView;
}
- (NSArray *)arrVC {
    if (!_arrVC) {
        _arrVC = NSArray.new;
    }
    return _arrVC;
}
@end
