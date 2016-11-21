//
//  ViewController.m
//  Github Repos
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (nonatomic) NSMutableArray *names;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.names = [[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/carmen-c/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        for (NSDictionary *repo in repos) {
        NSString *repoName = repo[@"name"];
        Repo *repo = [[Repo alloc]initWithName:repoName];
        [self.names addObject:repo];
        //NSLog(@"repo: %@", repoName);
        }
        
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        [self.aTableView reloadData];
        }];
        
    }];
    
    [dataTask resume];

}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Repo *repo = self.names[indexPath.row];
    cell.textLabel.text = repo.name;
    return cell;
}





@end
