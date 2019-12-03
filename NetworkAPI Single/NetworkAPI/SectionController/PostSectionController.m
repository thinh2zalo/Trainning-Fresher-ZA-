//
//  PostSectionController.m
//  NetworkAPI
//
//  Created by Steve on 11/13/19.
//  Copyright © 2019 Steve. All rights reserved.
//
#import "../Model/ContentModel.h"
#import "../View/TripleImageCell.h"
#import "../View/SingleImageCell.h"
#import "PostSectionController.h"


@implementation PostSectionController {
    Content *content;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    float heightOfCell  = content.images.count == 3 ? [TripleImageCell  heightOfCellWithTitle:content.title timestampAndPublisher:content.publicsherName] :  [SingleImageCell heightOfCell];
    return CGSizeMake(self.collectionContext.containerSize.width, heightOfCell);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    const Class cellClass = content.images.count == 3 ? [TripleImageCell class] : [SingleImageCell class];
    ParentCell * cell = [self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
    [cell updateContentInsideCell:content];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    content = object;
}
@end
