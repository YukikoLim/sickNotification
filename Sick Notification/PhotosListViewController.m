//
//  PhotosListViewController.m
//  SickNote
//
//  Created by Lim Jessica on 23/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "PhotosListViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Utils.h"
#import "ImageModel.h"
#import "PhotoList.h"

@interface PhotosListViewController ()

@end

@implementation PhotosListViewController
@synthesize photos = _photos;
@synthesize urlCollector;
@synthesize imageModelObjects;
@synthesize delegate;
@synthesize dataObj;

- (NSMutableArray *)photos
{
    if (!_photos) _photos = [NSMutableArray array];
    return _photos;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        [self.delegate selectedImageModel:self.dataObj];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.imageModelObjects = [NSMutableArray array];
    for(NSURL *url in self.urlCollector)
    {
        ImageModel *imageModel = [[ImageModel alloc] init];
        imageModel.imageUrl = url;
        [self.imageModelObjects addObject:imageModel];
        NSLog(@"Image model %@,",imageModelObjects);
    }
    
    //Get selected image and convert to NSData before pass to root view controller
    self.dataObj = [NSMutableArray array];
    for(ImageModel *imgModel in imageModelObjects)
    {
        ImageModel *model = imgModel;
        [model getImageWithCompletionHandler:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dataObj addObject:UIImageJPEGRepresentation(image, 1.0)];
            });
        }];
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.urlCollector count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PhotoList *list = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (list == nil) {
        list = [PhotoList instance];
    }

    ImageModel *model = [self.imageModelObjects objectAtIndex:indexPath.row];
    model.index = indexPath.row;
    list.imageModel = model;

    return list;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.urlCollector removeObjectAtIndex:indexPath.row];
        [self.imageModelObjects removeObjectAtIndex:indexPath.row];
        [self.dataObj removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

@end
