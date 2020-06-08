//
//  FirstViewController.swift
//  AvoidCoronaApp
//
//  Created by Azderica on 2020/06/02.
//  Copyright © 2020 Azderica. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var KoreaCOVIDTableView: UITableView!
    
    var jsondata: [String: Any]!
    var datacount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //테이블 뷰 delegate 설정
        KoreaCOVIDTableView.dataSource = self
        KoreaCOVIDTableView.delegate = self
        //Label layout 설정
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        //COVID 데이터 JSON 파싱
        getData {
            let updateTime = (self.jsondata["updateTime"] as! String).components(separatedBy: "(")
            self.titleLabel.text = updateTime[0]
            self.dateLabel.text = updateTime[1].components(separatedBy: ")")[0]
            print("reload Data")
            print(self.datacount)
            self.KoreaCOVIDTableView.reloadData()
        }
    }
    
    func getData(success: @escaping ()->()) {
        do {
            let url = URL(string: "http://api.corona-19.kr/korea")
            if let data = try String(contentsOf: url!).data(using: .utf8) {
                jsondata = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                datacount = jsondata.count
                print(jsondata)
                success()
            }
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KoreaCOVIDTableView.dequeueReusableCell(withIdentifier: "COVIDCell", for: indexPath) as! COVIDCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "누적 확진자 수"
            cell.valueLabel.text = jsondata["TotalCase"] as? String
            break
        case 1:
            cell.titleLabel.text = "누적 완치자 수"
            cell.valueLabel.text = jsondata["TotalRecovered"] as? String
            break
        case 2:
            cell.titleLabel.text = "누적 사망자 수"
            cell.valueLabel.text = jsondata["TotalDeath"] as? String
            break
        case 3:
            cell.titleLabel.text = "격리 환자 수"
            cell.valueLabel.text = jsondata["NowCase"] as? String
            break
        default:
            break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
