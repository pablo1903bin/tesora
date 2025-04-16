
import 'package:flutter/material.dart';


extension BuildContextExtension on BuildContext{
  Size get screenSize{
    return findAncestorWidgetOfExactType<MediaQuery>()!.data.size;
  }

  MediaQueryData get mediaQueryData {
    return findAncestorWidgetOfExactType<MediaQuery>()!.data;
  }

  double get top {
    return mediaQueryData.viewPadding.top;
  }

  double appBarHeighEstimado(){
    return top + kToolbarHeight;
  }

  double get heightLessAppBar {
    return screenSize.height - appBarHeighEstimado();
  }


  double xScreen(double pct) {
    
    return (screenSize.width*pct)/100;
  }

  double yScreen(double pct) {

    double h = screenSize.height - appBarHeighEstimado();
    //double h = screenSize!.height ;

    return (h*pct)/100;
  }

}