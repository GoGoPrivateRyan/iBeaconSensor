//
//  IMViewController.m
//  iBeaconTemplate
//
//  Created by James Nick Sears on 5/29/14.
//  Copyright (c) 2014 iBeaconModules.us. All rights reserved.
//

#import "IMViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "iBeaconDetailsViewController.h"

@interface IMViewController ()

@end

@implementation IMViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:@"MyIdentifier"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CLBeacon *beacon = (CLBeacon*)[self.beacons objectAtIndex:indexPath.row];
    NSString *proximityLabel = @"";
    switch (beacon.proximity) {
        case CLProximityFar:
            proximityLabel = @"你和寶物離很遠";
            ((UIImageView *)[cell viewWithTag:100]).image = [UIImage imageNamed:@"wifi_d3.png"];
            break;
        case CLProximityNear:
            proximityLabel = @"你附近有寶物";
            ((UIImageView *)[cell viewWithTag:100]).image = [UIImage imageNamed:@"wifi_d4.png"];
            break;
        case CLProximityImmediate:
            proximityLabel = @"你差不多就在寶物旁邊";
            ((UIImageView *)[cell viewWithTag:100]).image = [UIImage imageNamed:@"wifi_d6.png"];
            break;
        case CLProximityUnknown:
            proximityLabel = @"無法分辦你和寶物之間的距離";
            ((UIImageView *)[cell viewWithTag:100]).image = [UIImage imageNamed:@"wifi_d1.png"];
            break;
    }
    
    ((UILabel *)[cell viewWithTag:101]).text = proximityLabel;
    
    NSString *detailLabel = [NSString stringWithFormat:@"Major: %d, Minor: %d, 訊號強度: %d, UUID: %@",
                             beacon.major.intValue, beacon.minor.intValue, (int)beacon.rssi, beacon.proximityUUID.UUIDString];
    ((UILabel *)[cell viewWithTag:102]).text = detailLabel;

    return cell;    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showiBeaconDetails"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CLBeacon *beacon = (CLBeacon*)[self.beacons objectAtIndex:indexPath.row];
        NSLog(@"major=%d, minor=%d", beacon.major.intValue, beacon.minor.intValue);

        
        iBeaconDetailsViewController *destViewController = segue.destinationViewController;
        //destViewController.detailsLabel.text = @"ttttt";//[recipes objectAtIndex:indexPath.row];
        destViewController.major = beacon.major.intValue;
        destViewController.minor = beacon.minor.intValue;
        //cell.imageView.image = [UIImage imageNamed:@"wifi_d1.png"];
        NSLog(@"major1=%d, minor1=%d", destViewController.major, destViewController.minor);
    }
}

@end
