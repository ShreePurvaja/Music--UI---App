import 'package:flutter/material.dart';
import 'package:music_app/components/my_drawer.dart';
import 'package:music_app/modules/playlist_provider.dart';
import 'package:music_app/modules/song.dart';
import 'package:music_app/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late final dynamic playlistProvider;
  @override
  void initState(){
    super.initState();

    //get playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context , listen: false);
  }

  //got to a song
  void goToSong(int songIndex){
    //update current song index
    playlistProvider.currentSongIndex = songIndex;


    //navigate to song page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>const SongPage() 
      )
    );
  }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(centerTitle:true,title:const Text("P L A Y L I S T")),
      drawer:const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context,value,child) {
          //get the playlist
          final List<Song> playlist = value.playlist;


          //return list view ui
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder:(context,index){
              //get the individual song
              final Song song = playlist[index];

              //return list title ui
              return  ListTile(
                title:Text(song.songName,style:const TextStyle(fontWeight: FontWeight.bold,)),
                subtitle: Text(song.artistName,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                leading: Image.asset(song.albumImagePath),
                onTap: () => goToSong(index),
                
              );
            },
          );
        }
      ),
    );
  }
}