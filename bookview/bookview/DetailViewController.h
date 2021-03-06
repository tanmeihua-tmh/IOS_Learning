//
//  DetailViewController.h
//  bookview
//
//  Created by 王晨旭 on 2019/5/8.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UITextView *detailInfo;
@property (nonatomic, copy) NSString *lineNo;
@end

NS_ASSUME_NONNULL_END
