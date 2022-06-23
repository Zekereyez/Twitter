//
//  ComposeViewController.h
//  twitter
//
//  Created by Zeke Reyes on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "APIManager.h"


NS_ASSUME_NONNULL_BEGIN

//  ComposeViewController.h
@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *tweetMessage;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
