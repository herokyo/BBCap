//
//  TimeAxisValueFormatter.swift
//  BBCap
//
//  Created by Lam Le V. on 5/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//


import Foundation
import Charts

public class TimeAxisValueFormatter: IAxisValueFormatter {

    // Dummy
    let days: [String] = ["Day1", "Day2", "Day3", "Day4", "Day5", "Day6", "Day7", "Day8", "Day9", ""]

    // TODO : - Use data in chart later
    weak var chart: LineChartView?

    init(chart: LineChartView) {
        self.chart = chart
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return days[Int(value / 10) - 1]
    }
}
