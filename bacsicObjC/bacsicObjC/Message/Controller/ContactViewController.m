//
//  groupViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/12/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController () <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UICollectionView * collectionView;

@end


@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchBar.frame = CGRectMake(0 , 44, self.view.frame.size.width, 40);
    [self.searchBar setKeyboardType:UIKeyboardTypeDefault];
    [self.searchBar setKeyboardAppearance:UIKeyboardAppearanceDefault];

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = UICollectionViewFlowLayout.new;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10,  10 , 10);
        
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        
        [_collectionView registerClass:ThreeImageCell.class forCellWithReuseIdentifier:];
       
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = UISearchBar.new;
        _searchBar.delegate = self;
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}





@end
