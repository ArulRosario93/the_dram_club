import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User DB architecture
  // Attandance-Record: ""
  // Direct-Messages: []
  // Email-ID: ""
  // Leave-Record: ""
  // Name: ""

  // Notifications: []
  // Workspace: [
  //  {
  //  "Name": "",
  //  "Role": "",
  //  "Workspace-ID": ""
  //  "last-visited": true,
  // }
  // ]
  // profile-file: ""

  Future<bool> userExist(String emailID) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(emailID)
        .get()
        .then((value) {
      if (value.exists && value.data()?['Authentications']) {
        return true;
      }
    });
    return false;
  }

  Future<String> userAuthentication(String emailID) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(emailID)
        .get()
        .then((value) {
      if (value.exists) {
        return value.data()!["Authentications"];
      }
    });
    return "No Data";
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

    

      await FirebaseFirestore.instance.collection("Users").doc(user.email).set({
        "Name": user.email,
        "Email-ID": user.email,
        "UID": user.uid,
        "profilePic": "",
        "Status": '',
        "Attandance-Record": 78,
        "Direct-Messages": [],
        "Leave-Record": "",
        "Notifications": [],
        "Authentications": "Email-Password",
        "Workspace": [],
      });
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  //Google Sign in
  Future<String> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        return "No Account Founded";
      }
      UserCredential result = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      User user = result.user!;
      if (await userExist(user.email!)) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.email)
            .update({
          "Authentications": "Google",
        });
        return "SUCCESS";
      } else {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.email)
            .set({
          "Name": user.displayName,
          "Email-ID": user.email,
          "UID": user.uid,
          "profilePic": user.photoURL,
          "Attandance-Record": 80,
          "Direct-Messages": [],
          "Status": '',
          "Leave-Record": "",
          "Authentications": "Google",
          "Notifications": [],
          "Workspace": [],
        });
      }
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createWorkspace(
    String name,
    String emailID,
    String workspaceName,
    int strict,
    List roles,
    String role,
    String description,
  ) async {
    // Create UUID
    String res = "Error";

    const uuid = Uuid();
    final id = uuid.v1();

    try {
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Workspace": FieldValue.arrayUnion([
          {
            "Name": workspaceName,
            "Role": role,
            "RoleInt": 0, // 0 for admin
            "Description": description,
            "ID": id,
            "lastVisited": true,
          }
        ]),
      });

      // assigning last visited false to all other workspaces of the user
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(emailID)
          .get()
          .then((value) async {
        List workspaces = value.data()!["Workspace"];
        for (var i in workspaces) {
          if (i["ID"] != id) {
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(emailID)
                .update({
              "Workspace": FieldValue.arrayRemove([
                {
                  "Name": i["Name"],
                  "Role": i["Role"],
                  "Description": i["Description"],
                  "ID": i["ID"],
                  "lastVisited": true,
                }
              ]),
            });
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(emailID)
                .update({
              "Workspace": FieldValue.arrayUnion([
                {
                  "Name": i["Name"],
                  "Role": i["Role"],
                  "Description": i["Description"],
                  "ID": i["ID"],
                  "lastVisited": false,
                }
              ]),
            });
          }
        }
      });

      final channelID = const Uuid().v1();

      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(id)
          .collection(channelID)
          .doc("Files")
          .set({});
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(id)
          .collection(channelID)
          .doc("Messages")
          .set({
        "Msg": {
          "Round1": [],
          "roundCount": 0,
          "currentRound": 1,
        },
      });

      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(id)
          .collection(channelID)
          .doc("Users")
          .set({
        "Users": [
          {
            "Name": name,
            "Email-ID": emailID,
            "Data-Joined": Timestamp.now(),
          },
        ]
      });

      await FirebaseFirestore.instance.collection("Workspace").doc(id).set({
        "All-Users": {
          "Name": name,
          "Email-ID": emailID,
          "Data-Joined": Timestamp.now(),
        },
        "Name": workspaceName,
        "Admin": emailID,
        "Roles": roles,
        "Strict": strict,
        "Channels": [
          {
            "Name": "General",
            "ID": channelID,
            "Description": "General Channel",
          }
        ],
        "Requests": [],
        "Responses": []
      });

      res = "Success";
    } catch (e) {
      // print(e.toString());
      res = e.toString();
    }

    return res;
  }

  Future createChannel(String workspaceID, String channelName,
      String description, String name, String emailID, List people) async {
    String res = "Error";
    try {
      final id = const Uuid().v1();

      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .collection(id)
          .doc("Files")
          .set({});
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .collection(id)
          .doc("Messages")
          .set({
        "Msg": {
          "Round1": [],
          "roundCount": 0,
          "currentRound": 1,
        },
      });
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .collection(id)
          .doc("Users")
          .set({
        "Users": [
          {
            "Name": name,
            "Email-ID": emailID,
            "Data-Joined": Timestamp.now(),
          },
          ...people
        ]
      });
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .update({
        "Channels": FieldValue.arrayUnion([
          {
            "Name": channelName,
            "ID": id,
            "Description": description,
          }
        ]),
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> requestUsertoJoinWorkspace(
    String workSpaceID,
    String name,
    String role,
    int roleInt,
    String emailID,
    String workspaceName,
    String workspaceDescription,
  ) async {
    String res = "Error";

    final notificationID = const Uuid().v1();

    try {
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Notifications": FieldValue.arrayUnion([
          {
            "Name": workspaceName,
            "ID": workSpaceID,
            "Description": workspaceDescription,
            "notificationID": notificationID,
            "Data-Joined": Timestamp.now(),
            "Note": "You've been invited to join this workspace",
            "Type": "Request-Workspace",
          }
        ])
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future acceptRequestToJoinWorkspace(
    String workspaceID,
    String emailID,
    String name,
    String workspaceName,
    String role,
    int roleInt,
    String notificationID,
    String workspaceDescription,
  ) async {
    String res = "Error";

    try {
      //remove notification from the user
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Notifications": FieldValue.arrayRemove([
          {
            "Name": workspaceName,
            "ID": workspaceID,
            "Description": workspaceDescription,
            "notificationID": notificationID,
            "Data-Joined": Timestamp.now(),
            "Note": "You've been invited to join this workspace",
            "Type": "Request-Workspace",
          }
        ])
      });

      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Workspace": FieldValue.arrayUnion([
          {
            "Name": workspaceName,
            "Description": workspaceDescription,
            "ID": workspaceID,
            "Role": role,
            "RoleInt": roleInt,
            "lastVisited": false,
          }
        ])
      });

      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .update({
        "All-Users": FieldValue.arrayUnion([
          {
            "Email-ID": emailID,
            "Name": name,
            "Data-Joined": Timestamp.now(),
          }
        ])
      });

      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Notifications": FieldValue.arrayUnion([
          {
            "Note": "You've accepted to join $workspaceName workspace",
            "Time": Timestamp.now(),
            "Type": "Joined-Workspace",
          }
        ])
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> rejectRequestToJoinWorkspace(
    String workspaceID,
    String emailID,
    String name,
    String workspaceName,
    String workspaceDescription,
    String notificationID,
  ) async {
    String res = "Error";

    try {
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Notifications": FieldValue.arrayRemove([
          {
            "Name": workspaceName,
            "ID": workspaceID,
            "Description": workspaceDescription,
            "notificationID": notificationID,
            "Data-Joined": Timestamp.now(),
            "Note": "You've been invited to join this workspace",
            "Type": "Request-Workspace",
          }
        ])
      });

      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Notifications": FieldValue.arrayUnion([
          {
            "Note": "You've rejected to join $workspaceName workspace",
            "Time": Timestamp.now(),
            "Type": "Rejected-Workspace",
          }
        ])
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> exitUserFromWorkspace(
      String workspaceID, String emailID) async {
    String res = "Error";

    try {
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Workspace": FieldValue.arrayRemove([
          {
            "Name": workspaceID,
          }
        ])
      });

      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .update({
        "All-Users": FieldValue.arrayRemove([
          {
            "Email-ID": emailID,
          }
        ])
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future changeWorkspace(
    String workspaceID,
    String emailID,
    String workspaceName,
    String workspaceDescription,
    String Role,
    int RoleInt,
  ) async {
    String res = "Error";

    try {
      // assigning last visited false to all other workspaces of the user
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(emailID)
          .get()
          .then((value) async {
        List workspaces = value.data()!["Workspace"];
        for (var i in workspaces) {
          if (i["ID"] != workspaceID) {
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(emailID)
                .update({
              "Workspace": FieldValue.arrayRemove([
                {
                  "Name": i["Name"],
                  "Role": i["Role"],
                  "Description": i["Description"],
                  "ID": i["ID"],
                  "RoleInt": i["RoleInt"],
                  "lastVisited": true,
                }
              ]),
            });
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(emailID)
                .update({
              "Workspace": FieldValue.arrayUnion([
                {
                  "Name": i["Name"],
                  "Role": i["Role"],
                  "RoleInt": i["RoleInt"],
                  "Description": i["Description"],
                  "ID": i["ID"],
                  "lastVisited": false,
                }
              ]),
            });
          }
        }

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(emailID)
            .update({
          "Workspace": FieldValue.arrayUnion([
            {
              "Name": workspaceName,
              "Role": Role,
              "Description": workspaceDescription,
              "ID": workspaceID,
              "RoleInt": RoleInt,
              "lastVisited": true,
            }
          ]),
        });
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(emailID)
            .update({
          "Workspace": FieldValue.arrayRemove([
            {
              "Name": workspaceName,
              "Role": Role,
              "Description": workspaceDescription,
              "ID": workspaceID,
              "RoleInt": RoleInt,
              "lastVisited": false,
            }
          ]),
        });
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Stream getNotifications(String emailID) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(emailID)
        .snapshots();
  }

  Future<String> addUserToChannel(
      String workspaceID, String channelID, String name, String emailID) async {
    String res = "Error";

    try {
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .collection(channelID)
          .doc("Users")
          .update({
        "Users": FieldValue.arrayUnion([
          {
            "Name": name,
            "Email-ID": emailID,
            "Data-Joined": Timestamp.now(),
          }
        ])
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> channelChat(
      String workspaceID, String channelID) {
    return FirebaseFirestore.instance
        .collection("Workspace")
        .doc(workspaceID)
        .collection(channelID)
        .doc("Messages")
        .snapshots();
  }

  //Leave and responses
  Future<String> sendLeaveRequest(
    String workspaceID,
    String emailID,
    String name,
    String reason,
    String startDate,
    String endDate,
    String type,
    String userDP,
    int attandancePercenatge,
  ) async {
    String res = "Error";

    final requestID = const Uuid().v1();

    try {
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .update({
        "Requests": FieldValue.arrayUnion([
          {
            "Name": name,
            "Email-ID": emailID,
            "Reason": reason,
            "type": type,
            "Request-ID": requestID,
            "Start-Date": startDate,
            "End-Date": endDate,
            "Status": "Pending",
            "Profile-Pic": userDP,
            "Attandance-Percentage": attandancePercenatge,
            "Time":
                "${Timestamp.now().toDate().day} / ${Timestamp.now().toDate().month}",
          }
        ])
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await FirebaseFirestore.instance.collection("Users").get();
  }

  Future<String> sendLeaveResponse(
    String workspaceID,
    String emailID,
    String name,
    String reason,
    String type,
    String startDate,
    String endDate,
    String requestID,
    String responseType,
    int userAttandancePercentage,
    String time,
    String responseBy,
    String roleName,
    String responsebehavior,
    String response,
    String studentDP,
  ) async {
    String res = "Error";

    try {
      //Remove request from the workspace with the request ID
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .update({
        "Requests": FieldValue.arrayRemove([
          {
            "Name": name,
            "Email-ID": emailID,
            "Reason": reason,
            "type": type,
            "Request-ID": requestID,
            "Start-Date": startDate,
            "End-Date": endDate,
            "Status": "Pending",
            "Profile-Pic": studentDP,
            "Attandance-Percentage": userAttandancePercentage,
            "Time": time,
          }
        ])
      });

      //Add response to the workspace
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .update({
        "Responses": FieldValue.arrayUnion([
          {
            "Name": name,
            "Email-ID": emailID,
            "Request-ID": requestID,
            "Response": response,
            "Reason": reason,
            "Role": roleName,
            "Response-By": responseBy,
            "type": type,
            "Start-Date": startDate,
            "userSubmittedtime": time,
            "End-Date": endDate,
            "Response-Behavior": responsebehavior,
            "Attandance-Percentage": userAttandancePercentage,
            "Status": responseType,
            "Response-Time": Timestamp.now(),
          }
        ])
      });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // User user = result.user!;
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> changeUserName(String emailID, String name) async {
    String res = "Error";
    try {
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Name": name,
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> changeUserStatus(String emailID, String status) async {
    String res = "Error";
    try {
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Status": status,
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> sendMsgChannel(String workspaceID, String channelID,
      String msg, String emailiD, String name) async {
    String res = "Error";
    try {
      await FirebaseFirestore.instance
          .collection("Workspace")
          .doc(workspaceID)
          .collection(channelID)
          .doc("Messages")
          .get()
          .then((value) async => {
                if (value.data()!["Msg"]["roundCount"] > 200)
                  {
                    await FirebaseFirestore.instance
                        .collection("Workspace")
                        .doc(workspaceID)
                        .collection(channelID)
                        .doc("Messages")
                        .set({
                      "Msg": {
                        "Round${value.data()!["currentRound"] + 1}":
                            FieldValue.arrayUnion([
                          {
                            "Name": name,
                            "msg": msg,
                            "Email-ID": emailiD,
                            "Profile-Pic": "",
                            "Timestamp": DateTime.now().toString(),
                          }
                        ]),
                        "roundCount": FieldValue.increment(1),
                        "currentRound": FieldValue.increment(1)
                      },
                    }, SetOptions(merge: true))
                  }
                else
                  {
                    await FirebaseFirestore.instance
                        .collection("Workspace")
                        .doc(workspaceID)
                        .collection(channelID)
                        .doc("Messages")
                        .set({
                      "Msg": {
                        "Round${value.data()!["Msg"]["currentRound"]}":
                            FieldValue.arrayUnion([
                          {
                            "Name": name,
                            "msg": msg,
                            "Email-ID": emailiD,
                            "Profile-Pic": "",
                            "Timestamp": Timestamp.now(),
                          }
                        ]),
                        "roundCount": FieldValue.increment(1)
                      },
                    }, SetOptions(merge: true))
                  }
              });

      res = "Success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future createDirectMessageRoom(
    String emailID,
    String name,
    String emailID2,
    String name2,
  ) async {
    String res = "Error";
    try {
      final roomID = const Uuid().v1();
      await FirebaseFirestore.instance.collection("Users").doc(emailID).update({
        "Direct-Messages": FieldValue.arrayUnion([
          {
            "Name": name2,
            "Email-ID": emailID2,
            "ID": roomID,
          }
        ])
      });
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(emailID2)
          .update({
        "Direct-Messages": FieldValue.arrayUnion([
          {
            "Name": name,
            "Email-ID": emailID,
            "ID": roomID,
          }
        ])
      });
      await FirebaseFirestore.instance
          .collection("Direct-Messages")
          .doc(roomID)
          .set({
        "Msg": {
          "Round1": [],
          "roundCount": 0,
          "currentRound": 1,
        },
      });
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future sendDirectMessage(
    String emailID,
    String name,
    String roomID,
    String msg,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("Direct-Messages")
          .doc(roomID)
          .get()
          .then((value) async => {
                if (value.data()!["Msg"]["roundCount"] > 200)
                  {
                    await FirebaseFirestore.instance
                        .collection("Direct-Messages")
                        .doc(roomID)
                        .set({
                      "Msg": {
                        "Round${value.data()!["currentRound"] + 1}":
                            FieldValue.arrayUnion([
                          {
                            "Name": name,
                            "msg": msg,
                            "Email-ID": emailID,
                            "Timestamp": Timestamp.now(),
                          }
                        ]),
                        "roundCount": FieldValue.increment(1),
                        "currentRound": FieldValue.increment(1)
                      },
                    }, SetOptions(merge: true))
                  }
                else
                  {
                    await FirebaseFirestore.instance
                        .collection("Direct-Messages")
                        .doc(roomID)
                        .set({
                      "Msg": {
                        "Round${value.data()!["Msg"]["currentRound"]}":
                            FieldValue.arrayUnion([
                          {
                            "Name": name,
                            "msg": msg,
                            "Email-ID": emailID,
                            "Profile-Pic": "",
                            "Timestamp": Timestamp.now(),
                          }
                        ]),
                        "roundCount": FieldValue.increment(1)
                      },
                    }, SetOptions(merge: true))
                  }
              });
    } catch (e) {
      // print(e.toString());
      return e.toString();
    }
  }

  Future getWorkspace(String ID) async {
    return await FirebaseFirestore.instance
        .collection("Workspace")
        .doc(ID)
        .get();
  }

  Future getChannel(String workspaceID, String channelID) async {
    return await FirebaseFirestore.instance
        .collection("Workspace")
        .doc(workspaceID)
        .collection(channelID)
        .doc("Messages")
        .get();
  }

  Stream getDirectMessages(String roomID) {
    return FirebaseFirestore.instance
        .collection("Direct-Messages")
        .doc(roomID)
        .snapshots();
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // print(e.toString());
    }
  }

  Future getUser() async {
    try {
      var user = FirebaseFirestore.instance
          .collection("Users")
          .doc(_auth.currentUser!.email)
          .get();
      return user;
    } catch (e) {
      return false;
    }
  }
}
