//
//  DetailControllerViewController.m
//  DetailControllerViewController
//
//  Created by caishuning on 2021/9/2.
//

#import "DetailControllerViewController.h"
#import "DetailLabel.h"
#import "AppData.h"
#import "AppointPhoneTextField.h"
#import "PhoneTextField.h"
#import "DevelopmerNameField.h"
#import "UserInfo.h"
@interface DetailControllerViewController ()
@property (nonatomic,strong) AppointPhoneTextField *apointPhoneTextField;
@property (nonatomic,strong) PhoneTextField *phoneTextField;
@property (nonatomic,strong) DevelopmerNameField *developmerNameField;
@property (nonatomic,strong) UIButton * queryPhoneBtn;
@property (nonatomic,strong) UIButton * queryCodeBtn;
@property (nonatomic,strong) UIButton * isRepeatBtn;
@property (nonatomic,strong) UILabel *isRepeatLabel;
@end

@implementation DetailControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self constraint];
}

- (void)setUI
{
    
    self.apointPhoneTextField = [[AppointPhoneTextField alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_apointPhoneTextField];
    
    self.isRepeatBtn = ({
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(isRepeat:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 1;
        btn;
    });
    [self.view addSubview:_isRepeatBtn];
    
    self.isRepeatLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"需要获取你获取过的号码";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:CJHeight(15)];
        label;
    });
    [self.view addSubview:_isRepeatLabel];
    
    self.queryPhoneBtn = ({
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:mainColor];
        [btn setTitle:@"查询号码" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:CJHeight(18)];
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.layer.cornerRadius = CJHeight(10);
        [btn addTarget:self action:@selector(getPhone) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:_queryPhoneBtn];
    
    self.phoneTextField = [[PhoneTextField alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_phoneTextField];
    
    self.developmerNameField  = [[DevelopmerNameField alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_developmerNameField];
    
    
    self.queryCodeBtn = ({
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:mainColor];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:CJHeight(18)];
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.layer.cornerRadius = CJHeight(10);
        [btn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:_queryCodeBtn];
    
    
}

//获取号码
- (void)getPhone
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *dict = @{
                           @"id":@"10224",
                           @"operator":@"0",
                           @"Region":@"0",
                           @"card":@"0",
                           @"phone":_apointPhoneTextField.text,
                           @"loop":_isRepeatBtn.selected ? @"2" : @"1",
                           @"token":[AppData shareInstance].userInfo.token
                           };
    [manager POST:@"http://api.ussms.top:8080/yhquhao.php?" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [SVProgressHUD dismiss];
        UserInfo *userInfo = [AppData shareInstance].userInfo;
        int count = [userInfo.userGetCount intValue];
        if([[responseObject objectForKey:@"result"] isEqualToString: @"success"] && count > 0){
            userInfo.number = [responseObject objectForKey:@"number"];
            NSString *number = userInfo.number;
            self.phoneTextField.text = number;
            NSString *str = @"您获取的号码为：";
            str = [str stringByAppendingString:number];
            str = [str stringByAppendingString:@" 剩余获取次数："];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%d",--count]];
            userInfo.userGetCount =  [NSString stringWithFormat:@"%d",count];
            DSToast *toast = [[DSToast alloc]initWithText:str];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
        }else if(count == 0){
            DSToast *toast = [[DSToast alloc]initWithText:@"获取次数为0，不可获取！"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
            self.queryPhoneBtn.enabled = NO;
        }else{
            DSToast *toast = [[DSToast alloc]initWithText:@"没有可用的号码!"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [SVProgressHUD dismiss];
        DSToast *toast = [[DSToast alloc]initWithText:@"请求失败！"];
        [toast showInView:self.view showType:DSToastShowTypeCenter];
    }];
}

- (void)isRepeat:(UIButton *)sender
{
    if (sender.backgroundColor == [UIColor blueColor]) {
        sender.selected = YES;
        sender.backgroundColor = [UIColor whiteColor];
    }
    else{
        sender.selected = NO;
        sender.backgroundColor = [UIColor blueColor];
    }
}

//获取验证码
- (void)getCode
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *dict = @{
                           @"id":@"10224",
                           @"phone":_phoneTextField.text,
                           @"t":_developmerNameField.text,
                           @"token":[AppData shareInstance].userInfo.token
                           };
    [manager POST:@"http://api.ussms.top:8080/yhquma.php?" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [SVProgressHUD dismiss];
        if ([[responseObject objectForKey:@"result"] isEqualToString:@"success"]) {
        //初始化提示框；
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[responseObject objectForKey:@"message"] preferredStyle:  UIAlertControllerStyleAlert];
         
          [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          }]];
          //弹出提示框；
          [self presentViewController:alert animated:true completion:nil];
        }
        else{
            NSString *str = [responseObject objectForKey:@"error"];
            DSToast *toast = [[DSToast alloc]initWithText:str];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [SVProgressHUD dismiss];
        DSToast *toast = [[DSToast alloc]initWithText:@"请求失败！"];
        [toast showInView:self.view showType:DSToastShowTypeCenter];
    }];
}

-(void)backActionOfDelegate
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)constraint
{
    [_apointPhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@160).offset(CJHeight(160));
        make.left.equalTo(@30).offset(CJWidth(30));
        make.size.mas_equalTo(CGSizeMake(screenWidth - CJWidth(60), CJHeight(50)));
    }];
    
    [_isRepeatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_apointPhoneTextField.mas_left);
        make.top.equalTo(_apointPhoneTextField.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(CJWidth(15), CJHeight(15)));
    }];
    
    [_isRepeatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_isRepeatBtn.mas_right).offset(CJWidth(8));
        make.top.equalTo(_isRepeatBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(CJWidth(260), CJHeight(15)));
    }];
    
    [_queryPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_apointPhoneTextField.mas_left).offset(CJWidth(50));
        make.top.equalTo(_isRepeatLabel.mas_bottom).offset(CJHeight(20));
        make.width.mas_equalTo(_apointPhoneTextField.mas_width).offset(-CJWidth(100));
        make.height.mas_equalTo(_apointPhoneTextField.mas_height).offset(CJHeight(-5));
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_apointPhoneTextField.mas_left);
        make.top.equalTo(_queryPhoneBtn.mas_bottom).offset(CJHeight(20));
        make.size.mas_equalTo(CGSizeMake(screenWidth - CJWidth(60), CJHeight(50)));
    }];
    
    [_developmerNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_apointPhoneTextField.mas_left);
        make.top.equalTo(_phoneTextField.mas_bottom).offset(CJHeight(20));
        make.size.mas_equalTo(CGSizeMake(screenWidth - CJWidth(60), CJHeight(50)));
    }];
    
    [_queryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_apointPhoneTextField.mas_left).offset(CJWidth(50));
        make.top.equalTo(_developmerNameField.mas_bottom).offset(CJHeight(20));
        make.width.mas_equalTo(_apointPhoneTextField.mas_width).offset(-CJWidth(100));
        make.height.mas_equalTo(_apointPhoneTextField.mas_height).offset(CJHeight(-5));
    }];
}

@end
