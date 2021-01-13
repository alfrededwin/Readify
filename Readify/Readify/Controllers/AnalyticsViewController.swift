//
//  AnalyticsViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2021-01-12.
//
// Reference :  https://www.youtube.com/watch?v=J9hl7HHXNHU
// https://www.youtube.com/watch?v=GNf-SsDBQ20&t=501s

import Charts
import UIKit

//, ChartViewDelegate

class AnalyticsViewController: UIViewController {
    
//    var lineChart = LineChartView()

 
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        lineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
//        pieChart.center = view.center
//        view.addSubview(pieChart)

        var entries = [ChartDataEntry]()

        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x),
                                          y: Double(x)))
        }

        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
