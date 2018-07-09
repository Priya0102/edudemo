
#import <UIKit/UIKit.h>

@interface RequestedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contact;
@property (weak, nonatomic) IBOutlet UILabel *fromDate;

@property (weak, nonatomic) IBOutlet UILabel *toDate;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIButton *statusLblBtn;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIImageView *imgview;
@end
