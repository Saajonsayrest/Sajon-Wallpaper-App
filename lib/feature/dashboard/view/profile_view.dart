import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/app/view/decorations.dart';
import 'package:untitled1/extensions/padding_extensions.dart';
import 'package:untitled1/feature/google_auth_service/google_auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _imageFile;
  bool _isLoadingImage = false;

  @override
  void initState() {
    super.initState();
    _loadImageFromPreferences();
  }

  void _loadImageFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  void _saveImageToPreferences(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', imagePath);
  }

  Future<void> _getImage(ImageSource source) async {
    setState(() {
      _isLoadingImage = true;
    });

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _isLoadingImage = false;
      });

      // Save selected image path to shared preferences
      _saveImageToPreferences(_imageFile!.path);
    } else {
      setState(() {
        _isLoadingImage = false;
      });
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300.w,
          height: 300.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
            image: _imageFile != null
                ? DecorationImage(
                    image: FileImage(_imageFile!),
                    fit: BoxFit.cover,
                  )
                : const DecorationImage(
                    image: AssetImage('assets/images/person.png'),
                    fit: BoxFit.cover,
                  ),
          ),
          child: _imageFile == null
              ? _isLoadingImage
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : null
              : null,
        ),
        GestureDetector(
          onTap: () => _showImagePicker(context),
          child: Container(
            height: 50.h,
            width: 300.w,
            decoration: getShadowDecoration(color: Colors.teal),
            child: Center(
              child: Text(
                'Change Profile Image',
                style: TextStyle(color: Colors.white, fontSize: 22.sp),
              ),
            ),
          ).pT(10.h),
        ),
        GestureDetector(
          onTap: () {
            _showLogoutConfirmationDialog(context);
          },
          child: Container(
            height: 50.h,
            width: 300.w,
            decoration: getShadowDecoration(color: Colors.red),
            child: Center(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 25.sp),
              ),
            ),
          ).pT(80.h),
        )
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _handleSignOut(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      await AuthService().signOut();
      await clearSharedPreferences();
      Navigator.pushNamedAndRemoveUntil(context, '/signin',
          (route) => false); // Navigate to sign-in screen and clear stack
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
