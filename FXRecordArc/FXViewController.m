//
//  FXViewController.m
//  FXRecordArc
//
//  Created by 方 霄 on 14-6-10.
//  Copyright (c) 2014年 方 霄. All rights reserved.
//

#import "FXViewController.h"

@interface FXViewController ()
@property (weak, nonatomic) IBOutlet UIButton *touchButton;
@property (weak, nonatomic) IBOutlet UIView *buttonBackground;

@end

@implementation FXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.recordView = [[FXRecordArcView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:self.recordView];
    self.recordView.delegate = self;
    
    self.buttonBackground.layer.cornerRadius = 40;
    self.buttonBackground.clipsToBounds = YES;

}

- (IBAction)tapRecordBtn:(id)sender{
    [self.recordView startForFilePath:[self fullPathAtCache:@"record.wav"]];
}

- (IBAction)tapCancelBtn:(id)sender{
    [self.recordView commitRecording];
}

- (IBAction)tapPlayBtn:(id)sender{
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[self fullPathAtCache:@"record.wav"]] error:nil];
    [self.player play];
}

- (IBAction)tapStopBtn:(id)sender{
    [self.player stop];
}

- (NSString *)fullPathAtCache:(NSString *)fileName{
    NSError *error;
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (YES != [fm fileExistsAtPath:path]) {
        if (YES != [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"create dir path=%@, error=%@", path, error);
        }
    }
    return [path stringByAppendingPathComponent:fileName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recordArcView:(FXRecordArcView *)arcView voiceRecorded:(NSString *)recordPath length:(float)recordLength{
//    UIAlertView *alert =
//    [[UIAlertView alloc] initWithTitle: @"record"
//                               message: [NSString stringWithFormat:@"录音地址：%@,  时常：%f",recordPath, recordLength]
//                              delegate: nil
//                     cancelButtonTitle:@"OK"
//                     otherButtonTitles:nil];
//    [alert show];
    

}
- (IBAction)touchBegin:(id)sender {
    [self recordBegin];
}
- (IBAction)touchOutside:(id)sender {
    [self recordOver];
}
- (IBAction)touchInside:(id)sender {
    [self recordOver];
}

-(void)recordBegin{
    UIColor* touchColor = [[UIColor alloc]initWithRed:255.0/255.0 green:136.0/255.0 blue:138.0/255.0 alpha:1];
    self.buttonBackground.backgroundColor = touchColor;
    [self.recordView startForFilePath:[self fullPathAtCache:@"record.wav"]];
}

-(void)recordOver {
    UIColor* overColor = [[UIColor alloc]initWithRed:57.0/255.0 green:216.0/255.0 blue:250.0/255.0 alpha:1];
    self.buttonBackground.backgroundColor = overColor;
    [self.recordView commitRecording];
}

@end
