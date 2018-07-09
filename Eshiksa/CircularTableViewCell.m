

#import "CircularTableViewCell.h"
#import "BaseViewController.h"

@implementation CircularTableViewCell
@synthesize readMoreTxt;
@synthesize publishDateTxt;
@synthesize toDateTxt;


- (void)awakeFromNib {
    [super awakeFromNib];
    _readMoreBtn.layer.masksToBounds=YES;
    _readMoreBtn.layer.cornerRadius=8.0;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds
                                                   byRoundingCorners:(UIRectCornerTopRight )cornerRadii:CGSizeMake(6.0, 6.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _view.bounds;
    maskLayer.path = maskPath.CGPath;
    _view.layer.mask = maskLayer;
    

    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
