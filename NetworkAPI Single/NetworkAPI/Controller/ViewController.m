//
//  ViewController.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ViewController.h"
#import "SingleImageCell.h"
#import "TripleImageCell.h"
#import "ParentCell.h"
#import <AFNetworking/AFNetworking.h>
#import "../SectionController/PostSectionController.h"

#import "../View/NavBarView.h"
#import "../Model/ContentModel.h"
#import "../Define.h"
#import "../NetWork/FeedAPI.h"
#define SingleImageCellIdent @"SingleImageCell"
#define TripleImageCellIdent @"TripleImageCell"



@interface ViewController () <IGListAdapterDataSource >
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <Content *> * arrContents;
@property (nonatomic, strong) FeedAPI * feedAPI;
@property (nonatomic, strong) NavBarView * navbarView;
@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // handle connection
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self.feedAPI getContentsWithCompletion:^(NSArray <Content *> * contents, NSString * title ,NSString * strError) {
        if (strError == nil) {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                self.arrContents = [NSMutableArray arrayWithArray:contents];
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    
                    self.adapter.collectionView = self.collectionView;
                    
                });
            });
        } else {
            NSLog(@"error :%@", strError);
        }
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init]
                                           viewController:self];
        _adapter.collectionView = self.collectionView;
        _adapter.dataSource = self;
    }
    return _adapter;
}

- (void)loadUI {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    CGFloat navbarViewHeight = self.navigationController.navigationBar.frame.size.height + statusBar.frame.size.height;
    self.navbarView.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                       navbarViewHeight);
    self.collectionView.frame = CGRectMake(0, navbarViewHeight, self.view.frame.size.width, self.view.frame.size.height - navbarViewHeight);
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.arrContents;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    //    const Class cellClass = content.images.count == 3 ? [TripleImageCell class] : [SingleImageCell class];
    void (^configureBlock)(id item, __kindof UICollectionViewCell *cell) = ^(id item, __kindof UICollectionViewCell *cell) {
        Content * content = (Content *)item;
        if (content.images.count == 3) {
            [(TripleImageCell *) cell updateContentInsideCell:content];
        } else {
            [(SingleImageCell *) cell updateContentInsideCell:content];
        }
    };
    CGSize (^sizeBlock)(id item, id<IGListCollectionContext> _Nullable collectionContext) = ^(id item, id<IGListCollectionContext> _Nullable collectionContext) {
        Content * content = (Content *)item;

        float heightOfCell  = content.images.count == 3 ? [TripleImageCell  heightOfCellWithTitle:content.title timestampAndPublisher:content.publicsherName] :  [SingleImageCell heightOfCell];
        return CGSizeMake(collectionContext.containerSize.width, heightOfCell);
    };
    return [[IGListSingleSectionController alloc] initWithCellClass:cellClass configureBlock:configureBlock sizeBlock:sizeBlock ];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}
#pragma mark init


- (NSMutableArray<Content *> *)arrContents {
    if (!_arrContents) {
        _arrContents = NSMutableArray.new;
    }
    return _arrContents;
}

- (NavBarView *)navbarView {
    if (!_navbarView) {
        _navbarView = NavBarView.new;
        _navbarView.backgroundColor = RGB(25, 25, 25);
        [self.view insertSubview:_navbarView aboveSubview:self.collectionView];
    }
    return _navbarView;
}

- (FeedAPI *)feedAPI {
    if (!_feedAPI) {
        _feedAPI = FeedAPI.new;
    }
    return _feedAPI;
}

@end
