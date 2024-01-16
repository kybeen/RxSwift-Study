//
//  MemberItemCell.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/16/24.
//

import UIKit

import RxCocoa
import RxSwift

final class MemberItemCell: UITableViewCell {
    
    static let cellIdentifier = "memberItemCell"
    var disposeBag = DisposeBag()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    lazy var jobAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "JOB (AGE)"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.size.equalTo(70)
        }
        
        contentView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing)
            make.verticalEdges.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(jobAgeLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
        jobAgeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
        }
    }
    
    func setData(_ data: Member) {
        loadImage(from: data.avatar)
            .observe(on: MainScheduler.instance)
            .bind(to: avatarImageView.rx.image)
            .disposed(by: disposeBag)
        avatarImageView.image = nil
        nameLabel.text = data.name
        jobAgeLabel.text = "\(data.job) (\(data.age))"
    }
    
    private func loadImage(from url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                guard let data = data,
                      let image = UIImage(data: data) else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }
                
                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
