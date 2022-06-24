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

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (weak, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
