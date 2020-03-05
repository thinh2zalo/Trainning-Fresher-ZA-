//
//  HorizontalPgaeViewController.m
//  CalculatorBM
//
//  Created by vincent on 3/4/20.
//  Copyright © 2020 vincent. All rights reserved.
//

#import "HorizontalPageViewController.h"
#import "SolarViewController.h"
#import "SingletonAPI.h"

@interface HorizontalPageViewController () <BMPageViewControllerDelegate, BMPageViewControllerDataSource>
@property (nonatomic, strong) NSArray < SolarViewController *> * arrVC;
@property (nonatomic, strong) DateModel * mDateModel;

@end

@implementation HorizontalPageViewController

- (instancetype)init {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        self.BMPaingDelegate = self;
        self.BMPaingDataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [self handleDefault];
    [self createArrayViewController];
    NSInteger defaultPage  = [self.BMPaingDataSource defaultPage];
    SolarViewController * viewControllerShowed = self.arrVC[defaultPage];
  
    [viewControllerShowed setDataModel:self.mDateModel];
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}



- (void)createArrayViewController {
    SolarViewController *newVC1 = SolarViewController.new;
     SolarViewController *newVC2 = SolarViewController.new;
     SolarViewController *newVC3 = SolarViewController.new;
     self.arrVC = @[newVC1,newVC2,newVC3];
}

-(void)handleDefault{
    if (!_dateModel) {
        _mDateModel =  [DateModel createDataModel:[BMDate getCurrentJulianDayNumber]];
    }
}

- (DateModel *)getDateModel {
    if (!_mDateModel) {
        _mDateModel = DateModel.new;
    }
    return _mDateModel;
}
// MARK: - BMPageViewControllerDelegate

- (void)bmPageViewController:(BMPageViewController *)bmPageViewController willScrollToPageAt:(NSInteger)index direction:(NavigationDirection)direction animated:(BOOL)animated {
    SolarViewController *currentSolarViewController = (SolarViewController *)self.arrVC[bmPageViewController.getCurrentIndex];
    
    switch (direction) {
        case DirectionForword:{
            NSInteger nextJDN = [currentSolarViewController getDataModel].jdn + 1;
            DateModel *model = [DateModel createDataModel:nextJDN];
            [self.arrVC[index] setDataModel:model];
        }
            break;
        case DirectionReverse: {
            NSInteger preJDN = [currentSolarViewController getDataModel].jdn - 1;
            DateModel *model = [DateModel createDataModel:preJDN];
            [self.arrVC[index] setDataModel:model];
        }
            break;
            
        default:
            break;
    }
}


- (void)setDateModel:(DateModel *)dataModel {
    if (_mDateModel == dataModel || !dataModel) {
        return;
    }
    _mDateModel = dataModel;
    _dateModel = dataModel;
    
    [(SolarViewController *)self.getCurrentViewController setDataModel:_mDateModel];
}

-(void)bmPageViewController:(BMPageViewController *)bmPageViewController didScrollTo:(NSInteger)index {
    SolarViewController * solarShowed =  self.arrVC[bmPageViewController.getCurrentIndex];
    DateModel * modelShowed = solarShowed.getDataModel;
    BMDate *date = [[BMDate alloc]initLocalDate:modelShowed.jdn];
    self.mDateModel =  modelShowed;
    [self.HorizontalPageViewControllerDelegate triggerUpdate:date];
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


- (NSArray<SolarViewController *> *)arrVC {
    if (!_arrVC) {
        _arrVC = NSArray.new;
    }
    return _arrVC;
}




@end
