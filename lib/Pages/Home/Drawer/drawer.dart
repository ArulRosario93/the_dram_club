import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Pages/CreateWorkspace/create_workspace.dart";

class DrawerMain extends StatelessWidget {
  final List list;
  const DrawerMain({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    void createWorkspace() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateWorkSpace(),
          ));
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
                        title: Text(
                          "Create a Workspace to get started",
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
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
