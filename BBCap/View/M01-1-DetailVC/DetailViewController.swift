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
import Font_Awesome_Swift

final class DetailViewController: ViewController {

    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var hourPercentLabel: UILabel!
    @IBOutlet weak var dayPercentLabel: UILabel!
    @IBOutlet weak var weekPercentLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var addAlertButton: UIButton!
    @IBOutlet weak var addToPortfolioButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var dateCurrencyLabel: UILabel!
    @IBOutlet weak var todayButton: Button!
    @IBOutlet var volumeViews: [CurrencyVolumeView]!
    @IBOutlet var timeTypeButtons: [Button]!
    @IBOutlet weak var priceTypeButton: Button!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyTitleLabel: UILabel!

    // Properties
    private var isLoading = false
    private var index = 0

    var viewModel = DetailViewModel() {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configNavigationStatusBarView()
        configNavigationView()
        configButtons()
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

    private func configButtons() {
        priceTypeButton.setTitleColor(.white, for: UIControlState.normal)
        priceTypeButton.titleLabel?.font = .systemFont(ofSize: 16)

        timeTypeButtons.forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16)
            $0.setTitleColor(App.Color.bbGreenColor, for: .selected)
            $0.setBackgroundImage(nil, for: .selected)
            $0.isSelected = false
        }
    }

    private func configViewModel() {
        viewModel.delegate = self
    }

    func configChartView() {
        lineChartView.delegate = self
        lineChartView.chartDescription?.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(false)
        lineChartView.pinchZoomEnabled = false

        let leftAxis = lineChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.drawLimitLinesBehindDataEnabled = true
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

        let set1 = LineChartDataSet()
        set1.drawIconsEnabled = false
        set1.setColor(App.Color.bbGreenColor)
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.drawValuesEnabled = false
        set1.label = nil
        set1.formLineWidth = 0
        set1.fillAlpha = 1.0
        set1.fillColor = Config.chartFillColor
        set1.highlightColor = UIColor.white.withAlphaComponent(0.3)
        set1.highlightLineWidth = 1.0
        set1.drawFilledEnabled = true
        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }

    private func updateChartView() {
        // Update y-axis
        lineChartView.leftAxis.axisMaximum = viewModel.axisMaximum
        lineChartView.leftAxis.axisMinimum = viewModel.axisMinimum

        // Update date
        guard let set1 = lineChartView.data?.dataSets.first as? LineChartDataSet else { return }
        let values: [ChartDataEntry] = viewModel.axisPrices.enumerated().map { (arg) -> ChartDataEntry in
            let (index, price) = arg
            return  ChartDataEntry(x: Double(index), y: price, data: nil)
        }
        set1.values = values

        let data = LineChartData(dataSet: set1)
        lineChartView.data = data

        lineChartView.animate(xAxisDuration: 0.5)
    }

    // MARK: - Update view
    private func updateView() {
        guard isViewLoaded else { return }
        volumeViews.forEach {
            $0.viewModel = viewModel.volumeViewModel(withTag: $0.tag)
        }

        // Update default
        priceTypeButton.setTitle(viewModel.priceType.rawValue, for: .normal)
        chooseTimeTypeButtonTouchUpInside(todayButton)
        currencyImageView.setImage(urlString: viewModel.data?.iconPath)
        currencyTitleLabel.text = viewModel.data?.title
        currentCurrencyLabel.text = viewModel.data?.value

        hourPercentLabel.text = viewModel.data?.percentChange1h
        dayPercentLabel.text = viewModel.data?.percentChange24h
        weekPercentLabel.text = viewModel.data?.percentChange7d

        hourPercentLabel.textColor = viewModel.isNegativeHourPercent ? App.Color.bbRedColor : App.Color.bbLightGreenColor
        dayPercentLabel.textColor = viewModel.isNegativeDayPercent ? App.Color.bbRedColor : App.Color.bbLightGreenColor
        weekPercentLabel.textColor = viewModel.isNegativePercentWeek ? App.Color.bbRedColor : App.Color.bbLightGreenColor
    }

    // MARK: - IBAction

    @IBAction private func priceTypeButtonTouchUpInside(_ button: Button) {
        guard let priceType = try? DetailViewModel.PriceType.next(button.titleForNormal) else { return }
        viewModel.priceType = priceType
    }

    @IBAction private func addAlertButtonTouchUpInside(_ button: Button) {
        let vc = CreateAlertViewController()
        navigationController?.pushViewController(vc)
    }

    @IBAction private func addToPortfolioButtonTouchUpInside(_ button: Button) {
        let vc = AddTransactionViewController()
        navigationController?.pushViewController(vc)
    }

    @IBAction private func chooseTimeTypeButtonTouchUpInside(_ button: Button) {
        guard let value = button.titleLabel?.text, !isLoading else { return }
        isLoading = true
        timeTypeButtons.forEach { $0.isSelected = false }
        button.isSelected = true
        viewModel.notifyForGetCurrency(value: value) { [weak self] result in
            guard let this = self else { return }
            this.isLoading = false
            switch result {
            case .success:
                this.updateChartView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    @IBAction private func backButtonTouchUpInside(_ button: Button) {
        navigationController?.popViewController()
    }
}

// MARK: - ChartViewDelegate
extension DetailViewController: ChartViewDelegate {

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        viewModel.notifyForDate(entryX: entry.x.int)
        viewModel.notifyForCurrencyAt(entryX: entry.x.int)
    }
}

extension DetailViewController: DetailViewModelDelegate {

    func viewModelShouldUpdateChartView(_ viewModel: DetailViewModel) {
        updateChartView()
    }

    func viewModelShouldUpdatePriceTypeButton(_ viewModel: DetailViewModel) {
        priceTypeButton.setTitle(viewModel.priceType.rawValue, for: .normal)
    }

    func viewModelShouldUpdateDate(_ viewModel: DetailViewModel) {
        dateCurrencyLabel.text = viewModel.dateString
    }

    func viewModelShouldUpdateCurrency(_ viewModel: DetailViewModel) {
        currencyLabel.text = viewModel.price
    }
}

// MARK: - Config
extension DetailViewController {

    struct Config {
        static let topColor: UIColor = App.Color.bbBlackColor
        static let bottomColor: UIColor! = UIColor(red: 17, green: 22, blue: 22)
        static let chartFillColor: UIColor! = UIColor(red: 16, green: 97, blue: 86)
        static let gradientColors: [CGColor] = [Config.bottomColor.cgColor, Config.topColor.cgColor]
        static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        static let statusBarFrame: CGRect = CGRect(x: 0, y: 0, width: 375, height: Config.statusBarHeight)
    }
}
