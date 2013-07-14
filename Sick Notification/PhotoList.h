//
//  PhotoList.h
//  Sick Note
//
//  Created by Lim Jessica on 12/7/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageModel;

@interface PhotoList : UITableViewCell
+ (instancetype)instance;

@property(strong, nonatomic) ImageModel *imageModel;
@end
