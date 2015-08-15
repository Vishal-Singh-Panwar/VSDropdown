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
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;

- (IBAction)testAction:(id)sender;

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateButtonLayers];
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)updateButtonLayers
{
    [self.firstButton.layer setCornerRadius:3.0];
    [self.firstButton.layer setBorderWidth:1.0];
    [self.firstButton.layer setBorderColor:[self.firstButton.titleLabel.textColor CGColor]];
    
    [self.secondButton.layer setCornerRadius:3.0];
    [self.secondButton.layer setBorderWidth:1.0];
    [self.secondButton.layer setBorderColor:[self.secondButton.titleLabel.textColor CGColor]];
    
    [self.thirdButton.layer setCornerRadius:3.0];
    [self.thirdButton.layer setBorderWidth:1.0];
    [self.thirdButton.layer setBorderColor:[self.thirdButton.titleLabel.textColor CGColor]];
    
    [self.fourthButton.layer setCornerRadius:3.0];
    [self.fourthButton.layer setBorderWidth:1.0];
    [self.fourthButton.layer setBorderColor:[self.fourthButton.titleLabel.textColor CGColor]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender
{
    [self showDropDownForButton:sender adContents:@[@"Two wrongs don't make a right.",@"No man is an island.",@"Aplhabetic sorting",@"Fortune favors the bold.",@"If it ain't broke, don't fix it.",@"If you can't beat 'em, join 'em.",@"One man's trash is another man's treasure.",@"You can lead a horse to water, but you can't make him drink."] multipleSelection:YES];
    
}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    
    [_dropdown setDrodownAnimation:rand()%2];
   
    [_dropdown setAllowMultipleSelection:multipleSelection];

    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setSeparatorColor:sender.titleLabel.textColor];
    
    if (_dropdown.allowMultipleSelection)
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:[[sender titleForState:UIControlStateNormal] componentsSeparatedByString:@";"]];

    }
    else
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:@[[sender titleForState:UIControlStateNormal]]];

    }
    
}

#pragma mark -
#pragma mark - VSDropdown Delegate methods.
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    
    NSString *allSelectedItems = nil;
    if (dropDown.selectedItems.count > 1)
    {
        allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];

    }
    else
    {
        allSelectedItems = [dropDown.selectedItems firstObject];

    }
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
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
}


@end
