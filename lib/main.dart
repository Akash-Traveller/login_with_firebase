import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyLoginPage(),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
  filled: true,
  fillColor: Colors.deepOrange,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide.none,
  ),
);

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage>
    with TickerProviderStateMixin {

  final _auth = FirebaseAuth.instance;
  double _opacity = 0.0;
  double _opacity2 = 0.0;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    controller.repeat();
    Future.delayed(Duration(milliseconds: 250), () {
      _opacity2 = 1;
    });
    Future.delayed(Duration(milliseconds: 150), () {
      _opacity = 1;
    });
  }
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/iprimo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                AnimatedOpacity(
                  curve: Curves.bounceInOut,
                  opacity: _opacity2,
                  duration: Duration(seconds: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Good Morning',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          AnimatedBuilder(
                            animation: controller,
                            child: Container(
                              child: Image(
                                image: AssetImage('images/two.png'),
                                height: 30,
                              ),
                            ),
                            builder: (BuildContext context, Widget _widget) {
                              return Transform.rotate(
                                angle: controller.value * 6.3,
                                child: _widget,
                              );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 50, right: 110),
                        child: Text(
                          'Get Started Here!',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  curve: Curves.easeInOut,
                  opacity: _opacity2,
                  duration: Duration(seconds: 5),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Username',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.white, fontSize: 23),
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () async {
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if (newUser != null){
                                //You can navigate to HomeScreen as well , here i have used showdialog
                                showDialog(
                                    context: context,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 250),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(Radius.circular(40)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset('images/iprimo.png',height: 150),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Material(
                                                child: Text('Thanks for signing!!'),
                                                color: Colors.white,
                                                type: MaterialType.card,
                                                textStyle: TextStyle(fontSize: 25,color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                );
                              }
                            }
                            catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30)),
                              color: Colors.white60,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 15),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}