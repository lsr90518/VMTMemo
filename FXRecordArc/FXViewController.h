//
//  FXViewController.h
//  FXRecordArc
//
//  Created by 方 霄 on 14-6-10.
//  Copyright (c) 2014年 方 霄. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "MKMapView+ZoomLevel.h"
#import "JPSThumbnailAnnotation.h"
#import "MKMapView+ZoomLevel.h"
#import <MapKit/MKAnnotation.h>
#import "FXRecordArcView.h"
#import "ContentsViewController.h"
#import "MapContentViewController.h"
@interface FXViewController : UIViewController<FXRecordArcViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate,MKOverlay>{
    CLLocationManager *locationManager;
    CLLocation *checkinLocation;
    CLLocationCoordinate2D currentLocation;
}

@property(nonatomic, strong) FXRecordArcView *recordView;

@property(nonatomic, strong) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *penal_background;
@property (weak, nonatomic) IBOutlet MKMapView *content_map;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) NSString *now_time_str;

@end
