//
//  DetailViewController.h
//  twitter
//
//  Created by Zeke Reyes on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "DateTools.h"
#import "UIImageView+AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewControllerDelegate

-(void)didTapView:(Tweet *)tweet;

@end

@interface DetailViewController : UIViewController@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *tweetBody;


@property (weak, nonatomic) IBOutlet UIButton *didTapRetweet;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UIButton *didTapFavorite;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (weak, nonatomic) Tweet *tweet;

-(void)refreshData;

@end

NS_ASSUME_NONNULL_END
