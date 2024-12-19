import 'package:audio_app/pages/detail_audio_page.dart';
import 'package:flutter/material.dart';

import '../Themes/app_color.dart';

class ListViews extends StatelessWidget {
  List books = [];
   ListViews({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () {
              // Use push() to add to the navigation stack instead of replacing
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailAudioPage(
                    booksData: books,
                    index: i,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: 20, right: 20, top: 3, bottom: 3),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor().tabVarViewColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 0),
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ]),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                          width: 90,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(books[i]["img"])),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 24,
                                color: AppColor().starColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                books[i]["rating"],
                                style: TextStyle(
                                    color: AppColor().menu2Color),
                              )
                            ],
                          ),
                          Text(
                            books[i]["title"],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            books[i]["text"],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Avenir',
                                color: AppColor().subTitleText),
                          ),
                          Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5),
                                color: AppColor().loveColor),
                            child: Text(
                              'Love',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Avenir',
                                  color: Colors.white),
                            ),
                            alignment: Alignment.center,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
