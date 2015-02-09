//
//  PlayerViewController.m
//  cameraApp
//
//  Created by Aditya Narayan on 1/8/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self playVideo:self.videoURL];
}

-(void)playVideo:(NSURL*)videoURL{
    
    
    // Create an AVAsset with the URL that was selected
    AVAsset *avAsset = [AVAsset assetWithURL:videoURL];
    
    // Create a playerItem with the asset we just created
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    
    // Create an AVPlayer with the item we just created
    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    
    // Create a playerLayer with the player we just created
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    

    // Set the frame of the playerLayer
    //[avPlayerLayer setFrame:self.view.frame];
    //[avPlayerLayer setFrame:CGRectMake(0, 35, (self.view.frame.size.width), (self.view.frame.size.height - 85))];
    //[avPlayerLayer setFrame:self.videoView.frame];
    [avPlayerLayer setFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-90)];
    
    // Add the playerLayer to the view
    [self.videoView.layer addSublayer:avPlayerLayer];
    
    // Set the time to be zero
    [self.avPlayer seekToTime:kCMTimeZero];
    
    // Play the video
    [self.avPlayer play];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];

    
}



-(void)playerItemDidReachEnd:(NSNotification*)notification{
    
    
    
    [self.avPlayer seekToTime:kCMTimeZero];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonPressed:(id)sender {
    
    [self.avPlayer play];
    
    
}

- (IBAction)pauseButtonPressed:(id)sender {
    
    [self.avPlayer pause];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(id)sender {
    
    

    
    
    
}
@end
