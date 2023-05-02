//
//  ContentView.swift
//  SessionTabBarUIVC
//
//  Created by Guru Mahan on 02/05/23.
//



import SwiftUI

struct SessionTabBarView: View {
  @ObservedObject var sessionVM = SessionTabBarUIVM()
    @State var itemsPadding: CGFloat = 8
    @State var itemsTopPadding: CGFloat = 15
    @State var itemsBottomPadding: CGFloat = 15
    @State var itemstextFontSize: CGFloat = 12
    @State var itemsImageSize: CGFloat = 30
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                itemsSelectedView.background(.green)
                HStack(spacing: 10) {
                    sessionTabButton
                        .padding(.top,itemsTopPadding)
                        .padding(.bottom,itemsBottomPadding)
                    allDocumentTabButton
                        .padding(.top,itemsTopPadding)
                        .padding(.bottom,itemsBottomPadding)
                    allActivitiesTabButton
                        .padding(.top,itemsTopPadding)
                        .padding(.bottom,itemsBottomPadding)
                    chatTabButton
                        .padding(.top,itemsTopPadding)
                        .padding(.bottom,itemsBottomPadding)
                }
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                   
            }
        }
    }
    @ViewBuilder var itemsSelectedView: some View {
        VStack{
            if sessionVM.selectedItemsIndex == 1 {
               
            }else if sessionVM.selectedItemsIndex == 2 {
                StoryboardViewController()
            }else if sessionVM.selectedItemsIndex == 3 {
                
            }else if sessionVM.selectedItemsIndex == 4 {
                
            }
            
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    @ViewBuilder var sessionTabButton: some View {
        VStack(spacing: 0) {
            Button {
                sessionVM.selectedItemsIndex = 1
            } label: {
                Image("icon_Lecture")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: itemsImageSize,height: itemsImageSize)
            }
            Text("Sessions")
                .lineLimit(0)
                .font(.system(size: itemstextFontSize))
        }.foregroundColor(sessionVM.selectedItemsIndex == 1 ? .white : .white.opacity(0.5))
            .padding(itemsPadding)
    }
    
    @ViewBuilder var allDocumentTabButton: some View {
        VStack(spacing: 0){
            Button {
                sessionVM.selectedItemsIndex = 2
            } label: {
                Image("icon_Documents")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: itemsImageSize,height: itemsImageSize)
            }
            Text("All Document")
                .lineLimit(0)
                .font(.system(size: itemstextFontSize))
        }.foregroundColor(sessionVM.selectedItemsIndex == 2 ? .white : .white.opacity(0.5))
            .padding(itemsPadding)
    }
    
    @ViewBuilder var allActivitiesTabButton: some View {
        VStack(spacing: 0) {
            Button {
                sessionVM.selectedItemsIndex = 3
            } label: {
                Image("icon_Activities")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: itemsImageSize,height: itemsImageSize)
            }
            Text("All Activities")
                .lineLimit(0)
                .font(.system(size: itemstextFontSize))
        }.foregroundColor(sessionVM.selectedItemsIndex == 3 ? .white : .white.opacity(0.5))
            .padding(itemsPadding)
    }
    
    @ViewBuilder var chatTabButton: some View {
        VStack(spacing: 0) {
            Button {
                sessionVM.selectedItemsIndex = 4
            } label: {
                Image("message-24px")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: itemsImageSize,height: itemsImageSize)
            }
            Text("Chat")
                .lineLimit(0)
                .font(.system(size: itemstextFontSize))
        }                    .foregroundColor(sessionVM.selectedItemsIndex == 4 ? .white : .white.opacity(0.5))
            .padding(itemsPadding)

    }
    
}

struct SessionTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        SessionTabBarView()
    }
}

class SessionTabBarUIVC:UITabBarController {
//    var programinfo: ProgramInfoModel = ProgramInfoModel()
//    var courseinfo: [String: Any] = [:]
    var swiftUIView: SessionTabBarView!
    private var hostController:UIHostingController<SessionTabBarView>?
//    private var activityIndicator = ActivityIndicator()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftUIView = SessionTabBarView()
//        swiftUIView = SessionDocumentView(documentVM: SessionDocumentUIVM(programInfo: programinfo, courseInfo: courseinfo))
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func setUpView() {
        self.view.layoutIfNeeded()
        hostController = UIHostingController(rootView: swiftUIView)
        addChild(hostController!)
        view.addSubview(hostController!.view)
        hostController?.didMove(toParent: self)
        setupContraints()
       // setupAction()
    }
//    private func setupAction() {
//        hostController?.rootView.documentVM.showActivityIndicator = {
//            self.showActivity()
//        }
//        hostController?.rootView.documentVM.hideActivityIndicator = {
//            self.hideActivity()
//        }
//        hostController?.rootView.onBackTap = {
//            self.onBack()
//        }
//    }
    private func setupContraints() {
        hostController?.view.translatesAutoresizingMaskIntoConstraints = false
        hostController?.view?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hostController?.view?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        hostController?.view?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostController?.view?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
//    func showActivity() {
//        self.activityIndicator.showActivityIndicator(uiView: self.view)
//    }
//    func hideActivity() {
//        self.activityIndicator.hideActivityIndicator()
//    }
    func onBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}




struct SessionViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = SessionDocumentVC

    func makeUIViewController(context: Context) -> SessionDocumentVC {
        return SessionDocumentVC()
    }
    
    func updateUIViewController(_ uiViewController: SessionDocumentVC, context: Context) {
    }
    
    
}


struct StoryboardViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) ->SessionDocumentVC {
        let storyboard = UIStoryboard(name: "Main",
              bundle: nil)
        let assetsListVC = storyboard.instantiateViewController(identifier:
              "SessionDocumentVC")  as! SessionDocumentVC
        return assetsListVC

    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
