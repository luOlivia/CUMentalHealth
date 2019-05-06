//
//  locationVC.swift
//  mental_health_proj
//
//  Created by Jiehong Lin on 4/25/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//
import MapKit
import CoreLocation
import UIKit

class locationVC: UIViewController {
    
    var name: String
    var phone: String
    var image: String
    var indexPath: IndexPath
    var hours: String
    var hourText: UILabel!
    var address: String
    var website: String
    var map: MKMapView
    var coords: [Double]
    var showPhone: Bool
    
    var titleText: UILabel!
    var hourLabel: UILabel!
    var descripHours: UITextView!
    var addressLabel: UILabel!
    var phoneButton: UIButton!
    var webButton: UIButton!
    
    init(name: String, phone: String, image: String, hours: String, indexPath: IndexPath, address:String, website:String, coords:[Double]) {
        self.name = name
        self.indexPath = indexPath
        self.phone = phone
        self.image = image
        self.hours = hours
        self.address = address
        self.website = website
        self.map = MKMapView()
        self.coords = coords
        self.showPhone = true
        if (phone.contains("n") || phone.contains("N")){
            self.showPhone = false
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .white
        map = MKMapView()
        map.frame = CGRect(x: CGFloat(0), y: CGFloat(8), width: CGFloat(view.frame.size.width), height: CGFloat(454))
        print(coords)
        var location = CLLocationCoordinate2DMake(42.4456813,-76.4876695)
        if (coords != []){
            location = CLLocationCoordinate2DMake(coords[0], coords[1])
        }
        let span = MKCoordinateSpan()
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        annotation.subtitle = address
        map.addAnnotation(annotation)
        view.addSubview(map)
        
        descripHours = UITextView()
        descripHours.translatesAutoresizingMaskIntoConstraints = false
        descripHours.font = UIFont.systemFont(ofSize: 18)
        descripHours.text = "\(hours)";
        descripHours.isEditable = false
        view.addSubview(descripHours)
        
        addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = UIFont.systemFont(ofSize: 18)
        addressLabel.text = "\(address)"
        view.addSubview(addressLabel)
        
        titleText = UILabel()
        titleText.numberOfLines = 0
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.font = UIFont.systemFont(ofSize: 20)
        titleText.font = UIFont.boldSystemFont(ofSize: titleText.font.pointSize)
        titleText.text = "\(name)"
        view.addSubview(titleText)
        
        hourText = UILabel()
        hourText.translatesAutoresizingMaskIntoConstraints = false
        hourText.font = UIFont.systemFont(ofSize: 20)
        hourText.font = UIFont.boldSystemFont(ofSize: titleText.font.pointSize)
        hourText.text = "Hours:"
        view.addSubview(hourText)
        
        webButton = UIButton()
        webButton.translatesAutoresizingMaskIntoConstraints = false
        webButton.layer.borderWidth = 2.0
        let red = UIColor(red: 1, green: 0.6, blue: 0.6, alpha: 1.0)
        webButton.layer.borderColor = red.cgColor
        webButton.layer.cornerRadius = 10
        webButton.setTitleColor(red, for: .normal)
        webButton.setTitle("Visit Website", for: .normal)
        webButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        view.addSubview(webButton)
        
        if (showPhone == true){
            phoneButton = UIButton()
            phoneButton.translatesAutoresizingMaskIntoConstraints = false
            phoneButton.layer.borderWidth = 2.0
            phoneButton.layer.borderColor = red.cgColor
            phoneButton.layer.cornerRadius = 10
            phoneButton.setTitleColor(red, for: .normal)
            phoneButton.setTitle("Call Phone", for: .normal)
            phoneButton.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
            view.addSubview(phoneButton)
        }
        
        let shape = UIView(frame: CGRect(x: (0), y: (458), width: (view.frame.size.width), height: (8)))
        shape.backgroundColor = UIColor(red:1, green: 0.85, blue: 0.85, alpha: 1)
        let shape2 = UIView(frame: CGRect(x: (0), y: (528), width: (view.frame.size.width), height: (8)))
        shape2.backgroundColor = UIColor(red:1, green: 0.85, blue: 0.85, alpha: 1)
        let shape3 = UIView(frame: CGRect(x: (0), y: (584), width: (view.frame.size.width), height: (8)))
        shape3.backgroundColor = UIColor(red:1, green: 0.85, blue: 0.85, alpha: 1)
        view.addSubview(shape2)
        view.addSubview(shape)
        view.addSubview(shape3)

        
        setupConstraints()
        
        
    }
    
    func setupConstraints(){
//        NSLayoutConstraint.activate([
//            img.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 8),
//            img.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: 128),
//            img.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
//            img.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4)
//            ])
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 454),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 10),
            titleText.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: 38),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 0),
            addressLabel.bottomAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
            webButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 24),
            webButton.bottomAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 56),
            webButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            webButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 128)
            ])
        if (showPhone == true){
            NSLayoutConstraint.activate([
                phoneButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 24),
                phoneButton.bottomAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 56),
                phoneButton.leadingAnchor.constraint(equalTo: webButton.trailingAnchor, constant: 8),
                phoneButton.trailingAnchor.constraint(equalTo: webButton.trailingAnchor, constant: 128)
                ])
        }
        NSLayoutConstraint.activate([
            hourText.topAnchor.constraint(equalTo: webButton.bottomAnchor, constant: 24),
            hourText.bottomAnchor.constraint(equalTo: webButton.bottomAnchor, constant: 48),
            hourText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            hourText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
        NSLayoutConstraint.activate([
            descripHours.topAnchor.constraint(equalTo: hourText.bottomAnchor, constant: -4),
            descripHours.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descripHours.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            descripHours.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
        //        NSLayoutConstraint.activate([
        //            addressText.topAnchor.constraint(equalTo: descripHours.topAnchor, constant: 180),
        //            addressText.bottomAnchor.constraint(equalTo: descripHours.topAnchor, constant: 210),
        //            addressText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
        //            addressText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        //            ])
        //        NSLayoutConstraint.activate([
        //            websiteText.topAnchor.constraint(equalTo: addressText.topAnchor, constant: 32),
        //            websiteText.bottomAnchor.constraint(equalTo: addressText.topAnchor, constant: 48),
        //            websiteText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
        //            websiteText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        //            ])
    }
    
    @objc func openWebsite(_ target: UIButton){
        print("buttonclicked")
        if let urlcomp = URL(string: "\(website)") {
            UIApplication.shared.open(urlcomp)
        }
    }
    
    @objc func callPhone(_ target: UIButton){
        print("button2clicked")
        if let url = URL(string: "telprompt:\(phone)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }
}

