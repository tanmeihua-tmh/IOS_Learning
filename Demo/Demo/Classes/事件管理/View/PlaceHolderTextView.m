//
//  PlaceHolderTextView.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;

@end

@implementation PlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.delegate = self;
    UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    textView.font = self.font;
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor grayColor];
    textView.userInteractionEnabled = NO;
    _placeHolderTextView = textView;
    [self addSubview:textView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeHolderTextView.textContainerInset = self.textContainerInset;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    _placeHolderTextView.text = placeHolder;
}



//MARK: UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
    if ([self.placeHolderDelegate respondsToSelector:@selector(yjq_textViewDidEndEditing:)]) {
        [self.placeHolderDelegate yjq_textViewDidEndEditing:self];
    }
}

-(void)textViewDidChange:(UITextView *)textView {
    if ([self.placeHolderDelegate respondsToSelector:@selector(yjq_textViewDidChange:)]) {
        [self.placeHolderDelegate yjq_textViewDidChange:self];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    self.placeHolderTextView.hidden = textView.text.length > 0;
    NSLog(@"textViewDidChangeSelection:");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *string = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (([text isEqualToString:@" "] || [text isEqualToString:@"\n"]) && string.length == 0) {
        return NO;
    }
    return YES;
}

@end
