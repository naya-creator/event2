
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Resturants extends StatelessWidget {
  Resturants({super.key});
  List rest = [
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffdb1a1),
        title: const Text("Resturants"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: rest.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0, // تعديل المسافة بين الأعمدة
                  childAspectRatio: 1.0, // نسبة العرض إلى الارتفاع
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {

                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity, // استخدام العرض الكامل
                            height: 110,
                            color: Colors.grey[200],
                            child: Image.asset(
                              rest[i]['image'],
                              height: 80,
                              fit: BoxFit
                                  .cover, // استخدم BoxFit.cover للحفاظ على نسبة العرض
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              rest[i]['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
