//
//  MapContentViewController.h
//  FXRecordArc
//
//  Created by Lsr on 8/19/14.
//  Copyright (c) 2014 方 霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"
#import "JPSThumbnailAnnotation.h"
#import "MKMapView+ZoomLevel.h"
#import <MapKit/MKAnnotation.h>
#import <AVFoundation/AVFoundation.h>

@interface MapContentViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKOverlay>{
    CLLocationManager *locationManager;
    CLLocation *checkinLocation;
    CLLocationCoordinate2D currentLocation;
}


@property(nonatomic, strong) AVAudioPlayer *player;
@property(nonatomic, strong) NSString *cLat;
@property(nonatomic, strong) NSString *cLng;
@end
