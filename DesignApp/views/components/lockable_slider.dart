import 'package:flutter/material.dart';

class LockableSlider extends StatefulWidget {
  final Function(double) onChanged;
  final double value;
  final String colorName;
  final Function(bool) lockchanged;

  const LockableSlider({Key key, this.onChanged, this.value, this.colorName, this.lockchanged})
      : super(key: key);
  @override
  _LockableSliderState createState() => _LockableSliderState();
}

class _LockableSliderState extends State<LockableSlider> {
  bool _isUnlocked = true;

  @override
  Widget build(BuildContext context) {
    var imgUrl =
        _isUnlocked ? 'assets/lock_open.png' : 'assets/lock_closed.png';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            //  Image.asset('assets/lock_open.png'),
            Container(
              width: 30,
              height: 25,
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Image.asset(imgUrl),
                onPressed: () {
                  _isUnlocked = !_isUnlocked;
                  widget.lockchanged(_isUnlocked);
                  setState(() {});
                },
              ),
            ), //lock closed if locked
            Text(
              '${widget.colorName} ${widget.value}',
              style: TextStyle(
                  color: _isUnlocked
                      ? Colors.white
                      : Colors.grey), //change to grey if lock is closed
            ),
          ],
        ),
        Slider.adaptive(
          inactiveColor:
              _isUnlocked ? Colors.white : Colors.grey, //If inactive it's grey
          activeColor: _isUnlocked
              ? Colors.white
              : Colors.grey, //If it's inactive it's grey
          onChanged: (value) {
            if (_isUnlocked) {
              widget.onChanged(value);
            }
          },
          value: widget.value,
          min: 0,
          max: 256,
        ),
      ],
    );
  }
}
