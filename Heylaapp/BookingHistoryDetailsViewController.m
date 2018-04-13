//
//  ReviewTicketBookingViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 19/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "BookingHistoryDetailsViewController.h"

@interface BookingHistoryDetailsViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *name;
    NSMutableArray *email_id;
    NSMutableArray *mobile_no;
    NSMutableArray *order_id;
    NSMutableArray *_id;
    
}
@end

@implementation BookingHistoryDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    name = [[NSMutableArray alloc]init];
    email_id = [[NSMutableArray alloc]init];
    mobile_no = [[NSMutableArray alloc]init];
    order_id = [[NSMutableArray alloc]init];
    _id = [[NSMutableArray alloc]init];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.eventName.text = appDel.event_Name;
    self.dateLabel.text = appDel.event_StartDate;
    self.timeLabel.text = appDel.event_StartTime;
    self.location.text = appDel.event_Address;
    self.attendeesCount.text = appDel.seat_count;
    self.ticketDetails.text = [NSString stringWithFormat:@"%@ - %@  %@",appDel.plan_name,appDel.seat_count,@"Tickets"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.order_id forKey:@"order_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *bookingdetails = @"apimain/bookingAttendeesDetails";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingdetails, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         if ([msg isEqualToString:@"View Booking attendees"] && [status isEqualToString:@"success"])
         {
             [name removeAllObjects];
             [email_id removeAllObjects];
             [order_id removeAllObjects];
             [mobile_no removeAllObjects];
             [_id removeAllObjects];
             
             NSArray *Bookingattendees = [responseObject objectForKey:@"Bookingattendees"];
             for (int i = 0; i < [Bookingattendees count]; i++)
             {
                 NSDictionary *dict = [Bookingattendees objectAtIndex:i];
                 NSString *strName = [dict objectForKey:@"name"];
                 NSString *strMobile_no = [dict objectForKey:@"mobile_no"];
                 NSString *strEmail_id = [dict objectForKey:@"email_id"];
                 NSString *strorder_id = [dict objectForKey:@"order_id"];
                 NSString *strId = [dict objectForKey:@"id"];
                 
                 [name addObject:strName];
                 [email_id addObject:strEmail_id];
                 [order_id addObject:strorder_id];
                 [mobile_no addObject:strMobile_no];
                 [_id addObject:strId];
                 
             }
             
             [self.tableView reloadData];
         }
         else
         {
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"Heyla"
                                        message:msg
                                        preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      
                                  }];
             
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookingHistoryDetailsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *namestr = [name objectAtIndex:indexPath.row];
    cell.nameLabel.text = namestr;
    cell.emailLabel.text = [email_id objectAtIndex:indexPath.row];
    cell.mobileNo.text = [mobile_no objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117;
}
- (IBAction)backBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BookingHistoryViewController *myNewVC = (BookingHistoryViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BookingHistoryViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
@end
