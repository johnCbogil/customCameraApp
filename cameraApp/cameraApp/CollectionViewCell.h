//
//  CollectionViewCell.h
//  cameraApp
//
//  Created by Aditya Narayan on 1/6/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumbnail;


@end
