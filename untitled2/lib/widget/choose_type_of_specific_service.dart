import 'package:flutter/material.dart';

import 'type_of_product.dart';

class ChooseTypeOfSpecificService extends StatelessWidget {
  const ChooseTypeOfSpecificService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                      15,
                      (context1) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TypeOfProduct()));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/shopping.webp'),
                                    backgroundColor: Colors.indigo,
                                    radius: 300,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Balon',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          )),
                )
              ],
            ),
          ),
        ));
  }
}
