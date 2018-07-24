//
//  ViewController.m
//  ChartDemo
//
//  Created by 吕峰 on 2018/7/24.
//  Copyright © 2018年 吕峰. All rights reserved.
//

#import "ViewController.h"
#import "ChartDemo-Bridging-Header.h"
@import Charts;
@interface ViewController ()
@property (nonatomic,strong) PieChartView *pieChartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建饼图对象
    self.pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(10,100, 400, 400)];
    self.pieChartView.legend.enabled = NO;     //是否显示饼图图例描述
//     self.pieChartView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pieChartView];
    //基本样式
    [self.pieChartView setExtraOffsetsWithLeft:5 top:10 right:70 bottom:5];//饼状图距离边缘的间隙
    self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    self.pieChartView.drawSlicesUnderHoleEnabled= NO; //是否掏空饼图中心
    self.pieChartView.chartDescription.enabled = YES;//饼状图描述
    self.pieChartView.drawCenterTextEnabled = YES;//是否显示区块文本
//    [self.pieChartView setRotationEnabled:false];//禁止拖拽,默认true

    //设置饼状图中间的空心样式
    self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.5;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 0.55;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];//半透明空心的颜色
    
    //设置饼状图中心的文本
    if (self.pieChartView.isDrawHoleEnabled == YES) {
        //普通文本
        // self.pieChartView.centerText = @"饼状图";//中间文字
        //富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"饼状图"];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],
                                    NSForegroundColorAttributeName: [UIColor orangeColor]}
                            range:NSMakeRange(0, centerText.length)];
        self.pieChartView.centerAttributedText = centerText;
    }
    //图例描述
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    //图例在饼状图中的位置
    self.pieChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    self.pieChartView.legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    self.pieChartView.legend.orientation = ChartLegendOrientationVertical;
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 8;//图示大小
    [self setData];
}

- (PieChartData *)setData{
    
    //每个区块的数据
    //每个区块的名称或描述
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableArray *nameArr = [[NSMutableArray alloc]init];
    NSArray *dd = @[@"3",@"4",@"5"];
    NSArray *hh = @[@"asdas",@"dfgdfgd",@"dfgdfg"];
    [arr addObjectsFromArray:dd];
    [nameArr addObjectsFromArray:hh];
//    for (pieChart *model in _pieCharModel.pieChart) {
//        [arr addObject:model.totalamt];//@[@"8.54",@"3.26",@"2"];
//        [nameArr addObject:model.typename];
//    }

    NSMutableArray *values = [[NSMutableArray alloc] init];
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < arr.count; i++)
    {
        NSString * aaa = arr[i];
        double bb = aaa.doubleValue;
        [values addObject:[[PieChartDataEntry alloc] initWithValue: bb label: nameArr[i]]];
    }
    //dataSet
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"aaaf"];
    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];     //色值区间1
    [colors addObjectsFromArray:ChartColorTemplates.joyful];        //色值区间2
    [colors addObjectsFromArray:ChartColorTemplates.colorful];      //色值区间3
    [colors addObjectsFromArray:ChartColorTemplates.liberty];       //色值区间4
    [colors addObjectsFromArray:ChartColorTemplates.pastel];        //色值区间5
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];    //色值区间6
    dataSet.colors = colors;//区块颜色  26种颜色，同gitDemo一致
    dataSet.sliceSpace = 5;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    //数据与区块之间的用于指示的折线样式
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色
    //data
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 0;//小数位数
    formatter.multiplier = @1.f;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];          //设置区块字体颜色
    [data setValueFont:[UIFont systemFontOfSize:10]];       //设置区块字体大小
    self.pieChartView.data = data;
    [self.pieChartView setNeedsDisplay];        //显示数据
    return data;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
