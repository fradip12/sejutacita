import 'package:citav2/bloc/bloc.dart';
import 'package:citav2/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooserButton extends StatelessWidget {
  final String title;
  final Function func;
  final bool isSelected;

  const ChooserButton({Key key, this.title, this.func,@required this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isSelected ? state.materialColor : state.textColor,
          shape: StadiumBorder(),
        ),
        onPressed: func,
        child: chooserText(title: title,color: isSelected ? state.textColor : state.materialColor),
      ),
    );
  }
}
