//
//  ClassExtensions.swift
//  TopMusicVideos
//
//  Created by Alexandre Cros on 10/03/16.
//  Copyright © 2016 Alex Cros. All rights reserved.
//

import UIKit

extension MusicVideoTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
}