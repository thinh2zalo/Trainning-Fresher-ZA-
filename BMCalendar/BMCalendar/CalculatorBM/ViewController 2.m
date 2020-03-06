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
#import "BMButtonLabel.h"
#import "HorizontalPageViewController.h"
#import "SDWebImage.framework/Headers/SDWebImage.h"

@interface ViewController () <BMDatePickerViewDelegate, BMPageViewControllerDelegate, BMPageViewControllerDataSource, HorizontalPageViewControllerDelegate>
@property (nonatomic, strong) LunarCalendarView * lunarCalendarView;
@property (nonatomic, strong) SolarCalendarView * solarCalenDarView;

@property (nonatomic, strong) UIImageView * backgroundTemp;
@property (nonatomic, strong) UITextField * inputDateTF;
@property (nonatomic, strong) BMDate * date;
@property (nonatomic, strong) NSArray * arrVC;
@property (nonatomic, strong) NSArray * arrVerticalVC;

@property (nonatomic, strong) UIButton * commitBtn;
@property (nonatomic, strong) BMButtonLabel * solarMonthYearView;
@property (nonatomic, strong) BMButtonLabel * toDayLabel;

@property (nonatomic, strong) BMDatePickerView * lunarDatePickerView;
@property (nonatomic, strong) BMPageViewController * pageViewController;
@property (nonatomic, strong) BMPageViewController * pageViewControllerVerical;

@property (nonatomic, strong) UIImageView * backgroundImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
    [self.toDayLabel setHidden:YES];

}

- (void)loadData {
    // create 3 viewcontroller
   
    HorizontalPageViewController * horizontalPageViewController1 = HorizontalPageViewController.new;
    horizontalPageViewController1.HorizontalPageViewControllerDelegate = self;
    HorizontalPageViewController * horizontalPageViewController2 = HorizontalPageViewController.new;
    horizontalPageViewController2.HorizontalPageViewControllerDelegate = self;

    HorizontalPageViewController * horizontalPageViewController3 = HorizontalPageViewController.new;
    horizontalPageViewController3.HorizontalPageViewControllerDelegate = self;

    self.arrVC = @[horizontalPageViewController1, horizontalPageViewController2, horizontalPageViewController3];
    BMDate * currentDate = [BMDate getCurrentDate];
    [self.backgroundImgView sd_setImageWithURL:[SingletonAPI.sharedInstance getURLImage:currentDate.getJulianDayNumber]
             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
       self.backgroundImgView.sd_imageIndicator = SDWebImageActivityIndicator.grayIndicator;

       [self.lunarCalendarView loadDateWithInput:currentDate];
    [self.solarMonthYearView loadDateWithInput:currentDate];
    
    [self.toDayLabel setLabelText:@"Hôm nay"];
}

- (void)triggerUpdate:(BMDate *)date {
    [self setDate:date];
    [self loadUIWith:date isUpdateSolarView:NO];
}

- (void)loadUI {
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view insertSubview:self.pageViewController.view atIndex:1];
    self.backgroundImgView.frame = self.view.bounds;
    self.lunarCalendarView.frame = CGRectMake(0, HEIGHT_SCREEN - 160, WITDTH_SCREEN, 130);
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.lunarCalendarView.frame.origin.y);
    self.solarMonthYearView.frame = CGRectMake(0, 0, 170, 40);
    self.solarMonthYearView.center = CGPointMake(self.view.frame.size.width/2, 100);
    self.toDayLabel.frame = CGRectMake(20, self.solarMonthYearView.frame.origin.y,90 , 40);
}


// MARK: - BMDatePickerViewDelegate
- (void)didSelectDate:(BMDate *)bmDate {
    [self setDate:bmDate];
    [self loadUIWith:bmDate isUpdateSolarView:YES];
}

// MARK: - BMPageViewControllerDelegate

