//
//  ImageModel.h
//  SickNote
//
//  Created by Lim Jessica on 28/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^handler)(UIImage *image);

@interface ImageModel : NSObject

@property (nonatomic, strong) NSURL *imageUrl;

- (void)getImageWithCompletionHandler:(handler)completionBlock;

@end
