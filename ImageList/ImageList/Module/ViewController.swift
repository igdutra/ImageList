//
//  ViewController.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageInfos: [ImageInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red


        let imageService = ImageServices()

        imageService.fetchImageInfo { (infos) in

            if let info = infos {
                print(info)
            } else {
                print("nao rolou")


            }
        }

    }

}



