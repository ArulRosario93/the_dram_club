import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:the_dram_club/Pages/SearchUsersAdd/UserItemtoAdd/userItemAdd.dart';

class SearchUserAdd extends StatefulWidget {
  const SearchUserAdd({super.key});

  @override
  State<SearchUserAdd> createState() => _SearchUserAddState();
}

class _SearchUserAddState extends State<SearchUserAdd> {
  List allUsers = [];
  List filteredUsers = [];
  List selectedUsers = [];

  void handleSelectedUsers(String email, String name) {
    if (selectedUsers
        .any((ele) => ele['email'] == email && ele['name'] == name)) {
      setState(() {
        selectedUsers.removeWhere(
            (element) => element['email'] == email && element['name'] == name);
      });
    } else {
      setState(() {
        selectedUsers.add({'email': email, 'name': name});
      });
    }
    print(selectedUsers);
  }

  @override
  Widget build(BuildContext context) {
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
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search Users",
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
                      "assets/Lottie/people.json",
                      fit: BoxFit.fitWidth,
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 20,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return UserItemAdd(
                                userEmailID: "Arul Rosario $index",
                                userName: "itsarrowhere380@gmail.com",
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
