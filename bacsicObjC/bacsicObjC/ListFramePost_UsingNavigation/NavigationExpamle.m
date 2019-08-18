//
//  NavigationBar.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "NavigationExpamle.h"

@protocol PassData <NSObject>
@required
- (void)passData;

@end
@interface NavigationExample () <callSecondViewController, PassDataBack>
@property (nonatomic, strong) NSMutableArray <Container *> *listView ;
@property (nonatomic, strong) NSMutableArray<NSString *> *arrTitle;
@property (nonatomic, strong) NSArray <Content *> *contentsModel;

@end

@implementation NavigationExample

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
       [self updateUI];
        
    }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        
    }];
}


-(void)updateUI{
    NSInteger countArrTitle = [self.listView count];
    float originX = SCREEN_MAIN_WIDTH/2 - WIDTH_VIEW/2;
    float originY =  (SCREEN_MAIN_LENGTH - NAV_LENGTH - LENGTH_VIEW*countArrTitle- SPACE*(countArrTitle-1))/2 + NAV_LENGTH;
    [self.listView objectAtIndex:0].frame = CGRectMake(originX, originY, WIDTH_VIEW, LENGTH_VIEW);
    
    for (int i = 1; i < countArrTitle ; i++){
        float previousOriginY = [self.listView objectAtIndex:(i-1)].frame.origin.y;
        [self.listView objectAtIndex:(i)].frame = CGRectMake(originX, previousOriginY + LENGTH_VIEW +SPACE , WIDTH_VIEW, LENGTH_VIEW);
    }
}

-(void)callSencondVC:(Container*) container{
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = container.label.text;
   
    secondVC.delegate = self;
    [self.navigationController pushViewController:secondVC animated:YES];

}
- (void) getDataBack:(SecondViewController *)dataInsideSecond{
    NSLog(@"%@", dataInsideSecond.data);
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSMutableArray<Container *> *)listView{
    if (!_listView){
        _listView = NSMutableArray.new;
        for (NSInteger i = 0 ; i < [self.contentsModel count]; i++){
            Container *tempContainner = Container.new;
            tempContainner.delagte = self;
            [tempContainner.label textWithTopAlign:[self.contentsModel objectAtIndex:i].title];
            
            [self.view addSubview:tempContainner];
            [_listView  addObject:tempContainner];
        }
    }
    return _listView;
}

- (NSArray<Content *> *)contentsModel{
    if (!_contentsModel){
        _contentsModel = [ConnectData connectData].contents;
    }
    return _contentsModel;
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated{
      NSLog(@"viewDidAppear");
}
//- (void)viewWillDisappear:(BOOL)animated{
//      NSLog(@"viewWillDisappear");
//}
//- (void)viewDidDisappear:(BOOL)animated{
//      NSLog(@"viewDidDisppear");
//}

@end
