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
#import "SingletonAPI.h"
#import "SolarMonthYearView.h"

@interface ViewController () <BMDatePickerViewDelegate, BMPageViewControllerDelegate, BMPageViewControllerDataSource>
@property (nonatomic, strong) LunarCalendarView * lunarCalendarView;
@property (nonatomic, strong) SolarCalendarView * solarCalenDarView;

@property (nonatomic, strong) UIImageView * backgroundTemp;
@property (nonatomic, strong) UITextField * inputDateTF;
@property (nonatomic, strong) BMDate * date;
@property (nonatomic, strong) NSArray * arrVC;
@property (nonatomic, strong) UIButton * commitBtn;
@property (nonatomic, strong) SolarMonthYearView * solarMonthYearView;
@property (nonatomic, strong) BMDatePickerView * lunarDatePickerView;
@property (nonatomic, strong) BMPageViewController * pageViewController;
@property (nonatomic, strong) UIImageView * backgroundImgView;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SingletonAPI.sharedInstance getQuotationArr];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    // create 3 viewcontroller
    SolarViewController *newVC1 = SolarViewController.new;
    BMDate * currentDate = [BMDate getCurrentDate];
    NSInteger jdn = [currentDate getJulianDayNumber];
    DateModel *model = [self createDataModel:jdn];
    [newVC1 setDataModel:model];
    SolarViewController *newVC2 = SolarViewController.new;
    SolarViewController *newVC3 = SolarViewController.new;
    
    [self.backgroundImgView sd_setImageWithURL:[SingletonAPI.sharedInstance getURLImage:jdn]
          placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.backgroundImgView.sd_imageIndicator = SDWebImageActivityIndicator.grayIndicator;

    [self.lunarCalendarView loadDateWithInput:currentDate];

    self.arrVC = @[newVC1,newVC2,newVC3];
    [self loadUI];
}


// MARK: - BMDatePickerViewDelegate
- (void)didSelectDate:(BMDate *)bmDate {
    [self setDate:bmDate];
}

// MARK: - BMPageViewControllerDelegate

- (void)bmPageViewController:(BMPageViewController *)bmPageViewController willScrollToPageAt:(NSInteger)index direction:(NavigationDirection)direction animated:(BOOL)animated {
    SolarViewController *currentSolarViewController = (SolarViewController *)self.arrVC[bmPageViewController.getCurrentIndex];
    
    switch (direction) {
        case DirectionForword:{
            NSInteger nextJDN = [currentSolarViewController getDataModel].jdn + 1;
            DateModel *model = [self createDataModel:nextJDN];
            [self.arrVC[index] setDataModel:model];
        }
            break;
        case DirectionReverse:{
            NSInteger preJDN = [currentSolarViewController getDataModel].jdn - 1;
            DateModel *model = [self createDataModel:preJDN];
            [self.arrVC[index] setDataModel:model];
        }
            break;
            
        default:
            break;
    }
}

// MARK: - BMPageViewControllerDataSource


- (NSInteger)numberOfViewControllers:(BMPageViewController *)bmPageViewController {
    return self.arrVC.count;
}

- (UIViewController *)viewControllerFor:(BMPageViewController *)bmPageViewController atIndex:(NSInteger)index {
    return self.arrVC[index];
}

- (NSInteger)defaultPage {
    return 0;
}

- (void)loadUI {
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view addSubview:self.pageViewController.view];
    self.backgroundImgView.frame = self.view.bounds;
    self.lunarCalendarView.frame = CGRectMake(0, HEIGHT_SCREEN - 160, WITDTH_SCREEN, 130);
    self.pageViewController.view.frame = self.view.bounds;
    self.solarMonthYearView.frame = CGRectMake(0, 0, 200, 50);
    self.solarMonthYearView.center = CGPointMake(self.view.frame.size.width/2, 100);
}


- (DateModel *)createDataModel:(NSInteger)jdn {
    NSString *quote = [SingletonAPI.sharedInstance getQuote:jdn];
    NSURL *urlImage = [SingletonAPI.sharedInstance getURLImage:jdn];
    return [[DateModel alloc] initWithDate:jdn quote:quote imageURL:urlImage];
}

-(void)dismissKeyboard {
    [self.inputDateTF resignFirstResponder];
}

- (UIImageView *)backgroundTemp {
    if (!_backgroundTemp) {
        _backgroundTemp = UIImageView.new;
        _backgroundTemp.image = [UIImage imageNamed:@"background"];
        [self.view addSubview:_backgroundTemp];
    }
    return _backgroundTemp;
}


-(void)bmPageViewController:(BMPageViewController *)bmPageViewController didScrollTo:(NSInteger)index {
    SolarViewController * solarShowed =  self.arrVC[bmPageViewController.getCurrentIndex];
    DateModel * modelShowed = solarShowed.getDataModel;
    BMDate * date = [[BMDate alloc] initLocalDate:modelShowed.jdn];
    [self setDate:date];
}

-(void)loadUIWith:(BMDate *)date {
    if (!date) {
        return;
    }
    [self.solarMonthYearView loadDateWithInput:date];

    SolarViewController * solarShowed = self.arrVC[self.pageViewController.getCurrentIndex];
    if (!solarShowed) {
        return;
    }
    
    DateModel * dataModelShowed = [self createDataModel:date.getJulianDayNumber];
    if (!dataModelShowed) {
        return;
    }
    [solarShowed setDataModel:dataModelShowed];

    [self.backgroundImgView sd_setImageWithURL:[SingletonAPI.sharedInstance getURLImage:date.getJulianDayNumber]
     
    placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.lunarCalendarView loadDateWithInput:date];
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

- (SolarCalendarView *)solarCalenDarView {
    if (!_solarCalenDarView) {
        _solarCalenDarView = SolarCalendarView.new;
        [self.view addSubview:_solarCalenDarView];
    }
    return _solarCalenDarView;
}

- (BMPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = BMPageViewController.new;
        _pageViewController.BMPaingDelegate = self;
        _pageViewController.BMPaingDataSource = self;
    }
    return _pageViewController;
}



-(void)selectDate {
    BMDatePickerView *datePicker = BMDatePickerView.new;
    datePicker.typeOfCalendar = TypeCalendarDuongLich;
    datePicker.selectDate = self.date;
    datePicker.delegate = self;
    [datePicker show];
}

- (void)setDate:(BMDate *)date {
    if (!date || _date == date) {
        return;
    }
    _date = date;
    [self loadUIWith:date];
}

- (SolarMonthYearView *)solarMonthYearView {
    if (!_solarMonthYearView) {
        
        _solarMonthYearView = SolarMonthYearView.new;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDate)];
        [_solarMonthYearView addGestureRecognizer:tap];
        [self.view addSubview:_solarMonthYearView];
    }
    return _solarMonthYearView;
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
- (UIImageView *)backgroundImgView{
    if (!_backgroundImgView) {
        _backgroundImgView = UIImageView.new;
        [self.view addSubview:_backgroundImgView];
    }
    return _backgroundImgView;
}

@end
