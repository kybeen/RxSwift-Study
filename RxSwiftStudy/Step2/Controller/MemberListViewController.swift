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
                self?.memberListView.memberListTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        view.addSubview(memberListView)
        memberListView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
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
}

extension MemberListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberItemCell.cellIdentifier, for: indexPath) as! MemberItemCell
        let item = data[indexPath.row]
        cell.setData(item)
        return cell
    }
}

extension MemberListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memberDetailVC = MemberDetailViewController()
        let item = data[indexPath.row]
        memberDetailVC.data = item
        navigationController?.pushViewController(memberDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
