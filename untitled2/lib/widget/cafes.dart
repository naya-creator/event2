
import 'package:flutter/material.dart';

import 'halldetails.dart';

class Cafes extends StatelessWidget {
  Cafes({super.key});
  List cafe = [
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
      "location": "mazzeh",
      "price": "400\$"
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
      "location": "mazzeh",
      "price": "400\$"
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
      "location": "mazzeh",
      "price": "400\$"
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
      "location": "mazzeh",
      "price": "400\$"
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
      "location": "mazzeh",
      "price": "400\$"
    },
    {
      "image": "assets/images/shopping.webp",
      "title": "Name",
      "location": "mazzeh",
      "price": "400\$"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffdb1a1),
        title: Text("Cafe"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: cafe.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0, // تعديل المسافة بين الأعمدة
                  childAspectRatio: 0.75, // نسبة العرض إلى الارتفاع
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Halldaetails(HallId: i,)),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity, // استخدام العرض الكامل
                            height: 100,
                            color: Colors.grey[200],
                            child: Image.asset(
                              cafe[i]['image'],
                              height: 120,
                              fit: BoxFit
                                  .cover, // استخدم BoxFit.cover للحفاظ على نسبة العرض
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              cafe[i]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              cafe[i]['location'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              cafe[i]['price'],
                              style: TextStyle(
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