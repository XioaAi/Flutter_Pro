import 'package:flutter/material.dart';

class HeadItem extends StatelessWidget {
  HeadItem({
    this.margin,
    this.title,
    this.extra,
    this.titleColor,
    this.leftIcon,
    this.leftIconColor,
    this.rightIcon,
    this.onTap,
    Key key}):super(key:key);

  final double margin;
  final String title;
  final String extra;
  final Color titleColor;
  final IconData leftIcon;
  final Color leftIconColor;
  final IconData rightIcon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 45,
      alignment: Alignment.center,
      //margin: EdgeInsets.only(top: margin??0),
      child: ListTile(
        onTap: onTap,
        title: Row(
          //决定主轴方向的尺寸
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(leftIcon,color: leftIconColor),
            SizedBox(width: 10),
            Expanded(
              child:Text(title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14,color: this.titleColor),
              )
            )
          ],
        ),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(extra,style: TextStyle(fontSize: 14,color: Colors.grey)),
            Icon(rightIcon)
          ],
        ),
      ),
      decoration: BoxDecoration(
        border:Border(
          bottom:BorderSide(
            color:Colors.grey,
            width:0.33
          )
        )
      ),
    );
  }




}
