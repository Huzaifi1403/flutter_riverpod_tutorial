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
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                    color: Colors.white,
                    blurRadius: 20.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black.withOpacity(0.10),
                    width: 3,
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
                      icon: Icon(Icons.home),
                    ),
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(1);
                      },
                      icon: Icon(Icons.newspaper),
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
                        'assets/chatbot-round.gif',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(3);
                      },
                      icon: const Icon(Icons.notifications),
                    ),
                    IconButton(
                      onPressed: () {
                      pageController.jumpToPage(4);
                      },
                      icon: const Icon(Icons.person),
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
