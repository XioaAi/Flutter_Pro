import 'package:flustars/flustars.dart';

class SpUtils{

  static void put(String key,Object value){
    switch(value){
      case String:
        SpUtil.putString(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case String:
        SpUtil.putString(key, value);
        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        SpUtil.putObject(key, value);
        break;
    }
  }

}