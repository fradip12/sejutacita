import 'package:citav2/widgets/custom_icon.dart';
import 'package:flutter/material.dart';

class PagingButton extends StatelessWidget {
  final Function func;
  final IconData icon;

  const PagingButton({Key key, this.func, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: func ?? () {},
        child: Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: CIcon(iconData: icon, size: 15),
          ),
        ));
  }
}
