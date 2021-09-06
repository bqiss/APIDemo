//
//  ViewController.m
//  API
//
//  Created by caishuning on 2021/9/1.
//

#import "ViewController.h"
#import "DetailControllerViewController.h"
#import "CountTextField.h"
#import "SecretTextField.h"
#import "UserInfo.h"
#import "AppData.h"
@interface ViewController ()
{
    IQKeyboardReturnKeyHandler *returnKeyHandler;
}
@property (nonatomic,strong) CountTextField *countTextField;
@property (nonatomic,strong) SecretTextField *secretTextField;
@property (nonatomic,strong) UIButton *loginBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.countTextField = [[CountTextField alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_countTextField];
    
    self.secretTextField = [[SecretTextField alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_secretTextField];
    
    self.loginBtn = ({
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:mainColor];
        [btn setTitle:@"查询" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:CJHeight(18)];
        btn.titleLabel.textColor = [UIColor whiteColor];
        btn.layer.cornerRadius = CJHeight(10);
        [btn addTarget:self action:@selector(getUserInfo:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:_loginBtn];
    
    [self constraint];
    
}

- (void)constraint
{
    
    [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@260).offset(CJHeight(260));
        make.left.equalTo(@30).offset(CJWidth(30));
        make.size.mas_equalTo(CGSizeMake(screenWidth - 60, CJHeight(50)));
    }];
    
    [_secretTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countTextField.mas_bottom).offset(CJHeight(20));
        make.left.equalTo(_countTextField.mas_left);
        make.size.mas_equalTo(CGSizeMake(screenWidth - CJWidth(60), CJHeight(50)));
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secretTextField.mas_bottom).offset(CJHeight(20));
        make.left.equalTo(_countTextField.mas_left).offset(CJWidth(50));
        make.width.equalTo(_countTextField.mas_width).offset(-CJWidth(100));
        make.height.equalTo(_countTextField.mas_height).offset(-CJHeight(5));
    }];
}

- (void)getUserInfo:(UIButton *)sender
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *dict = @{
                           @"username":_countTextField.text,
                           @"password":_secretTextField.text
                           };
    [manager POST:@"http://api.ussms.top:8080/login.php" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if([[responseObject objectForKey:@"result"] isEqualToString:@"success"]){
            [AppData shareInstance].userInfo = [[UserInfo alloc]initWithDictionary:responseObject error:nil];
            DetailControllerViewController *detailVC = [[DetailControllerViewController alloc]init];
            [self.navigationController pushViewController:detailVC animated:YES];
            NSData *userInfo =  [NSKeyedArchiver archivedDataWithRootObject:[AppData shareInstance].userInfo requiringSecureCoding:nil error:nil];
            [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"USERINFO"];
            [AppData shareInstance].userInfo.userGetCount = @"5";
        }else{
            DSToast *toast = [[DSToast alloc]initWithText:@"账号或密码错误！"];
            [toast showInView:self.view showType:DSToastShowTypeCenter];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [SVProgressHUD dismiss];
        DSToast *toast = [[DSToast alloc]initWithText:@"登录失败！"];
        [toast showInView:self.view showType:DSToastShowTypeCenter];
    }];
}

@end
