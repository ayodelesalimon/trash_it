class LayoutController {
  static double _staticheight = 800.0;
  static double getStaticHeight(){
   return _staticheight;
  }


  static double getHeight(double height,{double? minHeight}){
    return height >=  (minHeight ?? _staticheight) ? height : (minHeight ?? _staticheight);
  }



}