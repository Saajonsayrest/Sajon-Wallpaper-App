import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/app/view/decorations.dart';
import 'package:untitled1/extensions/padding_extensions.dart';
import 'package:untitled1/feature/sign_in/google_auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _imageFile;
  bool _isLoadingImage = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _loadImageFromPreferences();
  }

  void _getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = currentUser;
    });
  }

  Future<void> _loadImageFromPreferences() async {
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
        Column(
          children: [
            GestureDetector(
              onTap: () => _showImagePicker(context),
              child: Stack(
                children: [
                  Container(
                    width: 300.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: _imageFile != null
                        ? ClipOval(
                            child: Image.file(
                              _imageFile!,
                              width: 300.w,
                              height: 300.h,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/person.png',
                                width: 300.w,
                                height: 300.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  if (_isLoadingImage)
                    Container(
                      width: 300.w,
                      height: 300.h,
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal),
                        ),
                      ),
                    ),
                ],
              ),
            ).pT(10.h),
            GestureDetector(
              onTap: () => _showImagePicker(context),
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: getShadowDecoration(color: Colors.teal),
                child: Center(
                  child: Text(
                    'Edit Profile Image',
                    style: TextStyle(color: Colors.white, fontSize: 22.sp),
                  ),
                ),
              ).pT(10.h),
            ),
          ],
        ).pB(50.h),
        Container(
          decoration: getShadowDecoration(),
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
          child: Column(
            children: [
              Text(
                _user?.displayName?.toUpperCase() ?? 'No Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.sp, color: Colors.teal),
              ).pB(10.h),
              Text(
                _user?.email ?? 'No Name',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.sp, color: Colors.teal),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _showLogoutConfirmationDialog(context);
          },
          child: Container(
            height: 50.h,
            width: 360.w,
            decoration: getShadowDecoration(color: Colors.red),
            child: Center(
              child: Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
              ),
            ),
          ).pT(50.h),
        )
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.white,
            elevation: 10.0,
            title: const Text(
              'Confirm Logout',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            content: Text(
              'Are you sure you want to Logout?',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'No',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ).pX(15.w),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ).pX(15.w),
                onPressed: () async {
                  Navigator.of(context).pop(true);
                  await _handleSignOut(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorite_photos');

    await prefs.clear();
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
}
