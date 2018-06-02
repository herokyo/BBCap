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

    // TODO : - Use data in chart later
    weak var chart: LineChartView?

    init(chart: LineChartView) {
        self.chart = chart
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return ""
    }
}
