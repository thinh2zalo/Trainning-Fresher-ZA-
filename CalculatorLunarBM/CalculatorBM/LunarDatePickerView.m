//
//  LunarDatePickerView.m
//  CalculatorBM
//
//  Created by vincent on 2/13/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "LunarDatePickerView.h"
#import "define.h"
#import "BMDate.h"


@interface LunarDatePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView * lunarDatePickerView;
@property (nonatomic, strong) UIView * alertView;
@property (nonatomic, strong) UIView * maskView;

@property(nonatomic, strong) NSArray *yearArr;
@property(nonatomic, strong) NSArray *monthArr;
@property(nonatomic, strong) NSArray *dayArr;
@property(nonatomic, strong) NSArray *typeCalendarArr;

@property(nonatomic, assign) NSInteger yearIndex;
@property(nonatomic, assign) NSInteger monthIndex;
@property(nonatomic, assign) NSInteger dayIndex;
@property(nonatomic, assign) NSInteger typeCalendarIndex;



@end
@implementation LunarDatePickerView

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    TypeOfColumnPicker typeOfColumnPicker = (TypeOfColumnPicker) component;
    switch (typeOfColumnPicker) {
        case ColumnTypeCalendar:
            self.typeCalendarIndex = row;
            self.yearIndex = self.selectDate.getlunarYear;
            self.monthIndex = self.selectDate.getLunarMonth;
            self.dayIndex = self.selectDate.getLunarDay;
            [self reloadDateArrayWithUpdateYear:YES updateMonth:YES updateDay:YES];
            [self.lunarDatePickerView reloadComponent:ColumnYear];
            [self.lunarDatePickerView reloadComponent:ColumnMonth];
            [self.lunarDatePickerView reloadComponent:ColumnDay];
            break;
        case ColumnDay:
                
            break;
        case ColumnMonth:
            
            break;
        case ColumnYear:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray * rowsArr = NSArray.new;
    rowsArr = @[@(self.typeCalendarArr.count), @(self.dayArr.count), @(self.monthArr.count),@(self.yearArr.count)];
    return [rowsArr[component] integerValue];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
    TypeOfColumnPicker typeOfColumnPicker = (TypeOfColumnPicker) component;
    if (!label) {
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    switch (typeOfColumnPicker) {
        case ColumnTypeCalendar:
            label.text = self.typeCalendarArr[row];
            break;
        case ColumnDay:
            label.text = self.dayArr[row];
            break;
        case ColumnMonth:
            label.text = self.monthArr[row];
            break;
        case ColumnYear:
            label.text = self.yearArr[row];
            break;
            
        default:
            break;
    }
    return label;
}



#pragma mark - UIPickerViewDelegate
- (void)setupUI {
    self.frame = SCREEN_BOUNDS;
    [self addSubview:self.maskView];

    [self addSubview:self.alertView];

    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIWindow *keyWindow;
    if (@available(iOS 13.0, *)) {
        if ([UIApplication sharedApplication].supportsMultipleScenes) {
            return;
        }
        NSSet <UIScene *> *windowScenes = [UIApplication sharedApplication].connectedScenes;
        for (UIWindowScene *windowScene in windowScenes.allObjects) {
            if ([windowScene isKindOfClass:[UIWindowScene class]]) {
                keyWindow = ((id <UIWindowSceneDelegate>)windowScene.delegate).window;
            }
        }
        if (!keyWindow) {
            keyWindow = [UIApplication sharedApplication].windows.firstObject;
        }
    } else {
        keyWindow = [UIApplication sharedApplication].delegate.window;
    }
    
    if (!keyWindow) {
        return;
    }
    
    [keyWindow addSubview:self];
    CGRect rect = self.alertView.frame;
    rect.origin.y = HEIGHT_SCREEN;
    self.alertView.frame = rect;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat alertViewHeight = self.alertView.bounds.size.height;
        CGRect rect = self.alertView.frame;
        rect.origin.y -= alertViewHeight;
        self.alertView.frame = rect;
    }];
}

