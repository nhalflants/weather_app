import 'package:flutter/material.dart';

class HighLowTemp extends StatelessWidget {
  const HighLowTemp({
    Key? key,
    required this.minTemp,
    required this.maxTemp,
  }) : super(key: key);

  final double minTemp;
  final double maxTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),
          ),
          child: _buildTemp('MIN', '${minTemp.round()}'),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: _buildTemp('MAX', '${maxTemp.round()}'),
        ),
      ],
    );
  }

  Widget _buildTemp(String text, String temp) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
              fontSize: 15,
            ),
          ),
        ),
        Text(
          '$temp°',
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
