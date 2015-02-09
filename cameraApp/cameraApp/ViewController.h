//
//  ViewController.h
//  cameraApp
//
//  Created by Aditya Narayan on 1/6/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CollectionViewCell.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import "PlayerViewController.h"



@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableArray *allVideos;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) ALAssetsLibrary *assetLibrary;

@property (strong, nonatomic) MPMoviePlayerController *videoController;

@property (strong, nonatomic) UIImagePickerController *picker;

@property (strong, nonatomic) NSURL *videoURL;







- (IBAction)cameraButtonPressed:(id)sender;

-(void)loadVideoLibrary;




@end

