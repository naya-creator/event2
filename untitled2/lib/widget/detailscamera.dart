
import 'package:flutter/material.dart';
/*       */
// ignore: must_be_immutable
class Detailscamera extends StatelessWidget {
  Detailscamera({super.key});
  List exam = [
    {"image": "assets/images/shopping.webp"},
    {"image": "assets/images/shopping.webp"},
    {"image": "assets/images/shopping.webp"},
    {"image": "assets/images/shopping.webp"},
    {"image": "assets/images/shopping.webp"},
    {"image": "assets/images/shopping.webp"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Man"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // لضمان عدم الالتصاق بحواف الشاشة
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Type of camera :",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: Card(
                    child: Text(
                      "soni",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Photography forms",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: exam.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0, // تعديل المسافة بين الأعمدة
                  childAspectRatio: 1.0, // نسبة العرض إلى الارتفاع
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity, // استخدام العرض الكامل
                            height: 110,
                            color: Colors.grey[200],
                            child: Image.asset(
                              exam[i]['image'],
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.blue,
                  onPressed: () {},
                  child: const Text(
                    "Choose",
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
}
