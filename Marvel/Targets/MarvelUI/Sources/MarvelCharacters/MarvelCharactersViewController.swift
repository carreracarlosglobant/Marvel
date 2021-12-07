//
//  MarvelCharactersViewController.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import UIKit

class MarvelCharactersViewController: UIViewController {
  // MARK: - Private properties
  private let presenter: MarvelCharactersPresenter
  private var tableView = UITableView()
  private var activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
  private var messageErrorLabel = UILabel()
  private var retryButton = UIButton()

  private enum Constants {
    static let imageItemTableViewCellheight = 270.0
    static let characterTableViewCellId = "characterTableViewCell"
  }

  // MARK: - Inits
  init(presenter: MarvelCharactersPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life cycle
  override func viewDidLoad() {
    setupViewController()
    setupTableView()
    setupRetryButton()
    setupConstraints()
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.hideNavigationBar()
  }

  // MARK: - Private methods
  private func setupViewController() {
    self.view.backgroundColor = .black
    self.title = self.presenter.model.title
    self.navigationController?.navigationBar.accessibilityIdentifier = self.presenter.model.title
    self.presenter.delegate = self
    presenter.getMarvelCHaracters()
  }

  private func setupTableView() {
    messageErrorLabel.text = presenter.model.messageErrorDefaultTitle
    messageErrorLabel.textColor = .white
    messageErrorLabel.textAlignment = .center
    messageErrorLabel.isHidden = true
    messageErrorLabel.numberOfLines = 0
    messageErrorLabel.translatesAutoresizingMaskIntoConstraints = false
    activityView.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.delegate = self
    tableView.dataSource = self
    tableView.accessibilityIdentifier = "marvelCharacters"
    tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: Constants.characterTableViewCellId)
    self.view.addSubview(tableView)
    tableView.addSubview(messageErrorLabel)
    tableView.addSubview(activityView)
  }

  private func setupRetryButton() {
    retryButton.translatesAutoresizingMaskIntoConstraints = false
    retryButton.isHidden = true
    retryButton.setTitleColor(.black, for: .normal)
    retryButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
    retryButton.titleLabel?.textAlignment = .center
    retryButton.backgroundColor = .white
    retryButton.clipsToBounds = true
    retryButton.layer.cornerRadius = 10
    retryButton.addTarget(self, action: #selector(retryGetMarvelCharacters), for: .touchUpInside)
    retryButton.setTitle(self.presenter.model.retryButtonTitle, for: .normal)
    self.tableView.addSubview(retryButton)
  }

  @objc private func retryGetMarvelCharacters() {
    presenter.getMarvelCHaracters()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // Table view
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
      // Message label
      messageErrorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      messageErrorLabel.heightAnchor.constraint(equalToConstant: 120),
      messageErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
      messageErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
      // Retry button
      retryButton.topAnchor.constraint(equalTo: messageErrorLabel.bottomAnchor, constant: 10),
      retryButton.heightAnchor.constraint(equalToConstant: 40),
      retryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 45),
      retryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
      // Activity view
      activityView.widthAnchor.constraint(equalToConstant: 50),
      activityView.heightAnchor.constraint(equalToConstant: 50),
      activityView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      activityView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
    ])
  }
}

// MARK: - UITableViewDelegate
extension MarvelCharactersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if presenter.characters.indices.contains(indexPath.row) {
      presenter.goToCharacterDetail(characterId: presenter.characters[indexPath.row].id)
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.imageItemTableViewCellheight
  }
}

// MARK: - UITableViewDataSource
extension MarvelCharactersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.characters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.characterTableViewCellId) as? CharacterTableViewCell else {
      return UITableViewCell()
    }
    if presenter.characters.indices.contains(indexPath.row) {
      cell.configure(name: presenter.characters[indexPath.row].name,
                     imageURL: "\(presenter.characters[indexPath.row].thumbnail.path).\(presenter.characters[indexPath.row].thumbnail.extensionString)")
    }
    cell.accessibilityIdentifier = "\(Constants.characterTableViewCellId)\(indexPath.row)"
    cell.selectionStyle = .none
    cell.backgroundColor = .clear
    return cell
  }
}

// MARK: - MarvelCharactersPresenterDelegate
extension MarvelCharactersViewController: MarvelCharactersPresenterDelegate {
  func updateContent() {
    DispatchQueue.main.async {
      self.messageErrorLabel.isHidden = true
      self.retryButton.isHidden = true
      self.tableView.reloadData()
    }
  }

  func showMessageError(message: String) {
    DispatchQueue.main.async {
      self.retryButton.isHidden = false
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
