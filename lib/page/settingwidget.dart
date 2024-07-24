import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_flags/country_flags.dart';
import 'package:expandable_section/expandable_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/favorWidget.dart';
import 'package:netflex/page/profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_service.dart';
import '../provider/provider.dart';
import 'package:netflex/api/google_signin_api.dart';
import 'package:netflex/page/flash_screen.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState()=> _StateSettingWidget();
}

class _StateSettingWidget extends State<SettingWidget>{
  String? appbartitle="";
  late String? darktheme;
  late String? language;
  late String? mylist;
  late String? logout;
  bool dropdown = true;
  bool translating = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (!translating)?Text(appbartitle!): Text("Loading"),
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
                  title:  (!translating)?Text(darktheme!): Text("Loading"),
                  trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value)=>notifier.changeTheme()
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      dropdown=!dropdown;
                    });
                  },
                  child: ListTile(
                    leading: const Icon(Icons.language),
                    trailing: (dropdown)?Icon(Icons.arrow_downward):Icon(Icons.arrow_upward),
                    title:(!translating)?Text(language!): Text("Loading"),
                    textColor: notifier.isDark ? Colors.white : Colors.black,
                  ),
                ),
                Consumer<LanguageProvider>(
                    builder: (context,value,child){
                      return  ExpandableSection(expand: !dropdown,
                          child:Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    value.lang = "en";
                                    Translate();
                                    if(!translating){
                                      setState(() {
                                        translating = !translating;
                                      });
                                    }
                                    showDialog("Changed Language", "Your language changed to English");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black12,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CountryFlag.fromCountryCode(
                                            'US',
                                            shape: const RoundedRectangle(6),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Anh",style: TextStyle(fontStyle: FontStyle.italic),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    value.lang = "fr";
                                    Translate();
                                    if(!translating){
                                      setState(() {
                                        translating = !translating;
                                      });
                                    }
                                    showDialog("Changed Language", "Your language changed to French");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black12,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CountryFlag.fromCountryCode(
                                            'fr',
                                            shape: const RoundedRectangle(6),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Pháp",style: TextStyle(fontStyle: FontStyle.italic),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    value.lang = "ar";
                                    Translate();
                                    if(!translating){
                                      setState(() {
                                        translating = !translating;
                                      });
                                    }
                                    showDialog("Changed Language", "Your language changed to Arab");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black12,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CountryFlag.fromCountryCode(
                                            'SA',
                                            shape: const RoundedRectangle(6),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Ả rập",style: TextStyle(fontStyle: FontStyle.italic),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    value.lang = "vi";
                                    Translate();
                                    if(!translating){
                                      setState(() {
                                        translating = !translating;
                                      });
                                    }
                                    showDialog("Changed Language", "Your language changed to VietNam");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black12,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CountryFlag.fromCountryCode(
                                            'VN',
                                            shape: const RoundedRectangle(6),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Việt nam",style: TextStyle(fontStyle: FontStyle.italic),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    value.lang = "de";
                                    Translate();
                                    if(!translating){
                                      setState(() {
                                        translating = !translating;
                                      });
                                    }
                                    showDialog("Changed Language", "Your language changed to Germany");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black12,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CountryFlag.fromCountryCode(
                                            'DE',
                                            shape: const RoundedRectangle(6),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Đức",style: TextStyle(fontStyle: FontStyle.italic),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FavorWidget()));
                  },
                  child: ListTile(
                    leading: const Icon(Icons.list),
                    title: (!translating)?Text(mylist!): Text("Loading"),
                    textColor: notifier.isDark ? Colors.white : Colors.black,
                  ),
                ),
                ElevatedButton(onPressed: Loggout
                  , child: ListTile(
                    leading: const Icon(Icons.logout),
                    title:  (!translating)?Text(logout!): Text("Loading"),
                    textColor: notifier.isDark ? Colors.white : Colors.black,
                  ),),
              ],
            );
          }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Translate();
  }

  void showDialog(String title, String content){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.bottomSlide,
        showCloseIcon: true,
        title: title,
        desc: content,
        btnOkOnPress: (){
          Provider.of<LanguageProvider>(context,listen: false).changeLang();
        }
    ).show();
  }
  Future Translate()async{
    appbartitle =await translate("Settings",context);
    language =await translate("Language",context);
    darktheme =await translate("Dark theme",context);
    mylist =await  translate("My list",context);
    logout =await translate("Logout",context);
    setState((){
      translating = !translating;
    });
  }
  Future Loggout() async{
    await GoogleSignInApi.logout;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('user');
    Provider.of<FavorProvider>(context,listen: false).clearAll();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FlashScreen()
        ));
  }
}
