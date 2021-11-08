import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -80,
            child: Image.asset(
              'asset/images/bg_top.png',
              width: width * 0.5,
            ),
          ),
          Positioned(
            top: 200,
            right: -30,
            child: Image.asset(
              'asset/images/bg_middle.png',
              width: width * 0.3,
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Image.asset(
              'asset/images/bg_bottom.png',
              width: width * 0.5,
            ),
          ),
          Container(
            child: child,
          ),
        ],
      ),
    );
  }
}
