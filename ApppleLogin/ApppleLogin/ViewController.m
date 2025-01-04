//
//  ViewController.m
//  ApppleLogin
//
//  Created by Inje Cho on 2022/06/09.
//

#import "ViewController.h"

@interface ViewController ()
//<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *nsdata = [NSUserDefaults standardUserDefaults];
    
    _NickNameLabel.text = [nsdata objectForKey:@"NickName"]; //Nick 불러오기
    _ageLabel.text =  [nsdata objectForKey:@"age"]; //나이 불러오기
    _addressLabel.text = [nsdata objectForKey:@"address"]; //주소 불러오기
    _genderLabel.text = [nsdata objectForKey:@"gender"]; //성별 불러오기
    
    NSLog(@"ViewController 진입 - 로그인 완료");
                                          
    // Do any additional setup after loading the view.
}



@end
