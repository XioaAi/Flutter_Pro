import 'package:flutter/material.dart';
import 'package:flutter_app/data/recommend_pro_entity.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/http/http_request.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoreRecommendedWidget extends StatefulWidget {

  final int cid;

  MoreRecommendedWidget(this.cid);

  @override
  _MoreRecommendedWidgetState createState() => _MoreRecommendedWidgetState(cid);
}

class _MoreRecommendedWidgetState extends State<MoreRecommendedWidget> {

  final int _cid;

  _MoreRecommendedWidgetState(this._cid);

  int page;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<RecommandProDataDatas> _data = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = 1;
    request(true);

  }

  void request(bool isRefush){
    String url = Api.baseUrl + Api.project_tree_info + '$page/json?cid=$_cid';
    HttpUtil().get(url,(data){
      RecommendProEntity recommendProEntity = RecommendProEntity.fromJson(data);

      if(recommendProEntity.data.datas.length<=0){
        if(!isRefush){
          _refreshController.loadNoData();
        }
      }

      if(isRefush){
        _data.clear();
      }
      _data.addAll(recommendProEntity.data.datas);
      if (mounted) setState(() {});
      if(isRefush){
        _refreshController.refreshCompleted();
      }else{
        _refreshController.loadComplete();
      }
    },errorCallBack: (){
      if(isRefush){
        _refreshController.refreshFailed();
      }else{
        _refreshController.loadFailed();
      }
    });
  }


  //整体布局
  Widget _layout() {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => _listViewItem(c,i),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.grey,
        );
      },
      itemCount: _data.length,

    );
  }

  //ListView 的Item布局
  Widget _listViewItem(context, position) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                _data[position].title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              subtitle: Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        _data[position].desc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 10, 10),
                      child: Text(
                          _data[position].author + "  " + _data[position].niceDate,
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    )
                  ],
                ),
              ),
              trailing: FadeInImage.assetNetwork(
                  image: _data[position].envelopePic,
                  fit: BoxFit.fitHeight,
                  width: 80,
                  placeholder: Utils.getImgPath('a',format: 'jpg'))),
          //Image.network(_data[position].envelopePic)),
          Divider(height: 2)
        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, '/browser',arguments:{
          'title':this._data[position].title,
          'url':this._data[position].link
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      child: _layout(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowAlways,
        completeDuration: Duration(milliseconds: 500),
      ),
      header: WaterDropHeader(),
      onRefresh: () async {
        page = 0;
        request(true);
      },
      onLoading: () async {
        page++;
        request(false);
      },
    );
  }
}
