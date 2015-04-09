//
//  ViewController.h
//  UITableView
//
//  Created by Bowei on 4/8/15.
//  Copyright (c) 2015 Teo Bowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelMeetupName;
@property (strong, nonatomic) IBOutlet UILabel *labelEventAttendee;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UIImageView *ivMeetupImg;
@property (strong, nonatomic) IBOutlet UILabel *labelCityCountry;

@end

