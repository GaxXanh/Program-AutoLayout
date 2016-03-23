//
//  SecViewController.m
//  Autolayout
//
//  Created by Pham Anh on 3/23/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "SecViewController.h"

/* Gray View Constraints */
NSString *const kGrayViewHorizontal = @"H:|-20-[_viewGray]-20-|";
NSString *const kGrayViewVertical = @"V:[_topGuide]-20-[_viewGray(==132)]";

/* Blue View Constraints */
NSString *const kBlueViewHorizontal = @"H:[_viewBlue(==73)]-20-|";
NSString *const kBlueViewVertical = @"V:[_viewGray]-16-[_viewBlue(==72)]";

/* Purple View Constraints */
NSString *const kPurpleViewHorizontal = @"H:[_viewPurple(==71)]";
NSString *const kPurpleViewVertical = @"V:[_viewPurple(==67)]-29-[_bottomGuide]";

/* Sentence Label Constraints */
NSString *const kSentenceLabelHorizontal = @"H:|-20-[_labelSentence]-30-[_viewBlue]";
NSString *const kSentenceLabelVertical = @"V:[_viewGray]-16-[_labelSentence(==72)]";

@interface SecViewController ()

@property (nonatomic, strong) UIView *viewGray;
@property (nonatomic, strong) UIView *viewBlue;
@property (nonatomic, strong) UIView *viewPurple;
@property (nonatomic, strong) UILabel *labelSentence;

@end

@implementation SecViewController

#pragma mark - View Life Cycle

- (void) viewDidLoad;
{
    [super viewDidLoad];
    
    [self constructUIComponents];
    [self addUIComponentsToView:self.view];
    [self.view addConstraints:[self constraints]];
}

- (void) constructUIComponents;
{
    self.viewGray = [self viewWithBackgroundColor:[UIColor grayColor]];
    self.viewBlue = [self viewWithBackgroundColor:[UIColor blueColor]];
    self.viewPurple = [self viewWithBackgroundColor:[UIColor purpleColor]];
    self.labelSentence = [self labelWithText:@"Ngày hôm qua như trong ..."];
}

- (void) addUIComponentsToView:(UIView *)paramView;
{
    [paramView addSubview:self.viewGray];
    [paramView addSubview:self.viewBlue];
    [paramView addSubview:self.viewPurple];
    [paramView addSubview:self.labelSentence];
}

- (UIView *) viewWithBackgroundColor:(UIColor *) paramColor;
{
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = paramColor;
    return view;
}

- (UILabel *) labelWithText:(NSString *) paramText;
{
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = paramText;
    label.numberOfLines = 3;
    return label;
}

#pragma mark - Add Constraint

- (NSArray *) viewGrayConstraints;
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    id _topGuide = self.topLayoutGuide;
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_viewGray, _topGuide);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kGrayViewHorizontal
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kGrayViewVertical
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) viewBlueConstraints;
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_viewBlue, _viewGray);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kBlueViewHorizontal
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kBlueViewVertical
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) viewPurpleConstraints;
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    id _bottomGuide = self.bottomLayoutGuide;
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_viewPurple, _bottomGuide);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kPurpleViewHorizontal
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kPurpleViewVertical
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    [result addObject:
     [NSLayoutConstraint constraintWithItem:self.viewPurple
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0f
                                   constant:0.0f]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) labelSentenceContraints;
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_viewGray, _viewBlue, _labelSentence);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kSentenceLabelHorizontal
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kSentenceLabelVertical
                                             options:0
                                             metrics:nil
                                               views:viewDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) constraints
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObjectsFromArray:[self viewGrayConstraints]];
    [result addObjectsFromArray:[self viewBlueConstraints]];
    [result addObjectsFromArray:[self viewPurpleConstraints]];
    [result addObjectsFromArray:[self labelSentenceContraints]];
    
    return [NSArray arrayWithArray:result];
}

@end
