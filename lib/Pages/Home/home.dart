import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Home/ChannelPage/channel_page.dart';
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
  var user;
  int _selectedIndex = 0;
  var workspace = [];
  bool loading = true;

  var curentWorkspaceShortBrief;

  var curentWorkspace;

  void handleFirstIntialData(val) {
    user = val;
    print(val['Workspace']);
    workspace = val['Workspace'];
    if (workspace.isNotEmpty) {
      curentWorkspaceShortBrief = val['Workspace'].firstWhere(
        (element) => element['lastVisited'] == true,
      );
    }
    loading = false;
    setState(() {});
  }

  void handleSecondIntialData() async {
    if (workspace.isNotEmpty) {
      await AuthServices()
          .getWorkspace(curentWorkspaceShortBrief["ID"])
          .then((value) => {
                curentWorkspace = value,
              });
      setState(() {});
    }
  }

  void handleInitialData() async {
    await AuthServices()
        .getUser()
        .then(handleFirstIntialData)
        .then((val) => handleSecondIntialData);
  }

  void handlePage(int val) {
    setState(() {
      _selectedIndex = val;
    });
  }

  void handleGotogetStarted() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationPage()));
  }

  @override
  void initState() {
    super.initState();
    handleInitialData();
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      ChannelPage(
          userID: user?['Email-ID'] ?? "",
          userName: user?['Name'] ?? "",
          list: curentWorkspace?['Channels'] ?? [],
          workspaceID: curentWorkspaceShortBrief?["ID"] ?? ""),

      // 0, 1, 2
      const LeaveForm(
        role: 1,
        strict: 2,
      ),
      // "Profile",
    ];

    if (loading &&
        curentWorkspaceShortBrief == null &&
        curentWorkspaceShortBrief?['Name'] == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        drawer: DrawerMain(list: workspace, userName: user?['Name'] ?? "", emailID: user?['Email-ID'] ?? "",),
        appBar: AppBar(
          title: Text(
            curentWorkspaceShortBrief?['Name'] ?? "The Dram Club",
            style: GoogleFonts.montserrat(),
          ),
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
