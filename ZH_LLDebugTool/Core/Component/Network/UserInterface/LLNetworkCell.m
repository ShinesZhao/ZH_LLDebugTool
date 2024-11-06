//
//  LLNetworkCell.m
//
//  Copyright (c) 2018 LLDebugTool Software Foundation (https://github.com/HDB-Li/LLDebugTool)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "LLNetworkCell.h"

#import "LLNetworkModel.h"
#import "LLFactory.h"
#import "LLConfig.h"
#import "LLConst.h"
#import "LLThemeManager.h"
@interface LLNetworkCell ()

@property (nonatomic, strong) UILabel *hostLabel;

@property (nonatomic, strong) UILabel *paramLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIView *coverLineView;

@property (strong, nonatomic) LLNetworkModel *model;

@end

@implementation LLNetworkCell

- (void)confirmWithModel:(LLNetworkModel *)model {
    if (_model != model) {
        _model = model;
        self.hostLabel.text = _model.url.host;
        self.paramLabel.text = _model.url.path;
        self.dateLabel.text = [_model.startDate substringFromIndex:11];
        
        // 失败code拼接
        BOOL requestSuccess = [_model.statusCode integerValue] == 200 ? YES : NO;
        if(!requestSuccess) self.hostLabel.text = [_model.url.host stringByAppendingFormat:@"(%@)",_model.statusCode];
        
        // 文案 颜色更改
        UIColor *textColor = requestSuccess ? [LLThemeManager shared].primaryColor : [UIColor colorWithRed:252/255.f green:74/255.f blue:91/255.f alpha:1];
        self.hostLabel.textColor= textColor;
        self.paramLabel.textColor= textColor;
        self.dateLabel.textColor= textColor;
        
        for (UIView *subview in self.subviews) {
            // > 颜色更改
            if ([subview isKindOfClass: [UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                if (button.currentBackgroundImage != nil) {
                    [button setTintColor:textColor];
                }
            }
        }
        
        // 线条颜色
        self.coverLineView.backgroundColor = textColor;
    }
}

#pragma mark - Over write
- (void)initUI {
    [super initUI];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.contentView addSubview:self.hostLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.paramLabel];
    [self.contentView addSubview:self.coverLineView];
    
    [self addHostLabelConstraints];
    [self addDateLabelConstraints];
    [self addParamLabelConstraints];
    [self addCoverLineViewConstraints];
}

- (void)addHostLabelConstraints {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.hostLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.hostLabel.superview attribute:NSLayoutAttributeTop multiplier:1 constant:kLLGeneralMargin];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.hostLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.hostLabel.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:kLLGeneralMargin];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.hostLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:-kLLGeneralMargin / 2.0];
    self.hostLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.hostLabel.superview addConstraints:@[top, left, right]];
}

- (void)addDateLabelConstraints {
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.hostLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.dateLabel.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-kLLGeneralMargin];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:65];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dateLabel.superview addConstraints:@[centerY, right, width]];
}

- (void)addParamLabelConstraints {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.paramLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.hostLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.paramLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.paramLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.hostLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:kLLGeneralMargin / 2.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.paramLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.paramLabel.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-kLLGeneralMargin];
    bottom.priority = UILayoutPriorityDefaultHigh;
    self.paramLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.paramLabel.superview addConstraints:@[left, right, top, bottom]];
}

- (void)addCoverLineViewConstraints {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.coverLineView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.coverLineView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.coverLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.coverLineView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.coverLineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[[UIScreen mainScreen] bounds].size.width-10];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.coverLineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5];
    bottom.priority = UILayoutPriorityDefaultHigh;
    self.coverLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.coverLineView.superview addConstraints:@[left,width, bottom,height]];
}

#pragma mark - Getters and setters
- (UILabel *)hostLabel {
    if (!_hostLabel) {
        _hostLabel = [LLFactory getLabel];
        _hostLabel.font = [UIFont boldSystemFontOfSize:19];
        _hostLabel.numberOfLines = 0;
        _hostLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _hostLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [LLFactory getLabel];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

- (UILabel *)paramLabel {
    if (!_paramLabel) {
        _paramLabel = [LLFactory getLabel];
        _paramLabel.font = [UIFont systemFontOfSize:14];
        _paramLabel.numberOfLines = 0;
        _paramLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _paramLabel;
}

- (UIView *)coverLineView{
    if (!_coverLineView) {
        _coverLineView = [LLFactory getView];
    }
    return _coverLineView;
}

@end
