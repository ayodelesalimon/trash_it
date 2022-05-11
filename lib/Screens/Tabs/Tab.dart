// import 'package:flutter/material.dart';
// import 'package:trash_it/Screens/Tabs/CardsTabPage.dart';
// import 'package:trash_it/Screens/Tabs/HistoryTabPage.dart';

// import 'HomeTab.dart';
// import 'ProfileTabPage.dart';

// class MyNavigationBar extends StatefulWidget {
//   MyNavigationBar({Key? key}) : super(key: key);

//   @override
//   _MyNavigationBarState createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   int _selectedIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//     HomeTabScreen(),
//     // //  CardsTabPage(),
//     HistoryTabPage(),
//      ProfileTabPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('Flutter BottomNavigationBar Example'),
//           backgroundColor: Colors.green),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 title: Text('Home'),
//                 backgroundColor: Colors.green),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.search),
//                 title: Text('Search'),
//                 backgroundColor: Colors.yellow),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               title: Text('Profile'),
//               backgroundColor: Colors.blue,
//             ),
//           ],
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.black,
//           iconSize: 40,
//           onTap: _onItemTapped,
//           elevation: 5),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:trash_it/Screens/Tabs/CardsTabPage.dart';
import 'package:trash_it/Screens/Tabs/HomeTab.dart';

import 'HistoryTabPage.dart';
import 'PaymentHistory.dart';
import 'PaymentTab.dart';
import 'ProfileTabPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  
  final pages = [
    const HomeTabScreen(),
    PaymentScreen(),
    PaymentHistoryScreen(),
    ProfileTabPage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
     
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }
  
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.teal[300],
        borderRadius: const BorderRadius.only(
        //  topLeft: Radius.circular(20),
          //topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? Image.asset("assets/tab/home_white.png")
                : Image.asset("assets/tab/home_white.png"),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                  ? Image.asset("assets/tab/payment_white.PNG")
                : Image.asset("assets/tab/payment_white.PNG"),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
               ?Image.asset("assets/tab/bills_white.png")
                : Image.asset("assets/tab/bills_white.png"),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? Image.asset("assets/tab/user_white.PNG")
                : Image.asset("assets/tab/user_white.PNG"),
          ),
        ],
      ),
    );
  }
}
