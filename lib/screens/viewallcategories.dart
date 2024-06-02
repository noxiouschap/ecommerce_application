import 'package:flutter/material.dart';

class ViewAllCategories extends StatelessWidget {
  const ViewAllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade100,
      // automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      //  widget.back,
      title: const Text(
        "Categories",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    ));
  }
}
