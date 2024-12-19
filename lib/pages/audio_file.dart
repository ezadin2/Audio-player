import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final audioPath;

  AudioFile({super.key, required this.advancedPlayer, this.audioPath});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();

  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  List<IconData> _icons = [Icons.play_circle_fill, Icons.pause_circle_filled];

  @override
  void initState() {
    super.initState();

    // Listen to duration changes
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    // Listen to position changes
    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    // Listen to player state changes
    widget.advancedPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlaying = false;
          isPaused = false;
        });
      }
    });

    // Set the source URL
    widget.advancedPlayer.setSource(UrlSource(this.widget.audioPath));
    this.widget.advancedPlayer.onPlayerComplete.listen((event){
      setState((){
        _position  = Duration(seconds: 0);
        if(isRepeat == true){
        isPlaying =true;

        }
       else{

          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  // Function to change position
  void changeToSecond(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    this.widget.advancedPlayer.seek(newDuration);
  }

  // Toggle between play and pause
  void togglePlayPause() {
    if (isPlaying) {
      widget.advancedPlayer.pause();
    } else {
      widget.advancedPlayer.play(UrlSource(this.widget.audioPath));
    }
    setState(() {
      isPlaying = !isPlaying;
      isPaused = !isPaused;
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: EdgeInsets.only(bottom: 10),
      onPressed: togglePlayPause,
      icon: Icon(
        isPlaying ? _icons[1] : _icons[0],
        size: 50,
        color: Colors.blue,
      ),
    );
  }

  Widget btnFast() {
    return IconButton(
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(1.5);
      },
      icon: Image.asset(
        "images/forward.png",
        width: 30,
        height: 30,
      ),
    );
  }

  Widget btnSlow() {
    return IconButton(
      onPressed: () {
        widget.advancedPlayer.setPlaybackRate(0.5);
      },
      icon: Image.asset(
        "images/backward.png",
        width: 30,
        height: 30,
      ),
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(
        Icons.loop,
        color: isRepeat ? Colors.blue : Colors.black, // Color based on state
      ),
      onPressed: () {
        if (!isRepeat) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            isRepeat = false;
            color = Colors.black;
          });
        }
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: Image.asset(
        "images/repeat.png",
        width: 30,
        height: 30,

      ),
      onPressed: () {
      },
    );
  }

  Widget slider() {
    return Slider(
      value: _position.inSeconds
          .toDouble()
          .clamp(0.0, _duration.inSeconds.toDouble()),
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      min: 0.0,
      max: _duration.inSeconds > 0 ? _duration.inSeconds.toDouble() : 1.0,
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
        });
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop()

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15), // Reduced padding here
      child: Column(
        children: [
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _position.toString().split(".")[0],
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: slider(),
              ),
              Text(
                _duration.toString().split(".")[0],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          loadAsset(),
        ],
      ),
    );
  }
}
