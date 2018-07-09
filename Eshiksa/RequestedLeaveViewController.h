

#import <UIKit/UIKit.h>

@interface RequestedLeaveViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *contactArr,*fromDateArr,*toDateArr,*statusArr,*reqLeaveArr;
@property(nonatomic,retain)NSString *indxp,*tag,*success,*error,*studentId;

@end
