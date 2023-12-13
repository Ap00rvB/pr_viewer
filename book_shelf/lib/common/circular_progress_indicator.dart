import 'package:flutter/material.dart';

class ModalCircularProgressIndicator extends StatelessWidget {
  final bool enabled;
  final bool showAdda;

  const ModalCircularProgressIndicator(Key? key, this.enabled,
      {this.showAdda = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.0,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.white,
          ),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
