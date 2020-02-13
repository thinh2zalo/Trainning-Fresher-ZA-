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

@property(nonatomic, copy) NSArray *yearArr;
@property(nonatomic, copy) NSArray *monthArr;
@property(nonatomic, copy) NSArray *dayArr;
@property(nonatomic, copy) NSArray *typeCalendar;


@end
@implementation LunarDatePickerView


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray * rowsArr = NSArray.new;
    
    rowsArr = @[@(2), @(self.dayArr.count), @(self.monthArr.count),@(self.yearArr.count)]; // 2 = am lich + duong lich;
    return [rowsArr[component] integerValue];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
   
    if (!label) {
        label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
   }
    if (component == 0) {
               label.text = [self getTypeCalendar][row];
           } else if (component == 1) {
               label.text = self.dayArr[row];
           } else if (component == 2) {
               label.text = self.monthArr[row];
           } else if (component == 3) {
               label.text = self.yearArr[row];
           }
    return label;
}

#pragma mark - UIPickerViewDelegate
- (void)setupUI {
    self.frame = SCREEN_BOUNDS;
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

         [UIView animateWithDuration:0.5 animations:^{
             CGFloat alertViewHeight = self.alertView.bounds.size.height;
             CGRect rect = self.alertView.frame;
             rect.origin.y -= alertViewHeight;
             self.alertView.frame = rect;
         }];
}

- (void)show {
     [self loadData];
     [self setupUI];
     [self.alertView addSubview:self.lunarDatePickerView];
}
- (UIPickerView *)lunarDatePickerView {
    if (!_lunarDatePickerView) {
        _lunarDatePickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, WITDTH_SCREEN, 400)];
        _lunarDatePickerView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _lunarDatePickerView.dataSource = self;
        _lunarDatePickerView.delegate = self;
    }
    return _lunarDatePickerView;
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_SCREEN - 400, WITDTH_SCREEN, 400)];
            UIView *shadowLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _alertView.frame.size.width, 1.0f)];
            shadowLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [_alertView addSubview:shadowLineView];
        _alertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _alertView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
        _maskView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0.2f];
        _maskView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _maskView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapMaskView:)];
        [_maskView addGestureRecognizer:myTap];
    }
    return _maskView;
}
- (void)loadData {
    self.dayArr = [self getDayArr:2020 month:2];
    self.monthArr = [self getMonthArr:2020];
    self.yearArr = [self getYearArr];
}
- (NSArray *)getYearArr {
    NSMutableArray *tempArr = [NSMutableArray array];

    for (NSInteger i = 1940; i <= 2099; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    return [tempArr copy];

}
- (NSArray *)getMonthArr:(NSInteger)year {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMonth - startMonth + 1)];
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
   return [tempArr copy];
}


- (NSArray *)getDayArr:(NSInteger)year month:(NSInteger)month {
    NSInteger startDay = 1;
    NSInteger endDay = [BMDate getDaysInYear:year month:month];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempArr addObject:[NSString stringWithFormat:@"%@", @(i)]];
    }
    return [tempArr copy];
}

- (NSArray *)getTypeCalendar {
    return @[@"Âm",@"Dương"];
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

- (NSArray *)typeCalendar {
    if (!_typeCalendar) {
        _typeCalendar = [NSArray array];
    }
    return _typeCalendar;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
