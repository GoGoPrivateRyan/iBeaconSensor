//
//  iBeaconDetailsViewController.m
//  iBeaconTemplate
//
//  Created by Ryan Tseng on 2014/10/22.
//  Copyright (c) 2014年 iBeaconModules.us. All rights reserved.
//

#import "iBeaconDetailsViewController.h"

@interface iBeaconDetailsViewController ()


@end

@implementation iBeaconDetailsViewController

@synthesize detailsLabel;
@synthesize devicePicture;
@synthesize major;
@synthesize minor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.minor == 1)
    {
        self.devicePicture.image = [UIImage imageNamed:@"pm_pica.png"];
        self.detailsLabel.text = @"捕獲 皮卡丘";
    }
    else if (self.minor == 2)
    {
        self.devicePicture.image = [UIImage imageNamed:@"pm_turtle.png"];
        self.detailsLabel.text = @"捕獲 傑尼龜";
    }
    else
    {
        self.devicePicture.image = [UIImage imageNamed:@"pm_frog.png"];
        self.detailsLabel.text = @"捕獲 妙蛙種子";
    }
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
