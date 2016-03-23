//
//  SecondViewController.m
//  Autolayout
//
//  Created by Pham Anh on 3/22/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "SecondViewController.h"

/* Email Text Field Constraints */
NSString *const kEmailTextFieldHorizontal = @"H:|-[_textFieldEmail]-|";
NSString *const kEmailTextFieldVertical = @"V:[_topGuide]-[_textFieldEmail]";

/* Confirm Email Text Field Constraints */
NSString *const kConfirmEmailHorizontal = @"H:|-[_textFieldConfirmEmail]-|";
NSString *const kConfirmEmailVertical = @"V:[_textFieldEmail]-[_textFieldConfirmEmail]";

/* Register Button Constraint */
NSString *const kRegisterVertical = @"V:[_textFieldConfirmEmail]-[_registerButton]";

@interface SecondViewController ()

@property (nonatomic, strong) UITextField *textFieldEmail;
@property (nonatomic, strong) UITextField *textFieldConfirmEmail;
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self constructUIComponents];
    [self addUIComponentsToView:self.view];
    [self.view addConstraints:[self constraints]];
}

#pragma mark - Private Methods

- (UITextField *) textFieldWithPlaceHolder:(NSString *) paramPlaceholder;
{
    UITextField *result = [[UITextField alloc] init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    result.borderStyle = UITextBorderStyleRoundedRect;
    result.placeholder = paramPlaceholder;
    return result;
}

- (void) constructUIComponents;
{
    
    self.textFieldEmail = [self textFieldWithPlaceHolder:@"Email"];
    
    self.textFieldConfirmEmail = [self textFieldWithPlaceHolder:@"Confirm Email"];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.registerButton setTitle:@"Register" forState:UIControlStateNormal];

}

- (void) addUIComponentsToView:(UIView *)paramView
{
    [paramView addSubview:self.textFieldEmail];
    [paramView addSubview:self.textFieldConfirmEmail];
    [paramView addSubview:self.registerButton];
}

- (NSArray *) emailTextFieldConstraints
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    id _topGuide = self.topLayoutGuide;
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldEmail, _topGuide);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kEmailTextFieldHorizontal
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kEmailTextFieldVertical
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) confirmEmailTextFieldConstraints
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldConfirmEmail, _textFieldEmail);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailHorizontal
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kConfirmEmailVertical
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) registerButtonConstraints;
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_registerButton, _textFieldConfirmEmail);
    
    [result addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:kRegisterVertical
                                             options:0
                                             metrics:nil
                                               views:viewsDictionary]];
    
    [result addObject:
     [NSLayoutConstraint constraintWithItem:self.registerButton
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0f
                                   constant:0.0f]
     ];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *) constraints
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObjectsFromArray:[self emailTextFieldConstraints]];
    [result addObjectsFromArray:[self confirmEmailTextFieldConstraints]];
    [result addObjectsFromArray:[self registerButtonConstraints]];
    
    return [NSArray arrayWithArray:result];
}

@end
