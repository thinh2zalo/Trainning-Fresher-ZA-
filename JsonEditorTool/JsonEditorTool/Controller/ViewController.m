//
//  ViewController.m
//  JsonEditorTool
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ViewController.h"
#import "../View/HomeView.h"
#import "Define.h"
#import "../Network/NetworkManager.h"
#import <IGListKit/IGListKit.h>
#import "../View/InforJsonCell.h"
#import "../SectionController/SearchSectionController.h"
#import "../SectionController/KeyValueSectionController.h"
@interface ViewController () <SearchSectionControllerDelegate>
//@property (nonatomic, strong) HomeView * homeView;
@property (nonatomic, strong) NSDictionary * dict;
@property (nonatomic, strong) IGListAdapter * adapter;
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@interface ViewController() <IGListAdapterDataSource, UISearchBarDelegate, UICollectionViewDelegate, KeyValueSectionControllerDelegate> {
    NSNumber * searchToken;
    NSString * textFilter;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    textFilter = @"";
    searchToken = @(42);
    
    NSURL * url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (!_jsonModel) {
        [NetworkManager.shareInstance  request:request completion:^(id  _Nullable response, NSString * _Nullable errorMsg){
            
            if ([response isKindOfClass:NSDictionary.class]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){

                        self.jsonModel = [[DictionaryJM alloc] initWithObject:response andKey:@"result"];
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:[self.jsonModel toDictionary]];
                    self.jsonModel = [[DictionaryJM alloc] initWithObject:dict andKey:@"result"];
                    if ([dict isEqualToDictionary:response]) {
                        NSLog(@"if they run this block you gonna completly r");
                    }
//                    NSLog(@"%@", dict);
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [self setupUI];
                    });
                });
            } else {
                NSLog(@"%@", errorMsg);
            }
        }];
    } else {
        [self setupUI];
        
    }
    
}

#pragma mark - KeyValueSectionControllerDelegate

- (void)performUpdate:(JsonModel *)oldObject andNewObject:(JsonModel *)newObject {
    NSUInteger index = [[self.jsonModel value] indexOfObject:oldObject];
    [[self.jsonModel value] replaceObjectAtIndex:index withObject:newObject];
    [self.adapter performUpdatesAnimated:YES completion:nil];
}


- (void)setupUI {
    self.adapter.collectionView = self.collectionView;
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.jsonModel.key style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationItem.title = self.jsonModel.key;
}

#pragma mark - SearchSectionControllerDelegate
- (void)searchSectionController:(IGListSectionController *)sectionController andDidChangeText:(NSString *)text {
    textFilter = text;
    [self.adapter performUpdatesAnimated:YES completion:nil];
}


#pragma mark - IGListAdapterDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    
    
    if ([textFilter isEqual:@""]) {
        return [@[searchToken] arrayByAddingObjectsFromArray:[self.jsonModel value]];
    } else {

        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"key contains[cd] %@", textFilter];
        NSArray * subArr = [[self.jsonModel value] filteredArrayUsingPredicate:filterPredicate];
        return [@[searchToken] arrayByAddingObjectsFromArray:subArr];
    }
}


- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ((NSNumber *)object == searchToken) {
        SearchSectionController * searchSC = SearchSectionController.new;
        searchSC.delegate = self;
        return searchSC;
    } else {
        KeyValueSectionController * kv = KeyValueSectionController.new;
        kv.delegate = self;
        return kv;
    }
   
}



- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}



#pragma mark - lazy init

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
     

    }
    return _collectionView;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init]
                                           viewController:self];
        _adapter.collectionViewDelegate = self;

        _adapter.dataSource = self;
    }
    return _adapter;
}



//- (HomeView *)homeView {
//    if (!_homeView) {
//        _homeView = HomeView.new;
//        [self.view addSubview:_homeView];
//    }
//    return _homeView;
//}




//- (void)cancelAlert {
//    <#code#>
//}
//
//- (void)saveAfterConfig {
//    <#code#>
//}



@end
