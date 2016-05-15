//
//  ViewController.swift
//  DatePickerSample
//
//  Created by 张楚昭 on 16/5/9.
//  Copyright © 2016年 tianxing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //使用时间选择器视图实现时间的选择
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func onclick(sender: AnyObject) {
        let theDate = self.datePicker.date
        //返回基于本地化的日期信息
        let desc = theDate.descriptionWithLocale(NSLocale.currentLocale())
        NSLog("the date picked is:%@",desc)
        //设置日期显示格式
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        NSLog("the date formate is:%@",dateFormatter.stringFromDate(theDate))
        self.label.text = dateFormatter.stringFromDate(theDate)
    }
    
    //使用普通选择器视图实现省份和响应城市名的选择
    var pickerData: NSDictionary!
    var pickerProvincesData: NSArray!
    var pickerCitiesData: NSArray!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var provinceAndCityLabel: UILabel!
    
    @IBAction func provinceAndCityBtnClick(sender: AnyObject) {
        let row1 = self.pickerView.selectedRowInComponent(0)
        let row2 = self.pickerView.selectedRowInComponent(1)
        let province = self.pickerProvincesData[row1] as! String
        let city = self.pickerCitiesData[row2] as! String
        let title = NSString(format: "%@ %@市", province, city)
        self.provinceAndCityLabel.text = title as String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化 pickerview 界面
        let plistPath = NSBundle.mainBundle().pathForResource("provinces_cities", ofType: "plist")
        self.pickerData = NSDictionary(contentsOfFile: plistPath!)
        self.pickerProvincesData = self.pickerData.allKeys
        // 默认取出第一个省的所有市的数据
        let selectedProvince = self.pickerProvincesData[0] as? NSString
        self.pickerCitiesData = self.pickerData[selectedProvince!] as? NSArray
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    //UIPickerViewDataSource
    //选择器中拨轮的数目
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    //选择器中某个拨轮的行数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return self.pickerProvincesData.count
        }else{
            return self.pickerCitiesData.count
        }
    }
    //UIPickerViewDelegate
    //为选择器中某个拨轮的行提供显示数据
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return self.pickerProvincesData[row] as? String
        }else{
            return self.pickerCitiesData[row] as? String
        }
    }
    //选中选择器的某个拨轮中的某行时调用
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let selectdProvince = self.pickerProvincesData[row] as? String
            self.pickerCitiesData = self.pickerData[selectdProvince!] as! NSArray
            self.pickerView.reloadComponent(1)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

