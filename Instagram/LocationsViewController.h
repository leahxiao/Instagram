//
//  LocationsViewController.h
//  Instagram
//
//  Created by Leah Xiao on 7/13/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol LocationsViewControllerDelegate

//- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

- (void) setLocationTitle:(NSString *) nameOfPlace;
@end

@interface LocationsViewController : UIViewController
@property (weak, nonatomic) id<LocationsViewControllerDelegate> delegate;
@end
