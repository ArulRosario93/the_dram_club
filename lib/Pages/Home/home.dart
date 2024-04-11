import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/ChatBot/chat_bot.dart';
import 'package:the_dram_club/Pages/DirectMessages/direct_message.dart';
import 'package:the_dram_club/Pages/Home/ChannelPage/channel_page.dart';
import 'package:the_dram_club/Pages/Home/Drawer/drawer.dart';
import 'package:the_dram_club/Pages/LeaveForm/leave_form.dart';
import 'package:the_dram_club/Pages/Notifications/notification.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:the_dram_club/Pages/Profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user;
  var allUsers;
  int _selectedIndex = 0;
  var workspace = [];
  bool loading = true;
  var curentWorkspaceShortBrief;
  late DialogFlowtter dialogFlowtter;
  var curentWorkspace;

  void handleFirstIntialData(val) {
    setState(() {
      user = val;
      workspace = val['Workspace'];
      if (workspace.isNotEmpty) {
        curentWorkspaceShortBrief = val['Workspace'].firstWhere(
          (element) => element['lastVisited'] == true,
        );
      }
      loading = false;
    });
    // DialogAuthCredentials credentials = DialogAuthCredentials.fromJson(json);
    dialogFlowtter =
        DialogFlowtter(sessionId: "123456", jsonPath: "assets/service.json");
  }

  void handleSecondIntialData(val) async {
    if (workspace.isNotEmpty) {
      await AuthServices()
          .getWorkspace(curentWorkspaceShortBrief["ID"])
          .then((value) => {
                curentWorkspace = value,
              });
      setState(() {});
    }
  }

  void handleThirdIntialData(val) async {
    await AuthServices().getAllUsers().then((value) => {
          setState(() {
            allUsers = value.docs.map((e) => e.data()).toList();
          })
        });
  }

  void handleInitialData() async {
    await AuthServices()
        .getUser()
        .then(handleFirstIntialData)
        .then(handleSecondIntialData)
        .then(handleThirdIntialData);
  }

  //For Chat Bot
  final ScrollController _scrollController = ScrollController();

  bool openBot = false;
  List messages = [
    {
      "text": "Hello, I am your assistant Drammy. How you doin?",
      "isUser": false
    }
  ];
  void handleMsg(String msg) {
    // setState(() {
    //   messages.add(msg);
    // });
    handleDetectIntent(msg);
  }

  void handleDetectIntent(String msg) async {
    await dialogFlowtter
        .detectIntent(
            queryInput: QueryInput(
          text: TextInput(text: msg),
        ))
        .then((value) => setState(() {
              messages.add({
                "text": value.message?.text?.text?[0] ?? "",
                "isUser": false
              });
            }));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void handleCloseBot() {
    // setState(() {
    //   openBot = false;
    // });
    handleCloseitNow();
  }

  void handleCloseitNow() {
    setState(() {
      openBot = false;
    });
  }

  void handlePage(int val) {
    setState(() {
      _selectedIndex = val;
    });
  }

  void handleGotogetStarted() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationPage(
                emailID: user?['Email-ID'] ?? "",
                userDP: user?['profilePic'] ?? "",
                name: user?['Name'] ?? "")));
  }

  void handleEnv() async {
    await dotenv.load(
      fileName: "assets/.env",
    );
  }

  @override
  void initState() {
    super.initState();
    handleEnv();
    handleInitialData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ChannelPage(
          userID: user?['Email-ID'] ?? "",
          userName: user?['Name'] ?? "",
          list: curentWorkspace?['Channels'] ?? [],
          allUsers: allUsers ?? [],
          workspaceName: curentWorkspaceShortBrief?["Name"] ?? "",
          workspaceDescription: curentWorkspaceShortBrief?["Description"] ?? "",
          workspaceID: curentWorkspaceShortBrief?["ID"] ?? ""),

      // 0, 1, 2
      LeaveForm(
        role: curentWorkspaceShortBrief?["Role"] ?? "",
        roleInt: curentWorkspaceShortBrief?["RoleInt"] ?? 0,
        strict: 2,
        allForms: [
          curentWorkspace?["Requests"] ?? [],
          curentWorkspace?["Responses"] ?? []
        ],
        workspaceID: curentWorkspaceShortBrief?["ID"] ?? "",
        emailID: user?['Email-ID'] ?? "",
        userName: user?['Name'] ?? "",
        userDP: user?['profilePic'] ?? "",
        userAttandance: user?['Attandance-Record'] ?? 0,
      ),

      //Direct Messages
      DirectMessages(
        directMessage: user?["Direct-Messages"] ?? [],
      ),

      // "Profile",
      Profile(
        name: user?["Name"] ?? "",
        emailID: user?["Email-ID"] ?? "",
        status: user?["Status"] ?? "",
        attandancePercentage: user?["Attandance-Record"] ?? 0,
      )
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
        extendBody: true,
        resizeToAvoidBottomInset: true,
        // extendBodyBehindAppBar: true,
        drawer: DrawerMain(
          list: workspace,
          userName: user?['Name'] ?? "",
          emailID: user?['Email-ID'] ?? "",
        ),
        appBar: AppBar(
          title: Text(
            _selectedIndex == 3
                ? "Profile"
                : _selectedIndex == 2
                    ? "Direct Messages"
                    : _selectedIndex == 1
                        ? "Form"
                        : curentWorkspaceShortBrief?['Name'] ?? "The Dram Club",
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
        floatingActionButton: _selectedIndex == 0
            ? AnimatedContainer(
                duration: Durations.extralong1,
                curve: Curves.easeInOut,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: openBot ? MediaQuery.of(context).size.height * .5 : 60,
                width: openBot ? MediaQuery.of(context).size.width * .9 : 60,
                child: openBot
                    ? Container(
                        color: Colors.white,
                        child: ChatBot(
                          bottomScroll: _scrollToBottom,
                          toClose: handleCloseBot,
                          scroller: _scrollController,
                          messages: messages,
                          handleMsg: handleMsg,
                          boolval: openBot,
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.chat),
                        onPressed: () {
                          setState(() {
                            openBot = !openBot;
                          });
                        },
                      ),
              )
            : null,
        bottomNavigationBar: GNav(
          backgroundColor: Colors.white,
          gap: 8.0,
          onTabChange: handlePage,
          // tabBackgroundColor: Colors.grey.shade50,
          padding: const EdgeInsets.all(18.0),
          color: Colors.black,
          activeColor: Colors.black,
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.format_align_center, text: 'Form'),
            GButton(icon: Icons.message_rounded, text: 'Chats'),
            GButton(icon: Icons.person_2_rounded, text: 'Profile'),
          ],
        ),
        body: pages[_selectedIndex]);
  }
}
