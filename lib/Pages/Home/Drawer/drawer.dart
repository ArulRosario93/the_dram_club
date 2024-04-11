import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Auth_services/auth_services.dart";
import "package:the_dram_club/Pages/CreateWorkspace/create_workspace.dart";
import "package:the_dram_club/Pages/Home/home.dart";

class DrawerMain extends StatelessWidget {
  final List list;
  final String emailID;
  final String userName;
  const DrawerMain(
      {super.key,
      required this.list,
      required this.emailID,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    void createWorkspace() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CreateWorkSpace(emailID: emailID, userName: userName),
          ));
    }

    void showMsg(String res) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
        duration: const Duration(seconds: 2),
      ));
    }

    void goHome() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    void handleChangeWorkspace(
        String emailID,
        String workspaceID,
        String workspaceName,
        String workspaceDescription,
        String Role,
        int RoleInt) async {
      // Add your logic here
      String res = await AuthServices().changeWorkspace(workspaceID, emailID,
          workspaceName, workspaceDescription, Role, RoleInt);

      if (res == "Success") {
        showMsg("Workspace Changed");
        goHome();
      } else {
        // Add your logic here
        showMsg(res);
      }
    }

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            "WorkSpace",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: list.isEmpty
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (list.isEmpty)
                      ListTile(
                        // tileColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        leading: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onTap: createWorkspace,
                        title: Text(
                          "Create Workspace",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    for (var i in list)
                      ListTile(
                        leading: Text(
                          i['Name'][0] + i['Name'][1],
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                        title: Text(
                          i['Name'],
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        trailing: Icon(
                          Icons.more_horiz_rounded,
                          color: i["lastVisited"] == true
                              ? Colors.white70
                              : Colors.grey,
                        ),
                        tileColor: i["lastVisited"] == true
                            ? Colors.grey[700]
                            : const Color.fromARGB(255, 15, 15, 15),
                        splashColor: Colors.grey[800],
                        subtitle: Text(
                          i['Description'],
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.white70),
                        ),
                        onTap: () => handleChangeWorkspace(
                            emailID,
                            i["ID"],
                            i["Name"],
                            i["Description"],
                            i["Role"],
                            i["RoleInt"]),
                      )
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                list.isNotEmpty
                    ? ListTile(
                        // tileColor: Colors.grey,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        leading: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onTap: createWorkspace,
                        title: Text(
                          "Create Workspace",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      )
                    : const SizedBox(),
                ListTile(
                  // tileColor: Colors.grey,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  onTap: () async => await AuthServices().signOut(),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
