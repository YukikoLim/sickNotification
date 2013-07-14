//
//  ViewController.m
//  NavigationController
//
//  Created by Lim Jessica on 12/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "RootViewController.h"
#import "AbsenceTypesViewController.h"
#import "PhotosListViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Utils.h"
#import "ImageModel.h"
#import "MKNumberBadgeView.h"

@interface RootViewController ()
@end

@implementation RootViewController
@synthesize selectedCell;
@synthesize selectedAbsenceType;
@synthesize myDatePicker;
@synthesize selectedDate;
@synthesize bottomToolbar;
@synthesize imgPicker;
@synthesize photos;
@synthesize photoDelegate;
@synthesize collector;

NSArray *absTypeIndexPaths, *startDateIndexPaths;
UIActionSheet *aac;
NSURL *imageURL;
MKNumberBadgeView *numberBadge;

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [numberBadge removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIBarButtonItem *test = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(organiseAttachement)];
    
    self.navigationItem.rightBarButtonItem = test;
    
    numberBadge = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(250, -1, 40, 40)];
    numberBadge.value = collector.count;
    
    
    [self.navigationController.navigationBar addSubview:numberBadge];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Sick Note";
    
    collector = [[NSMutableArray alloc]init];
    //TODO: Send sick notification button
    /*UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendSickNote:)];
	self.navigationItem.rightBarButtonItem = sendButton;*/
    
        
	// Do any additional setup after loading the view, typically from a nib.
    //Initialize the dataArray
    dataArray = [[NSMutableArray alloc] init];
    
    //First section data
    NSArray *firstItemsArray = [[NSArray alloc] initWithObjects:@"Absence Type", @"Start Date", nil];
    NSDictionary *firstItemsArrayDict = [NSDictionary dictionaryWithObject:firstItemsArray forKey:@"data"];
    [dataArray addObject:firstItemsArrayDict];
    
    //Second section data
    NSArray *secondItemsArray = [[NSArray alloc] initWithObjects:@"Item 4", @"Item 5", nil];
    NSDictionary *secondItemsArrayDict = [NSDictionary dictionaryWithObject:secondItemsArray forKey:@"data"];
    [dataArray addObject:secondItemsArrayDict];
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = YES;
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Sick Notification Data";
    else
        return @"Employee Data";
  
}

