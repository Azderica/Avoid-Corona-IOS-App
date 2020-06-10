//
//  RealtimeSituationBoardViewController.swift
//  AvoidCoronaApp
//
//  Created by 윤영신 on 2020/06/10.
//  Copyright © 2020 Azderica. All rights reserved.
//

import UIKit

class RealtimeSituationBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var COVIDTableView: UITableView!
    
    var jsondata_kor: [String: Any]!
    var jsondata2: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //테이블 뷰 delegate 설정
        COVIDTableView.dataSource = self
        COVIDTableView.delegate = self
        //Label layout 설정
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        //COVID 데이터 JSON 파싱
        getDataKorea {
            self.titleLabel.text = "COVID-19 실시간 상황판"
            self.COVIDTableView.reloadData()
        }
        getData2 {
            self.COVIDTableView.reloadData()
        }
    }
    
    func getDataKorea(success: @escaping ()->()) {
        do {
            let url = URL(string: "http://api.corona-19.kr/korea")
            if let data = try String(contentsOf: url!).data(using: .utf8) {
                jsondata_kor = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(jsondata_kor)
                success()
            }
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    func getData2(success: @escaping ()->()) {
        do {
            let url = URL(string: "http://api.corona-19.kr/korea/country/new")
            if let data = try String(contentsOf: url!).data(using: .utf8) {
                jsondata2 = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(jsondata2)
                success()
            }
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전세계"
        }
        else {
            return "대한민국"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = COVIDTableView.dequeueReusableCell(withIdentifier: "RealtimeSituationBoardCell", for: indexPath) as! RealtimeSituationBoardCell
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "확진자"
            case 1:
                cell.titleLabel.text = "사망자"
            case 2:
                cell.titleLabel.text = "격리해제"
            case 3:
                cell.titleLabel.text = "치사율"
            case 4:
                cell.titleLabel.text = "발생국"
            default:
                break
            }
        }
        else {
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "확진자"
                if let totalCase = (jsondata_kor["TotalCase"]), let todayRecovered = (jsondata_kor["TodayRecovered"] as? String), let todayDeath = (jsondata_kor["TodayDeath"] as? String), let totalCaseBefore = (jsondata_kor["TotalCaseBefore"] as? String) {
                    if let todayRecovered_int = Int(todayRecovered), let todayDeath_int = Int(todayDeath), let totalCaseBefore_int = Int(totalCaseBefore) {
                        let todayCase = todayDeath_int + todayRecovered_int + totalCaseBefore_int
                        cell.valueLabel.text = "\(totalCase)명 (+\(todayCase))"
                    }
                }
            case 1:
                cell.titleLabel.text = "사망자"
                if let totalDeath = (jsondata_kor["TotalDeath"]), let todayDeath = (jsondata_kor["TodayDeath"]) {
                    cell.valueLabel.text = "\(totalDeath)명 (+\(todayDeath))"
                }
            case 2:
                cell.titleLabel.text = "격리해제"
                if let totalRecovered = (jsondata_kor["TotalRecovered"]), let todayRecovered = (jsondata_kor["TodayRecovered"]) {
                    cell.valueLabel.text = "\(totalRecovered)명 (+\(todayRecovered))"
                }
            case 3:
                cell.titleLabel.text = "치사율"
                if let deathPercentage = (jsondata_kor["deathPercentage"]) {
                    cell.valueLabel.text = "\(deathPercentage)%"
                }
            case 4:
                cell.titleLabel.text = "총검사자"
                if let totalChecking = (jsondata_kor["TotalChecking"]) {
                    cell.valueLabel.text = "\(totalChecking)명"
                }
            case 5:
                cell.titleLabel.text = "검사중"
                if let checkingCounter = (jsondata_kor["checkingCounter"]) {
                    cell.valueLabel.text = "\(checkingCounter)명"
                }
            case 6:
                cell.titleLabel.text = "음성판정"
                if let notcaseCount = (jsondata_kor["notcaseCount"]) {
                    cell.valueLabel.text = "\(notcaseCount)명"
                }
            default:
                break
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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

