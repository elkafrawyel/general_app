import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/helpers/logging_helper.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:image_picker/image_picker.dart';

import 'app_text.dart';

showAppImageDialog({
  required BuildContext context,
  required Function(File image) onFilePicked,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => _ImagePickerDialog(
      onFilePicked: onFilePicked,
    ),
  );
}

class _ImagePickerDialog extends StatelessWidget {
  final Function(File image) onFilePicked;

  const _ImagePickerDialog({
    required this.onFilePicked,
  });

  @override
  Widget build(BuildContext context) {
    bool isAr = StorageClient().isAr();
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: StorageClient().get(StorageClientKeys.isDarkMode)
            ? Brightness.dark
            : Brightness.light,
        scaffoldBackgroundColor: context.kBackgroundColor,
      ),
      child: CupertinoActionSheet(
        cancelButton: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          color: context.kBackgroundColor,
          child: AppText(
            text: isAr ? 'إغلاق' : 'Close',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          CupertinoButton(
            color: context.kBackgroundColor,
            child: Row(
              children: <Widget>[
                Icon(
                  CupertinoIcons.photo_camera_solid,
                  color: context.kPrimaryColor,
                ),
                const SizedBox(width: 20),
                AppText(
                  text: isAr ? 'الكاميرا' : 'Camera',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            onPressed: () async {
              Navigator.pop(context);
              File? imageFile = await _pickImage(gallery: false);
              if (imageFile != null) {
                onFilePicked(imageFile);
              }
            },
          ),
          CupertinoButton(
            color: context.kBackgroundColor,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.insert_photo,
                  color: context.kPrimaryColor,
                ),
                const SizedBox(width: 20),
                AppText(
                  text: isAr ? 'الاستوديو' : 'Gallery',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            onPressed: () async {
              try {
                Navigator.pop(context);
                File? imageFile = await _pickImage();
                if (imageFile != null) {
                  onFilePicked(imageFile);
                }
              } catch (e) {
                AppLogger.log(e.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  Future<File?> _pickImage({bool gallery = true}) async {
    XFile? media;
    if (gallery) {
      media = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      media = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    if (media != null) {
      return File(media.path);
    } else {
      return null;
    }
  }
}
