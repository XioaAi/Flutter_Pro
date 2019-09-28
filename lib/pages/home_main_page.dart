import 'package:flutter/material.dart';
import 'package:flutter_app/common/common.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/widget/condition_page_widget.dart';
import 'package:flutter_app/widget/project_page_widget.dart';
import 'package:flutter_app/widget/system_page_widget.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeMainPage();
  }
}

class HomeMainPage extends StatefulWidget {

  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {

  var tabList = [
    HomePageWeight(),
    ProjectPageWeight(),
    ConditionPageWight(),
    SystemPageWeight()
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context)=>IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(ImagesUrl.homeHeadImg),
              ),
              onPressed: () => Scaffold.of(context).openDrawer()
          )),
          title: HomeTitleWidget(),
          centerTitle: true,
          actions: <Widget>[
            Icon(
              Icons.search,
              size: 25,
            )
          ],
        ),
        drawer: DrawWidget(),
        body: TabBarView(children: tabList),
      ),
    );
  }
}

class HomeTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TabBar(
        unselectedLabelColor: Colors.white,
        labelColor: Colors.red,
        tabs: [
          Tab(text: "主页"),
          Tab(text: "项目"),
          Tab(text: "动态"),
          Tab(text: "体系"),
        ],
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}

class DrawWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      height: 200,
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: CircleAvatar(
                          maxRadius: 15,
                          backgroundImage: NetworkImage(ImagesUrl.homeHeadImg),
                        ),
                        otherAccountsPictures: <Widget>[
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          )
                        ],
                        accountName: Text('昵称'),
                        accountEmail: Text('个人简介'),
                        decoration:BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(ImagesUrl.homeDrawbgImg),
                                fit: BoxFit.cover
                            )
                        ),
                      )
                  )
              )
            ],
          ),
          ListTile(leading: Icon(Icons.collections), title: Text('收藏')),
          Divider(),
          ListTile(leading: Icon(Icons.settings), title: Text('设置')),
          Divider(),
          ListTile(leading: Icon(Icons.info), title: Text('关于')),
          Divider(),
          ListTile(leading: Icon(Icons.share), title: Text('分享')),
          Divider(),
          ListTile(leading: Icon(Icons.power_settings_new), title: Text('注销')),
          Divider(),
        ],
      ),
    );
  }
}
