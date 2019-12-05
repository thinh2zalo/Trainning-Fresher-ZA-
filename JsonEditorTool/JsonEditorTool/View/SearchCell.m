//
//  SearchCell.m
//  JsonEditorTool
//
//  Created by Steve on 12/5/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)layoutSubviews {
    self.searchBar.frame = self.bounds;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = UISearchBar.new;
        [self addSubview:_searchBar];
    }
    return _searchBar;
}


@end
