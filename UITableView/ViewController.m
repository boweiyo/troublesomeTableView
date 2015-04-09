//
//  ViewController.m
//  UITableView
//
//  Created by Bowei on 4/8/15.
//  Copyright (c) 2015 Teo Bowei. All rights reserved.
//

#import "ViewController.h"
#import "MeetUp.h"
#import "CustomCell.h"
#import "IconDownloader.h"

@interface ViewController (){
    NSMutableData *jsonResponse;
    NSMutableArray *result;
    UIImage *image;
    UIImage *image1;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.

//    NSURL *url = [NSURL URLWithString:
//                  @"https://lh6.ggpht.com/r3ObIjBYMgSexwchOlmRo283DQcdSPKpYVWppB8YAJ7ilOxsM8mEoQdIOXBAG2yx5Xk=w300-rw"];
//    image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:[NSURL URLWithString:@"https://lh6.ggpht.com/r3ObIjBYMgSexwchOlmRo283DQcdSPKpYVWppB8YAJ7ilOxsM8mEoQdIOXBAG2yx5Xk=w300-rw"]
//            completionHandler:^(NSData *data,
//                                NSURLResponse *response,
//                                NSError *error) {
//               
//                image = [UIImage imageWithData:data];
//                
//                [self.tableView reloadData];
//                
//            }] resume];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.meetup.com/2/groups?lat=51.509980&lon=-0.133700&page=20&key=1f5718c16a7fb3a5452f45193232"]];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    jsonResponse = [NSMutableData data];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    

//    [self.view addSubview:[[UIImageView alloc] initWithImage:image]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [jsonResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString *responseString = [[NSString alloc] initWithData:jsonResponse encoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    id allDataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    result = [[NSMutableArray alloc]init];
    
    if ([allDataDictionary isKindOfClass:[NSDictionary class]]){
        NSArray *meetup = allDataDictionary[@"results"];
        if ([meetup isKindOfClass:[NSArray class]]){
            
            for (NSDictionary *dictionary in meetup) {
                MeetUp *temp= [[MeetUp alloc] init];
                
                temp.title= [dictionary objectForKey:@"name"];
                temp.attendee = [dictionary objectForKey:@"who"];
                temp.desc = [dictionary objectForKey:@"description"];
                temp.country = [dictionary objectForKey:@"country"];
                temp.city = [dictionary objectForKey:@"city"];
                
                [result addObject:temp];
            }
        }
    }
    [self.tableView reloadData];
}


////- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
////{
////    if (section == 0)
////        return nil;
////    else
////        return @"";
////}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (result.count>0) {
//    return result.count;
//    }
//    else
//        return 0;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //    return (result.count>0)? result.count:0;
    if(result.count!=0){
        return result.count;
    }
    else
        return 0;
    
}

- (void)startIconDownload:(MeetUp *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.meetup = appRecord;
        [iconDownloader setCompletionHandler:^{
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.imageView.image = appRecord.icon;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //    if(cell == nil){
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //    }
    
    MeetUp *temp = result[indexPath.row];
    cell.lblName.text = temp.title;
    cell.lblWho.text = temp.attendee;
    cell.lblDescription.text = temp.desc;
    cell.lblCityCountry.text = temp.country;
//    cell.ivImg.image = temp.icon;
    if(image1==nil)
    {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://photos3.meetupstatic.com/photos/event/5/8/e/7/global_82759.jpeg"]]];
        if (imgData) {
          image1 = [UIImage imageWithData:imgData];
            if (image1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (cell)
                        cell.ivImg.image = image1;
                });
            }
        }
    });
    }
    else
    {
        cell.ivImg.image = image1;

    }
    
    return cell;
}

@end
