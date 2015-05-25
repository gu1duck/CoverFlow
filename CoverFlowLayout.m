//
//  CoverFlowLayout.m
//  CoverFlowLayout
//
//  Created by Jeremy Petter on 2015-05-22.
//  Copyright (c) 2015 Jeremy Petter. All rights reserved.
//

#import "CoverFlowLayout.h"


@implementation CoverFlowLayout


-(void)prepareLayout{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat totalHeight = self.collectionView.bounds.size.height;
    self.itemSize = CGSizeMake(totalHeight *0.8, totalHeight * 0.8);
    self.minimumInteritemSpacing = 0.1;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attribute in attributes) {
        
        CGRect visibleRegion;
        visibleRegion.origin = self.collectionView.contentOffset;
        visibleRegion.size   = self.collectionView.bounds.size;
        
        CGFloat distanceOffset = (attribute.center.x - (visibleRegion.origin.x + visibleRegion.size.width/2))/visibleRegion.size.width/2;
        CGFloat scaleFactor = 1 - 0.8 * fabs(distanceOffset);
        CGFloat rotationFactor = -2*M_PI*distanceOffset;
        
        attribute.alpha = scaleFactor;
        attribute.transform3D = CATransform3DConcat(CATransform3DMakeScale(scaleFactor, scaleFactor, scaleFactor), CATransform3DMakeRotation(rotationFactor, 0, 1, 0));
        attribute.zIndex = 10-(-10*fabs(scaleFactor));
        

//        attribute.transform3D = CATransform3DMakeScale(scaleFactor, scaleFactor, scaleFactor);
//        attribute.transform3D = CATransform3DMakeRotation(rotationFactor, 0, 1, 0);
    }
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
