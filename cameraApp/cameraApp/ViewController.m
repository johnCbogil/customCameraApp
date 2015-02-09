//
//  ViewController.m
//  cameraApp
//
//  Created by Aditya Narayan on 1/6/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadVideoLibrary];
}

-(void)loadVideoLibrary{
    
    
    
    // Create an array to store the videos
    self.allVideos = [[NSMutableArray alloc]init];
    
    // Create an assetsLibrary object
    self.assetLibrary = [[ALAssetsLibrary alloc]init];
    
    // Enumerate through all of the groups in the photos app
    [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         if(group){
             
             // filter the groups by video
             [group setAssetsFilter:[ALAssetsFilter allVideos]];
             
             // Enumerate through the videos
             [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop)
              {
                  if(asset){
                      
                      
                      
                      // Add all of videos to the array
                      [self.allVideos addObject:asset];
                      
                      
                      
                  }
              }];
             
         } else {
         }
     }
                                   failureBlock:^(NSError *error){
                                       
                                   }];
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self.collectionView reloadData];
                       
                   });
    
    
}


-(UIImage*)imageFromVideoURL:(NSURL*)videoURL{
    
    UIImage *image = nil;
    
    AVAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // Calculate the midpoint of the video
    Float64 durationSeconds = CMTimeGetSeconds([asset duration]);
    CMTime midpoint = CMTimeMakeWithSeconds(durationSeconds/2.0, 600);
    
    // Retrieve the image from the specified time
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef halfWayImage = [imageGenerator copyCGImageAtTime:midpoint actualTime:&actualTime error:&error];
    
    if(halfWayImage != NULL){
        
        // Convert the CGImage to UIImage
        image = [[UIImage alloc]initWithCGImage:halfWayImage];
        [self.dict setValue:image forKey:@"name"];
        NSLog(@"Values of dictionary %@", self.dict);
        NSLog(@"Video URL:%@",videoURL);
        CGImageRelease(halfWayImage);
    }
    return image;
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"NUMBER OF ITEMS IN SECTION METHOD: VIDEO COUNT: %lu", (unsigned long)self.allVideos.count);
    return self.allVideos.count;
    
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Assign data to cells here
    
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    ALAsset *alasset = [self.allVideos objectAtIndex:indexPath.row];
    cell.videoThumbnail.image = [UIImage imageWithCGImage:alasset.thumbnail];
    
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayerViewController *playerViewController = [[PlayerViewController alloc]init];

    
    NSLog(@"%@", [self.allVideos[indexPath.row] valueForProperty:ALAssetPropertyAssetURL]);
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    playerViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PlayerViewController"];
    playerViewController.videoURL = [self.allVideos[indexPath.row] valueForProperty:ALAssetPropertyAssetURL];

    [self.navigationController  pushViewController:playerViewController animated:YES];
    //[self presentViewController:playerViewController animated:YES completion:nil];
    
    
}




- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonPressed:(id)sender {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        // Create a picker
        self.picker = [[UIImagePickerController alloc]init];
        
        // Set the delegate
        self.picker.delegate = self;
        
        // Allow for editing ("use video")
        self.picker.allowsEditing = YES;
        
        // Set the sourctype to be the camera
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // Set the media types array to be of type movie
        self.picker.mediaTypes = [[NSArray alloc]initWithObjects:(NSString*)kUTTypeMovie, nil];
        
        // Present the picker
        [self presentViewController:self.picker animated:YES completion:nil];
    }
}

// Called when the user "chooses" the video
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Save video to library
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = (NSString*)[[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,
                                                @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    

}

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [self loadVideoLibrary];
        [self.collectionView reloadData];
        
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
