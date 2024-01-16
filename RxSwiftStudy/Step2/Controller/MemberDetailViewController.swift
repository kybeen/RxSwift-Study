//
//  MemberDetailViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/8/24.
//

import UIKit

import RxCocoa
import RxSwift

final class MemberDetailViewController: UIViewController {
    
    let memberDetailView = MemberDetailView()
    
    var data: Member!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(memberDetailView)
        memberDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        setData(data)
    }
    
    func setData(_ data: Member) {
        loadImage(from: data.avatar)
            .observe(on: MainScheduler.instance)
            .bind(to: memberDetailView.avatarImageView.rx.image)
            .disposed(by: disposeBag)
        memberDetailView.idLabel.text = "#\(data.id)"
        memberDetailView.nameLabel.text = data.name
        memberDetailView.jobLabel.text = data.job
        memberDetailView.ageLabel.text = "(\(data.age))"
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
