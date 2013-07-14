//
//  PhotoList.m
//  Sick Note
//
//  Created by Lim Jessica on 12/7/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "PhotoList.h"
#import "ImageModel.h"

@interface PhotoList ()
@property (nonatomic, weak) IBOutlet UILabel *ibLabel;
@property (nonatomic, weak) IBOutlet UIImageView *ibImageView;
@end

@implementation PhotoList

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    for (NSLayoutConstraint *cellConstraint in self.constraints)
    {
        [self removeConstraint:cellConstraint];
        
        id firstItem = cellConstraint.firstItem == self ? self.contentView : cellConstraint.firstItem;
        id seccondItem = cellConstraint.secondItem == self ? self.contentView : cellConstraint.secondItem;
        
        NSLayoutConstraint* contentViewConstraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                                 attribute:cellConstraint.firstAttribute
                                                                                 relatedBy:cellConstraint.relation
                                                                                    toItem:seccondItem
                                                                                 attribute:cellConstraint.secondAttribute
                                                                                multiplier:cellConstraint.multiplier
                                                                                  constant:cellConstraint.constant];
        
        [self.contentView addConstraint:contentViewConstraint];
    }
}
+ (instancetype)instance
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PhotoList"
                                                      owner:nil
                                                    options:nil];
    PhotoList *list = nibViews[0];
    return list;
}

- (void)setImageModel:(ImageModel *)imageModel
{
    _imageModel = imageModel;
    [_imageModel getImageWithCompletionHandler:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ibImageView.image = image;
        });
    }];
    
    [self.ibLabel setText:[NSString stringWithFormat:@"Attachement %d", _imageModel.index+1]];
}


@end
