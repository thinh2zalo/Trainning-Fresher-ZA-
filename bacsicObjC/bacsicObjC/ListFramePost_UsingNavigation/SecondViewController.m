//
//  secondViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController()
@property (nonatomic, strong) UITextView * textViewInSecondScreen;
@property (nonatomic, strong) UIButton * btnConfirm;

@end  
@implementation SecondViewController

-(void)viewDidLoad{
    [super viewDidLoad];
        [self updateUI];
    
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        
        [self updateUI];
        
    }completion:nil];
}

-(void)updateUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float originX = 20;
    float widthOfView;
    float originY =  SCREEN_MAIN_HEIGHT/3;
    if (!UIInterfaceOrientationIsPortrait(orientation)) {
        widthOfView = originX = 40;
    }
    widthOfView = SCREEN_MAIN_WIDTH - originX * 2;
    self.textViewInSecondScreen.frame = CGRectMake(originX, originY, widthOfView, HEIGHT_TEXTVIEW);
    self.btnConfirm.frame = CGRectMake(originX + widthOfView - WIDTH_BTN - 10 , originY + HEIGHT_TEXTVIEW + 10, WIDTH_BTN, HEIGHT_BTN);
}

- (UIButton *)btnConfirm{
    if (!_btnConfirm) {
        _btnConfirm = UIButton.new;
        [_btnConfirm addTarget:self action:@selector(delegatePassData) forControlEvents:UIControlEventTouchUpInside];
        [_btnConfirm setTitle:@"confirm" forState:UIControlStateNormal];
        _btnConfirm.layer.borderWidth = 1.0f;
        _btnConfirm.layer.cornerRadius = 8;
        _btnConfirm.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:_btnConfirm ];
    }
    return  _btnConfirm;
}

- (void)delegatePassData{
    if (_delegate){
        _data = self.textViewInSecondScreen.text;
        
        [_delegate getDataBack:self];
    }
}

- (UITextView *)textViewInSecondScreen{
    if (!_textViewInSecondScreen) {
        _textViewInSecondScreen = UITextView.new;
        _textViewInSecondScreen.text = _data;
        [_textViewInSecondScreen setFont:[UIFont boldSystemFontOfSize:15]];
        
        _textViewInSecondScreen.layer.borderWidth = 1.0f;
        _textViewInSecondScreen.layer.cornerRadius = 8;
        _textViewInSecondScreen.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.view addSubview:_textViewInSecondScreen];
    }
    return _textViewInSecondScreen;
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    NSLog(@"viewWillDisappear2");
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    NSLog(@"viewDidDisappear2");
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear2");
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
//    NSLog(@"viewDidAppear2");
//}


@end
