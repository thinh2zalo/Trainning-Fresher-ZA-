//
//  LunarDatePickerView.m
//  CalculatorBM
//
//  Created by vincent on 2/13/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "BMDatePickerView.h"
#import "define2.h"
#import "BMYear.h"
#import "BMDate.h"
#import "BMDate+Utility.h"



@interface BMDatePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView * datePickerView;
@property (nonatomic, strong) UIView * alertView;
@property (nonatomic, strong) UIView * maskView;

@property(nonatomic, strong) NSArray *yearArr;
@property(nonatomic, strong) NSArray *monthArr;
@property(nonatomic, strong) NSArray *dayArr;
@property(nonatomic, strong) NSArray  *typeCalendarArr;

@property(nonatomic, assign) NSInteger yearIndex;
@property(nonatomic, assign) NSInteger monthIndex;
@property(nonatomic, assign) NSInteger dayIndex;
@property(nonatomic, assign) NSInteger typeCalendarIndex;

@property (nonatomic, strong) UIButton *doneBtn;

@property(nonatomic, assign) TypeOfCalendar  mTypeOfCalendar;
@property(nonatomic, strong) BMDate  *mSelectDate;


@end
@implementation BMDatePickerView

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    TypeOfColumnPicker typeOfColumnPicker = (TypeOfColumnPicker) component;
    switch (typeOfColumnPicker) {
        case ColumnTypeCalendar:
            self.typeCalendarIndex = row;
            self.mTypeOfCalendar = [self.typeCalendarArr[self.typeCalendarIndex] integerValue];
            [self reloadArraysAndIndexs:YES UpdateMonth:YES updateDay:YES];
            [self.datePickerView reloadComponent:ColumnYear];
            [self.datePickerView reloadComponent:ColumnMonth];
            [self.datePickerView reloadComponent:ColumnDay];
            [self scrollToSelectDate:NO];
            break;
            
        case ColumnYear:
            self.yearIndex = row;
            [self reloadArraysAndIndexs:NO UpdateMonth:YES updateDay:YES];
            [self.datePickerView reloadComponent:ColumnMonth];
            [self.datePickerView reloadComponent:ColumnDay];
            [self newDateWithConfig];
            break;
            
        case ColumnMonth:
            self.monthIndex = row;
            [self reloadArraysAndIndexs:NO UpdateMonth:NO updateDay:YES];
            [self.datePickerView reloadComponent:ColumnDay];
            [self newDateWithConfig];
            break;
            
        case ColumnDay:
            self.dayIndex = row;
            [self newDateWithConfig];
            break;
        default:
            break;
    }
}

