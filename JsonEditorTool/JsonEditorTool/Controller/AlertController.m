//
//  JMAlertController.m
//  JsonEditorTool
//
//  Created by Steve on 12/6/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "AlertController.h"
#import "../Define.h"
#import "../Model/JsonModel.h"
#import "../Controller/JETViewController.h"
#import "../DLRadioButton/DLRadioButton.h"
#define WINDOW_WIDTH 340

@interface AlertController()
@property (nonatomic) CGFloat windowHeight;
@property (nonatomic) CGFloat windowWidth;
@property (strong, nonatomic) UIImageView *backgroundView;
@property (strong, nonatomic) JsonModel * jsonModel;
@property (weak, nonatomic) UIViewController *rootViewController;


@end

@implementation AlertController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViewWindowWidth:WINDOW_WIDTH];
        self.alertView.alertController = self;
        
    }
    return self;
}
- (void)viewDidLoad {

}
- (void)setupViewWindowWidth:(CGFloat)windowWidth {

    self.windowWidth = windowWidth;
    self.windowHeight = 320.0f;
    _backgroundView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.7f;
}

- (void)showAlert:(UIViewController *)viewController withJsonModel:(JsonModel *) jsonModel typeAlert:(NSString *)typeAlert{
    if (jsonModel) {
        self.jsonModel = jsonModel;
    }
   _rootViewController = viewController;
    [self.alertView updateContentInside:jsonModel withAlert: typeAlert];
   
    NSUInteger indexOfCurrentVC = [viewController.navigationController.childViewControllers indexOfObject:viewController];
    if (indexOfCurrentVC > 0) {
        JETViewController * preVC = viewController.navigationController.childViewControllers[indexOfCurrentVC - 1];
        self.alertView.parentJsonModel = [preVC jsonModel];
    }
    
    [_rootViewController.navigationController addChildViewController:self];

    [_rootViewController.navigationController.view addSubview:_backgroundView];
    [_rootViewController.navigationController.view addSubview:self.view];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGSize sz = CGSizeMake(SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
    
    self.view.frame = CGRectMake((sz.width-_windowWidth)/2, 150, _windowWidth, _windowHeight);
    self.alertView.frame = self.view.bounds;

}

- (void)fadeOut {
    [self fadeOutWithDuration:0.3f];
}

- (void)fadeOutWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.backgroundView.alpha = 0.0f;
        self.view.alpha = 0.0f;
    } completion:^(BOOL completed) {
        [self.backgroundView removeFromSuperview];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
      
    }];
}


- (AlertView *)alertView {
    if (!_alertView) {
        _alertView = AlertView.new;
    
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 5.0f;
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.borderWidth = 0.5f;
        [self.view addSubview:_alertView];
    }
    return _alertView;
}




@end
