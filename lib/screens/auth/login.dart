import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import '../main/order-list.dart';
import '../../services/auth.dart';
import '../../services/common.dart';
import '../../blocs/validators.dart';

class Login extends StatefulWidget {
  static String tag = "login";

  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  login() {
    if (!isLoading && _formKey.currentState.validate() && mounted) {
      setState(() {
        isLoading = true;
      });
    }
    _formKey.currentState.save();
    Map<String, dynamic> body = {'email': email, 'password': password};
    AuthService.login(body).then((onValue) {
      if (onValue['message'] != null) {
        showSnackbar(onValue['message']);
      }
      if (onValue['token'] != null) {
        Common.setToken(onValue['token']).then((saved) {
          if (saved) {
            checkAuth();
          }
        });
      }
    }).catchError((onError) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      showSnackbar(onError.toString());
      print("Error " + onError.toString());
    });
  }

  void checkAuth() {
    AuthService.getUserInfo().then((onValue) {
      String role = onValue['role'];
      if (role == 'Manager' || role == 'Owner') {
        if (role == 'Manager') {
          Common.setId(onValue['locationInfo']['locationId']);
        }
        if (role == 'Owner') {
          Common.setId(onValue['_id']);
        }
        Common.setRole(role);
        showSnackbar('Login Successfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => OrderList()),
            (Route<dynamic> route) => false);
      } else {
        showSnackbar('You are not authorized to login');
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3000),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[_logoSection(), _loginForm()],
          ),
        ),
      ),
    );
  }

  Widget _logoSection() {
    return Column(
      children: <Widget>[
        Image.asset(
          'lib/assets/logos/logo.png',
          width: 100,
          height: 100,
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            _emailField(),
            SizedBox(height: 10.0),
            _passwordField(),
            SizedBox(height: 10.0),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(Validators.emailPattern).hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        onSaved: (String value) {
          email = value;
        },
        autofocus: false,
        initialValue: 'watson@gmail.com',
        obscureText: false,
        decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PRIMARY, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PRIMARY, width: 2.0),
          ),
        ));
  }

  Widget _passwordField() {
    return TextFormField(
      autofocus: false,
      initialValue: '123456',
      obscureText: true,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password should be atleast 6 char long';
        }
      },
      onSaved: (String value) {
        password = value;
      },
      decoration: new InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PRIMARY, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PRIMARY, width: 2.0),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: screenWidth(context),
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        padding: EdgeInsets.all(12),
        fillColor: PRIMARY,
        child: isLoading
            ? Text("Please Wait...", style: TextStyle(color: Colors.white))
            : Text("Login", style: TextStyle(color: Colors.white)),
        onPressed: login,
      ),
    );
  }
}
