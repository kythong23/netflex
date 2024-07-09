import 'package:flutter/material.dart';
import 'package:netflex/page/profile.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState()=> _StateSettingWidget();
}

class _StateSettingWidget extends State<SettingWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<UiProvider>(
          builder: (context, UiProvider notifier, child) {
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text("Dark theme"),
                  trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value)=>notifier.changeTheme()
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  textColor: notifier.isDark ? Colors.white : Colors.black,
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  textColor: notifier.isDark ? Colors.white : Colors.black,
                ),
              ],
            );
          }
      ),
    );
  }
}