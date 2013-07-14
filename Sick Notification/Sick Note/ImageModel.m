//
//  ImageModel.m
//  SickNote
//
//  Created by Lim Jessica on 28/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "ImageModel.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotosListViewController.h"

@implementation ImageModel
@synthesize imageUrl;

- (void)getImageWithCompletionHandler:(handler)completionBlock
{
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {

        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        CGImageRef iref = [imageRep fullResolutionImage];
        if (iref) {
            UIImage *image = [UIImage imageWithCGImage:iref];
            completionBlock(image);
            NSLog(@"Image URL in image model %@", image);
        }
        
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc]init];
    [assetslibrary assetForURL:self.imageUrl resultBlock:resultblock failureBlock:nil];
}
@end
