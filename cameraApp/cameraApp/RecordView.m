//
//  RecordView.m
//  sloMoTest
//
//  Created by Aditya Narayan on 1/12/15.
//  Copyright (c) 2015 John Bogil. All rights reserved.
//

#import "RecordView.h"

@implementation RecordView

+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
    return [(AVCaptureVideoPreviewLayer *)[self layer] session];
}

- (void)setSession:(AVCaptureSession *)session
{
    [(AVCaptureVideoPreviewLayer *)[self layer] setSession:session];
}
@end
