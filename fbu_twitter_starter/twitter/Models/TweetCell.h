//
//  TweetCell.h
//  twitter
//
//  Created by Zeke Reyes on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "APIManager.h"
#import "DateTools.h"
#import "UIImageView+AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *tweetUser;
@property (weak, nonatomic) IBOutlet UILabel *tweetAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
