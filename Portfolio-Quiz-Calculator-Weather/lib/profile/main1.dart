import 'package:flutter/material.dart';

import 'about.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Personal Portfolio'),
            centerTitle: true,
            bottom: const TabBar(isScrollable: true, tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'About',
              ),

            ]),
          ),

          body: TabBarView(
            children: [
              AboutPage(),

            ],
          ),
        ));
  }
}
