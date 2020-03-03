//
//  SolarViewController.m
//  CalculatorBM
//
//  Created by vincent on 2/26/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "SolarViewController.h"
#import "SolarCalendarView.h"
@interface SolarViewController ()
@property (nonatomic, strong) DateModel * dataModel;
@property (nonatomic, strong)  SolarCalendarView * solarCalendarView;
@end
@implementation SolarViewController
@synthesize dataModel = _dataModel;

- (instancetype)initWithModel:(DateModel *)dateModel {
    if (!dateModel) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.dataModel = dateModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpdateUI];
}

-(void)setUpdateUI {
    self.solarCalendarView.frame = self.view.bounds;
    [self.solarCalendarView loadDateWithInput:self.dataModel];
}

- (DateModel *)getDataModel {
    if (!_dataModel) {
        _dataModel = DateModel.new;
    }
    return _dataModel;
}

- (void)setDataModel:(DateModel *)dataModel {
    if (dataModel == nil || _dataModel == dataModel) {
        return;
    }
    _dataModel = dataModel;
    [self.solarCalendarView loadDateWithInput:self.dataModel];
}

- (SolarCalendarView *)solarCalendarView {
    if (!_solarCalendarView) {
        _solarCalendarView = SolarCalendarView.new;
        [self.view addSubview:_solarCalendarView];
    }
    return _solarCalendarView;
}


@end
