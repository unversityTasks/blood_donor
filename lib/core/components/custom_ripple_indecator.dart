import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RippleIndicator extends StatelessWidget {
  final String message;

  const RippleIndicator({Key? key,required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             const Padding(
                padding: EdgeInsets.all(2.0),
                child: Center(
                    child: SpinKitRipple(
                  color: Color.fromARGB(1000, 221, 46, 68),
                )),
              ),
             const SizedBox(width: 10.0),
              Text(
                message,
              ),
            ],
          )),
    );
  }
}
