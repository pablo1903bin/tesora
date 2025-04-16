

import 'package:flutter/material.dart';

extension BoxConstraintsExtension on BoxConstraints {

  double x(double pct) {
    
    return (minWidth*pct)/100;
  }

  double y(double pct) {

    return (minHeight*pct)/100;
  }

  Rect fromLTWH(double left, double top, double width, double height){
    return Rect.fromLTWH( x(left), y(top), x(width), y(height));
  }

  

}