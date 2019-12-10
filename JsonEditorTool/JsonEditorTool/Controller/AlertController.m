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
        
    }
    return self;
}
- (void)viewDidLoad {

}
- (void)setupViewWindowWidth:(CGFloat)windowWidth {

    self.windowWidth = windowWidth;
    self.windowHeight = 178.0f;
    _backgroundView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.7f;
}
- (void)showAlert:(UIViewController *)viewController withJsonModel:(JsonModel *) jsonModel {
    self.jsonModel = jsonModel;
    
    _rootViewController = viewController;
    
    [self.contentView updateContentInside:jsonModel];
    
    
    [_rootViewController addChildViewController:self];
    [_rootViewController.view addSubview:_backgroundView];
    [_rootViewController.view addSubview:self.view];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGSize sz = CGSizeMake(SCREEN_MAIN_WIDTH, SCREEN_MAIN_HEIGHT);
    
    self.view.frame = CGRectMake((sz.width-_windowWidth)/2, _windowHeight, _windowWidth, _windowHeight);
    self.contentView.frame = self.view.bounds;

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


- (AlertView *)contentView {
    if (!_contentView) {
        _contentView = AlertView.new;
        
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.borderWidth = 0.5f;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}





@end
