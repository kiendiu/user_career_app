import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class BaseDefaultAvatarView extends StatelessWidget with GlobalThemePlugin {
  final String name;

  // pass index to change color of background and text
  // use first color in pallet for default
  final int? colorPalletIndex;
  final double size;

  // pass fontSize and fontWeight
  // use first color in pallet for default

  const BaseDefaultAvatarView(
      {super.key, required this.name, this.colorPalletIndex, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: _getColorData(colorPalletIndex ?? Random(0).nextInt(8))
              .background,
          border: Border.all(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(size)),
      child: Text(
        _name,
        style: conf.customStyle(
          const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
          ) as CustomStyle,
        ).copyWith(color: _getColorData(colorPalletIndex ?? Random(0).nextInt(8)).text),
        maxLines: 1,
        textScaleFactor: 1,
      ).center().squareBox(edgeSize: 28 / 40 * size).center(),
      // 28 = text size in design
      // 40 is total view size.
      // 28 : 40 is textSize/viewSize ratio
    );
  }


  String get _name {
    if (name.trim().isEmpty) return '';

    final nameParts = name.trim().split(' ');

    if (nameParts.length == 1) return nameParts.first[0].toUpperCase();

    return '${nameParts.first[0].toUpperCase()}${nameParts.last[0].toUpperCase()}';
  }

  _ColorData _getColorData(int index) {
    return _colorPallets[index % _colorPallets.length];
  }
}

typedef _ColorData = ({Color background, Color text});

const _colorPallets = <_ColorData>[
  (background: Color(0xffE8F4FF), text: Color(0xff3D73D1)),
  (background: Color(0xffFFEFE8), text: Color(0xffE96C56)),
  (background: Color(0xffFFF7E8), text: Color(0xffF09833)),
  (background: Color(0xffE8FFF2), text: Color(0xff3FB37F)),
  (background: Color(0xffFFFCE8), text: Color(0xffF9CC45)),
  (background: Color(0xffF0E8FF), text: Color(0xff9886E2)),
  (background: Color(0xffE8F4FF), text: Color(0xff3D73D1)),
  (background: Color(0xffE8FFFB), text: Color(0xff33C0BB)),
  (background: Color(0xffF7F8FA), text: Color(0xffA9AEB8))
];
