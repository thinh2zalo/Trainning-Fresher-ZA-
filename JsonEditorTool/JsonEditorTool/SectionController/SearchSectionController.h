//
//  SearchSectionController.h
//  JsonEditorTool
//
//  Created by Steve on 12/5/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchSectionControllerDelegate

-(void)searchSectionController:(IGListSectionController *) sectionController andDidChangeText:(NSString *) text;

@end

@interface SearchSectionController : IGListSectionController
@property (nonatomic, weak) id <SearchSectionControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
