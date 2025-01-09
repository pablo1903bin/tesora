

import 'dart:developer' as dev;

class Log {

  //static bool enabled = kDebugMode;
  static bool infoEnabled = false;
  static bool httpEnabled = false;
  static bool enabled = false;
  //static bool infoEnabled = true;
  //static bool httpEnabled = false;

  late DateTime start;
  DateTime? end;
  late List<String> mensajes;

  Log(){
    mensajes = [];
    start = DateTime.now();
  }

  add(String m){
    mensajes.add(m);
  }

  show({String? titulo}){

    end = DateTime.now();

    debug("------------start-$titulo-${start.toString()}---------------");
    for (var m in mensajes){
      debug(m);
    }

    debug("Time: ${end!.difference(start).toString()}");

    debug("------------end-$titulo-${end.toString()}---------------");

  }


  static void debug(String m){
    if(enabled){
      dev.log(m);
    }
  }


  static void http(String m){
    if(httpEnabled){
      dev.log(m);
    }
  }

  static void info(String m){
    if(infoEnabled){
      dev.log(m);
    }
  }
}
