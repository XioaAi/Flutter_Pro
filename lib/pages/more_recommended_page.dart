import 'package:flutter/material.dart';
import 'package:flutter_app/data/project_tree_entity.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/http/http_request.dart';
import 'package:flutter_app/widget/more_recommended_widget.dart';

class MoreRecommendedProject extends StatefulWidget {
  @override
  _MoreRecommendedProjectState createState() => _MoreRecommendedProjectState();
}

class _MoreRecommendedProjectState extends State<MoreRecommendedProject> {

  List<ProjectTreeData> _tabList = List();

  List<Widget> getTabs(){
    List<Widget> tabs = List();
    for(int a = 0;a<_tabList.length;a++){
      tabs.add(Tab(
        text: _tabList[a].name,
      ));
    }
    return tabs;
  }

  List<Widget> getTabViews(){
    List<Widget> tabViews = List();
    for(int a = 0;a<_tabList.length;a++){
      tabViews.add(MoreRecommendedWidget(_tabList[a].id));
    }
    return tabViews;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init执行');
    requestTree();
    print('init执行完毕');

  }

  void requestTree(){
    String url = Api.baseUrl + Api.project_tree;
    HttpUtil().get(url,(data){
      ProjectTreeEntity projectTreeEntity = ProjectTreeEntity.fromJson(data);
      _tabList.addAll(projectTreeEntity.data);
      setState(() {
      });
    },errorCallBack: (){
      //处理请求失败
    });
  }



  @override
  Widget build(BuildContext context) {
    print('build开始执行');

    return DefaultTabController(
        length: this._tabList.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('项目分类'),
            centerTitle: true,
            bottom: TabBar(
              tabs: getTabs(),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          body: TabBarView(
              children: getTabViews()
          ),
        )
    );
  }
}
