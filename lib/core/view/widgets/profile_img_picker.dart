import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_new_template/export.dart';

class ProfileImgPicker extends StatelessWidget {
  ProfileImgPicker({
    super.key,
    this.url,
    required this.onChange,
  });

  final pickedImg = ValueNotifier<File?>(null);
  final String? url;
  final Function(File) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FilePickerResult? file = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);
        if (file != null) {
          File temp = File(file.files.first.path!);
          pickedImg.value = temp;
          onChange(temp);
        }
      },
      child: Stack(
        children: [
          ValueListenableBuilder<File?>(
            valueListenable: pickedImg,
            builder: (context, value, child) => value == null
                ? FadeImage(
                    width: 140.0,
                    height: 140.0,
                    imageUrl: url,
                  )
                : Container(
                    width: 140.0,
                    height: 140.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(value),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ),
          const ResponsivePositioned(
            sidePadding: 10,
            bottom: 10,
            child: Icon(Icons.edit),
          )
        ],
      ).centered(),
    );
  }
}
