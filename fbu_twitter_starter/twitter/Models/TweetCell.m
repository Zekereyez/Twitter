//
//  TweetCell.m
//  twitter
//
//  Created by Zeke Reyes on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (IBAction)didTapShare:(UIButton *)sender {
}


// TODO: Find out which didTap function is right...
- (IBAction)didTapLike:(UIButton *)sender {
    // Update the local tweet model depending on status
    // If already liked then take one like away
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    }
    // Increment by one like
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    
    // TODO: Update cell UI
    [self refreshData];
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    if (self.tweet.favorited) {
                [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                    if (error) {
                        NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                    } else if (tweet) {
                        NSLog(@"Successfully retweeted the following Tweet: \n%@", tweet.text);
                    }
                }];
            } else {
                [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                    if (error) {
                        NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                    } else if (tweet) {
                        NSLog(@"Successfully unretweeted the following Tweet: \n%@", tweet.text);
                    }
                }];
            }
}
- (IBAction)didTapFavorite:(id)sender {
    // Update the local tweet model depending on status
    // If already liked then take one like away
    if (self.tweet.favorited) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
    }
    // Increment by one like
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
    }
    
    // TODO: Update cell UI
    [self refreshData];
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    if (self.tweet.favorited) {
                [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                    if (error) {
                        NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                    } else if (tweet) {
                        NSLog(@"Successfully retweeted the following Tweet: \n%@", tweet.text);
                    }
                }];
            } else {
                [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                    if (error) {
                        NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                    } else if (tweet) {
                        NSLog(@"Successfully unretweeted the following Tweet: \n%@", tweet.text);
                    }
                }];
            }
}

- (IBAction)didTapRetweet:(UIButton *)sender {
}

- (IBAction)didTapComments:(UIButton *)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData {
    // Update all the views and sets the labels to respective text
    // Name, screen name, and date update
    self.tweetAuthor.text = self.tweet.user.name;
    self.tweetUser.text = self.tweet.user.screenName;
    self.tweetDate.text = self.tweet.createdAtString;
    
    // Tweet body update
    self.textLabel.text = self.tweet.text;
    
    // Retweet and like count updates
    // Note self.tweet can be replaced with _tweet
    // think of C++ class implementation
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    
    // User profile picture update and url data
    NSString *URLString = self.tweet.user.profilePicture;
    // Removes instance of '_normal' to make url return a hd quality profile picture
    URLString = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:URLString];
    // Setting image of profile pic to nil to prevent flickering
    self.profilePic.image = nil;
    // Setting the image of the profile pic
    [self.profilePic setImageWithURL:url];
    
    // Favorite and Retweet Icons for image update
    UIImage *favoriteIcon;
    UIImage *retweetIcon;
    
    // Favorite Icon assignment
    if (self.favoriteButton.selected) {
        favoriteIcon = [UIImage imageNamed:@"favor-icon-red.png"];
    }
    else {
        favoriteIcon = [UIImage imageNamed:@"favor-red.png"];
    }
    
    // Retweet Icon Assignment
    if (self.retweetButton.selected) {
        retweetIcon = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    else {
        retweetIcon = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    
    [self.favoriteButton setImage:favoriteIcon forState:UIControlStateNormal];
    [self.retweetButton setImage:retweetIcon forState:UIControlStateNormal];
}

@end
