//
//  AbsenceTypesViewController.h
//  SickNote
//
//  Created by Lim Jessica on 15/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
/*#import "RootViewController.h"

@interface AbsenceTypesViewController : UITableViewController

@property NSArray* absenceType;
@property (nonatomic,weak) RootViewController *selectedAbsenceTypeFromList;
@end
*/
@class AbsenceTypesViewController;

@protocol absenceTypeViewControllerDelegate <NSObject>
-(void) selectedDataAbsenceType:(NSString*) selectedData;
@end

@interface AbsenceTypesViewController : UITableViewController
{
    __weak id<absenceTypeViewControllerDelegate>delegate;
}
@property (nonatomic,weak) id<absenceTypeViewControllerDelegate> delegate;
@property NSArray *absenceTypes;
@end