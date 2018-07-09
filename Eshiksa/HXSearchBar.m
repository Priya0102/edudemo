

#import "HXSearchBar.h"

@implementation HXSearchBar
- (void)setCursorColor:(UIColor *)cursorColor
{
    if (cursorColor) {
        _cursorColor = cursorColor;
    
        UITextField *searchField = self.searchBarTextField;
        if (searchField) {
 
            [searchField setTintColor:cursorColor];
        }
    }
}


- (UITextField *)searchBarTextField
{

    _searchBarTextField = [self valueForKey:@"searchField"];
    return _searchBarTextField;
}


- (void)setClearButtonImage:(UIImage *)clearButtonImage
{
    if (clearButtonImage) {
        _clearButtonImage = clearButtonImage;
      
        UITextField *searchField = self.searchBarTextField;
        if (searchField) {
        
            UIButton *button = [searchField valueForKey:@"_clearButton"];
            [button setImage:clearButtonImage forState:UIControlStateNormal];
            searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
}

- (void)setHideSearchBarBackgroundImage:(BOOL)hideSearchBarBackgroundImage {
    if (hideSearchBarBackgroundImage) {
        _hideSearchBarBackgroundImage = hideSearchBarBackgroundImage;
        self.backgroundImage = [[UIImage alloc] init];
    }
}


- (UIButton *)cancleButton
{
    self.showsCancelButton = YES;
    for (UIView *view in [[self.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            _cancleButton = (UIButton *)view;
        }
    }
    return _cancleButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
