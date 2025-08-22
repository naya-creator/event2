import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/models/non-pending_task_model.dart';
import '../bloc/tasks_bloc.dart';
import 'pendingTasks.dart';

class NonpendingtasksPage extends StatelessWidget {
  const NonpendingtasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc()..add(GetNonPendingTasks()),
      child: const Nonpendingtasks(),
    );
  }
}

class Nonpendingtasks extends StatelessWidget {
  const Nonpendingtasks({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "Non Pending Tasks",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.065,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TasksBloc>().add(GetNonPendingTasks());
            },
            icon: Icon(Icons.refresh, size: screenWidth * 0.07),
          ),
        ],
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NonPengingTasksLoaded) {
            if (state.tasks.isNotEmpty) {
              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  final task = state.tasks[index];
                  return _buildTaskCard(task, screenWidth, screenHeight);
                },
              );
            } else {
              return Center(
                child: Text(
                  "You Don't Have Tasks",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    color: Colors.redAccent,
                  ),
                ),
              );
            }
          } else if (state is TasksError) {
            return Center(
              child: Text(
                state.masseg,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: screenWidth * 0.05,
                ),
              ),
            );
          }
          return Center(
            child: Text(
              "No tasks available",
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Pendingtasks()),
          );
        },
        label: Text(
          'Pending tasks',
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        icon: Icon(Icons.list_alt, size: screenWidth * 0.06),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTaskCard(NonPendingData task, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.01,
      ),
      child: Container(
        // ارتفاع مرن حسب المحتوى
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            stops: [0.6, 0.90],
            colors: [
              Color.fromARGB(255, 252, 109, 109),
              Color.fromARGB(255, 255, 104, 104),
            ],
          ),
          border: Border.all(
            width: screenWidth * 0.008,
            color: const Color.fromARGB(255, 255, 243, 72),
          ),
          boxShadow: const [BoxShadow(blurRadius: 4)],
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ارتفاع العمود مرن حسب المحتوى
            children: [
              Text(
                "Task ${task.assignmentId}",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 43, 28),
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              Text(
                "Service: ${task.service}",
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.008),
              Text(
                "Status: ${task.status}",
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.008),
              Text(
                "Description: ${task.description}",
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
