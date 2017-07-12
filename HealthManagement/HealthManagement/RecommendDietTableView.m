//
//  RecommendDietTableView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecommendDietTableView.h"
#import "RecommendDietCell.h"

@implementation RecommendDietTableView

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40+6, kScreen_Width, self.height-(40+6))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        
        NSArray *titleArr = @[@"适合我的",@"销量最高",@"距离最近",@"类型"];
        CGFloat width = kScreen_Width/titleArr.count;
        for (int i=0; i<titleArr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width*i, 0, width, baseView.height);
            //    _nearbyBtn.backgroundColor = [UIColor redColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            //            _recommendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
            //    _recommendBtn.selected = YES;
            btn.tag = 100+i;
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i < titleArr.count-1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width*(i+1), (baseView.height-20)/2, 1, 20)];
                line.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
                [self addSubview:line];
            }
            
            if (i == titleArr.count-1) {
                
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
                
                _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+15, (baseView.height-10)/2, 10, 10)];
                _imgView1.image = [UIImage imageNamed:@"Restaurant_12"];
                //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
                [btn addSubview:_imgView1];
            }
            
            if (i == 0) {
                self.lastBtn = btn;
                btn.selected = YES;
                
            }
        }
        
        
        // 表视图
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)exchangeAction:(UIButton *)btn
{
    
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    
    if (btn.tag == 100) {
        
    }
    else if (btn.tag == 101) {
        
    }
    else if (btn.tag == 102) {
        
    }
    else if (btn.tag == 103) {
        _imgView1.image = [UIImage imageNamed:@"Restaurant_11"];
        
    }
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 117+5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendDietCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[RecommendDietCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    //    cell.textLabel.text = self.dataArray[indexPath.row];
    //    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

@end
