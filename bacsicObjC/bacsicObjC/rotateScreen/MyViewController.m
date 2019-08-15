//
//  MyViewController.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/13/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "MyViewController.h"


@interface MyViewController ()

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UIButton* firstButton;
@property (nonatomic, strong) UIButton* secondButton;

@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
       [self checkToSetLayout];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        NSLog(@"WillAppear");
}
-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"DidAppear");
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
         [self checkToSetLayout];
     
     } completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
         
     }];
}

-(void)checkToSetLayout{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
       orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self layoutPortraitUI];
        
        NSLog(@"protraitUI");
    }
    if (orientation == UIInterfaceOrientationLandscapeRight ||
       orientation == UIInterfaceOrientationLandscapeLeft) {
        
        NSLog(@"landscape");
        
        [self layoutLandScapeUI];
    }
    
}

-(void)layoutPortraitUI{

    NSInteger labelOriginX = SCREEN_MAIN_WIDTH/2 - WIDTH/2 ;
    NSInteger labelOriginY = SCREEN_MAIN_LENGTH/4 - HEIGHT/2;
    SetFrame(self.label, labelOriginX, labelOriginY, WIDTH, HEIGHT);
    
    NSInteger spaceButton = (SCREEN_MAIN_WIDTH - 2*WIDTH_BTN)/3 ;
    SetFrame(self.firstButton, spaceButton, SCREEN_MAIN_LENGTH/2, WIDTH_BTN, HEIGHT_BTN);
    SetFrame(self.secondButton, spaceButton*2 + WIDTH_BTN, SCREEN_MAIN_LENGTH/2 , WIDTH_BTN, HEIGHT_BTN);
 }
-(void)layoutLandScapeUI{
    
    NSInteger labelOriginX = SCREEN_MAIN_WIDTH/4 - WIDTH/2 ;
    NSInteger labelOriginY = SCREEN_MAIN_LENGTH/2 - HEIGHT/2;
    SetFrame(self.label, labelOriginX, labelOriginY, WIDTH, HEIGHT);
    
    NSInteger spaceButton = (SCREEN_MAIN_LENGTH - 2*HEIGHT_BTN)/3 ;
    SetFrame(self.firstButton, SCREEN_MAIN_WIDTH/2 + SCREEN_MAIN_WIDTH/4 - WIDTH_BTN/2, spaceButton , WIDTH_BTN, HEIGHT_BTN);
    SetFrame(self.secondButton, SCREEN_MAIN_WIDTH/2 + SCREEN_MAIN_WIDTH/4 - WIDTH_BTN/2, 2*spaceButton + HEIGHT_BTN , WIDTH_BTN, HEIGHT_BTN);
}


-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");
}
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDiDDisappear");
}
- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen  mainScreen] bounds]];
    NSLog(@"loadView");
}
-(IBAction)button:(id)sender{
    NSLog(@"hello");
}

- (UILabel *)label {
    if (!_label) {
        _label = UILabel.new;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor blueColor];
         _label.text = @"Label";
        [self.view addSubview:_label];
    }
    return _label;
}
- (UIButton *)firstButton {
    if (!_firstButton) {
        
        _firstButton = UIButton.new;
          [_firstButton setBackgroundColor:[UIColor blueColor]];
        [_firstButton setTitle:@"button1" forState:UIControlStateNormal];
        [self.view addSubview:_firstButton];
    }
    return _firstButton;
}
- (UIButton *)secondButton{
    if (!_secondButton) {
        
        _secondButton = UIButton.new;
        [_secondButton setBackgroundColor:[UIColor blueColor]];
        [_secondButton setTitle:@"button2" forState:UIControlStateNormal];
        [self.view addSubview:_secondButton];
    }
    return _secondButton;
}

@end
