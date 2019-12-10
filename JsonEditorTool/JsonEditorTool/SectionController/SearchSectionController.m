//
//  SearchSectionController.m
//  JsonEditorTool
//
//  Created by Steve on 12/5/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SearchSectionController.h"
#import "../View/SearchCell.h"


@interface SearchSectionController() <UISearchBarDelegate>
@end
@implementation SearchSectionController


#pragma mark - override listSectionController

- (NSInteger)numberOfItems {
    return 1;
}
- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 50);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    SearchCell * cell = [self.collectionContext dequeueReusableCellOfClass:SearchCell.class forSectionController:self atIndex:index];
    cell.searchBar.delegate = self;
    return cell;
}

// MARK: UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.delegate searchSectionController:self andDidChangeText:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.delegate searchSectionController:self andDidChangeText:searchBar.text];

}




@end
