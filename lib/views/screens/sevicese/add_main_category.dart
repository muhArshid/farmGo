import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/model/core/category_item.dart';
import 'package:farmapp/model/core/item.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/views/screens/sevicese/add_new_item.dart';
import 'package:farmapp/views/screens/sevicese/serch_item.dart';
import 'package:farmapp/views/screens/sevicese/widgets/add_payment.dart';
import 'package:farmapp/views/widgets/button_icons_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class AddFarmScreen extends StatefulWidget {
  final MainCategoryItemModel? category;
  const AddFarmScreen({Key? key, this.category}) : super(key: key);

  @override
  _AddFarmScreenState createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  final GlobalKey _menuKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    List<PaymentChoice> payment = <PaymentChoice>[
      PaymentChoice(title: 'expense', value: widget.category!.expense ?? ''),
      PaymentChoice(title: 'profite', value: widget.category!.profite ?? ''),
      PaymentChoice(title: 'losse', value: widget.category!.losse ?? ''),
    ];
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 10,
          bottom: 0,
          child: ListView(
            children: [
              FutureBuilder(
                  future: serviceController.getImage(
                      context, widget.category!.image!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return Container(
                        //width: 100.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: snapshot.data!.image as ImageProvider,
                          ),
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(0, 83, 9, 1),
                                  width: 0.0)),
                          color: AppColorCode.gray2,
                          boxShadow: [
                            BoxShadow(
                              color: AppColorCode.brandColor,
                              blurRadius: 6.0,
                              spreadRadius: 3.0,
                              offset: Offset(
                                  -2.0, 5.0), // shadow direction: bottom right
                            )
                          ],
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 150.0)),
                        ),
                      );
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    return Container();
                  }),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Members',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SerchScreen(
                              category: widget.category,
                            ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'more',
                            style: AppFontMain(
                              color: AppColorCode.headerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 10, color: Colors.black),
                          Icon(Icons.arrow_forward_ios,
                              size: 10, color: Colors.black),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    itemCount: payment.length,
                    itemBuilder: (context, index) {
                      final listItem = payment[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              listItem.title,
                              style: AppFontMain(
                                color: AppColorCode.pureWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              height: 5.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  //     color: AppColorCode.pureWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  listItem.value,
                                  style: AppFontMain(
                                    color: AppColorCode.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add_box_outlined,
                                    color: AppColorCode.brandColor,
                                  ),
                                  onPressed: () {
                                    serviceController.change(listItem.value);
                                    showMaterialModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        height: 50.h,
                                        color: Colors.white,
                                        child: AddPayment(
                                          textName: listItem.title,
                                          modal: widget.category!,
                                        ),
                                      ),
                                    );
                                    // cartController.decreaseQuantity(cartItem);
                                  }),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Text(
              //         'expense',
              //         style: AppFontMain(
              //           color: AppColorCode.black,
              //           fontSize: 20,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       Container(
              //         height: 5.h,
              //         width: 20.w,
              //         decoration: BoxDecoration(
              //             //     color: AppColorCode.pureWhite,
              //             borderRadius: BorderRadius.circular(10)),
              //         child: Center(
              //           child: Text(
              //             widget.category!.expense!,
              //             style: AppFontMain(
              //               color: AppColorCode.black,
              //               fontSize: 20,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Center(
              //         child: IconButton(
              //             icon: Icon(
              //               Icons.add_box_outlined,
              //               color: AppColorCode.brandColor,
              //             ),
              //             onPressed: () {
              //               showMaterialModalBottomSheet(
              //                 context: context,
              //                 builder: (context) => Container(
              //                   height: 50.h,
              //                   color: Colors.white,
              //                   child: AddPayment(
              //                     textName: 'expense',
              //                     modal: widget.category!,
              //                   ),
              //                 ),
              //               );
              //               // cartController.decreaseQuantity(cartItem);
              //             }),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: appBar(
            label: '',
          ),
        ),
        Positioned(
            top: 210,
            left: 10,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.category!.name!,
                    style: AppFontMain(
                      color: AppColorCode.brandColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (serviceController.itemModelList.value != null)
                    Text(
                      'Tottal ' +
                          serviceController.itemModelList.value!.length
                              .toString(),
                      style: AppFontMain(
                        color: AppColorCode.brandColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                ],
              ),
            )),
        Positioned(
          top: 20,
          left: 200,
          right: 0,
          child: PopupMenuButton(
            key: _menuKey,
            itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text('Delete'), value: 'd'),
              new PopupMenuItem<String>(
                  child: const Text('Add Member'), value: 'a'),
              // ct.profileData!.mediaId != 0
              //     ? new PopupMenuItem<String>(
              //         child: const Text('Delete'), value: 'd')
              //     : new PopupMenuItem<String>(
              //         height: 0, child: Container(), value: 'd'),
            ],
            onSelected: (val) async {
              if (val == 'd') {
                serviceController.deleteMainCategory(widget.category!.id!);
              }
              if (val == 'a') {
                Get.to(() => AddNewScreen(
                      category: widget.category,
                    ));
              }
            },
            child: Center(
                child: Icon(
              Icons.drag_indicator,
              color: AppColorCode.pureWhite,
            )),
          ),
        )
      ],
    )));
  }
}
