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

@interface PhotosListViewController ()

@end

@implementation PhotosListViewController
@synthesize photos = _photos;
@synthesize galleryImage;
@synthesize test;
@synthesize urlCollector;
@synthesize photoCollector;
@synthesize imageModelObjects;

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

- (void)viewDidLoad
{

    [super viewDidLoad];

    self.imageModelObjects = [NSMutableArray array];
    for(NSURL *url in self.urlCollector)
    {
        ImageModel *imageModel = [[ImageModel alloc] init];
        imageModel.imageUrl = url;
        [self.imageModelObjects addObject:imageModel];
        NSLog(@"Image model %@,",imageModelObjects);
    }
    
    //You can discard the collecter. IF u want the url, u can get from the self.imageModelObjects.
    //self.urlCollector = nil;
    
    //photoCollector = [[NSMutableArray alloc]init];
    
    //NSLog(@"Image is THIS --- %@",test);
    NSLog(@"Collector in photoList %@ ,%i",self.urlCollector, urlCollector.count);
   
    /*for (int i = 0; i < urlCollector.count; i++) {
    // define the block to call when we get the asset based on the url (below)
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        CGImageRef iref = [imageRep fullResolutionImage];
        if (iref) {
            //galleryImage = [UIImage imageWithCGImage:iref];
            [photoCollector addObject:[UIImage imageWithCGImage:iref]];
            [self.tableView reloadData];
            NSLog(@"This is in assetLibrarty");
        }

        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        
    };
    
    
    // get the asset library and fetch the asset based on the ref url (pass in block above)
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc]init];
    [assetslibrary assetForURL:[urlCollector objectAtIndex:i] resultBlock:resultblock failureBlock:nil];
    
    }*/
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.photos count];
    return [self.urlCollector count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    
    /*cell.imageView.image = self.photoCollector [indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"Attachement %d", indexPath.row+1]];

    NSLog(@"This is in cellForRowAtIndexPath");
    NSLog(@"Gallery image is %@",self.photoCollector [indexPath.row]);*/
    

    ImageModel *model = [self.imageModelObjects objectAtIndex:indexPath.row];
    NSLog(@"Image model in cellForRowAtindexPath %@",model);
    [model getImageWithCompletionHandler:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
            NSLog(@"Image is %@",image);
        });

       
    }];

   [cell.textLabel setText:[NSString stringWithFormat:@"Attachement %d", indexPath.row+1]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
