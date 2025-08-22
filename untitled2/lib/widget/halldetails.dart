import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../Api/dio_consumer.dart';
import '../Api/endpoint.dart';
import '../cubit/halldetails_cubit.dart';
import '../cubit/halldetails_state.dart';
import 'camera.dart';
import 'choose_type_of_decoration.dart';
import 'choose_type_of_food.dart';
import 'music.dart';

class Halldaetails extends StatefulWidget {
  final int HallId;

  const Halldaetails({super.key, required this.HallId});

  @override
  State<Halldaetails> createState() => _HalldaetailsState();
}

class _HalldaetailsState extends State<Halldaetails> {
  // A helper function to build the bottom sheet for available times (existing logic)
  Widget _buildDatePickerAndTimesheet(
      BuildContext context, HalldetailsCubit cubit) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ' available times:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12.0,
            runSpacing: 8.0,
            children: cubit.availableTimes.map((time) {
              return Chip(
                label: Text(time),
                backgroundColor: const Color(0xfffdb1a1).withOpacity(0.3),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 18, color: Color(0xfffdb1a1)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // A new function to show the reservation bottom sheet
  void _showReservationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => HalldetailsCubit(DioConsumer(dio:Dio())),
          child: _ReservationSheetContent(hallId: widget.HallId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      HalldetailsCubit(DioConsumer(dio:Dio()))..getHallDetails(widget.HallId)..getAllServices(widget.HallId),
      child: BlocConsumer<HalldetailsCubit, HalldetailsStatus>(
        listener: (BuildContext context, HalldetailsStatus status) {},
        builder: (BuildContext context, HalldetailsStatus status) {
          var cubit = HalldetailsCubit.get(context);

          if (status is start_HallDetails_class || status is start_HallDetailsServices_class) {
            return Scaffold(
              appBar: AppBar(backgroundColor: const Color(0xfffdb1a1)),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xfffdb1a1)),
                    Text(' please wait ')
                  ],
                ),
              ),
            );
          }
          if (status is error_HallDetails_class || status is error_HallDetailsServices_class) {
            return Scaffold(
              appBar: AppBar(backgroundColor: const Color(0xfffdb1a1)),
              body: const Center(child: Text('faild :(')),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xfffdb1a1),
                title: const Text("صفحة القاعة"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Image.network('${Endpoint.imageUrl}${cubit.hallDetails?.imageurl1 ?? ''}'),
                    const SizedBox(height: 10),
                    // عرض الصور الفرعية للقاعة
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.network("${Endpoint.imageUrl}${cubit.hallDetails?.imageurl2 ?? ''}", width: 70),
                          const SizedBox(width: 10),
                          Image.network("${Endpoint.imageUrl}${cubit.hallDetails?.imageurl3 ?? ''}", width: 70),
                          const SizedBox(width: 10),
                          //Image.network("${EndPoints.imageUrl22}${cubit.hallDetails?.imageurl4 ?? ''}", width: 70),
                          const SizedBox(width: 10),
                          //Image.network("${EndPoints.imageUrl22}${cubit.hallDetails?.imageurl5 ?? ''}", width: 70),
                          const SizedBox(width: 10),
                          //  Image.network("${EndPoints.imageUrl22}${cubit.hallDetails?.imageurl6 ?? ''}", width: 70),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      cubit.hallDetails?.nameEn ?? 'N/A',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                                (index) => IconButton(
                              icon: cubit.stars[index]
                                  ? const Icon(Icons.star)
                                  : const Icon(Icons.star_border_outlined),
                              onPressed: () {
                                cubit.addStars(index);
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            if (cubit.isFavorite(widget.HallId)) {
                              bool success = await cubit.PostDeleteFav('hall', widget.HallId);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text(' تم ازالته من المفضله بنجاح')),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text(' لم يتم ازالته من المفضله ')),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              bool success = await cubit.PostAddFav('hall', widget.HallId);
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text(' تم اضافته للمفضله بنجاح')),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text(' لم يتم اضافته للمفضله ')),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          icon: cubit.isFavorite(widget.HallId)
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.place),
                        const SizedBox(width: 10),
                        Text(
                          cubit.hallDetails?.locationEn ?? 'N/A',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text("العنوان بالتفصيل"),
                    const SizedBox(height: 20),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.people),
                        Text(" ${cubit.hallDetails?.capacity ?? 'N/A'} guest")
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Row(
                      children: [
                        const Text("Price: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${cubit.hallDetails?.price ?? 'N/A'}\$", style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const Divider(),
                    const Text("Services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                    const SizedBox(height: 10),
                    cubit.allservices.isEmpty
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "لا خدمات متوفرة",
                          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                        : GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.2,
                      children: List.generate(
                        cubit.allservices.length,
                            (index) {
                          final service = cubit.allservices[index];
                          return GestureDetector(
                            onTap: () {
                              if (service.nameEn == 'Decoration') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseTypeOfDecoration(serviceId: service.serviceId)));
                              }
                              if (service.nameEn == 'Food') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseTypeOfFood(servicesid: service.serviceId)));
                              }
                              if (service.nameEn == 'Music') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Music()));
                              }
                              if (service.nameEn == 'PHOTOGRAFER') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Camera()));
                              }
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.room_service, size: 40, color: Color(0xfffdb1a1)),
                                    const SizedBox(height: 8),
                                    Text(
                                      service.nameEn ?? 'N/A',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          onPressed: () async {
                            bool success = await cubit.getavailabletimes(widget.HallId);
                            if(success) {
                              showModalBottomSheet(
                                context: context,
                                // The `BoxConstraints` ensures the modal sheet takes the full width.
                                constraints: const BoxConstraints(maxWidth: double.infinity),
                                builder: (context) => _buildDatePickerAndTimesheet(context, cubit),
                              );
                            }
                          },
                          child: const Text(
                            "Available times",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    // This is the updated button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          onPressed: () {
                            _showReservationSheet();
                          },
                          child: const Text(
                            "Reservation the hall",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// New class for the reservation sheet content to manage its state correctly
class _ReservationSheetContent extends StatefulWidget {
  final int hallId;

  const _ReservationSheetContent({required this.hallId});

  @override
  _ReservationSheetContentState createState() => _ReservationSheetContentState();
}

class _ReservationSheetContentState extends State<_ReservationSheetContent> {
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final TextEditingController _homeAddressController = TextEditingController();

  @override
  void dispose() {
    _homeAddressController.dispose();
    super.dispose();
  }

  // Moved helper function to this class to fix the lookup error
  Widget _buildTimePickerButton(String label, TimeOfDay? time, bool isStartTime) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xfffdb1a1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
        );
        if (picked != null) {
          setState(() {
            if (isStartTime) {
              _startTime = picked;
            } else {
              _endTime = picked;
            }
          });
        }
      },
      child: Text(
        time == null ? label : time.format(context),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // New method to show the success dialog
  void _showSuccessDialog(int reservationid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title:  Text(
            '   تم الحجز بنجاح!  ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
              const SizedBox(height: 10),
              Text(
                  '   قم بحفظ رقم حجزك في حال أردت إضافة خدمات إليه'
                      ' {${reservationid}}'  ,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the bottom sheet
              },
              child: const Text(
                'موافق',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HalldetailsCubit, HalldetailsStatus>(
      listener: (context, status) {},
      builder: (context, status) {
        final cubit = HalldetailsCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Reserve the Hall",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfffdb1a1),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Calendar Date Picker
                  Text(
                    _selectedDate == null
                        ? "Select a Date"
                        : "Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 300,
                    child: CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      onDateChanged: (DateTime newDate) {
                        setState(() {
                          _selectedDate = newDate;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Time pickers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimePickerButton("Start Time", _startTime, true),
                      _buildTimePickerButton("End Time", _endTime, false),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const Text(
                    'please enter your home address',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Home Address',
                            labelStyle: const TextStyle(color: Color(0xfffdb1a1)),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xfffdb1a1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: const Icon(Icons.home_outlined, color: Color(0xfffdb1a1)),
                          ),
                          controller: _homeAddressController,
                          // This onChanged callback triggers a rebuild of the StatefulBuilder
                          // so that the button's enabled state can be re-evaluated.
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Confirmation button
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      color: const Color(0xfffdb1a1),
                      // The button is disabled unless all conditions are met
                      onPressed: _selectedDate != null &&
                          _startTime != null &&
                          _endTime != null &&
                          _homeAddressController.text.isNotEmpty
                          ? () async {
                        // Format the selected values for the API call
                        final String resevDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
                        final String startTime = '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}';
                        final String endTime = '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}';

                        // Get the cubit instance
                        final cubit = HalldetailsCubit.get(context);

                        // Call the reservation function
                        bool success = await cubit.PostReserveHall(widget.hallId, resevDate, startTime, endTime,_homeAddressController.text);

                        // Show a SnackBar based on the result
                        if (success) {
                          _showSuccessDialog(cubit.reserv!.reservationId); // Show the new success dialog
                        } else {
                             showDialog(
                               context: context,
                           builder: (BuildContext context) {
                       return   AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.white,
                            title:  Text(
                              '   فشل الحجز !  ',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.sms_failed, color: Colors.red, size: 60),
                                const SizedBox(height: 10),
                                Text(
                                  '${cubit.ErrorMassege}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                  Navigator.of(context).pop(); // Close the bottom sheet
                                },
                                child: const Text(
                                  'موافق',
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        });}
                      }
                          : null, // Disable button if not all fields are selected
                      child: const Text(
                        "Confirm Reservation",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
