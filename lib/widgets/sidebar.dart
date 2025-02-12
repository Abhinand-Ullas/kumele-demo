import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedIndex = 0;

  final List<String> icons = [
    'assets/home.png',
    'assets/books.png',
    'assets/bag.png',
    'assets/messages.png',
    'assets/chart1.png',
    'assets/settings.png',
    'assets/filter.png',
    'assets/cart.png',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: 80,
      height: height,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: selectedIndex == index
                          ? Border(
                              left: BorderSide(
                                color: Colors.blue,
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    child: Center(
                      child: Image.asset(
                        icons[index],
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
