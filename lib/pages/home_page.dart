import 'package:flutter/material.dart';
import 'package:flutter_app/widget/head_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_app/http/http_request.dart';
import 'package:flutter_app/http/api.dart';
import 'package:flutter_app/data/recommend_pro_entity.dart';
import 'package:flutter_app/data/home_banner_entity.dart';

class HomePageWeight extends StatefulWidget {
  @override
  _HomePageWeightState createState() => _HomePageWeightState();
}

class _HomePageWeightState extends State<HomePageWeight> with WidgetsBindingObserver{
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _swiperIndex = 0;

  int page = 1;

  bool _banner_auto = false;

  List<RecommandProDataDatas> _data = List();
  List<HomeBannerData> _banner = List();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    requestData();
    print("initState 执行");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("程序从后台切换到前台才会执行");
    if(AppLifecycleState.resumed == state){
      requestData();
    }
  }


  void requestData(){
    String urlBanner = Api.baseUrl + Api.banner;
    HttpUtil().get(urlBanner,(data){
      HomeBannerEntity homeBannerEntity = HomeBannerEntity.fromJson(data);
      _banner.clear();
      _banner.addAll(homeBannerEntity.data);
      setState(() {
        _banner_auto = true;
      });
    },errorCallBack: (){
      //处理请求失败
    });

    requestList(true);
  }

  void requestList(bool isRefush){
    String url = Api.baseUrl + Api.recommend_pro + '$page/json';
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

  //banner Item
  Widget bannerItem(context, index){
      return FadeInImage.assetNetwork(
          image: _banner[index].imagePath,
          fit: BoxFit.cover,
          placeholder: Utils.getImgPath('a',format: 'jpg'));
  }

  //整体布局
  Widget _layout() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              HeadItem(
                leftIcon: Icons.spa,
                leftIconColor: Colors.red,
                title: '即将全部开源,敬请期待!',
                titleColor: Colors.red,
                rightIcon: Icons.chevron_right,
                extra: 'Go',
              ),
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Swiper(
                      itemCount: _banner.length,
                      autoplay: _banner_auto,
                      loop: true,
                      pagination: null,
                      control: SwiperControl(
                        iconNext: null,
                        iconPrevious: null,
                      ),
                      itemBuilder: (context, index) => bannerItem(context,index),
                      onIndexChanged: (index) {
                        setState(() {
                          this._swiperIndex = index + 1;
                        });
                      },
                      onTap: (index){
                        Navigator.pushNamed(context, '/browser',arguments:{
                          'title':this._banner[index].title,
                          'url':this._banner[index].url
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text((this._swiperIndex.toString()+'/'+ this._banner.length.toString()),
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  Divider(height: 2),
                ],
              ),
              HeadItem(
                leftIcon: Icons.book,
                leftIconColor: Colors.blue,
                title: '推荐项目',
                titleColor: Colors.blue,
                rightIcon: Icons.chevron_right,
                extra: '更多',
                onTap: (){
                  Navigator.pushNamed(context, '/more');
                },
              ),
            ])),
        SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _listViewItem(context, index),
              childCount: _data.length,
            )
        ),
      ],
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
      //physics: NeverScrollableScrollPhysics(),
      controller: _refreshController,
      enablePullUp: true,
      child: _layout(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowAlways,
        completeDuration: Duration(milliseconds: 500),
      ),
      header: WaterDropHeader(),
      onRefresh: () {
        page = 0 ;
        requestList(true);
      },
      onLoading: () async {
        page++;
        requestList(false);
      },
    );
  }
}
