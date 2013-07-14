//
//  PhotosListViewController.h
//  SickNote
//
//  Created by Lim Jessica on 23/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface PhotosListViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray * photos;
@property (nonatomic, strong) NSURL *test;
@property (nonatomic, strong) UIImage *galleryImage;
@property (nonatomic, strong) NSMutableArray *urlCollector;
@property (nonatomic, strong) NSMutableArray *photoCollector;
@property (nonatomic, strong) NSMutableArray *imageModelObjects;

@end
