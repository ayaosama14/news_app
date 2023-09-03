import 'package:flutter/material.dart';

import '../../../../core/components.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }),
        Row(
          children: [
            mainCircleAvatar(Icons.search),
            mainCircleAvatar(Icons.notifications_none_rounded),
          ],
        ),
      ],
    );
  }
}
