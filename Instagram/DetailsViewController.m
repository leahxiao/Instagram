//
//  DetailsViewController.m
//  Instagram
//
//  Created by Leah Xiao on 7/10/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//
#import <Parse/Parse.h>
#import "DetailsViewController.h"
#import "postCell.h"
#import "Post.h"
#import "PostingViewController.h"
#import "FeedViewController.h"
#import "LocationsViewController.h"

@interface DetailsViewController () <LocationsViewControllerDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsTimestampLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailsCaptionLabel.text = self.post.caption;
    
     NSString *createdAtStringVersion;
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//     // Configure the input format to parse the date string
     formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *date = self.post.createdAt;
     createdAtStringVersion = [formatter stringFromDate:date];
    self.detailsTimestampLabel.text = createdAtStringVersion;
    
    self.detailsImageView.file = self.post.image;
    [self.detailsImageView loadInBackground];
    
    //

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    LocationsViewController *locationsController= [segue destinationViewController];
   // locationsController.photoImage = self.myImage;
    locationsController.delegate = self;
    
}


- (IBAction)likeButton:(id)sender {
    
}




@end
