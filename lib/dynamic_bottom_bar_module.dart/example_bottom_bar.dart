import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/auth_module/auth_screen.dart';
import 'package:flutter_riverpod_tutorial/counter_module/counter_Screen.dart';
import 'package:flutter_riverpod_tutorial/post_module/post_screen.dart';
import 'package:flutter_riverpod_tutorial/todo_module/todo_Screen.dart';

class ExampleBottomBar extends StatefulWidget {
  const ExampleBottomBar({super.key});

  @override
  State<ExampleBottomBar> createState() => _ExampleBottomBarState();
}

class _ExampleBottomBarState extends State<ExampleBottomBar> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  List<Widget> pages = [
    const CounterScreen(),
    const TodoScreen(),
    const CounterScreen(),
    const PostScreen(),
    AuthScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                child: Container(
                  margin: const EdgeInsets.only(left:  32, right: 32, top: 0, bottom: 24),
                  decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                  color: Colors.transparent,
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                    offset: Offset(0,0),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black.withOpacity(0.10),
                    width: 1.5,
                  ),
                  ),
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(0);
                      },
                      icon: Image.asset(
                      'assets/nav-day-home.png',
                      width: 40,
                      height: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(1);
                      },
                      icon: Image.asset(
                      'assets/nav-day-market.png',
                      width: 40,
                      height: 40,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 2),
                        ),
                      ],
                      ),
                      child: Image.asset(
                        'assets/nav-day-lunex.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(3);
                      },
                      icon: Image.asset(
                      'assets/nav-day-bell.png',
                      width: 40,
                      height: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(4);
                      },
                      icon: Image.asset(
                      'assets/nav-day-more.png',
                      width: 40,
                      height: 40,
                      ),
                    ),
                    ],
                  ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
