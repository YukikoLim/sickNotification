//
//  Utils.m
//  SickNote
//
//  Created by Lim Jessica on 24/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}
@end
