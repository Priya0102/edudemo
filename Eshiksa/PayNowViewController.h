//
//  PayNowViewController.h
//  Eshiksa
//
//  Created by Punit on 08/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayNowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *creditCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *debitCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *netBankingBtn;
@property (weak, nonatomic) IBOutlet UIButton *proceedBtn;
@property(nonatomic,retain)NSString *tag,*success,*error,*merchantId,*pgURL,*pgAction,*instId,*instName,*pgName,*encryptKey,*totalAmountStr,*indxpath,*udf1,*courseIdStr,*batchIdStr,*departmentIdStr,*sessionIdStr,*studentIdStr,*cardtypeStr,*tempIdStr,*txnIdStr,*concessionStatusStr,*pgNBComissionStr,*pgCCComission,*pgDCComission,*pgUrlStr;

@property (weak, nonatomic) IBOutlet UILabel *courseid;
@property (weak, nonatomic) IBOutlet UILabel *batchid;
@property (weak, nonatomic) IBOutlet UILabel *departmentId;
@property (weak, nonatomic) IBOutlet UILabel *sessionId;
@property (weak, nonatomic) IBOutlet UILabel *studentId;
@property (weak, nonatomic) IBOutlet UILabel *previousAmount;
@property (weak, nonatomic) IBOutlet UILabel *payableAmount;
@property (weak, nonatomic) IBOutlet UILabel *netAmount;


@end
