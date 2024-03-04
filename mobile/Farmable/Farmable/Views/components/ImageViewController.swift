//
//  ImageViewController.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/3/24.
//

import Foundation

import UIKit
import SwiftUI

class ImageViewController: UIViewController {
    
   
    var imageView: UIImageView!
    var messageLabel: UILabel!
    
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAndDisplayImage(imageName: imageName)
    }
    
    private func setupUI() {
        imageView = UIImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func fetchAndDisplayImage(imageName:String) {
        let request = ImageRequest()
        request.getImg(imageName: imageName) { [weak self] result in
            print("see request result", result)
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.imageView.image = image
                    self?.messageLabel.isHidden = true
                case .failure:
                    self?.imageView.isHidden = true
                    self?.messageLabel.text = "Image does not exist, tap to add image"
                }
            }
        }
    }
}


struct ImageViewControllerRepresentable: UIViewControllerRepresentable {
//    typealias UIViewControllerType = ImageViewController
    
    var imageName: String

    func makeUIViewController(context: Context) -> ImageViewController {
       
        return ImageViewController(imageName: imageName)
    }

    func updateUIViewController(_ uiViewController: ImageViewController, context: Context) {
    }
}
