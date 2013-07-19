//
//  PhotosListViewController.h
//  SickNote
//
//  Created by Lim Jessica on 23/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class PhotosListViewController;

@protocol photosListViewControllerDelegate <NSObject>
-(void) selectedImageModel:(NSMutableArray *) imageModelArray;
@end

@interface PhotosListViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    __weak id<photosListViewControllerDelegate>delegate;
}

@property (nonatomic, strong) NSMutableArray * photos;
@property (nonatomic, strong) NSMutableArray *urlCollector;
@property (nonatomic, strong) NSMutableArray *imageModelObjects;
@property (nonatomic, strong) NSMutableArray *dataObj;
@property (nonatomic, weak) id<photosListViewControllerDelegate> delegate;

@end
