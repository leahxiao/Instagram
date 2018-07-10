//
//  FeedViewController.m
//  Instagram
//
//  Created by Leah Xiao on 7/9/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "postCell.h"
#import "LogInViewController.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "PostingViewController.h"

@interface FeedViewController () // <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * posts;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getPosts];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    UIRefreshControl *refCont = [[UIRefreshControl alloc] init];
    [self beginRefresh:(refCont)];

    
    [self.tableView reloadData];
//
    // Do any additional setup after loading the view.
}

- (void) getPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];
    //[query includeKey:@"user"];
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // put all the received chats into our array
            self.posts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.tableView reloadData];
    [self getPosts];
    [refreshControl endRefreshing];
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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[DetailsViewController class] ]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
//    else if([segue.destinationViewController isKindOfClass:[PostingViewController class] ]){
//        PostingViewController *postingViewController = (PostingViewController*) navigationController.topViewController;
//        postingViewController.delegate = self;
 //   }
    else{
        UINavigationController *navigationController = [segue destinationViewController];
        NSLog(@"heh");
    };
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    postCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    
    // get all the infor from the chat object and set it onto the screen
    cell.uploadCaption.text = post.caption;
    cell.uploadView.file = post.image;
    [cell.uploadView loadInBackground];
    

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.posts.count;
}



@end
