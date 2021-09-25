import 'package:flutter/material.dart';
import 'package:trash_it/Constants/TextStyle.dart';


class NaviationDrawer extends StatelessWidget {
  const NaviationDrawer({
    Key? key,
  }) : super(key: key);
  // Future<void> _launchInBrowser(String url) async {
  //   //const url = "https://tlwc.faithpays.org/donations/together-it-is-possible-we-can-and-are-making-a-difference-4-2/?customize_changeset_uuid=cb67539b-1ff1-4938-b915-7df65f5cec94&customize_autosaved=on";
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                      fit: BoxFit.contain),
                ), accountEmail: null, accountName: null,
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: AssetImage('images/map.png'),
                //   // child: Text("LA"),
                // ),
                // accountName: Text(
                //   'TLWC',
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 25,
                //       fontWeight: FontWeight.bold),
                // ),
                // accountEmail: Text('Changing Life & Attitude'),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: Text(
            //     'TLWC',
            //     style: TextStyle(
            //         color: Colors.grey,
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: Text('Changing Life & Attitude'),
            // ),
            Divider(height: 1, color: Colors.white),
            Card(
              color: Colors.grey,
              child: ListTile(
                onTap: () {
              Navigator.pop(context);
            },
                trailing: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.white),
            // Card(
            //   color: Colors.grey,
            //   child: ListTile(
            //     onTap: () {
            //        Navigator.push(
            //           context, MaterialPageRoute(builder: (_) => ConnectScreen()));
            //     },
            //     trailing: Icon(Icons.chat_bubble_outline_outlined,
            //         color: Colors.white),
            //     title: Text(
            //       'Lets Connect',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Divider(height: 1, color: Colors.white),
            Card(
              color: Colors.grey,
              child: ListTile(
                onTap: () {
                //  _launchInBrowser("https://www.bible.com/bible/1/GEN.1.KJV");
                },
                //https://www.bible.com/bible/1/GEN.1.KJV
                trailing: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Text(
                  'Complaint',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.white),
            Card(
              color: Colors.grey,
              child: ListTile(
                onTap: () {
                 // _launchInBrowser("https://tlwc.faithpays.org/");
                },
                trailing: Icon(Icons.link, color: Colors.white),
                title: Text(
                  'Suggestion',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.white),
            Card(
              color: Colors.grey,
              child: ListTile(
                onTap: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => ProfileApp()));
                },
                trailing: Icon(Icons.contacts, color: Colors.white),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.white),
              //SizedBox(height: 150,),
           
            Card(
              color: Colors.grey,
              child: ListTile(
                onTap: () {
                  // Navigator.push(595084
                  //   context,690599
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                //  );
                },
                trailing:
                    Icon(Icons.notifications_outlined, color: Colors.white),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.white),
              SizedBox(height: 250,),
           
            Card(
              color: Colors.red,
              child: ListTile(
                onTap: () {
                  // Navigator.push(595084
                  //   context,690599
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(),
                  //   ),
                //  );
                },
                trailing:
                    Icon(Icons.exit_to_app, color: Colors.white),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
