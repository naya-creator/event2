// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'const/color.dart';

// // ignore: must_be_immutable
// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//   List event = [
//     {
//       "image": "assets/images/flat-fast-food-webinar_23-2149046598.jpg",
//       "title": "Name",
//     },
//     {
//       "image": "assets/images/flat-fast-food-webinar_23-2149046598.jpg",
//       "title": "Name",
//     },
//     {
//       "image": "assets/images/flat-fast-food-webinar_23-2149046598.jpg",
//       "title": "Name",
//     },
//     {
//       "image": "assets/images/flat-fast-food-webinar_23-2149046598.jpg",
//       "title": "Name",
//     }
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 154, 149, 149),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Icon(
//                           Icons.person,
//                           size: 150,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(
//                       "Name",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Divider(),
//                 ],
//               ),
//               ListTile(
//                 title: Text("Favorite"),
//                 leading: Icon(Icons.favorite),
//                 onTap: () {},
//               ),
//               ListTile(
//                 title: Text("Language"),
//                 leading: Icon(Icons.language),
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       String? selectedLanguage;
//                       return AlertDialog(
//                         title: Text('اختر اللغة'),
//                         content: StatefulBuilder(
//                           builder: (BuildContext context, StateSetter setState) {
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 InkWell(
//                                   onTap: () async {
//                                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                                     await prefs.setString('selectedLanguage', 'ar');
//                                     print('تم حفظ اللغة: العربية');
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: RadioListTile<String>(
//                                     title: Row(
//                                       children: [
//                                         Text('العربية'),
                                        
//                                       ],
//                                     ),
//                                     value: 'ar',
//                                     groupValue: selectedLanguage,
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         selectedLanguage = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () async {
//                                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                                     await prefs.setString('selectedLanguage', 'en');
//                                     print('تم حفظ اللغة: English');
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: RadioListTile<String>(
//                                     title: Row(
//                                       children: [
//                                         Text('English'),
                                        
//                                       ],
//                                     ),
//                                     value: 'en',
//                                     groupValue: selectedLanguage,
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         selectedLanguage = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text("Log Out"),
//                 leading: Icon(Icons.logout),
//                 onTap: () {},
//               ),
//               ListTile(
//                 title: Text("Setting"),
//                 leading: Icon(Icons.settings),
//                 onTap: () {},
//               )
//             ],
//           ),
//         ),
//         body: Builder(
//           builder: (context) => Container(
//             color: const Color(0xfff8f5fb),
//             child: Stack(
//               children: [
//                 Positioned(
//                   right: 0,
//                   top: 0,
//                   child: Stack(
//                     children: [
//                       Image.asset(
//                         "assets/images/flat-fast-food-webinar_23-2149046598.jpg",
//                         width: 150,
//                       ),
//                       Positioned(
//                         top: 10,
//                         right: 10,
//                         child: IconButton(
//                           icon: Icon(Icons.menu, size: 28, color: Colors.white),
//                           onPressed: () {
//                             Scaffold.of(context).openEndDrawer();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     SizedBox(height: 35),
//                     Text(
//                       "Find the \n trending events",
//                       style: TextStyle(
//                           color: AppColor.blue,
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.left,
//                     ),
//                     SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: "Search",
//                           prefixIcon: const Icon(Icons.search),
//                           border: InputBorder.none,
//                           fillColor: Colors.grey[200],
//                           filled: true,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Text(
//                         'Events',
//                         style: TextStyle(
//                           color: AppColor.blue,
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     Expanded(
//                       child: GridView.builder(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 20,
//                           crossAxisSpacing: 10,
//                           childAspectRatio: 0.75,
//                         ),
//                         itemCount: event.length,
//                         itemBuilder: (context, i) {
//                           return Card(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: double.infinity,
//                                   height: 120,
//                                   color: Colors.grey[200],
//                                   child: Image.asset(
//                                     event[i]['image'],
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Text(
//                                         event[i]['title'],
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                     MaterialButton(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30)),
//                                       color: AppColor.blue,
//                                       onPressed: () {
//                                         // Navigator.of(context).pushReplacement(
//                                         //   MaterialPageRoute(
//                                         //       builder: (context) => Places()),
//                                         // );
//                                       },
//                                       child: Text(
//                                         "This",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }