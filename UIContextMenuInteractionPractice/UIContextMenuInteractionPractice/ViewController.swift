//
//  ViewController.swift
//  UIContextMenuInteractionPractice
//
//  Created by Insu on 2023/07/13.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {

    
    // MARK: - Properties
    
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 75
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5

        let contextMenuInteraction = UIContextMenuInteraction(delegate: self)
        $0.addInteraction(contextMenuInteraction)
        
        $0.isUserInteractionEnabled = true
        
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
        
    }


}

// MARK: - UIContextMenuInteractionDelegate

extension ViewController: UIContextMenuInteractionDelegate {
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let photoLibraryAction = UIAction(title: "사진 보관함", image: UIImage(systemName: "photo")) { _ in
                print("사진 보관함 클릭됨")
            }
            
            let capturePhotoAction = UIAction(title: "사진 찍기", image: UIImage(systemName: "camera")) { _ in
                print("사진 찍기 클릭됨")
            }
            
            return UIMenu(title: "", children: [photoLibraryAction, capturePhotoAction])
        }
    }
    
    
    
}

