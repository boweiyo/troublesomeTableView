//
//  CustomCell.h
//  UITableView
//
//  Created by Bowei on 4/9/15.
//  Copyright (c) 2015 Teo Bowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ivImg;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblWho;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblCityCountry;


@end
