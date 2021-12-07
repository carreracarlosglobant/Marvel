//
//  MarvelCharacterDetailViewController.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 05/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

class MarvelCharacterDetailViewController: UIViewController {
  // MARK: - Private properties
  private let presenter: MarvelCharacterDetailPresenter
  private var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
  private var characterImageView = UIImageView()
  private var messageErrorLabel = UILabel()
  private var descriptionLabel = UILabel()

  // MARK: - Inits
  init(presenter: MarvelCharacterDetailPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life cycle
  override func viewDidLoad() {
    setup()
    setupUI()
    setupConstraints()
    super.viewDidLoad()
  }

  // MARK: - Private methods
  private func setup() {
    self.view.backgroundColor = .black
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    presenter.delegate = self
    presenter.getMarvelCharacterDetail()
  }

  private func setupUI() {
    characterImageView.translatesAutoresizingMaskIntoConstraints = false
    activityView.translatesAutoresizingMaskIntoConstraints = false
    messageErrorLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.textColor = .white
    descriptionLabel.textAlignment = .center
    descriptionLabel.numberOfLines = 0
    messageErrorLabel.text = "Error getting Detail of Marvel Character"
    messageErrorLabel.textColor = .white
    messageErrorLabel.textAlignment = .center
    messageErrorLabel.isHidden = true
    characterImageView.backgroundColor = .clear
    characterImageView.accessibilityIdentifier = "characterImageView"
    characterImageView.image = UIImage(systemName: "photo")
    characterImageView.contentMode = .scaleAspectFit
    characterImageView.tintColor = .white
    self.view.addSubview(characterImageView)
    self.view.addSubview(descriptionLabel)
    self.view.addSubview(activityView)
    self.view.addSubview(messageErrorLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // characterImageView
      characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      characterImageView.heightAnchor.constraint(equalToConstant: view.frame.height*0.4),
      characterImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      characterImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      // messageLabel
      messageErrorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      messageErrorLabel.heightAnchor.constraint(equalToConstant: 120),
      messageErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      messageErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      // Activity view
      activityView.widthAnchor.constraint(equalToConstant: 50),
      activityView.heightAnchor.constraint(equalToConstant: 50),
      activityView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      activityView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      // Description Label
      descriptionLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
}

// MARK: - MarvelCharacterDetailPresenterDelegate
extension MarvelCharacterDetailViewController: MarvelCharacterDetailPresenterDelegate {
  func updateData() {
    DispatchQueue.main.async {
      self.messageErrorLabel.isHidden = true
      self.title = self.presenter.model?.title
      self.descriptionLabel.text = self.presenter.model?.description ?? "Description not available"
      self.characterImageView.contentMode = .scaleToFill
      guard let url = URL(string: self.presenter.model?.URLImage ?? "") else { return }
      DispatchQueue.main.async {
        self.characterImageView.load(url: url)
      }
    }
  }

  func showMessageError(message: String) {
    DispatchQueue.main.async {
      self.messageErrorLabel.isHidden = false
      self.messageErrorLabel.text = message
    }
  }

  func showActivityView() {
    DispatchQueue.main.async {
      self.activityView.isHidden = false
      self.activityView.startAnimating()
    }
  }

  func hideActivityView() {
    DispatchQueue.main.async {
      self.activityView.isHidden = true
      self.activityView.stopAnimating()
    }
  }
}

