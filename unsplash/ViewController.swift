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
    
    fileprivate func setImage(linkImage: String) {
        let url = URL(string: linkImage)
        
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
    
    @IBAction func didLoadImage(_ sender: Any) {
        
        APIManager.fetchImages { (images) in
            print(images, images.count)
            let index = Int.random(in: 0..<10)
            self.setImage(linkImage: (images[index].urls.regular))
        }
        
//        APIManager.getAllImages { (images) in
//            print(images, images.count)
//            let index = Int.random(in: 0..<10)
//            self.setImage(linkImage: (images[index].urls.regular))
//        }
        
//        APIManager.getImage(imageId: "dli0gNKJmE8") { (image) in
//            print(image!)
//            self.setImage(linkImage: (image?.urls.regular)!)
//        }
    }
    
}

