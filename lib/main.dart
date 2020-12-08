import 'package:flutter/material.dart';
import 'package:flutter_ui_day10/Animations/FadeAnimations.dart';
import 'package:flutter_ui_day10/LoginPage.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;
  bool hideIcon = false;
  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 300), vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _widthController.forward();
      }
    });
    _widthController = AnimationController(
      duration: Duration(milliseconds: 600), vsync: this,
    );
    _widthAnimation = Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _positionController.forward();
      }
    });
    _positionController = AnimationController(
      duration: Duration(milliseconds: 1000), vsync: this,
    );
    _positionAnimation = Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)..addStatusListener((status) {
      setState(() {
        hideIcon=true;
      });
      if(status==AnimationStatus.completed){
        _scale2Controller.forward();
      }
    });
    _scale2Controller = AnimationController(
      duration: Duration(milliseconds: 1000), vsync: this,
    );
    _scale2Animation = Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        Navigator.push(context, PageTransition(
          type: PageTransitionType.fade,
          child: LoginPage(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimation(1,Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/one.png'),
                    fit: BoxFit.cover
                  )
                ),
              )),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(1.3,Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/one.png'),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(1.6,Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/one.png'),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(1, Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40
                    ),
                  ),),
                  SizedBox(height: 15,),
                  FadeAnimation(1.3, Text(
                    'We promise that you will have the most virus free time with us ever.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7,),
                      height: 1.4,
                    ),
                  ),),
                  SizedBox(height: 180,),
                  FadeAnimation(1.6, AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child)=> Transform.scale(
                      scale: _scaleAnimation.value,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _widthController,
                        builder: (context, child)=> Container(
                          width: _widthAnimation.value,
                          height: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue.withOpacity(0.4)
                          ),
                          child: InkWell(
                            onTap: (){
                              _scaleController.forward();
                            },
                            child: Stack(
                              children: [
                                AnimatedBuilder(
                              animation: _positionController,
                              builder: (context, child)=>Positioned(
                                    left: _positionAnimation.value,
                                    child: AnimatedBuilder(
                                      animation: _scale2Controller,
                                      builder: (context, child)=>Transform.scale(
                                        scale: _scale2Animation.value,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue
                                        ),
                                        child: hideIcon==false?Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ):Container(),
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),),
                  ),),
                  SizedBox(height: 60,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

