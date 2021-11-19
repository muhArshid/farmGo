import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

// final spinner = Center(
//   child: SpinKitThreeBounce(
//     size: 30,
//     itemBuilder: (BuildContext context, int index) {
//       return DecoratedBox(
//         decoration: BoxDecoration(
//             color: index.isEven
//                 ? AppColorCode.buttunColorLate
//                 : AppColorCode.buttunColorDark),
//       );
//     },
//   ),
// );

errorDialog(String mssg) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'OOPS..',
              style: AppFontMain(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                mssg,
                style: AppFontMain(fontSize: 14, color: AppColorCode.textDim),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OKAY',
                      style: AppFontMain(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
