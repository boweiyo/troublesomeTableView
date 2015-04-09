//
//  MeetUp.h
//  UITableView
//
//  Created by Bowei on 4/8/15.
//  Copyright (c) 2015 Teo Bowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MeetUp : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *attendee;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong)NSString *country;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *img;
@property (nonatomic, strong) UIImage *icon;

@end
