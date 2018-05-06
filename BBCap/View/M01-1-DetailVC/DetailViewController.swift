//
//  DetailViewController.swift
//  BBCap
//
//  Created by Lam Le V. on 5/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift
import Charts

final class DetailViewController: ViewController {

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var currentCurrencyLabel: UILabel!
    @IBOutlet private weak var hourPercentLabel: UILabel!
    @IBOutlet private weak var dayPercentLabel: UILabel!
    @IBOutlet private weak var weekPercentLabel: UILabel!
    @IBOutlet private weak var lineChartView: LineChartView!
    @IBOutlet private var volumeViews: [VolumeView]!

    var viewModel = DetailViewModel() {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationStatusBarView()
        configNavigationView()
        configChartView()
        updateView()
    }

    // MARK: - Status bar
    private func configNavigationStatusBarView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Config.gradientColors
        gradientLayer.frame = Config.statusBarFrame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Navigation view
    private func configNavigationView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navigationView.bounds
        gradientLayer.colors = Config.gradientColors
        navigationView.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func configChartView() {
        lineChartView.delegate = self
        lineChartView.chartDescription?.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = true

        let leftAxis = lineChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 190
        leftAxis.axisMinimum = -50
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.enabled = true
        leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false

        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 13)
        xAxis.labelTextColor = .white
        xAxis.drawGridLinesEnabled = false
        xAxis.axisLineColor = .clear
        xAxis.yOffset = 7
        xAxis.labelCount = 5
        xAxis.axisMinimum = 1.0
        xAxis.valueFormatter = TimeAxisValueFormatter(chart: lineChartView)
        lineChartView.legend.form = .line

        // Chart view content inset
        lineChartView.minOffset = -20
        lineChartView.setExtraOffsets(left: 0, top: 4, right: 10, bottom: -17)

        setDataCount()
    }

    // MARK: - Update view
    private func updateView() {
        guard isViewLoaded else { return }
        volumeViews.forEach {
            $0.viewModel = viewModel.volumeViewModel(withTag: $0.tag)
        }
    }

    private func setDataCount() {
        let values: [ChartDataEntry] = Dummy.vals.enumerated().map { (arg) -> ChartDataEntry in
            let (index, value) = arg
            return ChartDataEntry(x: Double(index), y: value, data: nil)
        }
        let set1 = LineChartDataSet(values: values, label: "")
        set1.drawIconsEnabled = false
        set1.setColor(Config.chartGreenColor)
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.drawValuesEnabled = false
        set1.formLineWidth = 0
        set1.fillAlpha = 1.0
        set1.fillColor = Config.chartFillColor
        set1.highlightColor = UIColor.white.withAlphaComponent(0.3)
        set1.highlightLineWidth = 1.0
        set1.drawFilledEnabled = true
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }

    // MARK: - IBAction

    @IBAction private func addAlertButtonTouchUpInside(_ button: UIButton) {
        // TODO: - Handle later
    }

    @IBAction private func addToPortfolioButtonTouchUpInside(_ button: UIButton) {
        // TODO: - Handle later
    }

    @IBAction private func backButtonTouchUpInside(_ button: UIButton) {
        navigationController?.popViewController()
    }
}

// MARK: - ChartViewDelegate
extension ViewController: ChartViewDelegate {

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("x: \(entry.x), y: \(entry.y)")
    }
}

// MARK: - Config
extension DetailViewController {

    struct Config {
        static let topColor: UIColor! = UIColor(red: 24, green: 19, blue: 32)
        static let bottomColor: UIColor! = UIColor(red: 17, green: 22, blue: 22)
        static let chartFillColor: UIColor! = UIColor(red: 16, green: 97, blue: 86)
        static let chartGreenColor: UIColor! = UIColor(red: 0, green: 216, blue: 159)
        static let gradientColors: [CGColor] = [Config.bottomColor.cgColor, Config.topColor.cgColor]
        static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        static let statusBarFrame: CGRect = CGRect(x: 0, y: 0, width: 375, height: Config.statusBarHeight)
    }
}

// MARK: - Dummy
extension DetailViewController {

    class Dummy {
        static let vals: [Double] = [
            31, 18, 29, 51, 41, 18, 20, 10, 48, 50, 46, 18, 20, 44, 35, 7, 6, 29, 11, 21, 34, 10, 16, 32, 41, 28,
            24, 45, 37, 24, 48, 45, 3, 5, 42, 3, 14, 22, 45, 35, 28, 24, 25, 7, 13, 34, 35, 26, 6, 17, 39, 11, 30,
            12, 38, 33, 14, 39, 13, 41, 23, 45, 4, 45, 27, 15, 23, 6, 15, 17, 101, 32, 92, 84, 122, 36, 59, 38, 75,
            102, 121, 31, 59, 78, 41, 88, 71, 128, 33, 76, 115, 32, 50, 98, 109, 107, 111, 34, 81, 93
        ]
    }
}
