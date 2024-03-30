import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:the_dram_club/Pages/CreateWorkspace/create_workspace.dart";

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

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
      backgroundColor: Colors.blue,
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
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Text(
                        "HO",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      title: Text(
                        "Home",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      // splashColor: Colors.greenAccent,
                      splashColor: Colors.grey[800],
                      subtitle: Text(
                        "Home Page should be the best how you sodbaba",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400, color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Text(
                        "HO",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      title: Text(
                        "Home",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      splashColor: Colors.black,
                      subtitle: Text(
                        "Home Page should be the best how you sodbaba",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400, color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Text(
                        "HO",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      title: Text(
                        "Home",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      splashColor: Colors.black,
                      subtitle: Text(
                        "Home Page should be the best how you sodbaba",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400, color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
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
                ListTile(
                  // tileColor: Colors.grey,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
