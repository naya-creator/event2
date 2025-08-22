import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/register_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('الإعدادات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, screenWidth),
              SizedBox(height: screenHeight * 0.04),
              _buildSettingItem(
                context,
                icon: Icons.email_outlined,
                label: 'تغيير البريد الإلكتروني',
                onTap: () {},
              ),
              _buildDivider(screenHeight),
              _buildSettingItem(
                context,
                icon: Icons.phonelink_setup_outlined,
                label: 'تغيير رقم الهاتف',
                onTap: () {},
              ),
              
             
              _buildDivider(screenHeight),
              _buildSettingItem(
                context,
                icon: Icons.logout,
                label: 'تسجيل الخروج',
                onTap: () {
                  final cubit = context.read<RegisterCubit>();
                  cubit.logoutUser(context);
                },
              ),
              _buildDivider(screenHeight),
              _buildSettingItem(
                context,
                icon: Icons.language_outlined,
                label: 'لغة التطبيق',
                onTap: () {},
              ),
              _buildDivider(screenHeight),
              _buildSettingItem(
                context,
                icon: Icons.notifications_none_outlined,
                label: 'الإشعارات',
                onTap: () {},
              ),
              _buildDivider(screenHeight),
              _buildSettingItem(
                context,
                icon: Icons.edit_attributes_outlined,
                label: 'تغيير السمة',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
      child: Row(
        children: [
          Icon(Icons.settings, size: screenWidth * 0.09, color: Colors.black),
          SizedBox(width: screenWidth * 0.06),
          Text(
            'الإعدادات',
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.03,
        ),
        child: Row(
          children: [
            Icon(icon, size: screenWidth * 0.07, color: Colors.black),
            SizedBox(width: screenWidth * 0.05),
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: screenWidth * 0.04, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(double screenHeight) {
    return Divider(
      height: screenHeight * 0.01,
      thickness: 1,
      color: Colors.grey[300],
    );
  }
}