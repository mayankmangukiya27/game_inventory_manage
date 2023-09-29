import 'package:flutter/material.dart';

class ConmanLoader extends StatelessWidget {
  const ConmanLoader({super.key, required this.child, required this.loadingState});

  final Widget child;
  final bool loadingState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loadingState)
          Opacity(
            opacity: 0.8,
            child: Container(
              color: Colors.black.withOpacity(.5),
            ),
          ),
        if (loadingState)
          const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Image(
                  //   image: AssetImage(
                  //     ImageIndex.loadingImage,
                  //   ),
                  //   fit: BoxFit.cover,
                  //   height: 55,
                  //   width: 55,
                  // ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                      strokeWidth: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
