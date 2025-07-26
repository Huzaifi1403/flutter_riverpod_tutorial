import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/counter_module/weekly_calendar_view.dart';

class DisplayHomepageBanner extends StatelessWidget {
  const DisplayHomepageBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Stack(
        children: [
          Image.asset(
            'assets/white_template.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 40,
            child: SizedBox(
              height: 10,
              width: width,
              child: Row(
                children: [
                  Flexible(
                    flex: 9,
                    child: Card(
                      color: const Color(0xffFF001A),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Outstanding Payment',
                              style:
                                  TextStyle(fontSize: 8, color: Colors.white),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "RM 12,351.18",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Container(
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0x66FFFFFF),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                            size: 15,
                                            color: Colors.white,
                                            Icons.visibility_off)),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                // Implement your payment logic here
                              },
                              child: Container(
                                margin: const EdgeInsets.all(0),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Color(0xffFF001A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(3),
                          color: Color(0xffFBEBEB),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/red-sheild.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Call',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xff3B4775)),
                                    ),
                                    Text('Guard',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff3B4775),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.all(3),
                          color: const Color(0xffFEF4E2),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/headphone-1.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text('Call',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff3B4775))),
                                    Text('Management',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff3B4775),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 3,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  'assets/purple-calendar.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Book',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xff3B4775))),
                                  Text('Facility',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xff3B4775),
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top + 140,
              left: 0,
              right: 0,
              child: WeeklyCalendarView()),
        ],
      );
    });
  }
}
