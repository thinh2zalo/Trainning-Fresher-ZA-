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

@interface ContactViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <User *> * arrContacts;
@property (nonatomic, strong) NSMutableDictionary * dictListContacts;
//@property (nonatomic, strong) NSMutableDictionary * searchedDict;

@end
BOOL isFiltered;
NSMutableDictionary * searchedDict;

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isFiltered = false;
    
    self.searchBar.frame = CGRectMake(0 , 44, self.view.frame.size.width, 40);
    [self.searchBar setKeyboardType:UIKeyboardTypeDefault];
    [self.searchBar setKeyboardAppearance:UIKeyboardAppearanceDefault];
    self.collectionView.frame = CGRectMake(0, self.searchBar.frame.origin.y + self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height - TABBAR_HEIGHT - 40);
    self.arrContacts;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        isFiltered = false;
    } else {
        isFiltered = true;
        NSMutableArray * searchedArray = NSMutableArray.new;
         searchedDict = NSMutableDictionary.new;
        for (User * user in self.arrContacts) {
            NSRange range = [user.userName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [searchedArray addObject:user];
                searchedDict = [self sortListContact:searchedArray];
            }
        }
    }
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CONTACT_CELL forIndexPath:indexPath];
//    if (isFiltered && [searchedDict isKindOfClass:NSMutableDictionary.class]) {
//        [(ContactCell *) cell updateContactCell:[self getArrayOfDict: searchedDict andIndex:indexPath.section][indexPath.item]];
//    }
    [(ContactCell *) cell updateContactCell:[self getArrayOfDict: self.dictListContacts andIndex:indexPath.section][indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 40);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (isFiltered && [searchedDict isKindOfClass:NSMutableDictionary.class]) {
//        return [[self getArrayOfDict: searchedDict andIndex:section] count];
//    }
    return [[self getArrayOfDict: self.dictListContacts andIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    if (isFiltered && [searchedDict isKindOfClass:NSMutableDictionary.class]) {
//        return [searchedDict count];
//    }
    return [self.dictListContacts count];
}

- (NSArray *) getArrayOfDict:(NSDictionary *) dict andIndex:(NSInteger) index {
    NSString *key = [[dict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][index];
    return [dict objectForKey:key];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width - 40, 80);
}

- (NSMutableDictionary *) sortListContact:(NSMutableArray <User*> *) arrContacts {
    NSMutableDictionary* dictListContacts = NSMutableDictionary.new;
    int currentIndex = 1;
    for (User * user in arrContacts) {
        
        NSString * fullName = [NSString getLastName:user.userName];
        NSString * fristCharacter = [[fullName substringToIndex:1] uppercaseString];
        
        if (![dictListContacts objectForKey:fristCharacter]) {
            NSMutableArray <User *> * subArr = NSMutableArray.new;
            [subArr addObject:user];
            
            for (int index = currentIndex ; index < [arrContacts count]; index++) {
                NSString * fullNameNext = [NSString getLastName:arrContacts[index].userName];
                NSString * fristCharacterNext = [[fullNameNext substringToIndex:1] uppercaseString];
                if ([fristCharacter isEqualToString: fristCharacterNext]) {
                    [subArr addObject:arrContacts[index]];
                }
            }
            [dictListContacts setObject:subArr forKey:fristCharacter];
            
        }
        currentIndex = currentIndex + 1 ;
        
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
        _arrContacts = NSMutableArray.new;
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
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        
        [_collectionView registerClass:HeaderAlphabet.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ALPHABET];
        
        [_collectionView registerClass:ContactCell.class forCellWithReuseIdentifier:CONTACT_CELL];
        
        
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



- (NSMutableDictionary *)dictListContacts {
    if (!_dictListContacts) {
        _dictListContacts = NSMutableDictionary.new;
       _dictListContacts = [self sortListContact:self.arrContacts];
    }
    return _dictListContacts;
}

@end
