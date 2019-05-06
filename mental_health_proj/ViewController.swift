//
//  ViewController.swift
//  mental_health_proj
//
//  Created by Jiehong Lin on 4/25/19.
//  Copyright © 2019 Mitchell Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var tableView: UITableView!
    var locations: [Location]! = []
    var activeLocations: [Location] = []
    let reuseIdentifier = "songCellReuse"
    var containerView: UIView!
    
    let filterCollectionViewHeight: CGFloat = 50
    let padding: CGFloat = 20
    let filterReuseIdentifier = "FilterCollectionViewCell"
    
    var filters: [Filter] = []
    //var activeFavoriteFilter: Set<Favorite> = []
    var activeTypeFilter: Set<Type> = []
    var activeTimeFilter: Set<Time> = []
    var activeLocationFilter: Set<LocationType> = []
    
    var filterCollectionView: UICollectionView!
    
    var searchBar: UISearchBar!
    var currentSearchText: String = ""
    var placeholderText: String = "Type here!"
    
//    var nav: UINavigationBar!
    
    override func viewDidLoad() {
        let white = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = white
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .automatic
        super.viewDidLoad()
        get()
        title = "CU Mental Health"
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor(red:1, green: 0.85, blue: 0.85, alpha: 1)
        
//        let locale1 = Location(name: "Crisis Counseling and Intervention", image: "cornh", phone: "(607)255-5155", hours: "Monday-Tuesday:  8:30 am – 7:00 pm\nWednesday:  10:00 am – 7:00 pm\nThursday:  8:30 am – 7:00 pm\nFriday: 8:30 am – 5:00 pm\nSaturday: 10:00 am – 4:00 pm\nSunday: Closed", address: "110 Ho Plaza, Ithaca, NY 14853", website: "http://www.health.cornell.edu", types: [.emergency, .general], times: [.morning, .afternoon, .evening], locations: [.central], coords: [42.445760,-76.485360])
//        let locale2 = Location(name: "Empathy, Assistance and Referral Service", image: "ears", phone:"(607)255-3277", hours:"Sunday - Thursday  3-10:30 pm\nFriday  3-10 pm\nSaturday  6-10 pm", address: "213 Willard Straight Hall", website: "http://www.orgsync.rso.cornell.edu/org/ears", types: [.ears], times: [.afternoon, .evening], locations: [.central], coords: [42.446491,-76.485420])
//        let locale3 = Location(name: "'Coming to your Senses' Mindfulness Series", image: "mindfulness", phone: "n/a", hours: "Tuesday 2:00 p.m. to 2:30 p.m.", address: "110 Ho Plaza, Ithaca, NY 14853, Level 1 Tang Conference Center", website: "http://www.health.cornell.edu/services/counseling-psychiatry/group-counseling", types: [.grouptherapy], times: [.afternoon], locations: [.central], coords: [42.445760,-76.485360])
//        let locale4 = Location(name: "Faculty & Staff Assistance Program", image: "fsap", phone: "(607)255-2673", hours: "Monday–Friday, 8:30 am – 5:00 pm\n(11:00 am start on Wednesdays)", address: "312 College Avenue Suite A Ithaca, NY 14850", website: "http://www.fsap.cornell.edu", types: [.general, .letstalk], times: [.morning, .afternoon], locations: [.offcampus], coords: [42.441010,-76.485760])
        //locations = [locale1, locale2, locale3, locale4]
        activeLocations = locations
        filters = Setup.getFilters()
        
        searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsSearchResultsButton = true
        searchBar.showsCancelButton = false
        searchBar.placeholder = placeholderText
        searchBar.tintColor = UIColor(red:1, green: 0.5, blue:0.5, alpha: 1)
        searchBar.barTintColor = UIColor(red:1, green: 0.5, blue: 0.5, alpha: 1)
        searchBar.backgroundColor = UIColor(red:1, green: 0.5, blue: 0.5, alpha: 1)
        searchBar.text = currentSearchText
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.allowsMultipleSelection = true
        view.addSubview(filterCollectionView)
//        nav = UINavigationBar.appearance()
//        nav.tintColor = UIColor(red:1, green: 0.3, blue: 0.3, alpha: 1)
//        nav.barTintColor = UIColor(red:1, green: 0.3, blue: 0.3, alpha: 1)
//        view.addSubview(nav)
        
        for filter in filters {
            changeFilter(filter: filter, shouldRemove: false)
        }
        
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        tableView.backgroundColor = UIColor(red:1, green: 0.85, blue: 0.85, alpha: 1)
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.register(locationCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            filterCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            //            filterCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            filterCollectionView.heightAnchor.constraint(equalToConstant: filterCollectionViewHeight)])
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 4),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
            ])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (currentSearchText.count < 3) {
            searchBar.prompt = "Please enter more text!"
        }
        else if (currentSearchText.lowercased() == "clear") {
            for filter in filters {
                changeFilter(filter: filter, shouldRemove: false)
                tableView.reloadData()
            }
        }
        else {
            //print("a")
            for filter in filters {
                //print("b")
                //print(filter.filterTitle)
                //print(filter.filterTitle.lowercased())
                if (currentSearchText.lowercased().contains(filter.filterTitle.lowercased()) || filter.filterTitle.lowercased().contains(currentSearchText.lowercased())) {
                    //print(filter.filterTitle + " passes")
                }
                else {
                    //print(filter.filterTitle + " should be removed")
                    changeFilter(filter: filter, shouldRemove: true)
                    tableView.reloadData()
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        if (activeLocations.count < locations.count) {
            self.searchBar.prompt = "Type clear and press search to clear filters!"
        }
        else {
            self.searchBar.prompt = ""
        }
        self.currentSearchText = ""
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        let filter = filters[indexPath.item]
        cell.setup(with: filter.filterTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) is FilterCollectionViewCell else { return }
        let currentFilter = filters[indexPath.item]
        changeFilter(filter: currentFilter, shouldRemove: false)
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) is FilterCollectionViewCell else { return }
        let currentFilter = filters[indexPath.item]
        changeFilter(filter: currentFilter, shouldRemove: true)
        tableView.reloadData()
    }

    func changeFilter(filter: Filter, shouldRemove: Bool = false) {
        if let type = filter as? Type {
            if shouldRemove {
                activeTypeFilter.remove(type)
            } else {
                activeTypeFilter.insert(type)
            }
        }
        if let time = filter as? Time {
            if shouldRemove {
                activeTimeFilter.remove(time)
            } else {
                activeTimeFilter.insert(time)
            }
        }
        if let location = filter as? LocationType {
            if shouldRemove {
                activeLocationFilter.remove(location)
            } else {
                activeLocationFilter.insert(location)
            }
        }
    filterResources()
    }
    
    func filterResources() {
        if activeTypeFilter.count == 0 && activeTimeFilter.count == 0 && activeLocationFilter.count == 0 {
            activeLocations = locations
            return
        }
        activeLocations = locations.filter({ r in
            var typeFilteredOut = activeTypeFilter.count > 0
            if activeTypeFilter.count > 0 {
                for type in r.types {
                    if activeTypeFilter.contains(type) {
                        typeFilteredOut = false
                    }
                }
            }
            
            var timeFilteredOut = activeTimeFilter.count > 0
            if activeTimeFilter.count > 0 {
                for time in r.times {
                    if activeTimeFilter.contains(time) {
                        timeFilteredOut = false
                    }
                }
            }
            
            var locationFilteredOut = activeLocationFilter.count > 0
            if activeLocationFilter.count > 0 {
                for location in r.locations {
                    if activeLocationFilter.contains(location) {
                        locationFilteredOut = false
                    }
                }
            }
            return !(typeFilteredOut || timeFilteredOut || locationFilteredOut)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func presenteditViewController(name1:String, phone1:String, image1:String, indexPath1: IndexPath, hours1:String, address1:String, website1:String, coords1: [Double]) {
        //        let ylocationVC = locationVC(name:name1, phone:phone1, image:image1, indexPath: indexPath1)
        //        //ylocationVC.delegate = self
        //        present(ylocationVC, animated: true, completion: nil)
        let navViewController = locationVC(name:name1, phone:phone1, image:image1, hours:hours1, indexPath: indexPath1, address: address1, website: website1, coords: coords1)
        navigationController?.pushViewController(navViewController, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! locationCell
        let locate = activeLocations[indexPath.row]
        cell.configure(for: locate)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 20
        cell.backgroundColor = UIColor(red:1, green: 0.95, blue: 0.95, alpha: 1)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 192
        return height
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let locate = activeLocations[indexPath.row]
        presenteditViewController(name1: locate.name, phone1: locate.phone, image1: locate.image, indexPath1: indexPath, hours1: locate.hours, address1: locate.address, website1: locate.website, coords1: locate.coords)
    }
    
    func tableView(_ tableView: UITableView,didDeselectRowAt indexPath: IndexPath) {
    }
//    func get(){
//        NetworkManager.getInfo()
//    }
    func get() {
        NetworkManager.getInfo { locationArray in
            for locationstructs in locationArray {
//                var coord = locationstructs.coordinates.split(separator: ",")
//                for var indiv in coord {
//                    var indivcoord = String(indiv)
//                    if indivcoord.contains("["){
//                        indivcoord.removeFirst()
//                    }
//                    if indivcoord.contains("]"){
//                        indivcoord.removeLast()
//                    }
//                    indivcoord = Float(indiv)
//                }
                //var coords = []
                var fixedcoords: [Double] = []
                let coords = locationstructs.coordinates.split(separator: ",")
                for coord in coords {

                    fixedcoords.append(Double(coord) ?? 1)
                }
                var fixedtimes: [Time] = []
                let times = locationstructs.times.split(separator: ",")
                for time in times {
                    //print(time)
                    if (time == (".morning") || time == " .morning"){
                        fixedtimes.append(.morning)
                    }
                    if (time == (".afternoon") || time == " .afternoon"){
                        fixedtimes.append(.afternoon)
                    }
                    if (time == (".evening") || time == " .evening"){
                        fixedtimes.append(.evening)
                    }
                }
                var fixedtypes: [Type] = []
                //print(locationstructs.types)
                if (locationstructs.types.contains("grou")){
                    fixedtypes.append(.group)
                }
                if (locationstructs.types.contains("emerg")){
                    fixedtypes.append(.emergency)
                }
                if (locationstructs.types.contains("lets")){
                    fixedtypes.append(.letstalk)
                }
                if (locationstructs.types.contains("ears")){
                    fixedtypes.append(.ears)
                }
                var fixedlocations: [LocationType] = []
                let locations = locationstructs.locations.split(separator: ",")
                for location in locations {
                    
                    if (location.contains("nor")){
                        fixedlocations.append(.north)
                    }
                    if (location.contains("cent")){
                        fixedlocations.append(.central)
                    }
                }
                let replace = locationstructs.hours.replacingOccurrences(of: "\\n", with: "\n")
                let current = Location(name: locationstructs.name, image: locationstructs.img, phone: locationstructs.phone, hours: replace, address: locationstructs.address, website: locationstructs.website, types: fixedtypes, times: fixedtimes, locations: fixedlocations, coords: fixedcoords)
                //print(current.times)
                print(current.hours)
                print(locationstructs.img)
                self.locations.append(current)
            }
            DispatchQueue.main.async {
                self.activeLocations = self.locations
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
        currentSearchText = searchText
    }
}
