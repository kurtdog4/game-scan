import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  static const String route = 'landing-page-route';

  // final String title;
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset("assets/GSLogoWhite.png"),
          iconSize: 50,
          onPressed: () => null,
        ),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Browse",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: "Rulesbot",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Theme.of(context).accentColor,
        child: const Icon(Icons.camera_alt),
        onPressed: () => null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
