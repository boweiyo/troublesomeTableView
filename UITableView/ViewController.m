//
//  ViewController.m
//  UITableView
//
//  Created by Bowei on 4/8/15.
//  Copyright (c) 2015 Teo Bowei. All rights reserved.
//

#import "ViewController.h"
#import "MeetUp.h"

@interface ViewController (){
    NSMutableData *jsonResponse;
    NSMutableArray *result;
    MeetUp *temp ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.meetup.com/2/groups?lat=51.509980&lon=-0.133700&page=20&key=1f5718c16a7fb3a5452f45193232"]];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    jsonResponse = [NSMutableData data];
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

    if ([allDataDictionary isKindOfClass:[NSDictionary class]]){ //Added instrospection as suggested in comment.
        NSArray *meetup = allDataDictionary[@"results"];
        if ([meetup isKindOfClass:[NSArray class]]){//Added instrospection as suggested in comment.
            
            for (NSDictionary *dictionary in meetup) {
                temp= [[MeetUp alloc] init];
                NSLog(@"%@",[dictionary objectForKey:@"name"]);
                temp.title=@"London French Meetup";//[dictionary objectForKey:@"name"]];
                temp.attendee = [dictionary objectForKey:@"who"];
                temp.desc = [dictionary objectForKey:@"description"];
                temp.country = [dictionary objectForKey:@"country"];
                temp.city = [dictionary objectForKey:@"city"];
                [result addObject:temp];
            }
            if(result.count>0)
            [self.tableView reloadData];
        }
    }
    
    
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
    return (result.count>0)? result.count:0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSLog(@"row number %ld",(long)indexPath.row);
//    if(result.count>0){
//        @try {
//            MeetUp *temp = result[indexPath.row-1];
//            [[self labelMeetupName]setText:temp.title];
////            [[self labelEventAttendee]setText:temp.attendee];
////            [[self labelDescription]setText:temp.attendee];
////            //    [self ivMeetupImg]
////            [[self labelCityCountry]setText:temp.country];
//        }
//        @catch (NSException *exception) {
//            //NSLog(exception);
//        }
//        @finally {
//        }
//
//    }
    
    return cell;
}

@end
