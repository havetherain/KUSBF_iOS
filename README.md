<img src = "https://github.com/gichang-yang/kusbf_readme_resource/blob/master/512%20-%20Play%20Store.png" height=32/>  KUSBF 17/18 Season iOS 어플리케이션
====================================
<img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/App_Icon.png" height=200/> <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/intro.png" height=200/> <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/main_info.png" height=200/> <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/union_info.png" height=200/> <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/developer_info.png" height=200/>

개발자 : 김지우

Preview
-------
* 17/18 kusbf어플은 2018.1.22 기준 총 143명이 설치및 사용중인 어플리케이션(안드로이드 기준)이며,<br>
* 하루 서버 접속 인원은 평균 110명 정도 됩니다.<br>
* 앱은 MVC패턴으로 작성되었으며, 개발기간을 단축하기 위해 일부 MVC의 디자인적 요소는 배제하였습니다.<br>
* 모든 어플의 디자인은 안드로이드 개발자(양기창 - ykcha9@gmail.com)가 하였으며, Zeplin, Sketch를 사용하여 디자인 하였습니다.<br>

Detail
------
* Splash

  <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/intro.png" height=200/>
  
  * Model : SplashViewContrller의 모델에서는 네트워크에서 받아온 json을 "main_info"와 "kusbf_info"로 뿌리기 위한 데이터 가공처리를 하는 비즈니스 로직을 담습니다.
  
  * View : SplashViewContrller의 view 에서는 Controller에서 전송하는 user info 등록 여부에 따라 로그인 화면으로 가거나 / 받아온 json을 통하여 MainTabBarViewContoller로 이동하는 역할을 합니다.
  
  * Controller : Controller에서는 realm데이터 베이스상의 user info 등록 여부를 판별하여 등록된 유저가 있으면 Network에 fetch 요청을 보내고, 등록된 유저가 없을 시, view에 로그인 화면으로 화면을 이동하는 요청을 보냅니다.
  
* PersonInfoViewController (First ViewController of MainTabBarViewContoller)

  * main info

    <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/main_info.png" height=200/>
      
      * Model : main info 의 모델에서는 intro 에서 받아온 json("main_info")를 최종적으로 view에 뿌리기 위한 데이터 가공처리를 하는 비즈니스 로직을 담습니다.
      이때, 각 card의 데이터 뭉치 단위로 데이터를 움직입니다.
  
      * View : main info 의 view 에서는 받아온 main_info의 rawData를 Controller에 전송한 뒤,
      presenter에서 model을 활용하여 분류한 데이터들을 받아와서 각각의 view에 뿌려주어 표시합니다. 
  
      * Controller : Controller에서는 view에서 넘겨받은 rawData를 각각의 card view에서 필요한 데이터에 알맞게 Model을 활용하여 가공 및 분류한뒤, View에 뿌려줍니다.
      
  * kusbf info

    <img src = "https://github.com/weststar25/KUSBF_iOS/blob/master/ScreenShot/union_info.png" height=200/>  
      
      * Model : kusbf info 의 모델에서는 intro 에서 받아온 json("kusbf_info")를 최종적으로 연합 총 점수 card에 뿌리기 위한 데이터 가공처리 및 Top10 & UnivSort TableView에 데이터를 던지기 위한
      비즈니스 로직을 담습니다.
      이때, 역시 각 card의 데이터 뭉치 단위로 데이터를 움직입니다.
  
      * View : main info 의 view 에서는 받아온 kusbf_info의 rawData를 Controller에 전송한 뒤,
      Controller에서 model을 활용하여 분류한 데이터들을 받아와서 total score 에 뿌려주고, Top10 Labels, UnivSortTableView와 연결합니다. 
  
      * Controller : Controller에서는 view에서 넘겨받은 rawData를 각각의 Total info, TableView에 필요한 데이터에 알맞게 데이터를 분류및 Model을 활용하여 가공하여 
      view에 전달합니다.
        
사용 라이브러리 및 api
-----------------

  * <a href="https://github.com/realm/realm-cocoa">Realm</a>
  
  * <a href="https://github.com/Alamofire/Alamofire">Alamofire</a>
  
  * <a href="https://github.com/SwiftyJSON/SwiftyJSON">SwiftyJSON</a>
  
  * <a href="https://github.com/onevcat/Kingfisher">Kingfisher</a>
  

라이선스
------
Project is published under the MIT licence. Feel free to clone and modify repo as you want, but don'y forget to add reference to authors :)

(안드로이드 기준)
<a href="https://play.google.com/store/apps/details?id=com.notisnow.kusbf.warrior">kusbf전투력 측정기 PlayStore 이동</a>

<br><br><br>
