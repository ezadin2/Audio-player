import 'dart:convert';

import 'package:audio_app/Themes/app_color.dart';
import 'package:audio_app/pages/my_tabs.dart';
import 'package:audio_app/pages/positioned.dart';
import 'package:audio_app/pages/silver_widget.dart';
import 'package:flutter/material.dart';

import 'list_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  ScrollController? _scrollController;
  TabController? _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/popularBooks.json')
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString('json/books.json')
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor().background,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        Drawer();
                      },
                      child: Icon(Icons.menu)),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.notifications)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              child: Stack(
                children: [
                  positioned(popularBooks: popularBooks),
                ],
              ),
            ),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return [silverWidget(tabController: _tabController)];
              },
              body: TabBarView(
                controller: _tabController, // Add the controller here
                children: [
                  ListViews(
                    books: books,
                  ),
                  ListViews(
                    books: books,
                  ),
                  ListViews(
                    books: books,
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}

