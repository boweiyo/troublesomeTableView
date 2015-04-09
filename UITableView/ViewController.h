//
//  ViewController.h
//  UITableView
//
//  Created by Bowei on 4/8/15.
//  Copyright (c) 2015 Teo Bowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

