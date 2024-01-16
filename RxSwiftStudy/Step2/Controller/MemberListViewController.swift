//
//  MemberListViewController.swift
//  RxSwiftStudy
//
//  Created by 김영빈 on 1/8/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

struct Member: Codable {
    let id: Int
    let name: String
    let avatar: String
    let job: String
    let age: Int
}

final class MemberListViewController: UIViewController {
    
    private let memberListView = MemberListView()
    
    var data: [Member] = []
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        loadMembers()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] members in
                self?.data = members
                //TODO: 테이블뷰 reloadData() 처리
            })
            .disposed(by: disposeBag)
        
        view.addSubview(memberListView)
        memberListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        memberListView.memberListTableView.register(MemberItemCell.self, forCellReuseIdentifier: MemberItemCell.cellIdentifier)
        memberListView.memberListTableView.dataSource = self
        memberListView.memberListTableView.delegate = self
    }
    
    
    private func loadMembers() -> Observable<[Member]> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: URL(string: MEMBER_LIST_URL)!) { data, _, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                guard let data = data,
                      let members = try? JSONDecoder().decode([Member].self, from: data) else {
                    emitter.onCompleted()
                    return
                }
                
                emitter.onNext(members)
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    //TODO: - DetailViewController로 이동 시 detailVC.data에 전달
}

extension MemberListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberItemCell.cellIdentifier, for: indexPath) as! MemberItemCell
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
