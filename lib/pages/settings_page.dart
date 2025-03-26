import 'package:flutter/material.dart';
import 'package:music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
   const SettingsPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle:true,title:const  Text("S E T T I N G S")),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding:const  EdgeInsets.all(14),
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //dark mode
            const Text("Dark Mode",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
            ),
            Switch(
              value: Provider.of<ThemeProvider>(context,listen:false).isDarkMode,
              onChanged:(value) =>Provider .of<ThemeProvider>(context,listen: false).toggleTheme()
            )
          ],
        ),
      ),
    );
  }
}