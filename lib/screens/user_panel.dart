import 'package:attendance_management_system_app/screens/login_screen.dart';
import 'package:attendance_management_system_app/screens/user_record_screen.dart';
import 'package:attendance_management_system_app/utility/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final uuid = const Uuid();

  String? selectedAttendance;
  String? leaveRequestText;
  bool isValueSelected = false;
  bool isAttendanceSubmitted = false;
  late TextEditingController leaveRequestC;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> userLogOut(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return const PopScope(
              child: SpinKitPulse(
            color: Colors.white,
          ));
        });
    final isConnected = await checkInternetConnection(context);

    if (!isConnected) {
      Navigator.of(context).pop();
      return false;
    }

    await FirebaseAuth.instance.signOut();
    return true;
  }

  void submitAttendance(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return const PopScope(
              child: SpinKitPulse(
            color: Colors.white,
          ));
        });
    final isConnected = await checkInternetConnection(context);

    if (!isConnected) {
      // Navigator.of(context).pop();
      return;
    }

    selectedAttendance =
        selectedAttendance == 'Leave' ? 'Pending' : selectedAttendance;

    final currentDate = Timestamp.now();

        try {
      final userId = firebaseAuth.currentUser!.uid;
      final attendanceId = uuid.v4().toString();

      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('attendance')
          .doc(attendanceId)
          .set(
        {
          'id': attendanceId,
          'date': currentDate,
          'attendanceStatus': selectedAttendance,
          'isLeaveAccepted': null,
          'leaveRequest': leaveRequestText,
        },
      );
    } on FirebaseException catch (error) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $error')));
      }
      return;
    }
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Success! Your attendance is marked.')));
    }
    setState(() {
      isAttendanceSubmitted = true;
    });
  }

  @override
  void initState() {
    leaveRequestC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    leaveRequestC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 47, 46, 46),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: const Color.fromARGB(255, 47, 46, 46),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 56,
                      child: FlutterLogo(
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: const Text('Confirmation'),
                                content: const Text(
                                    "Are you sure you want to Log Out?"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        final loggedOut =
                                            await userLogOut(context);

                                        if (!loggedOut) {
                                          return;
                                        }

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Please Log In again.')));
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const LoginScreen();
                                          }));
                                        }
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                ],
                              );
                            });
                      },
                      child: const Row(
                        children: [
                          IconButton(
                            enableFeedback: false,
                            onPressed: null,
                            disabledColor: Colors.white,
                            icon: Icon(Icons.logout_rounded),
                            color: Colors.white,
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton.outlined(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.dehaze_rounded,
            color: Colors.white,
            // size: 18,
          ),
        ),
        // backgroundColor: Colors.black87,
        title: const Text('Student Attendance'),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w200,
              color: const Color.fromARGB(255, 235, 234, 234),
              letterSpacing: 0.8,
              fontSize: height * 0.03,
            ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white60,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.black.withOpacity(0.87),
                    child: const Icon(
                      Icons.person,
                      size: 72,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  // border: Border.symmetric(
                  //   vertical: BorderSide(color: Colors.white),
                  // ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Attendance for today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: const Border.symmetric(
                    vertical: BorderSide(color: Colors.black12),
                  ),
                  color: (isAttendanceSubmitted)
                      ? Colors.blue
                      : Colors.red.shade700,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (isAttendanceSubmitted)
                          ? 'Submitted Successfully'
                          : 'Not Submitted',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.02,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      (isAttendanceSubmitted)
                          ? Icons.assignment_turned_in
                          : Icons.assignment_late,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.green.shade400,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton(
                    dropdownColor: Colors.black87,
                    // menuWidth: width - 100,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          fontSize: height * 0.02,
                        ),
                    underline: const SizedBox.shrink(),
                    hint: Text(
                      'Choose Attendance Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                      ),
                    ),
                    value: isAttendanceSubmitted
                        ? null
                        : selectedAttendance, // in order for the [disabledHint] to display, the [value] should also be null as well as [onChanged]
                    isExpanded: true,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    borderRadius: BorderRadius.circular(10),
                    disabledHint: Text(
                      '$selectedAttendance - Submitted',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.025,
                      ),
                    ),
                    onChanged: (isAttendanceSubmitted)
                        ? null
                        : (String? value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              selectedAttendance = value;
                              isValueSelected = true;
                            });
                          },
                    items: [
                      'Present',
                      'Absent',
                      'Leave',
                    ].map(
                      (String attendanceItem) {
                        return DropdownMenuItem(
                          value: attendanceItem,
                          child: Text(attendanceItem),
                        );
                      },
                    ).toList()),
              ),
              const SizedBox(height: 12),
              if (selectedAttendance == 'Leave')
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextField(
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                        ),
                    controller: leaveRequestC,
                    maxLength: 150,
                    maxLines: 3,
                    decoration: InputDecoration(
                      filled: true,
                      helperStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.white70,
                      enabled: !isAttendanceSubmitted,
                      alignLabelWithHint: true,
                      labelStyle: const TextStyle(
                        color: Colors.black87,
                      ),
                      labelText: 'Leave Request',
                      hintText: 'Why you want a leave, write here...',
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: isAttendanceSubmitted
                          ? null
                          : () {
                              if (isValueSelected == false) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please choose any attendance status to submit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (selectedAttendance == 'Leave') {
                                final returnValue = defaultUserInputValidator(
                                    leaveRequestC.text);
                                if (returnValue == null) {
                                  leaveRequestText = leaveRequestC.text
                                      .trim()
                                      .replaceAll('\n', '-');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    returnValue,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  )));
                                  return;
                                }
                              }
                              showDialog(
                                context: context,
                                builder: (builder) {
                                  return AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: const Text(
                                        "This can't be undone! Are you sure?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            submitAttendance(context);
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel')),
                                    ],
                                  );
                                },
                              );
                            },
                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        backgroundColor: Colors.green,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          fontSize: height * 0.02,
                        ),
                        disabledBackgroundColor: Colors.white38,
                      ),
                      child: const Text('Submit'),
                      // label: Text('Submit'),
                      // icon: Icon(Icons.done),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Divider(
                height: 2,
                color: Colors.white60,
              ),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  // border: const Border.symmetric(
                  //   vertical: BorderSide(color: Colors.white),
                  // ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Previous Attendance Record',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const UserRecordScreen();
                      }));
                    },
                    label: const Text(
                      'show my record',
                      style: TextStyle(color: Colors.black87),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 22,
                      color: Colors.black87,
                    ),
                    iconAlignment: IconAlignment.end,
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.02,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
