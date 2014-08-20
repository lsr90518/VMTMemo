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
@property (weak, nonatomic) IBOutlet UIView *navigationbar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation FXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.recordView = [[FXRecordArcView alloc] initWithFrame:CGRectMake(60, 60, 200, 280)];
    [self.view addSubview:self.recordView];
    self.recordView.delegate = self;
    
    
    //penal setting
    self.penal_background.layer.cornerRadius = 125;
    self.penal_background.layer.shadowColor = [UIColor blackColor].CGColor;
    self.penal_background.layer.shadowOffset = CGSizeMake(5, 5);
    self.penal_background.layer.shadowOpacity = 0.3;
    self.penal_background.layer.shadowRadius = 1.0;
    self.buttonBackground.layer.cornerRadius = 40;
    self.buttonBackground.clipsToBounds = YES;

    
    //navigation bar
    self.navigationbar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationbar.layer.shadowOffset = CGSizeMake(1, 1);
    self.navigationbar.layer.shadowOpacity = 0.6;
    self.navigationbar.layer.shadowRadius = 0.5;

    //time label
    NSDate* now_time = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* str = [formatter stringFromDate:now_time];
    [self.time_label setText:str];
    //

    //setup location
    [self setupLocationManager];
    ///Users/lsr/Library/Application Support/iPhone Simulator/7.1-64/Applications/DC4B5EF5-6FB6-4191-99B6-B50E81EBBEEE/Library/Caches/record.wav
    
    ///Users/lsr/Library/Application Support/iPhone Simulator/7.1-64/Applications/DC4B5EF5-6FB6-4191-99B6-B50E81EBBEEE/Library/Caches/record.wav
    
    ///Users/lsr/Library/Application Support/iPhone Simulator/7.1-64/Applications/DC4B5EF5-6FB6-4191-99B6-B50E81EBBEEE/Library/Caches/record.wav
    
//    NSString *songsDirectory=MUSIC_FILE_ALL;//沙盒地址
//    NSBundle *songBundle=[NSBundle bundleWithPath:songsDirectory];
//    NSString *bundlePath=[songBundle resourcePath];
//    
//    NSArray *arrMp3=[NSBundle pathsForResourcesOfType:@"mp3" inDirectory:bundlePath];
//    for (NSString *filePath in arrMp3) {
//        [self.wMp3URL addObject:filePath];
//    }
}

- (void) setupLocationManager {
    locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog( @"Starting CLLocationManager" );
        locationManager.delegate = self;
        locationManager.distanceFilter = 200;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    } else {
        NSLog( @"Cannot Starting CLLocationManager" );
        /*self.locationManager.delegate = self;
         self.locationManager.distanceFilter = 200;
         locationManager.desiredAccuracy = kCLLocationAccuracyBest;
         [self.locationManager startUpdatingLocation];*/
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    checkinLocation = newLocation;
    CLLocationCoordinate2D centerCoord = {checkinLocation.coordinate.latitude,checkinLocation.coordinate.longitude};
    [self.mapView setCenterCoordinate:centerCoord zoomLevel:13 animated:NO];
    currentLocation = centerCoord;
    //    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(34.070365,134.559553)];
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
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.penal_background.alpha = 0.0;
        self.buttonBackground.alpha = 0.0;
        self.recordView.alpha = 0.0;
        
    } completion:^(BOOL finshed){
        
        UIColor* overColor = [[UIColor alloc]initWithRed:57.0/255.0 green:216.0/255.0 blue:250.0/255.0 alpha:1];
        self.buttonBackground.backgroundColor = overColor;
        [self.recordView commitRecording];
        
        MapContentViewController * mcvc = [[MapContentViewController alloc]init];
        mcvc.cLat = [NSString stringWithFormat:@"%f",currentLocation.latitude];
        mcvc.cLng = [NSString stringWithFormat:@"%f",currentLocation.longitude];
        mcvc.log_time = self.time_label.text;
        [self presentViewController:mcvc animated:NO completion:nil];
        
    }];
    
}

@end
