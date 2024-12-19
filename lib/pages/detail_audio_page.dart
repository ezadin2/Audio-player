import 'package:audio_app/Themes/app_color.dart';
import 'package:audio_app/pages/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'my_home_page.dart';

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;

  const DetailAudioPage({super.key, this.booksData, required this.index});

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor().audioScaBackround,
      body: Stack(
        children: [
          // Background Gradient for more depth
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 2.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor().audioBlueBackround, Colors.white.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // AppBar with back button and search icon
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  advancedPlayer.stop(); // Stop audio on back press
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()), // Navigate to home page
                  );
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search, color: Colors.white),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),

          // Book Details Section
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.3,
            height: screenHeight * 0.43,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.booksData[widget.index]['title'],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      widget.booksData[widget.index]['subtitle'] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 15),
                    AudioFile(
                      advancedPlayer: advancedPlayer,
                      audioPath: widget.booksData[widget.index]["audio"],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        (double.tryParse(widget.booksData[widget.index]['rating']) ?? 0.0).toInt(),
                            (index) => Icon(Icons.star, color: Colors.amber, size: 20),
                      )..add(
                        (double.tryParse(widget.booksData[widget.index]['rating']) ?? 0.0) % 1 >= 0.5
                            ? Icon(Icons.star_half, color: Colors.amber, size: 20)
                            : Container(), // Half star (if applicable)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Book Cover Image (Circular)
          Positioned(
            top: screenHeight * 0.1,
            left: (screenWidth - 160) / 2,
            width: 160,
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                image: DecorationImage(
                  image: AssetImage(widget.booksData[widget.index]["img"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Bottom Horizontal Book Carousel
          // Remove this bottom carousel positioned code from the DetailAudioPage
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: screenHeight * 0.2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: List.generate(widget.booksData.length, (i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailAudioPage(
                              booksData: widget.booksData,
                              index: i,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(widget.booksData[i]["img"]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.booksData[i]["title"],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              widget.booksData[i]["subtitle"] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                (double.tryParse(widget.booksData[i]['rating']) ?? 0.0).toInt(),
                                    (index) => Icon(Icons.star, color: Colors.amber, size: 20),
                              )..add(
                                (double.tryParse(widget.booksData[i]['rating']) ?? 0.0) % 1 >= 0.5
                                    ? Icon(Icons.star_half, color: Colors.amber, size: 20)
                                    : Container(), // Half star (if applicable)
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
