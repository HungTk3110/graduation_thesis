import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/models/enum/choose_photo_type.dart';
import 'package:untitled1/navigator/routes.dart';
import 'package:untitled1/shared_view/app_avatar_default.dart';
import 'package:untitled1/shared_view/app_cache_image.dart';
import 'package:untitled1/shared_view/app_circle_avatar.dart';
import 'package:untitled1/shared_view/bottom_sheet_picker_photo_type.dart';
import 'package:untitled1/shared_view/widget/app_label_text_field.dart';
import 'package:untitled1/ui/profile/profile_cubit.dart';
import 'package:untitled1/utils/app_permission_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<ProfileCubit>(context);
    cubit.initData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            AppNavigator.pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Edit Profile'),
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 32.h),
            Center(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (prev, current) =>
                    prev.userLocal != current.userLocal ||
                    prev.fileAvatar != current.fileAvatar,
                builder: (BuildContext context, state) {
                  return _buildAvatar(
                      networkAvatar: state.userLocal?.avatar ?? '',
                      localAvatarPath: state.fileAvatar?.path);
                },
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'User Name',
              style: TextStyle(
                color: const Color(0xff303030),
                fontSize: 15.r,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: AppLabelTextField(
                textEditingController: cubit.userNameController,
                hintText: 'Search Your Task',
                background: Color(0xfff5f5f5),
              ),
            ),
            SizedBox(height: 200.h),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                cubit.onPressUpdate(context);
              },
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                    color: Color(0xffF26950),
                    borderRadius: BorderRadius.circular(15.r)),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.r,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar({
    required String networkAvatar,
    String? localAvatarPath,
  }) {
    final isLocalAvatar = localAvatarPath != null && localAvatarPath.isNotEmpty;
    File? localAvatarFile;

    if (isLocalAvatar) {
      localAvatarFile = File(localAvatarPath);
    }
    return Stack(
      children: [
        SizedBox(
          child: !isLocalAvatar && networkAvatar.isNotEmpty
              ? AppCircleAvatar(
                  size: 195,
                  url: networkAvatar,
                )
              : isLocalAvatar && localAvatarPath.isNotEmpty
                  ? Container(
                      height: 194,
                      width: 194,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Color(0xFFe6e6e6),
                        borderRadius: BorderRadius.circular(194 / 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(194 / 2),
                        child: Image.file(
                          localAvatarFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const AppAvatarDefault(
                      size: 195,
                    ),
        ),
        Positioned(
          right: 3,
          bottom: 10,
          child: InkWell(
            onTap: () {
              _showBottomSheetPickTypeSelectImage();
            },
            child: Container(
              height: 36,
              width: 36,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color(0xFF212121).withOpacity(0.4),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showBottomSheetPickTypeSelectImage() async {
    FocusScope.of(context).unfocus();
    ChoosePhotoType? chooseType = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return const BottomSheetPickerPhotoType();
      },
    );
    if (chooseType != null) {
      switch (chooseType) {
        case ChoosePhotoType.gallery:
          _pickPhotoFromLibrary();
          break;
        case ChoosePhotoType.camera:
          _pickPhotoFromCamera();
          break;
      }
    }
  }

  Future<void> _pickPhotoFromLibrary() async {
    final isDenied = await AppPermissionUtils.askPhotoLibraryPermission(() {
      // TODO: - show dialog permission denied
    });
    if (isDenied) return;
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    File file = File(imageFile.path);
    cubit.onChangeAvatar(file);
    print('Image uploaded to Firebase Storage: ');
    // try {
    //   final storageRef = FirebaseStorage.instance.ref();
    //   final name = file.path.split('/').last;
    //   final imagesRef = storageRef.child('images/$name');
    //   final snap = await imagesRef.putFile(file);
    //   final urlFile = await snap.ref.getDownloadURL();
    //   print('Image uploaded to Firebase Storage: $urlFile');
    // } on FirebaseException catch (e) {
    //   print(e);
    // }
  }

  Future<void> _pickPhotoFromCamera() async {
    final isDenied = await AppPermissionUtils.askPhotoLibraryPermission(() {
      // TODO: - show dialog permission denied
    });
    if (isDenied) return;

    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile == null) return;
    File file = File(imageFile.path);
    cubit.onChangeAvatar(file);
  }
}
