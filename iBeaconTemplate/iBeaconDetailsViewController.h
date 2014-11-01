//
//  iBeaconDetailsViewController.h
//  iBeaconTemplate
//
//  Created by Ryan Tseng on 2014/10/22.
//  Copyright (c) 2014年 iBeaconModules.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBeaconDetailsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *devicePicture;

@property int major; // beacon, major
@property int minor; // beacon, minor

@end
