import 'package:flutter/material.dart';

import '../Themes/app_color.dart';
import 'my_tabs.dart';
class silverWidget extends StatelessWidget {
  const silverWidget({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColor().silverBackground,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            margin: EdgeInsets.only(bottom: 20, left: 10),
            child: TabBar(
              indicatorPadding: EdgeInsets.all(0),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.all(0),
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 7,
                      offset: Offset(0, 0),
                    )
                  ]),
              tabs: [
                MyTabs(color: AppColor().menu1Color, text: "New"),
                MyTabs(
                    color: AppColor().menu2Color,
                    text: "Popular"),
                MyTabs(
                    color: AppColor().menu3Color,
                    text: "Trending"),
              ],
            ),
          )),
    );
  }
}