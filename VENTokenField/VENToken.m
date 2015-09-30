// VENToken.m
//
// Copyright (c) 2014 Venmo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VENToken.h"

#import <UIView+NibLoading/UIView+NibLoading.h>

@interface VENToken ()

@property (strong, nonatomic, readwrite) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic, readwrite) IBOutlet UIView *backgroundView;
@property (strong, nonatomic, readwrite) IBOutlet UIButton *button;

@end

@implementation VENToken

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadContentsFromNib];
        [self setUpInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContentsFromNib];
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit
{
    self.backgroundView.layer.cornerRadius = 5;
    self.colorScheme = [UIColor blueColor];
    self.titleLabel.textColor = self.colorScheme;
    [self.button addTarget:self
                    action:@selector(didTapToken:)
          forControlEvents:UIControlEventTouchDown];
}

- (void)setTitleText:(NSString *)text
{
    self.titleLabel.text = text;
    self.titleLabel.textColor = self.colorScheme;
    [self.titleLabel sizeToFit];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetMaxX(self.titleLabel.frame) + 3, CGRectGetHeight(self.frame));
    [self.titleLabel sizeToFit];
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    UIColor *textColor = highlighted ? [UIColor whiteColor] : self.colorScheme;
    UIColor *backgroundColor = highlighted ? self.colorScheme : [UIColor clearColor];
    self.titleLabel.textColor = textColor;
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setColorScheme:(UIColor *)colorScheme
{
    _colorScheme = colorScheme;
    self.titleLabel.textColor = self.colorScheme;
    [self setHighlighted:_highlighted];
}

- (void)didTapToken:(id)sender
{
    if (self.didTapTokenBlock) {
        self.didTapTokenBlock();
    }
}

@end
