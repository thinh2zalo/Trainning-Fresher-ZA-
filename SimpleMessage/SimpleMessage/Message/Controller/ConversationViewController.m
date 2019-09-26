//
//  conversationViewController.m
//  bacsicObjC
//
//  Created by Steve on 9/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ConversationViewController.h"

@interface ConversationViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray <Message *> *arrMessages;
@property (nonatomic, strong) FeedAPIMess *feedAPI;

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrMessages = [[self.feedAPI setUpdataMessage:self.conversationId] copy];
    self.collectionView.frame = CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = UICollectionViewFlowLayout.new;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 0,  0 , self.view.frame.size.width / 3);
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
       
        [_collectionView registerClass:MessageCell.class forCellWithReuseIdentifier:@"MessageCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MessageCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((SCREEN_MAIN_WIDTH / 3) * 2, [MessageCell heightOfLabel:self.arrMessages[indexPath.row].contentMessage]
                    + 20);
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:MessageCell.class]) {
        [(MessageCell *)cell updateDataForCell:self.arrMessages[indexPath.item]];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arrMessages count];
}
- (FeedAPIMess *)feedAPI {
    if (!_feedAPI) {
        _feedAPI = FeedAPIMess.new;
        
    }
    return _feedAPI;
}
@end
