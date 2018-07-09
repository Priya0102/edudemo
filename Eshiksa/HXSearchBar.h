

#import <UIKit/UIKit.h>

@interface HXSearchBar : UISearchBar
@property (nonatomic,strong) UIColor *cursorColor;
@property (nonatomic,strong) UITextField *searchBarTextField;
@property (nonatomic,strong) UIImage *clearButtonImage;
@property (nonatomic,assign) BOOL hideSearchBarBackgroundImage;
@property (nonatomic,strong) UIButton *cancleButton;

@end
