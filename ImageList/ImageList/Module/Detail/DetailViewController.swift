//
//  DetailViewController.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties

    var viewModel: DetailViewModel?
    var imageInfo: ImageInfo

    private var myView: DetailView {
        // swiftlint:disable force_cast
        return view as! DetailView
        // swiftlint:enable force_cast
    }

    // MARK: - Init

    init(info: ImageInfo) {
        self.imageInfo = info
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        let myView = DetailView()
        view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let detailViewModel = DetailViewModel(info: self.imageInfo,
                                              delegate: myView)

        viewModel = detailViewModel
        myView.viewModel = viewModel
    }
}

