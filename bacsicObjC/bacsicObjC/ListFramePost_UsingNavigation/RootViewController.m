//
//  NavigationBar.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "RootViewController.h"

@protocol PassData <NSObject>
@required
- (void)passData;
@end

@interface NavigationExample () <ViewDelegate, PassDataBack>{

}

@property (nonatomic, strong) NSMutableArray <ContainerView *> *listView ;
@property (nonatomic, strong) NSArray <Content *> *contentsModel;
@property (nonatomic, strong) UIButton *previousBtn;
@property (nonatomic, strong) UIButton *nextBtn;



@end

@implementation NavigationExample
int getCurrentIndex = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [self updateUI];
        
    }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        
    }];
}


- (void)updateUI{
    NSInteger countArrTitle = [self createView:self.contentsModel];
    self.view.backgroundColor = [UIColor whiteColor];
    float originX = SCREEN_MAIN_WIDTH/2 - WIDTH_VIEW/2;
    float originY =  (SCREEN_MAIN_HEIGHT - NAV_HEIGHT - HEIGHT_VIEW * countArrTitle- SPACE * (countArrTitle-1))/2 + NAV_HEIGHT;
    [self.listView objectAtIndex:0].frame = CGRectMake(originX, originY, WIDTH_VIEW, HEIGHT_VIEW);
    
    for (int i = 1; i < countArrTitle ; i++){
        float previousOriginY = [self.listView objectAtIndex:(i-1)].frame.origin.y;
        [self.listView objectAtIndex:(i)].frame = CGRectMake(originX, previousOriginY + HEIGHT_VIEW +SPACE , WIDTH_VIEW, HEIGHT_VIEW);
    }

    _previousBtn = self.previousBtn;
    _nextBtn = self.nextBtn;
}

- (void)onTouched:(ContainerView*) view{
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = view.label.text;
    secondVC.indexOfSubview = view.ContentID;
    secondVC.delegate = self;

    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)getDataBack:(SecondViewController *)dataInsideSecond{
    int count = 0;
    for (Content *aContent in self.contentsModel) {
        if (aContent.contentId == dataInsideSecond.indexOfSubview) {
            [self.contentsModel objectAtIndex:count].title = dataInsideSecond.data;
            break;
        }
        count = count + 1;
    }
   
    NSRange boldedRange = NSMakeRange(getCurrentIndex, [self.contentsModel count] - getCurrentIndex);
    [self createView:[self.contentsModel subarrayWithRange:boldedRange]];
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger )createView:(NSArray<Content *> *) listData{
    NSUInteger count = ([listData count] >= 5) ? 5 : [listData count];
    for (NSUInteger i = 0; i < 5 ; i ++){
        if (i < count ) {
            [[self.listView objectAtIndex:i] updateContentInsideContainerView:[listData objectAtIndex:i]];
             [self.listView objectAtIndex:i].hidden = NO;
        } else {
             [self.listView objectAtIndex:i].hidden = YES;
        
        }
    }
    return  count;
}

- (void)updateNext {
    int sizeOfcontents = [self.contentsModel count];
    if (getCurrentIndex + 5 < sizeOfcontents ){
       getCurrentIndex = getCurrentIndex + 5;
    }
    NSRange boldedRange = NSMakeRange(getCurrentIndex, [self.contentsModel count] - getCurrentIndex);
    NSArray * newArray =  [self.contentsModel subarrayWithRange:boldedRange];
    [self createView:newArray];
}

- (void)updatePre {
  
    getCurrentIndex = getCurrentIndex - 5;
    if (getCurrentIndex < 0){
        getCurrentIndex = 0;
    }
    NSRange boldedRange = NSMakeRange(getCurrentIndex, 5);
    NSArray * newArray =  [self.contentsModel subarrayWithRange:boldedRange];
    [self createView:newArray];
}

- (UIButton *)previousBtn {
    if (!_previousBtn) {
        _previousBtn = UIButton.new;
        _previousBtn.frame = CGRectMake(20 , SCREEN_MAIN_HEIGHT - 100 , WIDTH_BTN, HEIGHT_BTN);
          [_previousBtn addTarget:self action:@selector(updatePre) forControlEvents:UIControlEventTouchUpInside ];
        
        [_previousBtn setTitle:@"PREVIOUS" forState:UIControlStateNormal];
        _previousBtn.layer.borderWidth = 1.0f;
        _previousBtn.layer.cornerRadius = 8;
        _previousBtn.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:_previousBtn ];
    }
    return _previousBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = UIButton.new;
        float space = SCREEN_MAIN_WIDTH - _previousBtn.frame.origin.x * 2 - WIDTH_BTN * 2;
        _nextBtn.frame = CGRectMake(20 + WIDTH_BTN + space , _previousBtn.frame.origin.y , WIDTH_BTN, HEIGHT_BTN);
        [_nextBtn addTarget:self action:@selector(updateNext) forControlEvents: UIControlEventTouchUpInside];
        [_nextBtn setTitle:@"NEXT" forState:UIControlStateNormal];
        
        _nextBtn.layer.borderWidth = 1.0f;
        _nextBtn.layer.cornerRadius = 8;
        _nextBtn.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:_nextBtn ];
    }
    return _nextBtn;
}

- (NSArray<Content *> *)contentsModel{
    if (!_contentsModel){
        _contentsModel = [ConnectData connectData].contents;
    }
    return _contentsModel;
}

- (NSMutableArray<ContainerView *> *)listView{
    if (!_listView) {
        _listView = NSMutableArray.new;
        for (NSInteger i = 0 ; i < 5; i++){
            ContainerView *tempContainner = ContainerView.new;
            tempContainner.delagte = self;
            [self.view addSubview:tempContainner];
            [_listView  addObject:tempContainner];
        }
    }
    return _listView;
}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    NSLog(@"viewWillDisAppear1");
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    NSLog(@"viewDidDisappear1");
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear1");
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    NSLog(@"viewDidAppear1");
//}



@end
