import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_screen.dart';
import 'package:flutter_riverpod_tutorial/counter_module/counter_Screen.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_screen.dart';
import 'package:flutter_riverpod_tutorial/todo_module/todo_Screen.dart';

class KBottomBar extends StatefulWidget {
  const KBottomBar({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<KBottomBar> createState() => _KBottomBarState();
}

class _KBottomBarState extends State<KBottomBar> {
  late int currentIndex;
  List<Widget> pages = [
    const CounterScreen(),
    const TodoScreen(),
    const PostScreen(),
    AuthScreen()
  ];
  late final PageController pageController;
  @override
  void initState() {
    currentIndex = widget.currentIndex ?? 0; // Default to 0 if null
    super.initState();
    pageController = PageController(
      initialPage: currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomBarItems,
        currentIndex: currentIndex,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200), // Animation duration
            curve: Curves.easeInOut, // Animation curve
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> get getBottomBarItems {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.numbers),
        label: 'Int',
        backgroundColor: Colors.blue, // Add a color
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.view_module),
        label: 'Module',
        backgroundColor: Colors.green,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.post_add),
        label: 'Post',
        backgroundColor: Colors.orange,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Auth',
        backgroundColor: Colors.purple,
      ),
    ];
  }
}
