//
//  MapViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/20.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate> {
     MKMapView *_mapView;
     CLGeocoder *_geocoder;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMapGUI];
    [self getCoordinate];
    // Do any additional setup after loading the view.
}

- (void)initMapGUI {
    _mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsScale = YES;
    _mapView.showsCompass = YES;
    _mapView.showsTraffic = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}

- (void)getCoordinate {
    _geocoder = [[CLGeocoder alloc] init];
    [_geocoder geocodeAddressString:self.theRestaurant.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error != nil) {
            return;
        }
     
        CLPlacemark *placemark = [placemarks firstObject];
        MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
        pointAnnotation.title = self.theRestaurant.name;
        pointAnnotation.subtitle = self.theRestaurant.type;
        
        CLLocation *location = placemark.location;
        if(location != nil) {
            pointAnnotation.coordinate = location.coordinate;
            [_mapView showAnnotations:@[pointAnnotation] animated:YES];
            [_mapView selectAnnotation:pointAnnotation animated:YES];
        }
        
        [_mapView addAnnotation:pointAnnotation];
    }];
}

#pragma mark -MKMapViewDelegate-
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyPin";
    
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;//允许交互点击
    }

    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 53, 53)];
    leftView.image = [UIImage imageNamed:self.theRestaurant.iamge];
    annotationView.leftCalloutAccessoryView = leftView;
    
    annotationView.annotation=annotation;
    [annotationView setTintColor:[UIColor orangeColor]];
    
    return annotationView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
