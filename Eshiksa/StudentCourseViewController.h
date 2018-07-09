

#import <UIKit/UIKit.h>

@interface StudentCourseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIView *subjectView;
@property (weak, nonatomic) IBOutlet UILabel *studentName;
@property (weak, nonatomic) IBOutlet UILabel *course;
@property (weak, nonatomic) IBOutlet UILabel *batch;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;

@property (nonatomic,strong) NSMutableArray *subjectIdArr,*subjectnameArr,*subjectArr;


@property (weak, nonatomic) IBOutlet UILabel *subjects;


@end
