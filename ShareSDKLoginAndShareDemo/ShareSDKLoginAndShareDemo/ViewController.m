//
//  ViewController.m
//  ShareSDKLoginAndShareDemo
//
//  Created by 党玉华 on 2018/11/27.
//  Copyright © 2018年 dangyuhua. All rights reserved.
//

#import "ViewController.h"
#import "ShareManage.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@[@"QQ登录",@"微信登录",@"微博登录"],@[@"QQ分享"]];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableviewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.titles[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableviewCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableviewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SSDKPlatformType platformType;
        if (indexPath.row==0) {
            platformType = SSDKPlatformTypeQQ;
        }else if (indexPath.row==1) {
            platformType = SSDKPlatformTypeWechat;
        }else{
            platformType = SSDKPlatformTypeSinaWeibo;
        }
        [ShareManage login:platformType success:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess){
                NSLog(@"⚠️uid=%@",user.uid);
                NSLog(@"⚠️%@",user.credential);
                NSLog(@"⚠️token=%@",user.credential.token);
                NSLog(@"⚠️nickname=%@",user.nickname);
            }else{
                NSLog(@"⚠️%@",error);
            }
        }];
    }else if (indexPath.section==1){
        NSArray* imageArray = @[[UIImage imageNamed:@"1"]];
        if (imageArray) {
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                             images:imageArray
                                                url:[NSURL URLWithString:@"http://mob.com"]
                                              title:@"分享标题"
                                               type:SSDKContentTypeAuto];
            [ShareManage share:SSDKPlatformTypeQQ parameters:shareParams share:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                        break;
                    }
                    case SSDKResponseStateFail:
                    {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:action];
                        [self presentViewController:alert animated:YES completion:nil];
                        break;
                    }
                    default:
                        break;
                }
            }];
        }
    }
}



@end
