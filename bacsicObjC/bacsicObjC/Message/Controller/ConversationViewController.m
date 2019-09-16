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



@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = UICollectionViewFlowLayout.new;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0,  0 , 0);
        
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        
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
    
    return CGSizeMake(self.view.frame.size.width, [MessageCell heightOfLabel:self.arrMessages[indexPath.row].contentMessage]);
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
