//
//  ListViewController.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ListViewModel?

    private var myView: ListView {
            // swiftlint:disable force_cast
            return view as! ListView
            // swiftlint:enable force_cast
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = ListView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "List"

        // When viewModel is initialized, the request is made.
        let listViewModel = ListViewModel()

        viewModel = listViewModel
        myView.viewModel = viewModel
    }
}


