//
//  profileViewController.m
//  Instagram
//
//  Created by Leah Xiao on 7/11/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "profileViewController.h"
#import <parse/Parse.h>
#import "postCollectionViewCell.h"
#import "Post.h"
@interface profileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray * posts;
@property (strong, nonatomic) PFUser *currUser;


@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.currUser = [PFUser currentUser];
    self.userNameProfile.text = self.currUser.username;
 
    self.proPicImageView.file = self.currUser[@"proPic"]; // set this file to this image
    [self.proPicImageView loadInBackground]; // load it from the backgroup, pulling from the parse server
 
    
    self.collectionView.dataSource= self;
    self.collectionView.delegate = self;
    
    //set post
    [self getPosts];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing *(postersPerLine - 1)) / postersPerLine; //width divided by posters per line to fill screen appropriately with 3 posters (also takes spacing into account
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth , itemHeight);
       [self.collectionView reloadData];
    
}

- (void) getPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];    // just means this query is looking for the crap in the post column in the query table.
    //[query whereKey:@"likesCount" greaterThan:@100];    //filter, only get the ones that have a certain property
    query.limit = 100;  //gimme a hundred
    [query orderByDescending:@"createdAt"]; //sort by creation date
    [query includeKey:@"author"]; // get author, but author is a pointer to a user. so now each post will include user data (whatever is contained in the user that the author pointer points too ) as well
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // put all the received chats into our array
            self.posts = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)proPicProfileTapped:(id)sender {
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil]; // this will pull up the specific VC that allows you to choose a pohoto from the photo library. apple made it. thanks apple.
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];  // this is when yuou adjust the frame that gets included as part of the image, thew frame
    //PFFile *pfVersionofEdit = [self getPFFileFromImage:editedImage];
    PFFile *pfVersionofEdit = [PFFile fileWithName:@"pic.png" data:UIImagePNGRepresentation(editedImage)]; // a bunch of casting
    
    //  Do something with the images (based on your use case)
    [self.proPicImageView setImage:editedImage];
    [self.proPicImageView loadInBackground]; //retrieving from parse table
    self.currUser[@"proPic"] = pfVersionofEdit; // adding the image to the parse table; when you log in, the app sends the request to the data server, but will also keep a record of who the current user is so you can access attributes of the current user; keeps a copy of what the user is from the database on the app so you vcan locally access it (faster)
    [self.currUser saveInBackground]; //uploading to parse table
    
   // self.proPicImageView.file =self.currUser[@"proPic"];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData]; // casting to a pffile.
}



//cell for item is like the same thing as cell for row



// -(typw returned) name of function : (type of param 1) nameOfFirstParam outsideName2: (tyoe2) insidename2
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // get a new cell, cldean that out
    postCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.row];
    cell.post = post;
    //cell.post.image = post.image;
  //  [cell.postView setImage: post.image];
    [cell setPicture];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.posts.count;
}



/*
 
 - (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { // you can ignore the nonoull kind of- its for swift compatibility so you dont really need it
 MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
 NSDictionary *movie = self.movies[indexPath.item]; // no concept of rows in collection
 cell.collectionTitleLabel.text = movie[@"title"];
 NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
 NSString *posterURLString = movie[@"poster_path"];
 NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
 NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
 //cell.posterView.image= nil; // clear out any old image from the cell
 [cell.posterView setImageWithURL:posterURL];
 
 return cell;
 }
 
 - (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 return self.movies.count;
 }
 
 
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
