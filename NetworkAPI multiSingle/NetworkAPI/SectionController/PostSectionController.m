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
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionDelegate = self;
    }
    return self;
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


- (UICollectionViewLayoutAttributes *)listAdapter:(IGListAdapter *)listAdapter customizedFinalLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes sectionController:(IGListSectionController *)sectionController atIndex:(NSInteger)index {
    CATransform3D transform = CATransform3DMakeTranslation(0, self.collectionContext.containerSize.height, 0);
    transform = CATransform3DRotate(transform, M_PI*0.2, 0, 0, 1);
    attributes.transform3D = transform;
    attributes.alpha = 1.0f;
    return attributes;
}

- (UICollectionViewLayoutAttributes *)listAdapter:(IGListAdapter *)listAdapter customizedInitialLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes sectionController:(IGListSectionController *)sectionController atIndex:(NSInteger)index {
    attributes.transform3D = CATransform3DMakeTranslation(-self.collectionContext.containerSize.width, 0, 0);
    return attributes;
}

@end
