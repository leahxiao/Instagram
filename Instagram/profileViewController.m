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
    [self.proPicImageView loadInBackground]; // load it from the backgroup 
 
    
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
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 100;
    [query orderByDescending:@"createdAt"];
    //[query includeKey:@"user"];
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
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    //PFFile *pfVersionofEdit = [self getPFFileFromImage:editedImage];
    PFFile *pfVersionofEdit = [PFFile fileWithName:@"pic.png" data:UIImagePNGRepresentation(editedImage)];
    
    //  Do something with the images (based on your use case)
    [self.proPicImageView setImage:editedImage];
    [self.proPicImageView loadInBackground]; //retrieving from parse table
    self.currUser[@"proPic"] = pfVersionofEdit;
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
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
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
