//
//  VSViewController.m
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//

#import "VSViewController.h"
#import "VSDropdown.h"
@interface VSViewController ()<VSDropdownDelegate>
{
    VSDropdown *_dropdown;
}
- (IBAction)testAction:(id)sender;

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    [_dropdown setAllowMultipleSelection:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender
{
    [self showDropDownForButton:sender adContents:@[@"Two wrongs don't make a right.",@"No man is an island.",@"Aplhabetic sorting",@"Fortune favors the bold.",@"If it ain't broke, don't fix it.",@"If you can't beat 'em, join 'em.",@"One man's trash is another man's treasure.",@"You can lead a horse to water, but you can't make him drink.",@"Proverbs"]];
    
}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents
{
    
    [_dropdown setDrodownAnimation:rand()%2];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setSeparatorColor:sender.titleLabel.textColor];
    
    [_dropdown reloadDropdownWithContents:contents andSelectedItems:[sender.titleLabel.text componentsSeparatedByString:@";"]];
    
    
}

#pragma mark -
#pragma mark - VSDropdown Delegate methods.
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    NSString *allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
    [btn setTitle:allSelectedItems forState:UIControlStateNormal];
    
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    UIButton *btn = (UIButton *)dropdown.dropDownView;
    
    return btn.titleLabel.textColor;
    
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 5.0;
}


@end
