import 'package:flutter/material.dart';

PreferredSizeWidget MainAppBar(BuildContext context, String title) {
  return AppBar(
    toolbarHeight: 100,
    backgroundColor: Colors.black,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      const CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