- (void)reloadDateArrayWithUpdateYear:(BOOL)updateYear updateMonth:(BOOL)updateMonth updateDay:(BOOL)updateDay {
    if (self.yearArr.count == 0) {
           return;
       }
    if (updateMonth) {
       self.monthArr = [BMDate getMonthArr:self.selectDate.getlunarYear andTypeCalendar:self.typeOfCalendar];
    }
    if (updateDay) {
//        self.dayArr = [BMDate getday];

    }
}


- (void)removeLunarDatePicker {
    [UIView animateWithDuration:0.2 animations:^{
            CGFloat alertViewHeight = self.alertView.bounds.size.height;
            CGRect rect = self.alertView.frame;
            rect.origin.y += alertViewHeight;
            self.alertView.frame = rect;
            self.maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    
}

- (void)didTapMaskView {
    [self removeLunarDatePicker];
}

- (void)show {
    [self loadData];
    [self setupUI];
    [self.alertView addSubview:self.lunarDatePickerView];
}
// handle data
- (void)loadData {
    [self handlerDefaultSelectDate];
    [self initDateArray];
    [self scrollToSelectDate:self.selectDate andTypeOfCalendar:self.typeOfCalendar animated:YES];
}

- (void)handlerDefaultSelectDate {
    if (!_selectDate) {
        self.typeOfCalendar = TypeCalendarDuongLich;
        self.selectDate = [BMDate getCurrentDate];
    }
}

-(void)initDateArray {
    self.typeCalendarArr = [BMDate getTypeCalendars];
    if (self.typeOfCalendar == TypeCalendarDuongLich) {
//         self.dayArr = [BMDate getDayArr:self. month:<#(NSInteger)#>];
        self.monthArr = [BMDate getMonthArr:self.selectDate.getSolarYear andTypeCalendar:self.typeOfCalendar];
           self.yearArr = [BMDate getYearArrWithStartYear:STARTYEAR andEndYear:ENDYEAR];
    }
   
}

- (UIPickerView *)lunarDatePickerView {
    if (!_lunarDatePickerView) {
        _lunarDatePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, WITDTH_SCREEN, 200)];
        _lunarDatePickerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _lunarDatePickerView.dataSource = self;
        _lunarDatePickerView.delegate = self;
    }
    return _lunarDatePickerView;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WITDTH_SCREEN, 200)];
        UIView *shadowLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _alertView.frame.size.width, 1.0f)];
        shadowLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_alertView addSubview:shadowLineView];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _alertView;
}



- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
        _maskView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.4f];
        _maskView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _maskView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapMaskView)];
        [_maskView addGestureRecognizer:myTap];
    }
    return _maskView;
}

- (void)scrollToSelectDate:(BMDate *)selectDate andTypeOfCalendar:(TypeOfCalendar)typeOfCalendar animated:(BOOL)animated {
    NSInteger yearIndex = selectDate.getSolarYear - STARTYEAR;
     NSInteger monthIndex = selectDate.getSolarMonth -1 ;
     NSInteger dayIndex = selectDate.getSolarDay - 1;

    NSArray * indexArr = @[ @(typeOfCalendar), @(dayIndex), @(monthIndex), @(yearIndex)];
    
    for (NSInteger i = 0; i < indexArr.count; i++) {
        [self.lunarDatePickerView selectRow:[indexArr[i] integerValue] inComponent:i animated:animated];
    }

}


- (NSArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSArray array];
    }
    return _yearArr;
}

- (NSArray *)monthArr {
    if (!_monthArr) {
        _monthArr = [NSArray array];
    }
    return _monthArr;
}

- (NSArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSArray array];
    }
    return _dayArr;
}

- (NSArray *)typeCalendarArr {
    if (!_typeCalendarArr) {
        _typeCalendarArr = [NSArray array];
    }
    return _typeCalendarArr;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
