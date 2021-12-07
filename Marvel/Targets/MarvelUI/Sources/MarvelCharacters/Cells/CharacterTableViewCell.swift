//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 05/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
  // MARK: - Private properties
  private var characterImageView = UIImageView()
  private var characterNameLabel = UILabel()

  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

  override func prepareForReuse() {
    characterImageView.image = nil
    characterNameLabel.text = ""
  }

  // MARK: - Methods
  func configure(name: String, imageURL: String) {
    setupImageView(imageURL: imageURL)
    setupNameLabel(name: name)
    setupConstraints()
  }

  // MARK: - Private methods
  private func setupImageView(imageURL: String) {
    characterImageView.translatesAutoresizingMaskIntoConstraints = false
    characterImageView.backgroundColor = .clear
    characterImageView.image = UIImage(systemName: "photo")
    characterImageView.contentMode = .scaleToFill
    characterImageView.tintColor = .white
    guard let url = URL(string: imageURL) else { return }
    DispatchQueue.main.async {
      self.characterImageView.load(url: url)
    }
    contentView.addSubview(characterImageView)
  }

  private func setupNameLabel(name: String) {
    characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
    characterNameLabel.textColor = .white
    characterNameLabel.backgroundColor = .clear
    characterNameLabel.backgroundColor = .clear
    characterNameLabel.textAlignment = .center
    characterNameLabel.font = .boldSystemFont(ofSize: 25)
    characterNameLabel.text = name
    contentView.addSubview(characterNameLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // characterImageView
      characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      characterImageView.heightAnchor.constraint(equalToConstant: 220),
      characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      // characterNameLabel
      characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
      characterNameLabel.heightAnchor.constraint(equalToConstant: 50),
      characterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
}
