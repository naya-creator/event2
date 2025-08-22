
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Api/endpoint.dart';
import 'package:untitled2/widget/const/color.dart';

import '../cubit/profile_cubit.dart';
import 'edit_profile.dart';


class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
       // تحميل بيانات الكاش ة
    context.read<ProfileCubit>().loadCachedProfileOrRedirect();
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdatedSuccessfully ||
            state is ProfileImageUpdated) {
          context.read<ProfileCubit>().fetchProfile();
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        final user = cubit.user;

        if (user == null || state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        }

        ImageProvider? profileImage;
        if (user.imageUrl != null) {
          profileImage = NetworkImage(Endpoint.imageUrl + user.imageUrl!);
        }

        return RefreshIndicator(
          onRefresh: () async {
            await cubit.fetchProfile();
          },
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[400],
                  backgroundImage: profileImage,
                  child: profileImage == null
                      ? Icon(Icons.person, size: 80, color: Colors.white)
                      : null,
                ),
              ),
              SizedBox(height: 30),
              Card(
                child: ListTile(
                  leading: Icon(Icons.person, color: AppColor.blue),
                  title: Text("Full Name"),
                  subtitle: Text(user.name),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.email, color: AppColor.blue),
                  title: Text("Email"),
                  subtitle: Text(user.email),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.lock, color: AppColor.blue),
                  title: Text("Password"),
                  subtitle: Text("********"), // عرض مخفي لكلمة المرور
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: AppColor.blue,
                  onPressed: () async {
                    final updated = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(builder: (context) => Edit()),
                    );
                    if (updated == true) {
                      cubit.fetchProfile();
                    }
                  },
                  child: Text("Edit", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
