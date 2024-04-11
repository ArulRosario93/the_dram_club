import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Home/home.dart';
import 'package:the_dram_club/Pages/SearchUsersAdd/UserItemtoAdd/userItemAdd.dart';

class SearchUserAdd extends StatefulWidget {
  final List allUsers;
  final String workSpaceID;
  final String workspaceName;
  final String userName;
  final String userEmailID;
  final String workspaceDescription;
  const SearchUserAdd(
      {super.key,
      required this.allUsers,
      required this.workSpaceID,
      required this.workspaceName,
      required this.userName,
      required this.userEmailID,
      required this.workspaceDescription});

  @override
  State<SearchUserAdd> createState() => _SearchUserAddState();
}

class _SearchUserAddState extends State<SearchUserAdd> {
  List filteredUsers = [];
  List selectedUsers = [];

  TextEditingController searchController = TextEditingController();

  void handleSelectedUsers(String email, String name) {
    if (selectedUsers
        .any((ele) => ele['Email-ID'] == email && ele['Name'] == name)) {
      setState(() {
        selectedUsers.removeWhere((element) =>
            element['Email-ID'] == email && element['Name'] == name);
      });
    } else {
      setState(() {
        selectedUsers.add({'Email-ID': email, 'Name': name});
      });
    }
    print(selectedUsers);
  }

  void handleSearch(String val) {
    setState(() {
      filteredUsers = widget.allUsers
          .where((element) => element['Name'].contains(val))
          .toList();
    });
  }

  void showMsg(String res) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res),
      ),
    );
  }

  void goHome() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }

  void handleSubmit() async {
    String res = await AuthServices().requestUsertoJoinWorkspace(
        widget.workSpaceID,
        widget.userName,
        widget.userEmailID,
        widget.workspaceName,
        widget.workspaceDescription);

    if (res == "Success") {
      showMsg("Request Sent Successfully");
      goHome();
    } else {
      showMsg(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.allUsers);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Add Users To Workspace",
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: handleSearch,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search Users by Name",
                        hintStyle: GoogleFonts.montserrat(),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(55))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: filteredUsers.isEmpty
                  ? LottieBuilder.asset(
                      frameRate: FrameRate.composition,
                      "assets/Lottie/people.json",
                      repeat: false,
                      options: LottieOptions(enableMergePaths: true),
                      fit: BoxFit.fitWidth,
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredUsers.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return UserItemAdd(
                                userEmailID: filteredUsers[index]["Email-ID"],
                                userName: filteredUsers[index]["Name"],
                                selectedUsers: handleSelectedUsers,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
            selectedUsers.isNotEmpty
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add ${selectedUsers.length} Users",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
