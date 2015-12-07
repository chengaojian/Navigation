//
//  ViewController.m
//  导航
//
//  Created by 陈高健 on 15/12/3.
//  Copyright © 2015年 陈高健. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
//地址
@property (weak, nonatomic) IBOutlet UITextField *addressText;

@end

@implementation ViewController

//开始导航
- (IBAction)begin:(id)sender {
    
    //创建CLGeocoder对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.addressText.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //获取目的地地理坐标
        CLPlacemark *placemark = [placemarks lastObject];
        //Mapkit框架下的地标
        MKPlacemark *mkPlacemark = [[MKPlacemark alloc] initWithPlacemark:placemark];
        //目的地的item
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:mkPlacemark];
        MKMapItem *currentmapItem = [MKMapItem mapItemForCurrentLocation];
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        //MKLaunchOptionsDirectionsModeDriving:导航类型设置为驾车模式
        options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
        //设置地图显示类型为卫星模式
        options[MKLaunchOptionsMapTypeKey] = @(MKMapTypeHybrid);
        options[MKLaunchOptionsShowsTrafficKey] =@(YES);
        //打开地图
        [MKMapItem openMapsWithItems:@[currentmapItem,mapItem] launchOptions:options];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
