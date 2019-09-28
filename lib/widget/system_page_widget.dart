import 'package:flutter/material.dart';
import 'package:flutter_app/data/system_entity.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/http/http_request.dart';
import 'dart:math';

class SystemPageWeight extends StatefulWidget {
  @override
  _SystemPageWeightState createState() => _SystemPageWeightState();
}

class _SystemPageWeightState extends State<SystemPageWeight> {

  List<SystemData> _data = List();
  List<Color> _colors = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _colors.add(Colors.greenAccent);
    _colors.add(Colors.blue);
    _colors.add(Colors.yellowAccent);
    _colors.add(Colors.deepPurple);
    _colors.add(Colors.green);
    _colors.add(Colors.pink);

    String url = Api.baseUrl + Api.system_tree;
    HttpUtil().get(url,(data){
      SystemEntity systemEntity = SystemEntity.fromJson(data);
      _data.addAll(systemEntity.data);
      if (mounted) setState(() {});
    },errorCallBack: (){
      //处理请求失败
    });
  }

  //组装ListView的item
  Widget _listViewItemView(context,index){
    return Padding(
      padding: EdgeInsets.fromLTRB(10,10,10,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _data[index].name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            children: wrapItems(index),
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
          ),
          SizedBox(height: 10),
          Divider(height: 2,color: Colors.grey,)
        ],
      ),
    );
  }

  //组装Wrap中item
  List<Widget> wrapItems(index){
    List<Widget> mItems = List();
    for(int a = 0;a<_data[index].children.length;a++){
      mItems.add(FlatButton(
          child: Text(_data[index].children[a].name),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          color:_colors[Random().nextInt(6)],
          onPressed: (){}
      ));
    }
    return mItems;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: _listViewItemView,
    );
  }
}
