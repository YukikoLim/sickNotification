//
//  AbsenceTypesViewController.m
//  SickNote
//
//  Created by Lim Jessica on 15/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "AbsenceTypesViewController.h"

@interface AbsenceTypesViewController ()

@end

@implementation AbsenceTypesViewController
//@synthesize selectedAbsenceTypeFromList;
@synthesize delegate;

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
    
    // Set Title
    self.title = @"Absence Type";
    
    // Load Property List
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AbsenceTypeList" ofType:@"plist"];
    self.absenceTypes = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"authors > %@", self.absenceTypes);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"Total authors: %lu",(unsigned long)[self.absenceTypes count]);
    return [self.absenceTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[self.absenceTypes objectAtIndex:[indexPath row]]];
    
    
    
    return cell;
}


 /*// Override to support conditional editing of the table view.
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
    
    //RootViewController *rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    //rootViewController.selectedAbsenceType = [self.absenceType objectAtIndex:indexPath.row];
    
    //[self.navigationController setViewControllers:[NSArray arrayWithObject:rootViewController] animated:YES];
    
    NSString *selectedCell = nil;
    selectedCell = [self.absenceTypes objectAtIndex:indexPath.row];
    
    [self.delegate selectedDataAbsenceType: (NSString*) [self.absenceTypes objectAtIndex:indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@", selectedCell);
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"test is %@",[self.absenceTypes objectAtIndex:indexPath.row]);
    
}

@end
