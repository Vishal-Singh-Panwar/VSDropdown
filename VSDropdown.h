//
//  VSDropdown.h
//  DropdownSample
//
//  Created by Vishal Singh Panwar on 24/07/14.
//  Copyright (c) 2014 Vishal Singh Panwar. All rights reserved.
//
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



/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, Dropdown_Direction)
{
    /** Enum representing automatic direction.*/
    DropdownDirection_Automatic = 0,
    
    /** Enum representing up direction.*/
    DropdownDirection_Up,
    
    /** Enum representing down direction.*/
    DropdownDirection_Down
};

/** Enum representing different Dropdown direction*/
typedef NS_ENUM(NSUInteger, DropdownAnimation)
{
    /** Enum representing automatic direction.*/
    DropdownAnimation_Fade = 0,
    
    /** Enum representing up direction.*/
    DropdownAnimation_Scale,
    
    /** Enum representing down direction.*/
    DropdownAnimation_None
};


@class VSDropdown;

/** Protocol for dropdown. */
@protocol VSDropdownDelegate <NSObject>

@optional

/** called on dropdown delegate whenever an item is selected from dropdown.
 
 @param dropDown reference to VSDropdown object.
 @param str String which is selected.
 @param index Index of selected item in the content array which was passed as datasource.
 
 */
-(void)dropdown:(VSDropdown *)dropDown didSelectValue:(NSString *)str atIndex:(NSUInteger)index;


/** called on dropdown delegate whenever dropdown is added to a view using showDropDownForView: method
 
 @param dropDown reference to VSDropdown object.
 
 */

-(void)dropdownDidAppear:(VSDropdown *)dropDown;


/** called on dropdown delegate whenever dropdown will be removed from a view using remove method.
 
 @param dropDown reference to VSDropdown object.
 
 */
-(void)dropdownWillDisappear:(VSDropdown *)dropDown;



@end
#import <UIKit/UIKit.h>

/**---------------------------------------------------------------------------------------
 *  Custom Dropdown Menu. Use this class along with a nib file named "VSDropdown".
 *  ---------------------------------------------------------------------------------------
 */

@interface VSDropdown : UIView

/** Holds reference to tableView used in dropdown. */
@property (nonatomic,readonly)UITableView *tableView;

/** Holds reference to view for which dropdown is called. */
@property(nonatomic,weak,readonly)UIView *dropDownView;

/** Array containing items to show in dropdown. */
@property(nonatomic,readonly)NSArray *dataArr;

/** Alphabetically sorted dataArr. */
@property(nonatomic,readonly)NSMutableArray *sortedArr;

/** Reference to slected item in dropdown. */
@property(nonatomic,readonly)NSString *seletecdStr;

/** Reference to font used in dropdown*/
@property(nonatomic,readonly)UIFont *font;


/** Reference to text color used in dropdown*/
@property(nonatomic,readonly)UIColor *textColor;

/** Array containing items which should be disbaled*/
@property(nonatomic,readonly)NSMutableArray *disabledArray;

/** Direction for dropdown*/
@property(nonatomic,assign)Dropdown_Direction direction;

/** Assigned direction  for dropdown*/
@property(nonatomic,readonly)Dropdown_Direction assignedDirection;

/** Determines whether dropdown should adopt parent color theme. */
@property(nonatomic,assign)BOOL adoptParentTheme;

/** Determines whether dropdown should display items in sorted form. */
@property(nonatomic,assign)BOOL shouldSortItems;


/** Delegate to recive events from dropdown */
@property(nonatomic,weak)id<VSDropdownDelegate>delegate;

/** Dropdown height. Default is 160.0*/
@property(nonatomic,assign)CGFloat maxDropdownHeight;

/** Dropdown backGround imageview.*/
@property(nonatomic,readonly)UIImageView *backgroundImageView;

/** Dropdown backGround imageview.*/
@property(nonatomic,assign)DropdownAnimation drodownAnimation;


/** Specify whether dropdown should remove itslef whenever tapped outside the boudns of dropdown. When set, client will be to remove the dropdown. It is recommended to remove it by calling remove method.
 
 @see remove
 
 */
@property(nonatomic,assign)BOOL autoRemoveDisabled;


/** When set, dropdown will reduce its height irrespective of 'maxDropdownHeight' value when content to show is not large enough to cover the entire height of dropdown.*/
@property(nonatomic,assign)BOOL shouldContractForLesserContent;



/** Initializes and returns a newly allocated Dropdown object with the specified delegate, selectedStr and content. Content is used as datasource for the dropdown tableView.
 
 @param delegate delegate for the dropdown.
 
 */
-(id)initWithDelegate:(id<VSDropdownDelegate>)delegate;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 */
-(void)setupDropdownForView:(UIView *)view;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 */
-(void)setupDropdownForView:(UIView *)view direction:(Dropdown_Direction)direction;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 @param baseColor dropdown gadient will be formed using basecolor.
 @param scale gradient scale (from -1 to 1).
 
 */
-(void)setupDropdownForView:(UIView *)view direction:(Dropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale;



/** Use this method to show a dropdown over/below a view. If view passed is a UIButton, than font of the UIButton will be used.
 
 @param view UIView below/over which dropdown is required.
 @param direction direction in which dropdowm is required.
 @param topColor top color component of gradient.
 @param bottomColor bottom color component of gradient.
 
 @param scale gradient scale (from -1 to 1).
 
 @note scale will be ignored if both topColor and bottomColor are not nil. bottomColor value will be ignored if topColor is nil. If adoptParentTheme is set to YES then all the color component values passed will be ignored.
 
 */
-(void)setupDropdownForView:(UIView *)view direction:(Dropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale;


/** Removes the receiver from the screen.
 
 */
-(void)remove;


/** Use this method to reload the contents of Dropdown
 @param contents Array containing the NSString objects which will be displayed in dropdown after reload.
 */
-(void)reloadDropdownWithContents:(NSArray *)contents;


/** Use this method to to reload the contents of Dropdown
 @param contents Array containing the NSString objects which will be displayed in dropdown after reload.
 @param selectedString String which should be selected after reload.
 
 */
-(void)reloadDropdownWithContents:(NSArray *)contents andSelectedString:(NSString *)selectedString;


/** Use this method to to reload the contents of Dropdown using models
 @param contents Array containing the Model objects whose keyPath values will be displayed in dropDown
 @param keyPath A key path of the form relationship.property (with one or more relationships)
 @param selectedString String which should be selected after reload.
 
 */
-(void)reloadDropdownWithContents:(NSArray *)contents keyPath:(NSString *)keyPath selectedString:(NSString *)selectedItem;



@end

