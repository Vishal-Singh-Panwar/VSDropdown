VSDropdown
==========

Dropdown for iOS

VSDropdown is an iOS drop-in class which can be used to show menu item below/above UIButton. This class adapts appearance of the button for which it is shown, which you can customise, and presents itself  with appropriate frame and direction. Irrespective of the button's hierarchy in the Window, the Dropdown takes touches everywhere on the screen. It dismisses itself when tapped outside its bounds.



Usage
==========

```html
    [_dropdown setupDropDownForView:_myButton];
    
    [_dropdown reloadDropdownWithContents:@[@"Hello World",@"Dropdown test",@"Bla Bla bla.."] andSelectedString:_myButton.titleLabel.text];

```
<h3>Other<h3>

<b>adoptParentTheme</b> property can be used when the button has solid background color. When this is YES, the dropdown draws itslef with a gradient color which matches with the button's background color. 

You can tweak the componets of background color using below functions:

```html
    -(void)setupDropDownForView:(UIView *)view direction:(Dropdown_Direction)direction withBaseColor:(UIColor *)baseColor scale:(float)scale;
   
    -(void)setupDropDownForView:(UIView *)view direction:(Dropdown_Direction)direction withTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor scale:(float)scale;
```

About Sample
==========

In the sample, there are buttons of different background colors, sizes and fonts. Note that only one VSDropdown instance is used for all the button. Whenever a setupDropDownForView: message is called on VSDropdown instance, it removes itslef from its previous superview, if any, and draws itslef again for the  UIButton passed in the argument.


How it looks?
==========
![Alt text](/Screenshots/SC_0.png?raw=true "No dropdown")  
![Alt text](/Screenshots/SC_1.png?raw=true "Large Fonts")  
![Alt text](/Screenshots/SC_2.png?raw=true "Wider")  
![Alt text](/Screenshots/SC_3.png?raw=true "Direction upwards")  
![Alt text](/Screenshots/SC_4.png?raw=true "Samller")


License
==========
This code is distributed under the terms and conditions of the [MIT license](LICENSE).
