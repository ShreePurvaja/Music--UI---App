import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/modules/song.dart';

class PlaylistProvider extends ChangeNotifier{
  //playlist of songs
  final List<Song> _playlist = [
    
    //song 1
    Song(
      songName : "Dandellions",
      artistName: "Ruth B",
      albumImagePath: "assets/image/Ruth_B.jpg",
      audioPath: "audio/dandellions.mp3"
    ),
     Song(
      songName : "Ishq Wala Love",
      artistName: " Neeti Mohan and Shekhar Ravjiani",
      albumImagePath: "assets/image/student_of_the_year.jpg",
      audioPath: "audio/Ishq_Wala_Love.mp3"
    ),
     Song(
      songName : "Naane Varugiren",
      artistName: "Sathyaprakash and Shashaa Tirupati",
      albumImagePath: "assets/image/ok_kanmanii.jpg",
      audioPath: "audio/Naane_Varugiraen.mp3"
    ),
     Song(
      songName : "Theera Ulaa",
      artistName: "Darshana KT and Nikhita Gandhi",
      albumImagePath: "assets/image/o_kadhal_kanmani.jpg",
      audioPath: "audio/Theera_Ulaa.mp3"
    )

  ];

  //current song playing index
  int? _currentSongIndex;

  /* 
  A U D I O P L A Y E R
  */ 

  //audioplayer
  final AudioPlayer _audioPlayer =AudioPlayer();

  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider(){
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  void play() async{
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop current song
    await _audioPlayer.play(AssetSource(path)); //play the new song
    _isPlaying = true;
    notifyListeners();
  }
  

  //pause the current song
  void pause() async{
    await _audioPlayer.pause(); // pause current song
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async{
    await _audioPlayer.resume(); // pause current song
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async{
    if(_isPlaying){
      pause();
    }
    else{
      resume();
    }
  }

  //seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong(){
    if(_currentSongIndex != null){
      if(_currentSongIndex !< _playlist.length - 1){
        //go to next song if its not the last song
        currentSongIndex = _currentSongIndex! + 1;
      }else{
        //if its the last song ,loop back to first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async{
    //if more than 2 sec have passed,restart the song
    if(_currentDuration.inSeconds > 3){
     seek(Duration.zero);
    }
    //if its within first 2 sec,go to previous song
    else{
      if(_currentSongIndex! > 0){
        
      currentSongIndex = _currentSongIndex! - 1;
      }
      else{
       //if its the first song,loop back to last song 
        currentSongIndex = _playlist.length - 1;
      }
      
    } 
  }

  //listen to duration
  void listenToDuration(){
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
     });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
     });


    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) { 
      playNextSong();
    });

  }

  //dispose audio player

  /* 
  G E T T E R S

  */

  List<Song>get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isplaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;


  /* 
  S E T T E R S
  */ 
  set currentSongIndex(int? newIndex){
    //update current song index
    _currentSongIndex =newIndex;

    if(newIndex != null){
      play(); //play the song at the new index
    }

    //update the ui
    notifyListeners();
  }
    
    
}