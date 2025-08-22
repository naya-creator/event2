import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/dio_consumer.dart';
import '../Api/endpoint.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';
import '../models/getfavorite_model.dart';




// نموذج بيانات بسيط للصالة
class Hall {
  final String name;
  final String imageUrl;
  final String description;

  const Hall({
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class HallDisplayApp extends StatelessWidget {
  const HallDisplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // إزالة شريط "DEBUG" من الزاوية اليمنى العليا
      debugShowCheckedModeBanner: false,
      title: 'عرض الصالات',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto', // يمكنك تغيير الخط هنا
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HallListPage(),
      // تعيين اتجاه النص من اليمين لليسار للتطبيق بأكمله
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
/*
    } ),);     */
class HallListPage extends StatelessWidget {
  const HallListPage({super.key});

  // قائمة بالصالات لعرضها
  final List<Hall> halls = const [
    Hall(
      name: 'صالة الأفراح الكبرى',
      imageUrl: 'https://placehold.co/600x400/A78BFA/ffffff?text=صالة+الأفراح',
      description: 'صالة فسيحة ومجهزة بالكامل لاستضافة حفلات الزفاف والمناسبات الكبيرة.',
    ),
    Hall(
      name: 'صالة المؤتمرات الحديثة',
      imageUrl: 'https://placehold.co/600x400/60A5FA/ffffff?text=صالة+المؤتمرات',
      description: 'مثالية للاجتماعات وورش العمل والمؤتمرات مع أحدث التجهيزات التقنية.',
    ),
    Hall(
      name: 'صالة الاحتفالات العائلية',
      imageUrl: 'https://placehold.co/600x400/34D399/ffffff?text=صالة+الاحتفالات',
      description: 'مساحة دافئة ومريحة للاحتفالات العائلية الصغيرة وأعياد الميلاد.',
    ),
    Hall(
      name: 'صالة الاستقبال الفاخرة',
      imageUrl: 'https://placehold.co/600x400/FBBF24/ffffff?text=صالة+الاستقبال',
      description: 'تصميم أنيق ومريح لاستقبال الضيوف وتنظيم الفعاليات الخاصة.',
    ),
    Hall(
      name: 'صالة المناسبات المتعددة',
      imageUrl: 'https://placehold.co/600x400/EC4899/ffffff?text=صالة+المناسبات',
      description: 'مرنة وقابلة للتكيف مع مختلف أنواع المناسبات والفعاليات.',
    ),
    Hall(
      name: 'صالة الاجتماعات الصغيرة',
      imageUrl: 'https://placehold.co/600x400/8B5CF6/ffffff?text=صالة+الاجتماعات',
      description: 'مساحة هادئة ومجهزة للاجتماعات المصغرة والمناقشات.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>favorite_cubit(DioConsumer(dio:Dio()))..getAllFavorites(),
        child: BlocConsumer<favorite_cubit,Favorite_Status>
          ( listener: (context,status){},builder:(context,status){
             var key2= favorite_cubit.get(context);
            if(status is start_getfav){
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xfffdb1a1),
                ),
                body: const Center(
                  child: CircularProgressIndicator(color: Color(0xfffdb1a1),),
                )
              );
            }
  else{
    List<GetFavoritModel> test= key2.allFav;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffdb1a1),

        title: Center(
          child: Text(' Favorites',style: TextStyle(
            fontWeight: FontWeight.bold,
           color:  Colors.white,

          ),

          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100], // خلفية خفيفة للجسم
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: test.length,
          itemBuilder: (context, index) {
            return HallCard(hall: test[index]);
          },
        ),
      ),
    );
              }
  }));
}}

class HallCard extends StatelessWidget {
  final GetFavoritModel hall;

  const HallCard({super.key, required this.hall});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // حواف دائرية للبطاقة
      ),
      child: InkWell(

        onTap: () {
          // يمكنك إضافة منطق عند النقر هنا، مثل الانتقال إلى صفحة تفاصيل الصالة
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم النقر على ${hall.NameEn}')),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الصورة الرئيسية للصالة
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.network(
                '${Endpoint.imageUrl}${hall.Imageurl}',
                height: 200,
                fit: BoxFit.cover,
                // معالج الأخطاء في حالة فشل تحميل الصورة
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النص لليمين
                children: [
                  // اسم الصالة
                  Text(
                    hall.NameEn,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.right, // محاذاة النص لليمين
                  ),
                  const SizedBox(height: 8),
                  // وصف الصالة
                  Text(
                    hall.Type,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.right, // محاذاة النص لليمين
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
