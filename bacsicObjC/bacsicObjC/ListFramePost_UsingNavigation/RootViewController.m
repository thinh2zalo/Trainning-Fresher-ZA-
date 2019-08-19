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

@interface NavigationExample () <ViewDelegate, PassDataBack>
@property (nonatomic, strong) NSMutableArray <View *> *listView ;
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
    self.view.backgroundColor = [UIColor whiteColor];
    float originX = SCREEN_MAIN_WIDTH/2 - WIDTH_VIEW/2;
    float originY =  (SCREEN_MAIN_HEIGHT - NAV_HEIGHT - HEIGHT_VIEW * countArrTitle- SPACE * (countArrTitle-1))/2 + NAV_HEIGHT;
    [self.listView objectAtIndex:0].frame = CGRectMake(originX, originY, WIDTH_VIEW, HEIGHT_VIEW);
    
    for (int i = 1; i < countArrTitle ; i++){
        float previousOriginY = [self.listView objectAtIndex:(i-1)].frame.origin.y;
        [self.listView objectAtIndex:(i)].frame = CGRectMake(originX, previousOriginY + HEIGHT_VIEW +SPACE , WIDTH_VIEW, HEIGHT_VIEW);
    }
}

-(void)allText:(View*) view{
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    secondVC.data = view.label.text;
    secondVC.indexOfSubview = [self.view.subviews indexOfObject:view];
    secondVC.delegate = self;

    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void) getDataBack:(SecondViewController *)dataInsideSecond{
    [self.listView objectAtIndex:dataInsideSecond.indexOfSubview].label.text = dataInsideSecond.data;
    [[self.listView objectAtIndex:dataInsideSecond.indexOfSubview].label setNumberOfLines:3];
    [[self.listView objectAtIndex:dataInsideSecond.indexOfSubview].label sizeToFit];
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSMutableArray<View *> *)listView{
    if (!_listView){
        _listView = NSMutableArray.new;
        for (NSInteger i = 0 ; i < [self.contentsModel count]; i++){
            View *tempContainner = View.new;
            tempContainner.delagte = self;
            tempContainner.label.text = [self.contentsModel objectAtIndex:i].title;
            [tempContainner.label sizeToFit];
            // update thumbnail
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSURL *url = [self.contentsModel objectAtIndex:i].avatarURL;
                NSData * data = [[NSData alloc] initWithContentsOfURL:url];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                  
                    tempContainner.thumbnail.image= [UIImage imageWithData: data];
                });
           
            });
            tempContainner.timeStamp.text = [NSString compareTimeStamp:[self.contentsModel objectAtIndex:i].date];
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
