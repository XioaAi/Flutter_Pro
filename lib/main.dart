import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      home: Scaffold(
        body: SplashWeight(),
      ),
    );
  }
}

class SplashWeight extends StatefulWidget {

  @override
  _SplashWeightState createState() => _SplashWeightState();
}

class _SplashWeightState extends State<SplashWeight> {

  TimerUtil _timerUtil;

  //用来控制显示启动图还是引导图  0 启动图   1 引导图  2启动图和倒计时
  int _states = 0;
  //倒计时
  int _lastTime = 5;

  Widget _guideItem(String imageName,{String format : 'png'}){
    return Image.asset(
        Utils.getImgPath(imageName,format: format),
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity
    );
  }

  Widget _guideItemWithIndex(context,index){
    if(index == 2){
      return Stack(
        children: <Widget>[
          _guideItem('a',format: 'jpg'),
          Container(
            height: 100,
            width: 100,
            child: Text('进 入',style: TextStyle(fontSize: 16,color: Colors.yellow)),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
          )
        ],
      );
    }else{
      return _guideItem('a',format: 'jpg');
    }
  }

  void _doCutDown() async{
    _timerUtil = TimerUtil(mInterval:1000 , mTotalTime: 5*1000);
    await SpUtil.getInstance();
    bool _isShowed = SpUtil.getBool("splash");
    if(_isShowed){
      this._states = 2;
    }
    _timerUtil.setOnTimerTickCallback((time)  async {
      print("倒计时结束$time");
      if(time == 0){
        if(_isShowed){
          setState(() {
            this._lastTime = time~/1000;
          });
          //跳转到首页
          _goHomeMain();
        }else{
          print("倒计时结束");
          setState(() {
            this._states = 1;
          });
        }
      }else{
        if(_isShowed){
          setState(() {
            this._lastTime = time~/1000;
          });
        }
      }
    });
    _timerUtil.startCountDown();
  }

  void _goHomeMain(){
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void initState() {
    super.initState();
    _doCutDown();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timerUtil!=null) _timerUtil.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !(_states == 1),
          child: Swiper(
            autoplay: false,
            loop: false,
            itemCount: 3,
            pagination:SwiperPagination(
              alignment: Alignment.bottomCenter
            ),
            control: SwiperControl(
              iconNext: null,
              iconPrevious: null,
              color: Colors.blue,
              size: 20,
            ),
            onTap: (index){
              if(index == 2){
                SpUtil.putBool("splash",true);
                //跳转首页
                _goHomeMain();
              }
            },
            itemBuilder: _guideItemWithIndex
          )
        ),
        Offstage(
          offstage: (!(_states == 0 || _states == 2)),
          child: Stack(
            children: <Widget>[
              _guideItem("splash_bg"),
              Offstage(
                offstage: !(_states == 2),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 40,
                    width: 80,
                    margin: EdgeInsets.only(bottom: 10,right: 10),
                    child: new Center(child: Text('剩余 $_lastTime S',style: TextStyle(color: Colors.white),)),
                      decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              )
            ],
          )
        )
      ],
    );
  }
}

