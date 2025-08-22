
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final List<String> services = ['Food', 'Music', 'Design', 'Team'];

  List<String> selectedServices = [];

  void toggleService(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service);
      } else {
        selectedServices.add(service);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hall Reservation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Event name",
                style: TextStyle(color: Colors.pink),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Event History",
                style: TextStyle(color: Colors.pink),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (newDate != null) {
                        setState(() {
                          date = newDate;
                        });
                      }
                    },
                    icon: const Icon(Icons.date_range),
                  ),
                  const SizedBox(width: 50),
                  SizedBox(
                    width: 200,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${date.day}/${date.month}/${date.year}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Event Time",
                style: TextStyle(color: Colors.pink),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if (newTime != null) {
                        setState(() {
                          time = newTime;
                        });
                      }
                    },
                    icon: const Icon(Icons.access_time),
                  ),
                  const SizedBox(width: 50),
                  SizedBox(
                    width: 200,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          time.format(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "The Expected Number Of Guests",
                style: TextStyle(color: Colors.pink),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Services",
                style: TextStyle(color: Colors.pink, fontSize: 25),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: services.map((service) {
                  bool isSelected = selectedServices.contains(service);
                  return InkWell(
                    onTap: () => toggleService(service),
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: Card(
                        color: isSelected ? Colors.pink : Colors.white,
                        child: Center(
                          child: Text(
                            service,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Table time for rest",
                  style: TextStyle(color: Colors.pink, fontSize: 20)),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "first time for rest",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "services provided",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if (newTime != null) {
                        setState(() {
                          time = newTime;
                        });
                      }
                    },
                    child: SizedBox(
                      width: 130,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            time.format(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: SizedBox(
                      width: 90,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "second time for rest",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    "services provided",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if (newTime != null) {
                        setState(() {
                          time = newTime;
                        });
                      }
                    },
                    child: SizedBox(
                      width: 130,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            time.format(context),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 90,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 500,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.pink,
                    onPressed: () {},
                    child: const Text(
                      "Reservation",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
