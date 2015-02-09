//
//  PlayerViewController.h
//  cameraApp
//
//  Created by Aditya Narayan on 1/8/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"


@interface PlayerViewController : UIViewController


@property (strong, nonatomic) AVPlayer *avPlayer;


-(void)playVideo:(NSURL*)videoURL;

@property (strong, nonatomic) NSURL *videoURL;

@property (strong, nonatomic) IBOutlet UIView *videoView;


- (IBAction)backButtonPressed:(id)sender;

@end
