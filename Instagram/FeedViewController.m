//
//  FeedViewController.m
//  Instagram
//
//  Created by Leah Xiao on 7/9/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "LogInViewController.h"
#import "AppDelegate.h"

@interface FeedViewController () // <UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutTapped:(id)sender {
    // PFUser.current() will now be nil
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LogInViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
        
    }];
}
- (IBAction)composeButtonTapped:(id)sender {
     [self performSegueWithIdentifier:@"composeView" sender:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
