import 'package:flutter/material.dart';
import '../widgets/header_component.dart';
import '../widgets/navigationIcons_component.dart';
import '../widgets/statusList_component.dart';

class HomePage extends StatelessWidget {
  final String userName;

  HomePage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Header(userName: userName, profileImageUrl: 'assets/images/profile.jpg'),
          NavigationIcons(),
          Expanded(child: StatusList()),
        ],
      ),
    );
  }
}
