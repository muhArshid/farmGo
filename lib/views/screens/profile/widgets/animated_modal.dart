import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key? key, required this.photo, required this.onTap, required this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onTap,
              child: InteractiveViewer(
                  maxScale: 5,
                  child: Image.network(
                    photo,
                  ))),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final String photo;

  Widget build(BuildContext context) {
    //  timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: Center(
        child: PhotoHero(photo: photo, width: 300.0, onTap: () {}),
      ),
    );
  }
}
