//
//  MemberItemCell.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/16/24.
//

import UIKit

final class MemberItemCell: UITableViewCell {
    
    static let cellIdentifier = "memberItemCell"
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NAME"
        label.textColor = .black
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "JOB (AGE)"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .yellow
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.size.equalTo(70)
        }
        
        contentView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing)
            make.verticalEdges.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(infoLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: - 프리뷰 canvas 세팅
import SwiftUI

struct MemberListViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MemberListViewController
    func makeUIViewController(context: Context) -> MemberListViewController {
        return MemberListViewController()
    }
    func updateUIViewController(_ uiViewController: MemberListViewController, context: Context) {}
}
@available(iOS 13.0.0, *)
struct MemberListViewwPreview: PreviewProvider {
    static var previews: some View {
        MemberListViewControllerRepresentable()
    }
}
