import 'package:flutter/material.dart';
import 'package:the_dram_club/Pages/GetStarted/get_started.dart';
import 'package:the_dram_club/Pages/Home/Drawer/drawer.dart';
import 'package:the_dram_club/Pages/LeaveForm/leave_form.dart';
import 'package:the_dram_club/Pages/Notifications/notification.dart';
import 'package:the_dram_club/Utils/hovering_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void handleInitialData() {
    // print("WAITING FOR USER DATA");
    // var snap = await AuthServices().getCurrentUser();
    // print(snap);
  }

  void handlePage(int val) {
    setState(() {
      _selectedIndex = val;
    });
  }

  void handleGotogetStarted() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NotificationPage()));
  }

  @override
  void initState() {
    super.initState();
    handleInitialData();
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const Column(
        children: [
          HoveringWidget(),
          HoveringWidget(),
          Center(
            child: Text('Welcome to Dram'),
          ),
        ],
      ),

      // 0, 1, 2
      const LeaveForm(role: 2, strict: 2,),
      // "Profile",
    ];

    return Scaffold(
        drawer: const DrawerMain(),
        appBar: AppBar(
          title: const Text('Dram Club'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                handleGotogetStarted();
              },
            ),
            const SizedBox(width: 10)
          ],
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          height: 70,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () => handlePage(0),
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.black, width: 2),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.home)),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () => handlePage(1),
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.request_page)),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.person)),
                ),
              ]),
        ),
        body: pages[_selectedIndex]);
  }
}
