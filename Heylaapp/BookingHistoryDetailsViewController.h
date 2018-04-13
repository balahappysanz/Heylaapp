//
//  ReviewTicketBookingViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 19/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingHistoryDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ticketDetails;
@property (strong, nonatomic) IBOutlet UILabel *attendeesCount;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *location;

@end
