
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widget/login.dart';

import '../../cache/cache_helper.dart';
import '../../widget/profile_of_user.dart';
import '../bloc/models/tasks_data_model.dart';
import '../bloc/tasks_bloc.dart';
import '../../widget/settings.dart';
import 'nonPendingTask.dart';

class Pendingtasks extends StatefulWidget {
  const Pendingtasks({super.key});

  @override
  State<Pendingtasks> createState() => _TasksPartState();
}

class _TasksPartState extends State<Pendingtasks> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => TasksBloc()..add(GetPendingTasks()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 105, 95),
          title: Text(
            "Pending Tasks",
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.06,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                context.read<TasksBloc>().add(GetPendingTasks());
              },
              icon: Icon(Icons.refresh, size: screenWidth * 0.07),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "profile") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Profile()),
                  );
                // } else if (value == "settings") {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (_) => Settings()),
                //   );
                 } else if (value == "logout") {
                  _logout(context);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "profile",
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 10),
                      Text("Profile"),
                    ],
                  ),
                ),
                // const PopupMenuItem(
                //   value: "settings",
                //   child: Row(
                //     children: [
                //       // Icon(Icons.settings, color: Colors.black),
                //       // SizedBox(width: 10),
                //       // Text("Settings"),
                //     ],
                //   ),
                // ),
                const PopupMenuItem(
                  value: "logout",
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.black),
                      SizedBox(width: 10),
                      Text("Logout"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocListener<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is TaskActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.masseg),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is TasksError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.masseg),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TasksLoaded) {
                if (state.tasks.isNotEmpty) {
                  return _buildTasksList(state.tasks, screenWidth, screenHeight);
                } else {
                  return Center(
                    child: Text(
                      "You Don't Have Tasks",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: const Color.fromARGB(255, 252, 109, 109),
                      ),
                    ),
                  );
                }
              } else if (state is TasksError) {
                return Center(
                  child: Text(
                    state.masseg,
                    style: TextStyle(fontSize: screenWidth * 0.05),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'No tasks available',
                    style: TextStyle(fontSize: screenWidth * 0.05),
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Nonpendingtasks()),
            );
          },
          label: Text('Non pending task', style: TextStyle(fontSize: screenWidth * 0.04)),
          icon: Icon(Icons.list_alt, size: screenWidth * 0.06),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildTasksList(List<PendingData> tasks, double screenWidth, double screenHeight) {
    return ListView.builder(
      padding: EdgeInsets.all(screenWidth * 0.02),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _buildTaskCard(task, screenWidth, screenHeight);
      },
    );
  }

  Widget _buildTaskCard(PendingData task, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Container(
        height: screenHeight * 0.45,
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            stops: [0.6, 0.90],
            colors: [
              Color.fromARGB(255, 252, 109, 109),
              Color.fromARGB(255, 255, 104, 104),
            ],
          ),
          border: Border.all(width: 3, color: Colors.black),
          boxShadow: const [BoxShadow(blurRadius: 4)],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task ${task.assignmentId}",
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 43, 28),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Service: ${task.service}",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Status: ${task.status}",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Location & Description:\n${task.description}",
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
    ElevatedButton(
      onPressed: () async {
        // تحديث حالة المهمة للقبول
        context.read<TasksBloc>().add(AcceptTask(task.assignmentId, true));
        // الانتقال لصفحة Nonpendingtasks بعد القبول
        await Future.delayed(const Duration(milliseconds: 300)); // صغير لإعطاء فرصة للبلوك
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Nonpendingtasks()),
        );
      },
      child: Text(
        "Accept",
        style: TextStyle(fontSize: screenWidth * 0.04),
      ),
    ),
    SizedBox(width: screenWidth * 0.03),
    ElevatedButton(
      onPressed: () async {
        // تحديث حالة المهمة للرفض
        context.read<TasksBloc>().add(RejectTask(task.assignmentId, false));
        // الانتقال لصفحة Nonpendingtasks بعد الرفض
        await Future.delayed(const Duration(milliseconds: 300));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Nonpendingtasks()),
        );
      },
      child: Text(
        "Reject",
        style: TextStyle(fontSize: screenWidth * 0.04),
      ),
    ),
  ],
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await CacheHelper.removeData(key: 'token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => Login()),
      (route) => false,
    );
  }
}
