//
//  MainCollectionViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/5/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "MainCollectionViewController.h"



@interface MainCollectionViewController() <FeedAPIDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <Content *> *arrContents;
@property (nonatomic, strong) UITapGestureRecognizer *gesture;




@property (nonatomic) BOOL isLoadingData;
@property (nonatomic) BOOL isLoadingPreviousData;
@property (nonatomic) FeedAPI * feedAPI;
@end

@implementation MainCollectionViewController
@synthesize arrContents = _arrContens;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
  
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [self updateUI];
        [self.collectionView.collectionViewLayout invalidateLayout];
    }completion:nil];
}

- (void)updateUI{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float originX = 0.0f;
    if (!UIInterfaceOrientationIsPortrait(orientation)) {
        originX = 25;
    }
    float originY = KEY_WINDOW_SAFE_AREA_INSETS.top + self.navigationController.navigationBar.frame.size.height;
    self.collectionView.frame = CGRectMake(originX , originY , SCREEN_MAIN_WIDTH - originX, SCREEN_MAIN_HEIGHT - originY);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    Content * contentToUpdate = self.arrContents[indexPath.item];
    if ([cell isKindOfClass:ParentsCell.class]) {
        [((ParentsCell*)cell) updateContentInsideCell:contentToUpdate];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ParentsCell * cell;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (!UIInterfaceOrientationIsPortrait(orientation)) {
        if (indexPath.item % 4 == 0) {
             cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:ThreeImageCellIdenti forIndexPath:indexPath];
            
        } else if (indexPath.item % 4 == 3){
            
            cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:SingleImageCellIdenti forIndexPath:indexPath];
           
        } else {
            cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:BigImageCellIdenti forIndexPath:indexPath];
        }
        
    } else {
        if (indexPath.item % 3 == 1) {
            cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:SingleImageCellIdenti forIndexPath:indexPath];
        } else if (indexPath.item % 3 == 2){
            cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:BigImageCellIdenti forIndexPath:indexPath];
        } else {
            cell  = [self.collectionView dequeueReusableCellWithReuseIdentifier:ThreeImageCellIdenti forIndexPath:indexPath];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"sizeForItemAtIndexPath");
    NSString * titleToCal = [self.arrContents objectAtIndex:indexPath.item].title;
    float heightOfCell;
    float widthOfCell = self.collectionView.frame.size.width;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (!UIInterfaceOrientationIsPortrait(orientation)) {
        if (indexPath.item % 4 == 0 ) {
            
            heightOfCell = [ThreeImageCell heightOfCell:titleToCal];
        } else if (indexPath.item % 4 == 3 ) {
            heightOfCell = [SingleImageCell heightOfCell];
            
        } else {
            heightOfCell = [BigImageCell heightOfCellLandscape:titleToCal];
            
            
            widthOfCell = (self.collectionView.frame.size.width - 2 * ALIGN_LEFT - [(UICollectionViewFlowLayout *)collectionViewLayout minimumInteritemSpacing]) / 2;
        }
            
    } else {
        if (indexPath.item % 3 == 0 ) {
        
        heightOfCell = [ThreeImageCell heightOfCell:titleToCal];
        } else if (indexPath.item % 3 == 1 ) {
        heightOfCell = [SingleImageCell heightOfCell];
        
        } else {
        heightOfCell = [BigImageCell heightOfCell:titleToCal];
        }
    }
   
    return CGSizeMake(widthOfCell, heightOfCell);
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrContents.count;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = UICollectionViewFlowLayout.new;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(ALIGN_TOP, ALIGN_LEFT,  ALIGN_TOP , ALIGN_LEFT);
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        
        [_collectionView registerClass:ThreeImageCell.class forCellWithReuseIdentifier:ThreeImageCellIdenti];
        [_collectionView registerClass:SingleImageCell.class forCellWithReuseIdentifier:SingleImageCellIdenti];
        [_collectionView registerClass:BigImageCell.class forCellWithReuseIdentifier:BigImageCellIdenti];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray <Content *> *)arrContents{
    if (!_arrContens){
        _arrContens = NSMutableArray.new;
        [self callFeedAPI];
    }
    return _arrContens;
    
}


- (void)callFeedAPI {
    self.feedAPI.delegate = self;
    [self.feedAPI callAPI:10];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [AlertWindowViewController showAlert:self.arrContents[indexPath.item].title];
}


- (FeedAPI *)feedAPI {
    if (!_feedAPI) {
        _feedAPI = FeedAPI.new;
    }
    return _feedAPI;
}


- (void)updateArrContents:(NSArray *)arrContentsBack {
    [self.arrContents addObjectsFromArray:arrContentsBack];
    [self.collectionView reloadData];
}



@end
