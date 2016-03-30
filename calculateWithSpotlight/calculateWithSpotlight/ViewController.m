//
//  ViewController.m
//  calculateWithSpotlight
//
//  Created by fly on 16/3/30.
//
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, OperatorStyle)
{
    OperatorStyleAdd = 11,
    OperatorStyleMinus = 12,
    OperatorStyleMultiply = 13,
    OperatorStyleDivid = 14,
    OperatorStyleMod = 15
};

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) NSMutableArray *numArray;
@property (nonatomic, strong) NSMutableArray *operatorArray;
@property (nonatomic, assign) NSInteger tmpInput;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numArray = [[NSMutableArray alloc] init];
    self.operatorArray = [[NSMutableArray alloc] init];
    [self updateResultLabel:[NSString stringWithFormat:@"%@",@(0)]];
}

- (IBAction)numberClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.tmpInput = self.tmpInput * 10 + btn.tag;
    [self updateResultLabel:[NSString stringWithFormat:@"%@",@(self.tmpInput)]];
}

- (IBAction)operatorClick:(id)sender
{
    [self.numArray addObject:@(self.tmpInput)];
    if (self.numArray.count == 2 && self.operatorArray.count == 1) {
        [self showUpTmpRes];
    }
    else {
        [self updateResultLabel:[NSString stringWithFormat:@"%@",@(self.tmpInput)]];
        UIButton *btn = (UIButton *)sender;
        [self.operatorArray addObject:@(btn.tag)];
        self.tmpInput = 0;
    }
}

- (IBAction)resultClick:(id)sender
{
    [self.numArray addObject:@(self.tmpInput)];
    if (self.numArray.count == 2 && self.operatorArray.count == 1) {
        [self showUpTmpRes];
    }
    else {
        [self updateResultLabel:@"ERROR"];
    }
}

- (IBAction)clearClick:(id)sender
{
    self.tmpInput = 0;
    [self.numArray removeAllObjects];
    [self.operatorArray removeAllObjects];
    [self updateResultLabel:[NSString stringWithFormat:@"%@",@(0)]];
}

- (void)showUpTmpRes
{
    NSInteger tmpRes = [self calculator];
    [self updateResultLabel:[NSString stringWithFormat:@"%@",@(tmpRes)]];
    [self.numArray removeAllObjects];
    [self.numArray addObject:@(tmpRes)];
    [self.operatorArray removeAllObjects];
}

- (void)updateResultLabel:(NSString *)res
{
    self.resultLabel.text = res;
}

- (NSInteger)calculator
{
    NSInteger num1 = [self.numArray[0] integerValue];
    NSInteger num2 = [self.numArray[1] integerValue];
    OperatorStyle operator = [self.operatorArray[0] integerValue];
    switch (operator) {
        case OperatorStyleAdd:
            return num1 + num2;
            break;
        case OperatorStyleMinus:
            return num1 - num2;
            break;
        case OperatorStyleMultiply:
            return num1 * num2;
            break;
        case OperatorStyleDivid:
            if (num2 == 0) {
                return 0;
            }
            return num1 / num2;
            break;
        case OperatorStyleMod:
            return num1 % num2;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end