//
//  ViewController.m
//  JsonDataParse
//
//  Created by Civet on 2019/5/24.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"
#import "BookModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self parseData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayBooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *strID =@"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    BookModel *book = [_arrayBooks objectAtIndex:indexPath.row];
    cell.textLabel.text = book.mBookName;
    cell.detailTextLabel.text = book.mPrice;
    
    return  cell;
}
//解析数据
- (void)parseData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fileName" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //将json数据解析为字典格式
    NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //判断解析是否为字典
    if ([dicRoot isKindOfClass:[NSDictionary class]]){
        //开始解析数据
        _arrayBooks = [[NSMutableArray alloc] init];
        //解析根数据
        NSArray *arrayEnter = [dicRoot objectForKey:@"enter"];
        for (int i = 0; i < arrayEnter.count; i++){
            NSDictionary *dicBook = [arrayEnter objectAtIndex:i];
            //获取书籍名字对象
            NSDictionary *bookNameDic = [dicBook objectForKey:@"title"];
            NSString *bookName = [bookNameDic objectForKey:@"$t"];
            BookModel *book = [[BookModel alloc] init];
            book.mBookName = bookName;
            NSArray *arrAttr = [dicBook objectForKey:@"db:attribute"];
            for (int i = 0; i < arrAttr.count; i++) {
                NSDictionary *dic = [arrAttr objectAtIndex:i];
                NSString *strName = [dic objectForKey:@"name"];
                if ([strName isEqualToString:@"price"] == YES) {
                    NSString *price = [dic objectForKey:@"$t"];
                    book.mPrice = price;
                }
                else if ([strName isEqualToString:@"publisher"]){
                    NSString *pub = [dic objectForKey:@"publisher"];
                    book.mPublisher = pub;
                }
            }
            //添加数据到数组中
            [_arrayBooks addObject:book];
        }
    }
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
