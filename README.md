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
Other

License
==========
This code is distributed under the terms and conditions of the [MIT license](LICENSE).
