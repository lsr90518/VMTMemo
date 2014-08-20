//
//  MapContentViewController.m
//  FXRecordArc
//
//  Created by Lsr on 8/19/14.
//  Copyright (c) 2014 方 霄. All rights reserved.
//

#import "MapContentViewController.h"
#import "FXViewController.h"

@interface MapContentViewController ()
@property (weak, nonatomic) IBOutlet UIView *navigationbar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //navigation bar
    self.navigationbar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationbar.layer.shadowOffset = CGSizeMake(1, 1);
    self.navigationbar.layer.shadowOpacity = 0.6;
    self.navigationbar.layer.shadowRadius = 0.5;
    
    [self.mapView addAnnotations:[self generateAnnotations]];
    self.mapView.delegate = self;
    
    //setup location
    [self setupLocationManager];
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

- (NSArray *)generateAnnotations {
    NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:1];
    // Parliament of Canada
    JPSThumbnail *ottawa = [[JPSThumbnail alloc] init];
    ottawa.image = [UIImage imageNamed:@"shibuya1"];
    ottawa.title = @"Title";
    ottawa.subtitle = self.log_time;
//    ottawa.coordinate = CLLocationCoordinate2DMake(35.0291102,135.7793681);
    ottawa.coordinate = CLLocationCoordinate2DMake(self.cLat.floatValue, self.cLng.floatValue);
    ottawa.disclosureBlock = ^{
        [self playMemo];
        [self centerMap];
    };
    
    [annotations addObject:[[JPSThumbnailAnnotation alloc] initWithThumbnail:ottawa]];
    
    return annotations;
}

-(void)playMemo{
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[self fullPathAtCache:@"record.wav"]] error:nil];
    [self.player play];
}

- (void)centerMap
{
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(currentLocation.latitude,currentLocation.longitude) zoomLevel:17 animated:YES];
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

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"fwfwfw");
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"fwfwfw2");
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    NSLog(@"fwfwfw3");
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
- (IBAction)goRecorder:(id)sender {
    FXViewController *fxvc = [[FXViewController alloc]init];
    [self presentViewController:fxvc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
