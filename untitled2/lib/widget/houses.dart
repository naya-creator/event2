import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Houses extends StatelessWidget {
  Houses({super.key});
  List rest = [
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
        backgroundColor: const Color(0xfffdb1a1),
        title: const Text("Houses"),
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
                  childAspectRatio: 0.75, // نسبة العرض إلى الارتفاع
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(builder: (context) => Places()),
                      // );
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
                              rest[i]['image'],
                              height: 120,
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              rest[i]['location'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              rest[i]['price'],
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
