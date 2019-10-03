//
//  groupViewController.m
//  bacsicObjC
//
//  Created by CPU11606 on 9/12/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ContactViewController.h"
#define CONTACT_CELL @"ContactCell"
#define HEADER_ALPHABET @"headerAlphabet"

@interface ContactViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CollectionIndexViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <User *> * arrContacts;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic,strong) CollectionIndexView * collectionIndexView;
@property (nonatomic, strong) NSMutableDictionary * dictListContacts;

@end


@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headerView.topHeaderView setHidden:YES];
    [self.view layoutIfNeeded];
    heightOfHeader = self.headerView.frame.size.height;
    minHeaderHeight = heightOfHeader - 44;
    maxHeaderHeight = heightOfHeader;
    
    NSArray <NSString *> * array = [[self.dictListContacts allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self.collectionIndexView setupWithIndexTitles:array];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidStopScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidStopScrolling];
    }
    
}


- (void)moveContentToIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView scrollItemToTopWithIndexPath:indexPath];
//    self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x,self.collectionView.contentOffset.y ) ;

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float scrollDiff = scrollView.contentOffset.y + heightOfHeader;

    self.collectionView.contentInset = UIEdgeInsetsMake(MAX (88 , heightOfHeader - scrollDiff), 0,  0 ,0);
    
    [self.headerView  setHeightForBotHeader:scrollDiff];
    [self.headerView  setHeightForTopHeader:scrollDiff];
    [self.headerView.topHeaderView setHidden:YES];
    if (self.collectionView.contentOffset.y > - maxHeaderHeight) {
        [self.headerView.topHeaderView setHidden:NO];
        
    }
}

- (NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView {
    return [self.dictListContacts allKeys];
}

- (void) scrollViewDidStopScrolling {

    CGFloat range = maxHeaderHeight - minHeaderHeight;
    CGFloat midPoint = minHeaderHeight + (range / 2);
    if (self.collectionView.contentOffset.y < (- midPoint)) {
        [self expandHeader];
    } else if (self.collectionView.contentOffset.y < - minHeaderHeight){
        [self collapseHeader];
    }
}



- (void) collapseHeader {
    [self.headerView setHidden:false];
    [UIView animateWithDuration:0.2 animations:^{
        [self.headerView setHeightForBotHeader:self->heightOfBotTitle];
        [self.collectionView setContentOffset:CGPointMake(0, - self->minHeaderHeight)];
    }];
}

- (void) expandHeader {
    [UIView animateWithDuration:0.2 animations:^{
        [self.headerView setHeightForBotHeader:0];
        [self.collectionView setContentOffset:CGPointMake(0, - self->maxHeaderHeight)];
    }];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CONTACT_CELL forIndexPath:indexPath];
    
    [(ContactCell *) cell updateContactCell:[self getArrayOfDict: self.dictListContacts andIndex:indexPath.section][indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 40);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[self getArrayOfDict: self.dictListContacts andIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dictListContacts count];
}

- (NSArray *) getArrayOfDict:(NSDictionary *) dict andIndex:(NSInteger) index {
    if ([dict isKindOfClass:NSDictionary.class]) {
        NSString *key = [[dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][index];
        return [dict objectForKey:key];
        
    }
    else return @[];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width - 40, 80);
}

- (NSMutableDictionary *) sortListContact:(NSMutableArray <User*> *) arrContacts {
    NSMutableDictionary* dictListContacts = NSMutableDictionary.new;
    int currentIndex = 1;
    for (User * user in arrContacts) {
        
        NSString * fullName = [NSString getLastName:user.userName];
        NSString * firstCharacter = [[fullName substringToIndex:1] uppercaseString];
        if ([firstCharacter isKindOfClass:NSString.class]) {
            [[dictListContacts objectForKey:firstCharacter] addObject:user];
        }
        if (![dictListContacts objectForKey:firstCharacter]) {
            NSMutableArray <User *> * subArr = NSMutableArray.new;
            [subArr addObject:user];
            [dictListContacts setObject:subArr forKey:firstCharacter];
            
        }
        currentIndex++;
        
    }
    return dictListContacts;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerAlphabet = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        headerAlphabet = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_ALPHABET forIndexPath:indexPath];
        NSString * key = [[self.dictListContacts allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][indexPath.section] ;
        [(HeaderAlphabet *) headerAlphabet setAlphabet:key];
        
    }
    return headerAlphabet;
    
}
- (NSMutableArray<User *> *)arrContacts {
    if (!_arrContacts) {
        _arrContacts = [[FeedAPIContact queryContact] mutableCopy];
    }
    return _arrContacts;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = UICollectionViewFlowLayout.new;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 30;
        flowLayout.sectionInset = UIEdgeInsetsMake(30, 20,  30 ,20);
        flowLayout.sectionHeadersPinToVisibleBounds = true;
        
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(heightOfHeader , 0, 0, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        
        [_collectionView registerClass:HeaderAlphabet.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ALPHABET];
        
        [_collectionView registerClass:ContactCell.class forCellWithReuseIdentifier:CONTACT_CELL];
        [self.view insertSubview:_collectionView belowSubview:self.headerView];
        [_collectionView alignToView:self.view];
    }
    return _collectionView;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (CollectionIndexView *)collectionIndexView {
    if (!_collectionIndexView) {
        _collectionIndexView = CollectionIndexView.new;
        _collectionIndexView.delegate = self;
        [self.view insertSubview:_collectionIndexView aboveSubview:self.collectionView];
        [_collectionIndexView alignTop:@"0" bottom:@"0" toView:self.view];
        [_collectionIndexView alignTrailingEdgeWithView:self.view predicate:@"0"];
        [_collectionIndexView constrainWidth:@"30"];
    }
    return _collectionIndexView;
}

- (HeaderView *)headerView {
    if (!_headerView) {
        _headerView = HeaderView.new;
        [self.view addSubview:_headerView];
        _headerView.titleBotLab.text = @"CONTACT";
        _headerView.titleTopLab.text = @"Contact";
        [_headerView alignTop:@"0" leading:@"0" toView:self.view];
        [_headerView alignTrailingEdgeWithView:self.view predicate:@"0"];
        [_headerView constrainHeight:@"132"];
    }
    return _headerView;
}

- (NSMutableDictionary *)dictListContacts {
    if (!_dictListContacts) {
        _dictListContacts = NSMutableDictionary.new;
        _dictListContacts = [self sortListContact:self.arrContacts];
    }
    return _dictListContacts;
}

@end
