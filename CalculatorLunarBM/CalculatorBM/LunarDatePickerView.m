//
//  LunarDatePickerView.m
//  CalculatorBM
//
//  Created by vincent on 2/13/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "LunarDatePickerView.h"
#import "define.h"
#import "BMYear.h"
#import "BMDate.h"


@interface LunarDatePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView * lunarDatePickerView;
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



@end
@implementation LunarDatePickerView

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    TypeOfColumnPicker typeOfColumnPicker = (TypeOfColumnPicker) component;
    switch (typeOfColumnPicker) {
        case ColumnTypeCalendar:
            self.typeCalendarIndex = row;
            self.typeOfCalendar = (TypeOfCalendar)self.typeCalendarIndex;
            
            if (self.typeOfCalendar == TypeCalendarAmLich) {
                self.yearIndex = self.selectDate.getlunarYear - STARTYEAR;
                self.monthIndex = self.selectDate.getLunarMonth - 1;
                self.dayIndex = self.selectDate.getLunarDay - 1;
            } else {
                self.yearIndex = self.selectDate.getSolarYear - STARTYEAR;
                self.monthIndex = self.selectDate.getSolarMonth - 1;
                self.dayIndex = self.selectDate.getSolarDay - 1;
            }
            [self reloadDateArrayWithUpdateMonth:YES updateDay:YES];
            [self.lunarDatePickerView reloadComponent:ColumnMonth];
            [self.lunarDatePickerView reloadComponent:ColumnDay];
            break;
        case ColumnYear:
            self.yearIndex = row;
            if (self.typeOfCalendar == TypeCalendarAmLich) {
                
                NSInteger diff = 0;
                NSArray * monthArrOfThisYear = [BMDate getMonthArr:[self.yearArr[self.yearIndex] integerValue] andTypeCalendar:self.typeOfCalendar];
                diff =  self.monthArr.count  -  monthArrOfThisYear.count;
                if (<#condition#>) {
                    <#statements#>
                }
                self.monthIndex = self.monthIndex + diff;
            }
            [self reloadDateArrayWithUpdateMonth:YES updateDay:YES];
            if (self.typeOfCalendar == TypeCalendarAmLich) {
                NSInteger year = [self.yearArr[self.yearIndex] integerValue];
                if (self.monthIndex > [BMYear getLeapLunarMonth:year] && [BMYear isLeapLunarYear:year]) {
                    [self.lunarDatePickerView selectRow:self.monthIndex inComponent:ColumnMonth animated:NO];
                }
            }
            [self.lunarDatePickerView reloadComponent:ColumnMonth];
            [self.lunarDatePickerView reloadComponent:ColumnDay];
            break;
        case ColumnMonth:
            self.monthIndex = row;
            [self reloadDateArrayWithUpdateMonth:NO updateDay:YES];
            [self.lunarDatePickerView reloadComponent:ColumnDay];
            break;
        case ColumnDay:
            self.dayIndex = row;
            break;
        default:
            break;
    }
    
    if (self.yearArr.count * self.monthArr.count * self.dayArr.count == 0) return;
    if (self.monthIndex > self.monthArr.count - 1 || self.yearIndex > self.yearArr.count - 1 || self.dayIndex > self.dayArr.count - 1 ) {
        return;
    }
    if (typeOfColumnPicker != ColumnTypeCalendar) { // when selectDate is changed. create new date
        NSInteger year = [self.yearArr[self.yearIndex] integerValue];
        NSInteger month = [self.monthArr[self.monthIndex] integerValue];
        NSInteger day = [self.dayArr[self.dayIndex] integerValue];
        BOOL isLeapMonth = false;
        if ([BMYear isLeapLunarYear:year]) {
            if (self.monthIndex == [BMYear getLeapLunarMonth:year]) {
                isLeapMonth = true;
            }
        }
        if (self.typeOfCalendar == TypeCalendarAmLich) {
            self.selectDate = [[BMDate alloc] initDateWithLunarDate:day :month :year isLeapMonth:isLeapMonth andTimeZone:LOCAL_TIMEZONE];
        } else {
            self.selectDate = [[BMDate alloc] initDateWithSolarDate:day :month :year andTimeZone:LOCAL_TIMEZONE];
        }
    } else {
        NSLog(@"scrollToSelectDate");
        [self scrollToSelectDate:self.selectDate andTypeOfCalendar:self.typeOfCalendar animated:NO];
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
    [self.alertView addSubview:self.lunarDatePickerView];
}

// handle data
- (void)loadData {
    [self handlerDefaultSelectDate];
    [self initDateArray];
    [self scrollToSelectDate:self.selectDate andTypeOfCalendar:self.typeOfCalendar animated:NO];
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
        self.dayArr = [BMDate getDayArr:self.selectDate.getSolarYear month:self.selectDate.getSolarMonth andTypeOfCalendar:self.typeOfCalendar];
        self.monthArr = [BMDate getMonthArr:self.selectDate.getSolarYear andTypeCalendar:self.typeOfCalendar];
        self.yearArr = [BMDate getYearArrWithStartYear:STARTYEAR andEndYear:ENDYEAR];
    }
}

- (void)reloadDateArrayWithUpdateMonth:(BOOL)updateMonth updateDay:(BOOL)updateDay {
    if (self.yearArr.count == 0) {
        return;
    }
    if (updateMonth) {
        self.monthArr = [BMDate getMonthArr:[self.yearArr[self.yearIndex] integerValue] andTypeCalendar:self.typeOfCalendar];
    }
    if (updateDay) {
        NSInteger year = [self.yearArr[self.yearIndex] integerValue];
        NSInteger month = [self.monthArr[self.monthIndex] integerValue];
        if (self.typeOfCalendar == TypeCalendarAmLich) {
            BOOL isLeapMonth = false;
                 if ([BMYear isLeapLunarYear:year]) {
                     if (self.monthIndex == [BMYear getLeapLunarMonth:year]) {
                         isLeapMonth = true;
                     }
                 }
            self.dayArr = [BMDate getLunarDayArr:year month:month isLeapMonth:isLeapMonth];
        } else {
            self.dayArr = [BMDate getSolarDayArr:year month:month];
        }
    }
}

// lazy init

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
    
    NSInteger yearIndex, monthIndex,dayIndex, typeOfCalendarIndex = 0;
    if (typeOfCalendar == TypeCalendarDuongLich) {
        yearIndex = selectDate.getSolarYear - STARTYEAR;
        monthIndex = selectDate.getSolarMonth - 1;
        dayIndex = selectDate.getSolarDay - 1;
        typeOfCalendarIndex = typeOfCalendar;
    } else {
        yearIndex = selectDate.getlunarYear - STARTYEAR;
     
        if ((selectDate.isLeapLunarYear && selectDate.getLunarMonth > selectDate.getLeapLunarMonth) || [selectDate isLeapLunarMonth]) {
           monthIndex = selectDate.getLunarMonth;
        } else {
            monthIndex = selectDate.getLunarMonth - 1;
        }
        dayIndex = selectDate.getLunarDay - 1;
        typeOfCalendarIndex = typeOfCalendar;
    }
    
    self.yearIndex = yearIndex;
    self.monthIndex = monthIndex;
    self.dayIndex = dayIndex;
    
    NSArray * indexArr = @[@(typeOfCalendarIndex), @(dayIndex), @(monthIndex), @(yearIndex)];
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
