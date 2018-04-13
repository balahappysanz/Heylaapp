//
//  SelectCategoeryViewController.h
//  Heylaapp
//
//  Created by HappySanz on 14/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SelectCategoeryViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
- (IBAction)backBtn:(id)sender;
- (IBAction)selectAllBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *getStart;
- (IBAction)getStartBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *selectAll;
@property (strong, nonatomic) IBOutlet UIImageView *selectAllImageView;

@end
