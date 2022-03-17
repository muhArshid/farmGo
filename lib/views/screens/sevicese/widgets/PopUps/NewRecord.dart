import 'dart:typed_data';

import 'package:farmapp/model/core/FamilyData.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class NewRecord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewRecordState();
}

class NewRecordState extends State<NewRecord> {
  int? selectedType;
  TextEditingController _name = TextEditingController();

  Uint8List? _selectedImage;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColorCode.pureWhite,
                  borderRadius: BorderRadius.circular(20.0)),
              width: 100.w,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      'Add Member'.toUpperCase(),
                      // style: GoogleFonts.openSans(
                      //     color: AppColorCode.blackColor.withOpacity(0.8),
                      //     fontSize: 15.0,
                      //     fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: AppColorCode.pureWhite,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 45.0,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: Utils.getDefaultTextInputDecoration(
                                'Select Your Allergies (Optional)', null),
                            baseStyle: Utils.getprimaryFieldTextStyle(
                                AppColorCode.pureWhite),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Mother'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Father'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Child'),
                                    value: 3,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value as int?;
                                  });
                                },
                                hint: Text(
                                  'Select Member Type',
                                  style: Utils.getprimaryFieldTextStyle(
                                      AppColorCode.greyColor),
                                ),
                                value: selectedType,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: (_selectedImage == null)
                                ? Image.asset(getImage(selectedType))
                                : Image.memory(_selectedImage!),
                          ),
                          FlatButton(
                            onPressed: () async {
                              selectImage();
                            },
                            child: Text(
                              "Upload Yours",
                            ),
                            color: AppColorCode.greenColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Utils.buttonBorderRadius),
                                side: BorderSide(color: AppColorCode.redColor)),
                            height: 42.0,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _name,
                      decoration: Utils.getDefaultTextInputDecoration(
                          'Member Name',
                          Icon(
                            Icons.person,
                            color: AppColorCode.greyColor.withOpacity(0.6),
                          )),
                      cursorColor: AppColorCode.primaryText,
                      keyboardType: TextInputType.text,
                      style: Utils.getprimaryFieldTextStyle(
                          AppColorCode.greyColor),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: FlatButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Close",
                              ),
                              color: AppColorCode.redColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Utils.buttonBorderRadius),
                                  side:
                                      BorderSide(color: AppColorCode.redColor)),
                              height: 42.0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: FlatButton(
                              onPressed: () async {
                                Utils.familyData = null;
                                if (_name.text.isNotEmpty &&
                                    selectedType != null) {
                                  Utils.familyData = FamilyData(
                                      img: (_selectedImage == null)
                                          ? getImage(selectedType)
                                          : _selectedImage,
                                      imgType: (_selectedImage == null) ? 1 : 2,
                                      name: _name.text,
                                      type: selectedType);

                                  Navigator.pop(context);
                                } else {
                                  Utils.showToast(
                                      "Please select member name and type");
                                }
                              },
                              child: Text(
                                "Start",
                              ),
                              color: AppColorCode.primaryText,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Utils.buttonBorderRadius),
                                  side: BorderSide(
                                      color: AppColorCode.primaryText)),
                              height: 42.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getImage(type) {
    String path = '';

    switch (type) {
      case 1:
        path = 'assets/images/mother.png';
        break;
      case 2:
        path = 'assets/images/father.png';
        break;
      case 3:
        path = 'assets/images/child.png';
        break;
      default:
        path = 'assets/images/child.png';
    }

    return path;
  }

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = await pickedFile.readAsBytes();

      if (_selectedImage != null) {
        setState(() {});
      }
    } else {
      print('No image selected.');
    }
  }
}
