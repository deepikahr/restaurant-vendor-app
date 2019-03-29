import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import '../../styles/styles.dart';
import '../widgets/avatar.dart';
import '../../services/auth.dart';
// CouponCard

class Settings extends StatefulWidget {
  static String tag = "Settings";
  




  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  // final String url = "https://swapi.co/api/people";
  List data =List();

 @override
  void initState(){
    super.initState();
    this.checkAuth();
  }

   void checkAuth() {
    AuthService.getUserInfo().then((onValue) {

      //  data =onValue;
      // print(data);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account", style: headerDefaultColor()),
        iconTheme: new IconThemeData(color: WHITE),
      ),
      body: 
      
      // new ListView.builder(
      //   itemCount: data == null ? 0 : data.length,
      //   itemBuilder: (BuildContext context, int index){
      //       return Container(
      //           width: screenWidth(context),
      //             child: Column(
      //               children: <Widget>[
      //                 Card(child: Text('ksdkfsd', style:titleStyle()),),
      //               ],
      //             ),
                
      //       );
      //   }
      // ),

      
      Container(
        width: screenWidth(context),
        height: screenHeight(context),
        decoration: BoxDecoration(
          color: BG_COLOR,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _profilePic(),
              _settingSection(),
              _loginButton()
            ],
          ),
        ),
      ),



    );
  }

Widget _profilePic(){
  return Card(
    elevation: 5.0,
            color: WHITE,
            child:Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 28),
                ),
                  Avatar(
                      imgurl: 'https://cdn.pixabay.com/photo/2016/11/29/20/22/child-1871104_960_720.jpg',
                    ),
                    FlatButton(
                          onPressed: () {},
                          child: const Text('Change Profile'),
                          textColor: PRIMARY,
                          padding: EdgeInsets.all(0),
                        ),
              ],
            )
                    
                  );

}
  Widget _loginButton(){
    return  Container(
      width: screenWidth(context) ,
      padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        padding: EdgeInsets.all(12),
        fillColor: PRIMARY,
        child: Text("Update Profile", style: TextStyle(color: Colors.white)),
        onPressed: () {
          //  Navigator.of(context).pushNamed(OrderList.tag);
        }         
      ),
    );
  }

  Widget _settingSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 5.0,
            color: WHITE,
            margin: EdgeInsets.only(
              bottom: 5.0,
              top: 5.0,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 5.0, 10, 5.0),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context) * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Username',
                              style: textGray(),
                            ),
                            Text(
                              'Raam meena',
                              style: labelLarge(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: screenWidth(context) * 0.1,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: PRIMARY),
                    )),
                    child: FlatButton(
                      onPressed: () {},
                      child: const Text('EDIT'),
                      textColor: PRIMARY,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5.0,
            color: WHITE,
            margin: EdgeInsets.only(
              bottom: 5.0,
              top: 5.0,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 5.0, 10, 5.0),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context) * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: textGray(),
                            ),
                            Text(
                              'Raam1023@gmail.com',
                              style: labelLarge(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: screenWidth(context) * 0.1,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: PRIMARY),
                    )),
                    child: FlatButton(
                      onPressed: () {},
                      child: const Text('EDIT'),
                      textColor: PRIMARY,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5.0,
            color: WHITE,
            margin: EdgeInsets.only(
              bottom: 5.0,
              top: 5.0,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 5.0, 10, 5.0),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context) * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Contact',
                              style: textGray(),
                            ),
                            Text(
                              '0345235576',
                              style: labelLarge(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: screenWidth(context) * 0.1,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: PRIMARY),
                    )),
                    child: FlatButton(
                      onPressed: () {},
                      child: const Text('EDIT'),
                      textColor: PRIMARY,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5.0,
            color: WHITE,
            margin: EdgeInsets.only(
              bottom: 5.0,
              top: 5.0,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 5.0, 10, 5.0),
              margin: EdgeInsets.only(bottom: 5, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context) * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Address',
                              style: textGray(),
                            ),
                            Text(
                              '28th main, MCHS Colony,',
                              style: labelLarge(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: screenWidth(context) * 0.1,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: PRIMARY),
                    )),
                    child: FlatButton(
                      onPressed: () {},
                      child: const Text('EDIT'),
                      textColor: PRIMARY,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
