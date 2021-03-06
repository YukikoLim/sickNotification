//
//  RootViewController.h
//  NavigationController
//
//  Created by Lim Jessica on 12/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbsenceTypesViewController.h"
#import "PhotosListViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface RootViewController : UIViewController <photosListViewControllerDelegate,absenceTypeViewControllerDelegate,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    IBOutlet UITableView *mainTable;
    NSMutableArray *dataArray;
    IBOutlet UIToolbar *photoAlbumButton;
    UIImagePickerController *imgPicker;
    IBOutlet UIBarButtonItem *takePhotoButton;
    IBOutlet UIBarButtonItem *uploadAttachement;
}

@property (nonatomic,retain) NSString *selectedCell;
@property (nonatomic,strong) NSString *selectedAbsenceType;
@property (nonatomic,strong) UIDatePicker *myDatePicker;
@property (nonatomic,strong) NSString *selectedDate;
@property (nonatomic,weak) IBOutlet UIToolbar *bottomToolbar;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, strong) NSMutableArray * photos;
@property (nonatomic,strong) NSMutableArray *collector;

- (IBAction)getPhoto:(id)sender;
- (IBAction)getCameraPhoto:(id)sender;
- (IBAction)sendSickNote:(id)sender;




@end
