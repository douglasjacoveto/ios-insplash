//
//  ViewController.swift
//  unsplash
//
//  Created by Douglas Jacoveto on 06/06/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var imageLoad: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didLoadImage(_ sender: Any) {
        
        let url = URL(string: "https://images.unsplash.com/photo-1622960748104-094380e1d892?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzc0NTR8MHwxfGFsbHx8fHx8fHx8fDE2MjI5ODU1MDI&ixlib=rb-1.2.1&q=80&w=1080")
        
        let processor = DownsamplingImageProcessor(size: imageLoad.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        
        imageLoad.contentMode = .scaleAspectFill

        imageLoad.kf.setImage(with: url, options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
    }
    
}

