//
//  UITextView+vvExtension.m
//  vvExtension
//
//  Created by wangyang on 2019/12/5.
//  Copyright © 2019 iule. All rights reserved.
//

#import "UITextView+vvExtension.h"
#import <objc/runtime.h>

static char *labelKey = "vv_placeholderKey";
static char *needAdjust = "vv_needAdjust";
static char *changeLocation = "vv_location";

@implementation UITextView (vvExtension)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")), class_getInstanceMethod(self.class, NSSelectorFromString(@"swizzledDealloc")));
}

- (void)swizzledDealloc {
    // 移除观察
    if (objc_getAssociatedObject(self, @selector(vv_placeholdLabel))) {
        [self removeObserver:self forKeyPath:@"font"];
    }
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self swizzledDealloc];
}

#pragma mark -
#pragma mark - 设置placeholderLabel

- (UILabel *)vv_placeholdLabel {
    UILabel *label = objc_getAssociatedObject(self, labelKey);
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [self.class vv_defaultColor];
        objc_setAssociatedObject(self, labelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:UITextViewTextDidChangeNotification object:nil];
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    }
    return label;
}

#pragma mark -
#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"font"]) {
        self.needAdjustFont = YES;
        self.vv_placeholdLabel.font = self.font;
        [self updateLabel];
    }
}

#pragma mark -
#pragma mark - 设置默认颜色

+ (UIColor *)vv_defaultColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        color = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];//#999999
    });
    return color;
}

#pragma mark -
#pragma mark - setter getter

- (NSString *)vv_placeholder {
    return self.vv_placeholdLabel.text;
}

- (void)setVv_placeholder:(NSString *)vv_placeholder {
    self.vv_placeholdLabel.text = vv_placeholder;
    [self updateLabel];
}

- (UIColor *)vv_placeholderColor {
    return self.vv_placeholdLabel.textColor;
}

- (void)setVv_placeholderColor:(UIColor *)vv_placeholderColor {
    self.vv_placeholdLabel.textColor = vv_placeholderColor;
    [self updateLabel];
}

- (NSAttributedString *)vv_attributePlaceholder {
    return self.vv_placeholdLabel.attributedText;
}

- (void)setVv_attributePlaceholder:(NSAttributedString *)vv_attributePlaceholder {
    self.vv_placeholdLabel.attributedText = vv_attributePlaceholder;
    [self updateLabel];
}

- (CGPoint)vv_location {
    return CGPointFromString(objc_getAssociatedObject(self, changeLocation));
}

- (void)setVv_location:(CGPoint)vv_location {
    objc_setAssociatedObject(self, changeLocation, NSStringFromCGPoint(vv_location), OBJC_ASSOCIATION_ASSIGN);
    [self updateLabel];
}

- (BOOL)needAdjustFont {
    return [objc_getAssociatedObject(self, needAdjust) boolValue];
}

- (void)setNeedAdjustFont:(BOOL)needAdjustFont {
    objc_setAssociatedObject(self, needAdjust, @(needAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark -
#pragma mark - 更新label信息

- (void)updateLabel {
    if (self.text.length > 0) {
        [self.vv_placeholdLabel removeFromSuperview];
        return;
    }
    [self insertSubview:self.vv_placeholdLabel atIndex:0];
    if (self.needAdjustFont) {
        self.vv_placeholdLabel.font = self.font;
        self.needAdjustFont = NO;
    }
    CGFloat lineFramentPadding = self.textContainer.lineFragmentPadding;//边距
    UIEdgeInsets contentInset = self.textContainerInset;
    
    //设置label frame
    CGFloat labelX = lineFramentPadding + contentInset.left;
    CGFloat labelY = contentInset.top;
    
    if (self.vv_location.x != 0 || self.vv_location.y != 0) {
        if (self.vv_location.x < 0 || self.vv_location.x > CGRectGetWidth(self.bounds) - lineFramentPadding - contentInset.right || self.vv_location.y < 0) {
            //不做处理
        }else {
            labelX += self.vv_location.x;
            labelY += self.vv_location.y;
        }
    }
    
    CGFloat labelWidth = CGRectGetWidth(self.bounds) - contentInset.right - labelX;
    CGFloat labelHeight = [self.vv_placeholdLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)].height;
    self.vv_placeholdLabel.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
}

@end
