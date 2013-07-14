//
//  AppDelegate.h
//  Sick Note
//
//  Created by Lim Jessica on 9/7/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

//@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    UINavigationController *navController;
    RootViewController *viewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;


@end