- (void)newDateWithConfig {
    NSInteger year = [self.yearArr[self.yearIndex] integerValue];
    NSString * monthStr = self.monthArr[self.monthIndex];
    BOOL isLeapLunarMonth = false;
    if ([monthStr containsString:PLUS]) {
        isLeapLunarMonth = true;
    }
    NSInteger month = monthStr.integerValue;
    NSInteger day = [self.dayArr[self.dayIndex] integerValue];
    
    if (self.mTypeOfCalendar == TypeCalendarAmLich) {
        self.mSelectDate = [[BMDate alloc] initDateWithLunarDate:day :month :year isLeapMonth:isLeapLunarMonth andTimeZone:LOCAL_TIMEZONE];
    } else {
        self.mSelectDate = [[BMDate alloc] initDateWithSolarDate:day :month :year andTimeZone:LOCAL_TIMEZONE];
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
        label.frame = CGRectMake(0, 0, 200, 100);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    switch (typeOfColumnPicker) {
        case ColumnTypeCalendar:
            label.text = [self getTypeCalendarText:row];
            break;
        case ColumnDay:
            label.text = [self getDayText:row];
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

- (void)setupUI {
    self.frame = SCREEN_BOUNDS;
    [self addSubview:self.maskView];
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.doneBtn];
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


- (void)removeLunarDatePicker {
    [UIView animateWithDuration:0.3 animations:^{
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
    [self.alertView addSubview:self.datePickerView];
}

// handle data
- (void)loadData {
    [self handlerMinMaxDate];
    [self handlerDefaultSelectDate];
    [self initDateArray];
    [self.datePickerView reloadAllComponents];
    [self scrollToSelectDate:NO];
}

- (void)handlerMinMaxDate{
    if (!self.minDate) {
        self.minDate = [[BMDate alloc] initDateWithSolarDate:STARTDAY :STARTMONTH :STARTYEAR andTimeZone:LOCAL_TIMEZONE];
    }
    if (!self.maxDate) {
        self.maxDate = [[BMDate alloc] initDateWithSolarDate:ENDDAY :ENDMONTH :ENDYEAR andTimeZone:LOCAL_TIMEZONE];
    }
    if ([self.minDate bmDate_compare:self.maxDate]) {
        self.minDate = [[BMDate alloc] initDateWithSolarDate:STARTDAY :STARTMONTH :STARTYEAR andTimeZone:LOCAL_TIMEZONE];
        self.maxDate = [[BMDate alloc] initDateWithSolarDate:ENDDAY :ENDMONTH :ENDYEAR andTimeZone:LOCAL_TIMEZONE];
    }
}

- (void)handlerDefaultSelectDate {
    if (!_typeOfCalendar) {
        self.mTypeOfCalendar = TypeCalendarDuongLich;
    }
    if (!_selectDate) {
        self.mSelectDate = [BMDate getCurrentDate];
    }
    if ([self.mSelectDate bmDate_compare:self.maxDate]) {
        self.mSelectDate = self.maxDate;
    }
    if (![self.mSelectDate bmDate_compare:self.minDate]) {
        self.mSelectDate = self.minDate;
    }
}

// create  arrs + indexs with

-(void)initDateArray {
    self.typeCalendarArr = [BMDate getTypeCalendarArr];
    self.typeCalendarIndex = self.mTypeOfCalendar;
    [self reloadArraysAndIndexs:YES UpdateMonth:YES updateDay:YES];
}

- (void)reloadArraysAndIndexs:(BOOL)updateYear UpdateMonth:(BOOL)updateMonth updateDay:(BOOL)updateDay {
    
    if (updateYear) {
        // get yearArr
        self.yearArr = [BMDate getYearArrWithStartYear:self.minDate andEndYear:self.maxDate andTypeOfCalendar:self.mTypeOfCalendar];
        // get yearIndex
        self.yearIndex = [self.mSelectDate getYearWithTypeCalendar:self.mTypeOfCalendar] - [self.minDate getYearWithTypeCalendar:self.mTypeOfCalendar];
    }
    NSInteger year = [self.yearArr[self.yearIndex] integerValue] ;
    if (updateMonth) {
        // get MonthArr
        self.monthArr = [BMDate getMonthArr:year minDate:self.minDate maxDate:self.maxDate andTypeCalendar:self.mTypeOfCalendar];
        // get MonthIndex
        self.monthIndex = [self findIndexOfElement:[self.mSelectDate getStringMonth:self.mTypeOfCalendar] inArray:self.monthArr];
    }
    NSInteger month = [self.monthArr[self.monthIndex] integerValue];
    if (updateDay) {
        if (self.mTypeOfCalendar == TypeCalendarAmLich) {
            BOOL isLeapMonth = false;
            if ([BMYear isLeapLunarYear:year]) {
                if (self.monthIndex == [BMYear getLeapLunarMonth:year]) {
                    isLeapMonth = true;
                }
            }
            // get DayArr
            self.dayArr = [BMDate getLunarDayArr:year month:month minDate:self.minDate maxDate:self.maxDate isLeapMonth:isLeapMonth];
        } else {
            self.dayArr = [BMDate getSolarDayArr:year month:month minDate:self.minDate maxDate:self.maxDate];
        }
        // get DayIndex
        self.dayIndex = [self findIndexOfElement:@([self.mSelectDate getDayWithTypeCalendar:self.mTypeOfCalendar]).stringValue inArray:self.dayArr];
    }
}

-(NSInteger)findIndexOfElement:(NSString *)element inArray:(NSArray *)arr {
    NSInteger index = 0;
    if ([element containsString:PLUS]) {
        element = [NSString stringWithFormat:@"%tu", element.integerValue + 1];
    }
    if (element.integerValue <= [arr[0] integerValue]) {
        index = 0;
    } else if (element.integerValue >= [arr.lastObject integerValue]) {
        index = arr.count - 1;
    } else {
        index = [arr indexOfObject:element];
    }
    return index;
}

- (void)clickDoneBtn {
    [self.delegate didSelectDate:self.mSelectDate];
    [self removeLunarDatePicker];
}
// lazy init

- (UIPickerView *)datePickerView {
    if (!_datePickerView) {
        _datePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.doneBtn.frame.size.height + 5, WITDTH_SCREEN, 300)];
        _datePickerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _datePickerView.dataSource = self;
        _datePickerView.delegate = self;
    }
    return _datePickerView;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WITDTH_SCREEN, 300)];
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

- (void)scrollToSelectDate:(BOOL)animated{
    NSArray * indexArr = @[@(self.typeCalendarIndex), @(self.dayIndex), @(self.monthIndex), @(self.yearIndex)];
    for (NSInteger i = 0; i < indexArr.count; i++) {
        [self.datePickerView selectRow:[indexArr[i] integerValue] inComponent:i animated:animated];
    }
}

- (NSString *)getDayText:(NSInteger)row {
    NSString *dayString = self.dayArr[row];
    NSInteger jdnOfStartMonth;
    if (self.mTypeOfCalendar == TypeCalendarAmLich) {
        jdnOfStartMonth = self.mSelectDate.getJulianDayNumber - self.mSelectDate.getLunarDay;
    } else {
         jdnOfStartMonth = self.mSelectDate.getJulianDayNumber - self.mSelectDate.getSolarDay;
    }
    dayString = [NSString stringWithFormat:@"%@, %@", [BMDate dayOfWeek:(jdnOfStartMonth + row + 1)] ,dayString];
   return dayString;
}

- (NSString *)getTypeCalendarText:(NSInteger)row {
    NSString *typeCalendarText = DUONGLICH;
    if ([self.typeCalendarArr[row] integerValue] == TypeCalendarAmLich) {
        return AMLICH;
    }
    return typeCalendarText;
}

- (void)setSelectDate:(BMDate *)selectDate {
    if (!selectDate && self.mSelectDate == selectDate) {
        return;
    }
    _selectDate = selectDate;
    _mSelectDate = selectDate;
    if (_datePickerView) {
        [self loadData];
    }
}


- (void)setTypeOfCalendar:(TypeOfCalendar)typeOfCalendar {
    if (!typeOfCalendar && self.mTypeOfCalendar == typeOfCalendar) {
        return;
    }
    _typeOfCalendar = typeOfCalendar;
    _mTypeOfCalendar = typeOfCalendar;
    if (_datePickerView) {
        [self loadData];
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

- (NSInteger)yearIndex {
    if (_yearIndex < 0) {
        _yearIndex = 0;
    } else {
        _yearIndex = MIN(_yearIndex, self.yearArr.count - 1);
    }
    return _yearIndex;
}

- (NSInteger)monthIndex {
    if (_monthIndex < 0) {
        _monthIndex = 0;
    } else {
        _monthIndex = MIN(_monthIndex, self.monthArr.count - 1);
    }
    return _monthIndex;
}

- (NSInteger)dayIndex {
    if (_dayIndex < 0) {
        _dayIndex = 0;
    } else {
        _dayIndex = MIN(_dayIndex, self.dayArr.count - 1);
    }
    return _dayIndex;
}


- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = UIButton.new;
        _doneBtn.frame = CGRectMake(WITDTH_SCREEN - 60 - 30, 10, 60, 28);
        _doneBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_doneBtn addTarget:self action:@selector(clickDoneBtn) forControlEvents:UIControlEventTouchUpInside];
        _doneBtn.layer.cornerRadius = 6.0f;
        _doneBtn.layer.borderWidth = 1.0f;
        [_doneBtn setTitle:@"done" forState:UIControlStateNormal];
        _doneBtn.backgroundColor = [UIColor darkGrayColor];
         _doneBtn.layer.masksToBounds = YES;
        [self.alertView addSubview:_doneBtn];
    }
    return _doneBtn;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
