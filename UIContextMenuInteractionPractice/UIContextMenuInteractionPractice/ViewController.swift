

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
    
    private lazy var heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .black
        
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
        view.addSubview(heartButton)
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(60)
            $0.centerX.equalTo(imageView)
        }
        
    }


}

// MARK: - UIContextMenuInteractionDelegate

extension ViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        if interaction.view === heartButton {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
                let likeAction = UIAction(title: "좋아요", image: UIImage(systemName: "heart")) { _ in
                    print("좋아요 클릭됨")
                }

                return UIMenu(title: "반응 남기기", children: [likeAction])
            }
        } else {
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
}

