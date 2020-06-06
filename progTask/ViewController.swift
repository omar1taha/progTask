//
//  ViewController.swift
//  progTask
//
//  Created by Apple on 6/6/20.
//  Copyright © 2020 taj. All rights reserved.
//

import UIKit
import Moya
import NVActivityIndicatorView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var actIndicator: NVActivityIndicatorView!
    
    var productsArr : [product] = []
    
    var response : productResponse?
    
    @IBOutlet weak var prodcutTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //register the xib of cell in tableView
        let nib = UINib.init(nibName: String(describing: productTableViewCell.self), bundle: nil)
        self.prodcutTableView.register(nib, forCellReuseIdentifier: "productCell")

        self.prodcutTableView.delegate = self
        self.prodcutTableView.dataSource = self
        
        //call the api to get the data for the first time
        self.fetchData(urlToCall: "http://www.mocky.io/v2/5eda6417330000650079ebe3?mocky-delay=3000ms", isAppend: false)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func fetchData(urlToCall: String, isAppend: Bool){
        //generic function that access the moya abstract class with a url of api to call and isAppend which is a boolean used to check for pagination
        
        self.actIndicator.startAnimating()
        
        let provider = MoyaProvider<tajService>()
       
        
        provider.request(.test(url: urlToCall)) { result in
            
            switch result {
            case let .success(moyaResponse):

                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                
                if statusCode == 200{
                    do {
                        try moyaResponse.filterSuccessfulStatusCodes()
                        //get JSON from response
                        let data = try moyaResponse.mapJSON()
                        print(data)
                        
                        do{
                            //parse json using decoder
                            self.response = try! JSONDecoder().decode(productResponse.self, from: moyaResponse.data)

                            print(self.response)
                            
                            if let products = self.response?.data?.data{
                                self.productsArr += products
                                if isAppend{
                                    self.productsArr += products
                                }else{
                                    self.productsArr = products
                                }
                            }
                            self.actIndicator.stopAnimating()

                            self.prodcutTableView.isHidden = false
                            self.prodcutTableView.reloadData()
                            
                        }catch let err{
                            print(err.localizedDescription)
                        }
                        
                    }
                    catch {
                        // show an error to your user
                    }
                    
                }else if statusCode == 401{
                    self.actIndicator.stopAnimating()

                    AlertViewer().showAlertView(withMessage: "Unautohrized Access", onController: self)
                    
                    //return back to login
                    
                }else{

                    //500 or other
                    self.actIndicator.stopAnimating()

                    AlertViewer().showAlertView(withMessage: "We encountered an error try again later", onController: self)

                }
                
            case let .failure(error):
                // TODO: handle the error == best. comment. ever.
                self.actIndicator.stopAnimating()

                AlertViewer().showAlertView(withMessage: error.localizedDescription, onController: self)
            }
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! productTableViewCell
        //binding views in tableview
        cell.productName.text = self.productsArr[indexPath.row].name_en
        cell.productArName.text = self.productsArr[indexPath.row].name_ar
        cell.productPrice.text = String(self.productsArr[indexPath.row].price ?? 0.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97.0
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
            //we reached the end of the vc and check if there is a next page
            if self.response?.data?.next_page_url != nil{
                //call fetch data func with the next page url and append is true to add the results to the existing array
                self.fetchData(urlToCall: self.response?.data?.next_page_url ?? "", isAppend: true)
            }
        }
    }

    

}

