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
    NSLog(@"nothing");
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
    if(orientation == UIInterfaceOrientationPortrait ||
       orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self layoutPortraitUI];
        
        NSLog(@"protraitUI");
    }
    if(orientation == UIInterfaceOrientationLandscapeRight ||
       orientation == UIInterfaceOrientationLandscapeLeft) {
        
        NSLog(@"landscape");
        
        [self layoutLandScapeUI];
    }
    
}

-(void)layoutPortraitUI{
    NSLog(@"protraitUI is called");
    
    NSInteger screenMainWidth = self.view.frame.size.width;
    NSInteger screenMainHeight = self.view.frame.size.height;
    NSLog(@"screenMainWidth is: %tu screenMainHeight is: %tu ",screenMainWidth, screenMainHeight);
    NSInteger labelOriginX = screenMainWidth/2 - WIDTH/2 ;
    NSInteger labelOriginY = screenMainHeight/4 - HEIGHT/2;
    NSLog(@"X is: %tu Y is: %tu ",labelOriginX, labelOriginY);
    self.label.frame = CGRectMake(labelOriginX, labelOriginY, WIDTH, HEIGHT);
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor blueColor];
    NSInteger spaceButton = (screenMainWidth - 2*WIDTHBTN)/3 ;
    self.firstButton.frame = CGRectMake(spaceButton, screenMainHeight/2 , WIDTHBTN, HEIGHTBTN);
    
    [self.firstButton setBackgroundColor:[UIColor blueColor]];
    self.secondButton.frame = CGRectMake(spaceButton*2 + WIDTHBTN, screenMainHeight/2 , WIDTHBTN, HEIGHTBTN);
    
    [self.secondButton setBackgroundColor:[UIColor blueColor]];
}
-(void)layoutLandScapeUI{
    NSLog(@"landscape is called");
    NSInteger screenMainWidth = self.view.frame.size.width;
    NSInteger screenMainHeight = self.view.frame.size.height;
    
    NSLog(@"screenMainWidth is: %tu screenMainHeight is: %tu ",screenMainWidth, screenMainHeight);
    NSInteger labelOriginX = screenMainWidth/4 - WIDTH/2 ;
    NSInteger labelOriginY = screenMainHeight/2 - HEIGHT/2;
    self.label.frame = CGRectMake(labelOriginX, labelOriginY, WIDTH, HEIGHT);
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor blueColor];
    NSInteger spaceButton = (screenMainHeight - 2*HEIGHTBTN)/3 ;
    self.firstButton.frame = CGRectMake(screenMainWidth/2 + screenMainWidth/4 - WIDTHBTN/2, spaceButton , WIDTHBTN, HEIGHTBTN);
    
    [self.firstButton setBackgroundColor:[UIColor blueColor]];
    self.secondButton.frame = CGRectMake(screenMainWidth/2 + screenMainWidth/4 - WIDTHBTN/2, 2*spaceButton + HEIGHTBTN , WIDTHBTN, HEIGHTBTN);
    
    [self.secondButton setBackgroundColor:[UIColor blueColor]];
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
        self.label.text = @"Label";
        [self.view addSubview:_label];
    }
    return _label;
}
- (UIButton *)firstButton {
    if (!_firstButton) {
        
        _firstButton = UIButton.new;
        [self.firstButton setTitle:@"button1" forState:UIControlStateNormal];
        [self.view addSubview:_firstButton];
    }
    return _firstButton;
}
- (UIButton *)secondButton{
    if (!_secondButton) {
        
        _secondButton = UIButton.new;
        [self.secondButton setTitle:@"button2" forState:UIControlStateNormal];
        [self.view addSubview:_secondButton];
    }
    return _secondButton;
}

@end
