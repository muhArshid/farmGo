import 'package:farmapp/constants/controllers.dart';
import 'package:farmapp/controller/auth_controller.dart';
import 'package:farmapp/model/core/post_model.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/AppFontOswald.dart';
import 'package:farmapp/utils/AssetConstants.dart';
import 'package:farmapp/views/screens/profile/widgets/animated_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:farmapp/views/screens/profile/widgets/show_post.dart';
import 'package:share_plus/share_plus.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key, this.postModel}) : super(key: key);
  final PostModel? postModel;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  AnimationController? _animationController;
  bool isShowingMenu = false;
  bool selected = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  List<String>? imagePaths = [];
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var image = widget.postModel!.image!;
    List<FavModel> fav = widget.postModel!.fav!;
    FavModel? favData;
    int index = 0;
    while (index < fav.length) {
      print(fav[index]);
      favData = fav[index];
      if (favData!.id != null) {
        if (favData!.id! == userController.userModel.value.id) {
          setState(() {
            favData = fav[index];
            selected = true;
          });
        }
      }
      index++;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: 10.w,
        height: 60.h,
        decoration: BoxDecoration(
            color: AppColorCode.pureWhite,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                userController.userModel.value.profileImage != null
                    ? CircleAvatar(
                        // backgroundImage: AssetImage(AssetConstant.profiledemy),
                        backgroundImage: NetworkImage(
                            userController.userModel.value.profileImage!),
                        radius: 30,
                      )
                    : Container(),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userController.userModel.value.name ?? '',
                      style: AppFontMain(
                        color: AppColorCode.headerColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.postModel!.content!,
              style: AppFontMain(
                color: AppColorCode.headerColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HeroAnimation(
                    photo: widget.postModel!.downloadUrl!,
                  );
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: 80.w,
                height: 30.h,
                decoration: BoxDecoration(
                  //   color: AppColorCode.brandColor,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.postModel!.downloadUrl!),
                  ),
                ),
                // child: InteractiveViewer(
                //     maxScale: 5,
                //     child: Image.network(
                //       widget.postModel!.downloadUrl!,
                //     ))
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      if (!selected) {
                        profileController.addFavToPost(widget.postModel!.id!);
                        setState(() {
                          selected = true;
                        });
                      } else {
                        profileController.removeFavList(
                            favData, widget.postModel!.id!);
                        setState(() {
                          selected = false;
                        });
                      }
                    },
                    child: Icon(
                      selected
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: AppColorCode.redColor,
                      size: selected ? 30 : 27,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 15,
                // ),
                // Icon(
                //   Icons.messenger_outline_outlined,
                //   color: AppColorCode.brandColor,
                //   size: 30,
                // ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () async {
                    final RenderObject? box = context.findRenderObject();
                    String text = widget.postModel!.content!;
                    final url = widget.postModel!.downloadUrl!;
                    imagePaths!.add(widget.postModel!.downloadUrl!);
                    String subject = 'follow me';
                    await Share.share(
                      '${text}\n\n ${url}',
                    );
                  },
                  child: Icon(
                    Icons.file_upload_outlined,
                    color: AppColorCode.brandColor,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