- (void)bmPageViewController:(BMPageViewController *)bmPageViewController willScrollToPageAt:(NSInteger)index direction:(NavigationDirection)direction animated:(BOOL)animated {
    HorizontalPageViewController *horizontalPageViewController = (HorizontalPageViewController *)self.arrVC[bmPageViewController.getCurrentIndex];
    if (!horizontalPageViewController) {
        return;
    }
    
    switch (direction) {
        case DirectionForword:{
            NSInteger nextJDN = [horizontalPageViewController  getDateModel].jdn + 7;
            DateModel *model = [DateModel createDataModel:nextJDN];
            [(HorizontalPageViewController *)self.arrVC[index] setDateModel:model];
        }
            break;
        case DirectionReverse: {
            NSInteger nextJDN = [horizontalPageViewController  getDateModel].jdn- 7;
            DateModel *model = [DateModel createDataModel:nextJDN];
            [(HorizontalPageViewController *)self.arrVC[index] setDateModel:model];
        }
            break;
        default:
            break;
    }
}

-(void)bmPageViewController:(BMPageViewController *)bmPageViewController didScrollTo:(NSInteger)index {
    HorizontalPageViewController * solarShowed =  self.arrVC[bmPageViewController.getCurrentIndex];
        DateModel * modelShowed = solarShowed.getDateModel;
    BMDate * date = [[BMDate alloc] initLocalDate:modelShowed.jdn];
    [self setDate:date];
    [self loadUIWith:date isUpdateSolarView:NO];
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



- (UIImageView *)backgroundTemp {
    if (!_backgroundTemp) {
        _backgroundTemp = UIImageView.new;
        _backgroundTemp.image = [UIImage imageNamed:@"background"];
        [self.view addSubview:_backgroundTemp];
    }
    return _backgroundTemp;
}

- (void)loadUIWith:(BMDate *)date isUpdateSolarView:(BOOL)isUpdateSolarView{
    if (!date) {
        return;
    }
    
    [self.solarMonthYearView loadDateWithInput:date];

    HorizontalPageViewController * horizontalPageViewControllerShowed = self.arrVC[self.pageViewController.getCurrentIndex];
    if (!horizontalPageViewControllerShowed) {
        return;
    }
    
    DateModel * dataModelShowed = [DateModel createDataModel:date.getJulianDayNumber];
    if (!dataModelShowed) {
        return;
    }
    [self.toDayLabel setHidden:NO];

    if (self.date.getJulianDayNumber == BMDate.getCurrentJulianDayNumber) {
        [self.toDayLabel setHidden:YES];
    }
    if (isUpdateSolarView) {
        [horizontalPageViewControllerShowed setDateModel:dataModelShowed];
    }
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
        _pageViewController = [[BMPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
        _pageViewController.BMPaingDelegate = self;
        _pageViewController.BMPaingDataSource = self;
    }
    return _pageViewController;
}


 
- (void)selectDate {
    BMDatePickerView *datePicker = BMDatePickerView.new;
    datePicker.typeOfCalendar = TypeCalendarDuongLich;
    datePicker.selectDate = self.date;
    datePicker.delegate = self;
    [datePicker show];
}

- (void)selectToDay {
    [self setDate:[BMDate getCurrentDate]];
    [self loadUIWith:[BMDate getCurrentDate] isUpdateSolarView:YES];
}

- (void)setDate:(BMDate *)date {
    if (!date || _date == date) {
        return;
    }
    _date = date;
}

- (BMButtonLabel *)solarMonthYearView {
    if (!_solarMonthYearView) {
        
        _solarMonthYearView = BMButtonLabel.new;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDate)];
        [_solarMonthYearView addGestureRecognizer:tap];
        [self.view addSubview:_solarMonthYearView];
    }
    return _solarMonthYearView;
}

- (BMButtonLabel *)toDayLabel {
    if (!_toDayLabel) {
        _toDayLabel = BMButtonLabel.new;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectToDay)];
        [_toDayLabel addGestureRecognizer:tap];
        [self.view insertSubview:_toDayLabel aboveSubview:self.pageViewController.view];
    }
    return _toDayLabel;
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

//-(BMPageViewController *)pageViewControllerVerical {
//    if (!_pageViewControllerVerical) {
//        _pageViewControllerVerical = BMPageViewController.new;
//     }
//}

- (UIImageView *)backgroundImgView{
    if (!_backgroundImgView) {
        _backgroundImgView = UIImageView.new;
        [_backgroundImgView setContentMode:UIViewContentModeScaleAspectFill];
        [self.view insertSubview:_backgroundImgView atIndex:0];
    }
    return _backgroundImgView;
}

- (NSArray *)arrVerticalVC {
    if (!_arrVerticalVC) {
        _arrVerticalVC = NSArray.new;
    }
    return _arrVerticalVC;
}


@end
