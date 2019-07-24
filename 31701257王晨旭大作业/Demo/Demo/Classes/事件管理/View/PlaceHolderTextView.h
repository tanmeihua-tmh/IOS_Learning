//
//  PlaceHolderTextView.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaceHolderTextView;

@protocol PlaceHolderTextViewDelegate <NSObject>

- (void)yjq_textViewDidEndEditing:(PlaceHolderTextView *)textView;

- (void)yjq_textViewDidChange:(PlaceHolderTextView *)textView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PlaceHolderTextView : UITextView

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, weak) id<PlaceHolderTextViewDelegate> placeHolderDelegate;

@end

NS_ASSUME_NONNULL_END
