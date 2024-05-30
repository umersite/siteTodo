import 'package:flutter/material.dart';
import 'package:flutter_todos/pages/login_page.dart';
import 'package:flutter_todos/routes/page_routes.dart';
import 'package:flutter_todos/services/auth_service.dart';

class NavigationCustomDrawer extends StatefulWidget {
  const NavigationCustomDrawer({super.key});

  @override
  State<NavigationCustomDrawer> createState() => _NavigationCustomDrawerState();
}

class _NavigationCustomDrawerState extends State<NavigationCustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blueGrey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            createDrawerHeader(),
            createDrawerBodyItem(
                icon: Icons.contact_page,
                text: "Home Page",
                onTap: () =>
                    Navigator.pushReplacementNamed(context, PageRoutes.home)),
            createDrawerBodyItem(
                icon: Icons.contact_page,
                text: "Comment",
                onTap: () => Navigator.pushReplacementNamed(
                    context, PageRoutes.comments)),
            createDrawerBodyItem(
                icon: Icons.contact_page,
                text: "About Us",
                onTap: () => Navigator.pushReplacementNamed(
                    context, PageRoutes.aboutus)),
            createDrawerBodyItem(
                icon: Icons.contact_page,
                text: "Logout",
                onTap: () {
                  AuthenticationHelper().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }),
            const Divider(
              color: Colors.white,
            ),
            ListTile(
              title: const Text(
                'App version 1.0.0',
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

Widget createDrawerHeader() {
  return const SizedBox(
    height: 250.0,
    child: DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("assets/images/banner.jpg"))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 80,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/images/drawer_back.jpg"),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("Dead Man Inc."),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    ),
  );
}

Widget createDrawerBodyItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: [
        Icon(
          icon,
          color: Colors.yellowAccent,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
