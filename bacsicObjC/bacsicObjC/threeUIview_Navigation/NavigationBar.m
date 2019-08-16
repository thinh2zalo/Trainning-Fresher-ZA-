//
//  NavigationBar.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NavigationBar.h"

@interface NavigationBar ()
@property (nonatomic, strong) Container* view1;
@property (nonatomic, strong) Container* view2;
@property (nonatomic, strong) Container* view3;
@end

@implementation NavigationBar

- (void)viewDidLoad {
    [super viewDidLoad];
     [self checkToSetLayout];
    
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
    [self updateUI:(orientation == UIInterfaceOrientationPortrait ||
                     orientation == UIInterfaceOrientationPortraitUpsideDown)];
   
}


// update lai
-(void)updateUI:(BOOL)checkPortrait{
    float originX = SCREEN_MAIN_WIDTH/2 - WIDTH_VIEW/2;
    float originY =  (SCREEN_MAIN_LENGTH - LENGTH_VIEW*3- SPACE*2)/2;
    if (!checkPortrait){
        originX = SCREEN_MAIN_WIDTH/2 - WIDTH_VIEW/2;
        originY =  (SCREEN_MAIN_LENGTH - LENGTH_VIEW*3 - SPACE*2)/2;
    }
    self.view1.frame = CGRectMake(originX, originY, WIDTH_VIEW, LENGTH_VIEW);
    self.view2.frame = CGRectMake(originX, self.view1.frame.origin.y + LENGTH_VIEW + SPACE , WIDTH_VIEW, LENGTH_VIEW);
    self.view3.frame = CGRectMake(originX, self.view2.frame.origin.y + LENGTH_VIEW + SPACE , WIDTH_VIEW, LENGTH_VIEW);
}


-(Container *)view1{
    if (!_view1){
        self.view1 = Container.new;
         self.view1.label.text = @"view1";
        [self.view addSubview:_view1];
    }
    return _view1;
}
-(Container *)view2{
    if (!_view2){
        self.view2 = Container.new;
        self.view2.label.text = @"view2";
        [self.view addSubview:_view2];
    }
    return _view2;
}

-(Container *)view3{
    if (!_view3){
        self.view3 = Container.new;
        self.view3.label.text = @"view3";
        [self.view addSubview:_view3];
    }
    return _view3;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
