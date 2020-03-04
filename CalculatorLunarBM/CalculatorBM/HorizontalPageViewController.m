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
@end

@implementation HorizontalPageViewController

- (instancetype)init {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {

        SolarViewController *newVC1 = SolarViewController.new;
        SolarViewController *newVC2 = SolarViewController.new;
        SolarViewController *newVC3 = SolarViewController.new;
        self.arrVC = @[newVC1,newVC2,newVC3];
        self.BMPaingDelegate = self;
        self.BMPaingDataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
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
        case DirectionReverse: {
            NSInteger preJDN = [currentSolarViewController getDataModel].jdn - 1;
            DateModel *model = [self createDataModel:preJDN];
            [self.arrVC[index] setDataModel:model];
        }
            break;
            
        default:
            break;
    }
}

-(void)bmPageViewController:(BMPageViewController *)bmPageViewController didScrollTo:(NSInteger)index {
    SolarViewController * solarShowed =  self.arrVC[bmPageViewController.getCurrentIndex];
    DateModel * modelShowed = solarShowed.getDataModel;
    BMDate * date = [[BMDate alloc] initLocalDate:modelShowed.jdn];
    
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

- (DateModel *)createDataModel:(NSInteger)jdn {
    NSString *quote = [SingletonAPI.sharedInstance getQuote:jdn];
    NSURL *urlImage = [SingletonAPI.sharedInstance getURLImage:jdn];
    return [[DateModel alloc] initWithDate:jdn quote:quote imageURL:urlImage];
}

- (NSArray<SolarViewController *> *)arrVC {
    if (!_arrVC) {
        _arrVC = NSArray.new;
    }
    return _arrVC;
}


//- (NSInteger)numberOfViewControllers:(BMPageViewController *)bmPageViewController {
//    return 3;
//}
//
//- (UIViewController *)viewControllerFor:(BMPageViewController *)bmPageViewController atIndex:(NSInteger)index {
//
//}
//
//- (NSInteger)defaultPage {
//
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
