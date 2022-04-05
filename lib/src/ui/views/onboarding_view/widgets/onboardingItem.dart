import 'dart:ui';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingItem extends StatelessWidget {
  final String? imageAsset;
  final String? title;
  final String? description;
  OnBoardingItem({this.imageAsset, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      duration: Duration(milliseconds: 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            image: AssetImage(imageAsset!),
            height: ScreenUtil().setHeight(300),
            width: ScreenUtil().setWidth(500),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
          ),
          Text(
            title!,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}