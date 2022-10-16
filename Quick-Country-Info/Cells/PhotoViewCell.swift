//
//  PhotoViewCell.swift
//  Quick-Country-Info
//
//  Created by yilmaz on 17.10.2022.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    
    private var currentPhotoID: String?
    private var imageDownloader = ImageDownloader()
    
    lazy var poster: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.systemTeal.cgColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        contentView.backgroundColor = UIColor(named: "Background")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    
    private func setLayout() {
        contentView.addSubview(poster)
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    override func prepareForReuse() {
        currentPhotoID = nil
        poster.backgroundColor = .clear
        poster.image = nil
        imageDownloader.cancel()
    }
    
    func configure(with photoUrl: String, showsUsername: Bool = true) {
        downloadImage(with: photoUrl)
    }
    
    func downloadImage(with urlStr: String) {
        //        guard let regularUrl = photo.urls[.regular] else { return }
        //
        //        let url = sizedImageURL(from: regularUrl)
        //
        //        let downloadPhotoID = photo.identifier
        
        let url = URL(string: urlStr)!
        
        imageDownloader.downloadPhoto(with: url, completion: { [weak self] (image, isCached) in
            //            guard let strongSelf = self, strongSelf.currentPhotoID == downloadPhotoID else { return }
            
            guard let self = self else { return }
            
            if isCached {
                self.poster.image = image
                print("got from cache")
            } else {
                UIView.transition(with: self, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    self.poster.image = image
                }, completion: nil)
            }
        })
    }
}

