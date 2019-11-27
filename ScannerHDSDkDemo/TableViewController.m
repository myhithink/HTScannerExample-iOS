//
//  TableViewController.m
//  ScannerHDSDkDemo
//
//  Created by Frank on 2019/11/21.
//  Copyright © 2019 Hithink. All rights reserved.
//

#import "TableViewController.h"
#import <ScannerHDSDK/HTScanner.h>
#import <ScannerHDSDK/HTScannerProject.h>

#define DemoLicense @""

@interface TableViewController () 

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) HTScannerProject *project;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, strong) UISwitch *switch0;
@property (nonatomic, strong) UISwitch *switch1;
@property (nonatomic, strong) UISwitch *switch2;
@property (nonatomic, strong) UISwitch *switch3;
@property (nonatomic, strong) UISwitch *switch4;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"HTScannerExample";
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 210)];
    
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width - 20, 30)];
    _tipLabel.text = @"input license";
    [headView addSubview:_tipLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 160)];
    _textView.text = DemoLicense;
    _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10);
    [headView addSubview:_textView];
    self.tableView.tableHeaderView = headView;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView setSectionFooterHeight:0];
    [self.tableView setSectionHeaderHeight:20];
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
}

- (void)commentTableViewTouchInSide
{
    [_textView resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }
    else if (section == 2) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    // Configure the cell...
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    
    NSInteger row = indexPath.row;
    switch (indexPath.section)
    {
        case 0:
        {
            cell.textLabel.text = @"initScanner";
            
            cell.detailTextLabel.text = [[HTScanner sharedInstance] isLicenseValid]?@"License Valid":@"License Invalid";
        }
            break;
        case 1:
        {
            switch (row) {
                case 0:
                {
                    cell.textLabel.text = @"Default batch model single/batch:";
                    if (!_switch0)
                    {
                        _switch0 = [[UISwitch alloc] init];
                        _switch0.tag = row;
                        [_switch0 addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
                        _switch0.on = NO;
                        cell.accessoryView = _switch0;
                    }
                    _switch0.enabled = [[HTScanner sharedInstance] isLicenseValid];
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"\"Batch\" switch hide/show:";
                    if (!_switch1)
                    {
                        _switch1 = [[UISwitch alloc] init];
                        _switch1.tag = row;
                        [_switch1 addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
                        _switch1.on = YES;
                        cell.accessoryView = _switch1;
                    }
                    _switch1.enabled = [[HTScanner sharedInstance] isLicenseValid];
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"Default capture mode manual/auto:";
                    if (!_switch2)
                    {
                        _switch2 = [[UISwitch alloc] init];
                        _switch2.tag = row;
                        [_switch2 addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
                        _switch2.on = YES;
                        cell.accessoryView = _switch2;
                    }
                    _switch2.enabled = [[HTScanner sharedInstance] isLicenseValid];
                }
                    break;
                case 3:
                {
                    cell.textLabel.text = @"\"Auto\" switch hide/show:";
                    if (!_switch3)
                    {
                        _switch3 = [[UISwitch alloc] init];
                        _switch3.tag = row;
                        [_switch3 addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
                        _switch3.on = YES;
                        cell.accessoryView = _switch3;
                    }
                    _switch3.enabled = [[HTScanner sharedInstance] isLicenseValid];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            if (row == 0)
            {
                cell.textLabel.text = @"startScan";
            }
            else
            {
                cell.textLabel.text = @"export";
            }
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"settings";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)onSwitchValueChanged:(UISwitch *)switchBtn
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            NSInteger suc = [[HTScanner sharedInstance] initScanner:_textView.text];
            [self.tableView reloadData];
            _tipLabel.text = [NSString stringWithFormat:@"init License success:%@",@(suc)];
        }
            break;
        case 2:
        {
            typeof(self) __weak weakSelf = self;
            if (indexPath.row == 0)
            {
                [[HTScanner sharedInstance] setUIConfig:HTScannerCapturePage configID:HTScannerCapturePageSetMultiPages param:@(_switch0.isOn)];
                [[HTScanner sharedInstance] setUIConfig:HTScannerCapturePage configID:HTScannerCapturePageShowMultiPages param:@(_switch1.isOn)];
                [[HTScanner sharedInstance] setUIConfig:HTScannerCapturePage configID:HTScannerCapturePageSetAutoCapture param:@(_switch2.isOn)];
                [[HTScanner sharedInstance] setUIConfig:HTScannerCapturePage configID:HTScannerCapturePageShowAutoCapture param:@(_switch3.isOn)];
                
                NSInteger suc = [[HTScanner sharedInstance] startScanWithViewController:self completion:^(BOOL finsish, HTScannerProject * _Nonnull project) {
                    weakSelf.project = project;
                }];
                if (suc != 0)
                {
                    [self showInvalidAlert];
                }
                _tipLabel.text = [NSString stringWithFormat:@"show capture page success:%@",@(suc)];
            }
            else
            {
                [weakSelf showAlert];
            }
            
        }
            break;
        case 3:
        {
            NSInteger suc = [[HTScanner sharedInstance] displaySettingsPageWithNavigationController:self.navigationController];
            if (suc != 0)
            {
                [self showInvalidAlert];
            }
            _tipLabel.text = [NSString stringWithFormat:@"show settings page success:%@",@(suc)];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showInvalidAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"sdk license is not valid" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlert
{
    typeof(self) __weak weakSelf = self;
    if (_project)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"input export name" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"enable none";
            weakSelf.textField = textField;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *title = weakSelf.textField.text;
            weakSelf.fileName = title;
            [weakSelf showActionSheet];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please scan first." message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)showActionSheet
{
    typeof(self) __weak weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose Export Type" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"PDF" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf exportFilesWithType:HTScannerExportTypePDF];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf exportFilesWithType:HTScannerExportTypeImage];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)exportFilesWithType:(HTScannerExportType)type
{
    typeof(self) __weak weakSelf = self;
    NSString *cacheDirectory = [((NSArray *)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)) firstObject];
    NSInteger result = [_project export:cacheDirectory exportFileName:_fileName exportType:type exportCallback:^(NSArray * _Nonnull urls) {
        NSLog(@"urls:%@",urls);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf shareUrls:urls];
        });        
    }];
    _tipLabel.text = [NSString stringWithFormat:@"export result:%@",@(result)];
}

- (void)shareUrls:(NSArray <NSURL *>*)urls
{
    NSMutableArray *items = [NSMutableArray arrayWithArray:urls];
    if (items.count == 0)
    {
        return;
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];

//    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,
//                                         UIActivityTypePostToTwitter,
//                                         UIActivityTypePostToWeibo,
//                                         UIActivityTypePrint,
//                                         //                                         UIActivityTypeCopyToPasteboard,
//                                         UIActivityTypeAssignToContact,
//                                         UIActivityTypeSaveToCameraRoll,
//                                         UIActivityTypeAddToReadingList,
//                                         UIActivityTypePostToFlickr,
//                                         UIActivityTypePostToVimeo,
//                                         UIActivityTypePostToTencentWeibo];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
