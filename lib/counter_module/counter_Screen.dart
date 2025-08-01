import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/counter_module/counterProvider.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss the keyboard
      child: Container(
        decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black,Colors.blueAccent, Colors.white],
                      begin: Alignment.topRight,
                      end: Alignment.centerLeft
                    ),
                  ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: Stack(
            children:[ 
              ListView(
              children: [
                SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                'Managed by',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                                ),
                                Text(
                                'PropText Sdn. Bhd.',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                    'T2-18-01, Tower 2',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    ),
                                    Image.asset(
                                  'assets/switch-acc.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.fill,
                                ),
                                  ],
                                ),
                                Text(
                                    'NovaPoint',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    ),
                                    SizedBox(height: 10),
                                Row(
                                  spacing: 5,
                                  children: [
                                    Text(
                                    'Sunny 34°',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    ),
                                    Image.asset(
                                  'assets/Sunny-image.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.fill,
                                ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Image.asset(
                                  'assets/qr-image.png',
                                    width: MediaQuery.of(context).size.width * 0.045,
                                    height: MediaQuery.of(context).size.width * 0.045,
                                  fit: BoxFit.fill,
                                ),
                                Image.asset(
                                  'assets/bell-image.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/Ellipse 28.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final height = constraints.maxHeight;
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/home-bg-white-1.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/home-bg-white-2.png',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),
                        
                        Positioned(
                          top: 100,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.0), // transparent at top
                              Colors.white, // starts becoming white close to top
                              Colors.white, // solid white at bottom
                            ],
                            stops: [0.0, 0.15, 1.0], // adjust 0.15 to control where white starts
                            ),
                          ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomePageCardsWidget(),
                                BoldTitleWidget(),
                                MainPageCalendarWidget(),
                                DeveloperModuleWidget(),
                                HomePageGridWidget(),

                                 SizedBox(height: 60),

                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ]
            ),
            ]
          ),
        ),
      ),
    );
  }
}

class HomePageGridWidget extends StatelessWidget {
  const HomePageGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 0.85,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          final modules = [
            'Events',
            'Documents',
            'Forms',
            'Feedback',
            'ePolling',
            'Contacts',
            'Committee',
            'Security',
            'Access',
            'Facility',
          ];
          final icons = [
            'assets/icn-events.png',
            'assets/icn-document.png',
            'assets/icn-forms.png',
            'assets/icn-feedback.png',
            'assets/icn-poll.png',
            'assets/icn-contact.png',
            'assets/icn-committees.png',
            'assets/icn-security.png',
            'assets/icn-access.png',
            'assets/icn-facility.png',
          ];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  icons[index],
                  width: 35,
                  height: 35,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5),
              Text(
                modules[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,//MediaQuery.of(context).size.height * 0.01,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DeveloperModuleWidget extends StatelessWidget {
  const DeveloperModuleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.095,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.0625,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6).withOpacity(1),
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final items = [
                  {'icon': 'assets/icn-day-vp.png', 'label': 'Vacant Possession'},
                  {'icon': 'assets/icn-day-defect.png', 'label': 'Defect Report'},
                  {'icon': 'assets/icn-day-inspection.png', 'label': 'Joint Inspection'},
                  {'icon': 'assets/icn-day-appointment.png', 'label': 'Appointment'},
                ];
                int itemCount = items.length.clamp(1, 4);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            items[index]['icon'] as String,
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            items[index]['label'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.009,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MainPageCalendarWidget extends StatelessWidget {
  const MainPageCalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.085,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          Expanded(
            child: SizedBox(
              height: 100,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = (constraints.maxWidth - 60) / 7;
                  final double borderRadius = cardWidth / 2;
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  final dates = [
                    '01',
                    '02',
                    '03',
                    '04',
                    '05',
                    '06',
                    '07',
                  ];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      return SizedBox(
                        width: cardWidth,
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          elevation: 0,
                          child: Container(
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  days[index % days.length],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: MediaQuery.of(context).size.width * 0.027,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  dates[index % dates.length],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Builder(
                                  builder: (context) {
                                    final dotCount = (index % 4);
                                    final colors = [
                                      Colors.purple,
                                      Colors.green,
                                      Colors.red,
                                    ];
                                    final dotColors = colors.take(dotCount).toList();
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        dotColors.length,
                                        (i) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                            child: Container(
                                              width: 5,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: dotColors[i],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          Image.asset(
            'assets/icn-day-arrownext.png',
            width: 30,
            height: 30,
          ),
        ],
      ),
    );
  }
}

class BoldTitleWidget extends StatelessWidget {
  const BoldTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0, bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'My Activity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class HomePageCardsWidget extends StatelessWidget {
  const HomePageCardsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            spacing: 5,
            children: [
              Container(
                width: (constraints.maxWidth - 10) * 0.55,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Outstanding Payment',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RM 12.351.181',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular((MediaQuery.of(context).size.width * 0.1) / 2),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            // Add your pay now logic here
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Pay now',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                spacing: 5,
                children: [
                  Expanded(
                    child: Container(
                      width: (constraints.maxWidth - 10) * 0.275,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBEBEB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 5.0, right: 5.0, bottom: 5.0),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/bnr-guard.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Call',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Guard',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: (constraints.maxWidth - 10) * 0.275,
                      decoration: BoxDecoration(
                        color: Color(0xFFFEF4E2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 5.0, right: 5.0, bottom: 5.0),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/bnr-mo.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Call',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Management',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.0275,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE1E5FD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 5.0, right: 5.0, bottom: 5.0),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/bnr-facility.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.025,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Facility',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.0275,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