/*- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
   
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if (indexPath.section == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

   
    cell.textLabel.text = cellValue;
    
    if([cellValue isEqual: @"Absence Type"])
    {
        cell.imageView.image = [UIImage imageNamed:@"F_aids.jpg"];
        cell.detailTextLabel.text = selectedAbsenceType;
        
        //Get AbsenceType's indexPaths for reload this Absence Type section only
         absTypeIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section],nil];
        
        //NSLog(@"indexpath row :%i,indexpath section:%i",indexPath.row,indexPath.section);
    }
    else if([cellValue isEqual:@"Start Date"])
    {
        cell.imageView.image = [UIImage imageNamed:@"calendar.jpg"];
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd.MM.YYYY"];
        
        if(selectedDate == nil)
        {
            selectedDate = [df stringFromDate:currentDate];
        }

        cell.detailTextLabel.text = selectedDate;
        
        startDateIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section],nil];
        //NSLog(@"indexpath row :%i,indexpath section:%i",indexPath.row,indexPath.section);
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Initialize  View Controller
    AbsenceTypesViewController *absTypesViewController = [[AbsenceTypesViewController alloc]initWithNibName:@"AbsenceTypesViewController" bundle:nil];
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    self.selectedCell = [array objectAtIndex:indexPath.row];
    
    //UITableViewCell *cell = [mainTable cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%@", self.selectedCell);
    
    if([self.selectedCell isEqual: @"Absence Type"])
    {
        // Push View Controller onto Navigation Stack and tell AbsenceTypesViewController that RootViewController is its delegate
        absTypesViewController.delegate = self;
        [self.navigationController pushViewController:absTypesViewController animated:YES];
        
    }
    else if ([self.selectedCell isEqual:@"Start Date"])
    {
        aac = [[UIActionSheet alloc] initWithTitle:nil
                                          delegate:self
                                 cancelButtonTitle:nil
                            destructiveButtonTitle:nil
                                 otherButtonTitles:nil];
        
        myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
        
        myDatePicker.datePickerMode = UIDatePickerModeDate;
        myDatePicker.maximumDate=[NSDate date];
        
        
        [self.myDatePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
        
        UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
        [pickerDateToolbar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(DatePickerDoneClick)];
        [barItems addObject:doneBtn];
        
        [pickerDateToolbar setItems:barItems animated:YES];
        
        [aac addSubview:pickerDateToolbar];
        [aac addSubview:myDatePicker];
        [aac showInView:self.view];
        [aac setBounds:CGRectMake(0,0,320, 464)];
        
    }
    
    [mainTable deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void) selectedDataAbsenceType:(NSString*) selectedData
{
    selectedAbsenceType = selectedData;
    
    //only to reload absence type section
    [mainTable reloadRowsAtIndexPaths:absTypeIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"Selected type is %@",selectedAbsenceType);
}

//listen to changes in the date picker and just log them
- (void) datePickerDateChanged:(UIDatePicker *)paramDatePicker
{
    
    if ([paramDatePicker isEqual:self.myDatePicker])
    {
        
        NSLog(@"Selected date = %@", paramDatePicker.date);
        NSLog(@"Selected cell = %@", self.selectedCell);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd.MM.YYYY"];
        selectedDate = [formatter stringFromDate:paramDatePicker.date];
        [mainTable reloadRowsAtIndexPaths:startDateIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}

-(void)DatePickerDoneClick
{
    [aac dismissWithClickedButtonIndex:0 animated:YES];
}

/*//Bottom Toolbar
-(void) addToolbar
{
    UIBarButtonItem *capturePhotoBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(capturePhoto:)];
    capturePhotoBtn.style = UIBarButtonItemStyleBordered;
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil action:nil];
    UIBarButtonItem *uploadBtn = [[UIBarButtonItem alloc]initWithTitle:@"Upload" style:UIBarButtonItemStyleBordered target:self action:@selector(upload:)];
    NSArray *toolBarItems = [NSArray arrayWithObjects:capturePhotoBtn, spaceItem, uploadBtn, nil];
    
    [bottomToolbar setItems:toolBarItems];
    
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getPhoto:(id)sender {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Initialize  View Controller
    PhotosListViewController *photoListViewController = [[PhotosListViewController alloc]initWithNibName:@"PhotosListViewController" bundle:nil];
    
    // get the ref url
    imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    [self.collector addObject:imageURL];
    photoListViewController.urlCollector = self.collector;
    
    NSLog(@"Collector in root %@",self.collector);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:photoListViewController animated:YES];


}

- (IBAction)getCameraPhoto:(id)sender {
    // check #1 - make sure our source type is supported
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        
        // check #2 see if media type includes images
        if ([mediaTypes containsObject:(NSString *)kUTTypeImage]) {
            
            // create our image picker
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            [self  presentViewController:picker animated:YES completion:nil];
        }
    }  
   }


// implement the image pickers delegate methods
/*- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Initialize  View Controller
    PhotosListViewController *photoListViewController = [[PhotosListViewController alloc]initWithNibName:@"PhotosListViewController" bundle:nil];
    
    // do something with this image
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // handle the case where editting was not allowed...
    if (!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // save to photo albumn
    ALAssetsLibrary *al = [Utils defaultAssetsLibrary];
    [al writeImageToSavedPhotosAlbum:[image CGImage] metadata:nil
                     completionBlock:^(NSURL *assetURL, NSError *error)
     {
         // once we know it's saved, grab the ALAsset and store
         // it in our collection for display later
         ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
         {
             [self.photos addObject:myasset];
             photoListViewController.photos = self.photos;
             //[self.tableView reloadData];
         };
         
         ALAssetsLibrary *assetslibrary = [Utils defaultAssetsLibrary];
         [assetslibrary assetForURL:assetURL
                        resultBlock:resultblock
                       failureBlock:nil];
     }];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:photoListViewController animated:YES];
}*/


- (void)organiseAttachement
{
    
    // Initialize  View Controller
    PhotosListViewController *photoListViewController = [[PhotosListViewController alloc]initWithNibName:@"PhotosListViewController" bundle:nil];
    photoListViewController.urlCollector = self.collector;
    NSLog(@"Collector in root %@",self.collector);
    [self.navigationController pushViewController:photoListViewController animated:YES];
    
}

- (IBAction)sendSickNote:(id)sender {
}
@end
