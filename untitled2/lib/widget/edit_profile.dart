import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled2/cubit/profile_cubit.dart';
import 'package:untitled2/widget/const/color.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // final profile = context.read<ProfileCubit>().user;
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        print(_image!.path);
      });
      await context.read<ProfileCubit>().uploadProfileImage(_image!);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text.isNotEmpty &&
          _newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('كلمة المرور الجديدة غير متطابقة')),
        );
        return;
      }

      context.read<ProfileCubit>().updateUserProfile(
            name: _nameController.text,
            email: _emailController.text,
            image: _image,
            oldPassword: _oldPasswordController.text.isNotEmpty
                ? _oldPasswordController.text
                : null,
            newPassword: _newPasswordController.text.isNotEmpty
                ? _newPasswordController.text
                : null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.pink,
        title: const Text("Edit", style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdatedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pop(context, true);
          } else if (state is ProfileImageUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث الصورة بنجاح')),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : (context.read<ProfileCubit>().user?.imageUrl !=
                                    null
                                ? NetworkImage(context
                                    .read<ProfileCubit>()
                                    .user!
                                    .imageUrl!)
                                : null),
                        child: _image == null &&
                                context.read<ProfileCubit>().user?.imageUrl ==
                                    null
                            ? const Icon(Icons.person,
                                size: 60, color: Colors.white)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, color: AppColor.pink),
                          onPressed: _pickImage,
                        ),
                      ),
                      if (state is ProfileUpdating)
                        const Positioned.fill(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Personal Info Fields
                _buildTextField(_nameController, "Full Name"),
                const SizedBox(height: 16),
                _buildTextField(_emailController, "Email"),
                const SizedBox(height: 30),

                // Password Fields
                _buildPasswordField(
                  _oldPasswordController,
                  "Old Password",
                  obscureText: _obscureOldPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureOldPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureOldPassword = !_obscureOldPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  _newPasswordController,
                  "New Password",
                  obscureText: _obscureNewPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  _confirmPasswordController,
                  "Confirm Password",
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Save Button
                if (state is ProfileUpdating)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.pink,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _submitForm,
                    child: const Text("Save Changes",
                        style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool optional = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.pink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.pink),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.pink),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
      validator: (value) {
        if (!optional && (value == null || value.isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.pink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.pink),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.pink),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
