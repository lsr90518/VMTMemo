//
//  MKMapView+ZoomLevel.h
//  Nepre2
//
//  Created by Lsr on 11/29/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
