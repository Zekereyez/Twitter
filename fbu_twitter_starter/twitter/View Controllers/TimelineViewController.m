//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

// TODO: Make this build and see in COMPOSEVC why property
// TODO: isn't declaring
@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

//@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
- (IBAction)didTapLogout:(id)sender;

@property (nonatomic, strong) NSMutableArray *arrayOfTweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Source and delegate
    self.tableView.dataSource = self;
    self.tableView.dataSource = self;
    
    // Instantiating UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    // Binding action to the refresh control
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    // Adding UIRefreshControl to the table view
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Get timeline
    [self getTimeLine];
//    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
//        if (tweets) {
//            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (Tweet *tweet in tweets) {
//                NSString *text = tweet.text;
//                NSLog(@"%@", text);
//            }
//            // Valid tweets so we load the array with the tweet objects
//            self.arrayOfTweets = [NSMutableArray arrayWithArray:tweets];
//            [self.tableView reloadData];
//        } else {
//            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
//        }
//    }];
}

- (void)getTimeLine {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
            // Valid tweets so we load the array with the tweet objects
            self.arrayOfTweets = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];

}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // Get timeline
    [self getTimeLine];
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController]
    UINavigationController *navigationController = [segue destinationViewController];
    // Pass the selected object to the new view controller
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}


- (IBAction)didTapLogout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    // Clear out the tokens
    [[APIManager shared] logout];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    // Reference which tweet to the tweetCell
    cell.tweet = tweet;
    
    // Tweet author screen name
    cell.tweetAuthor.text = tweet.user.name;

    // Tweet @ name
      cell.tweetUser.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    
    // Tweet date
    cell.tweetDate.text = tweet.createdAtString;
    
    // Tweet text info here
    cell.tweetBody.text = tweet.text;
    
    // retweet count
    cell.retweetCount.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    // favorite / like count here
    cell.likeCount.text = [NSString stringWithFormat:@"%i", tweet.favoriteCount];
    
    // User profile picture and url data
    NSString *URLString = tweet.user.profilePicture;
    // Removes instance of '_normal' to make url return a hd quality profile picture
    URLString = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    // Setting image of profile pic to nil to prevent flickering
    cell.profilePic.image = nil;
    // Setting the image of the profile pic
    [cell.profilePic setImageWithURL:url];
    
    // Making the rounded profile pic 
    cell.profilePic.layer.masksToBounds = false;
    cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2;
    cell.profilePic.clipsToBounds = true;
    cell.profilePic.layer.borderWidth = 0.05;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (void)didTweet:(nonnull Tweet *)tweet {
    
    [self.arrayOfTweets addObject:tweet];
    [self.tableView reloadData];
    [self getTimeLine];
    
}
@end
