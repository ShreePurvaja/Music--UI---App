import 'package:flutter/material.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:Theme.of(context).colorScheme.surface,
      child:Column(
        children: [

          //logo 
          Theme(
            data: ThemeData(dividerColor: Theme.of(context).colorScheme.surface),
            child: DrawerHeader(
              child: Center(
                child: Icon(Icons.music_note,
                  size: 40,
                  color: Theme.of(context).colorScheme.inversePrimary
                )
              ),
            ),
          ),

          //hometitle
           Padding(
            padding: const  EdgeInsets.only(top:25,left:25),
            child:  ListTile(
              title: const Text("H O M E"),
              leading:const  Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),

          //settings
           Padding(
            padding: const  EdgeInsets.only(top:10,left:25),
            child:  ListTile(
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings),
              onTap: (){
                //pop drawer
                Navigator.pop(context);

                //navigate to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) =>const  SettingsPage() 
                  )
                );

              },
            ),
          ),
        ]
      )
    );
  }
}