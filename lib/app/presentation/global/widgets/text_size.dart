import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/styles%20copy.dart';

AutoSizeText autoSizeTextCards({String titulo = "", TextAlign align = TextAlign.center, Color color = colorPrincipal, double fontSize = 12,}) {
  return AutoSizeText(
    titulo,
    maxLines: 1,
    minFontSize: 10,
    maxFontSize: 28,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        fontFeatures: const [FontFeature.liningFigures()],
        color: color),
    textAlign: align,
  );
}

AutoSizeText autoSizeText({String titulo = "", TextAlign align = TextAlign.center, Color color = colorPrincipal, double fontSize = 12,}) {
  return AutoSizeText(
    titulo,
    maxLines: 1,
    minFontSize: 10,
    maxFontSize: 18,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        fontFeatures: const [FontFeature.liningFigures()],
        color: color),
    textAlign: align,
  );
}

AutoSizeText textDefDosLineas(String titulo, {TextAlign align = TextAlign.center}) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 10,
    maxFontSize: 16,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleSubTitulo,
    textAlign: align,
  );
}

AutoSizeText textDefPuntos(String titulo,
    {TextAlign align = TextAlign.center}) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 8,
    maxFontSize: 12,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
  );
}

AutoSizeText textDefaultDosLineas(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefault,
  );
}

AutoSizeText textDefaultDosLineasImage(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefaultImage,
  );
}

AutoSizeText textDefaultUnaLinea(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 1,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefault,
  );
}

AutoSizeText textTituloDosLineas(String titulo) {
  return AutoSizeText(
    titulo,
    style: textStyleTitulo,
    maxLines: 2,
    minFontSize: 10,
    maxFontSize: 18,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText textTituloUnaLinea(String titulo) {
  return AutoSizeText(
    titulo,
    style: textStyleTitulo,
    maxLines: 1,
    minFontSize: 10,
    maxFontSize: 18,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText textPrincipalUnaLinea(String titulo) {
  return AutoSizeText(
    titulo,
    style: textStylePrincipalBold,
    maxLines: 1,
    minFontSize: 8,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText textCuatroDosLineas(String titulo) {
  return AutoSizeText(
    titulo,
    style: textStyleDefaultCuatro,
    maxLines: 2,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
  );
}

AutoSizeText textCuatroUnaLinea(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 1,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefaultCuatro,
  );
}

AutoSizeText textTituloCuatroUnaLinea(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 1,
    minFontSize: 16,
    maxFontSize: 18,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefaultCuatro,
  );
}

AutoSizeText textCuatroCuatroLineas(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 4,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefaultCuatro,
  );
}

AutoSizeText textDefaultDosLineasBold(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 10,
    maxFontSize: 15,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleBold,
  );
}

AutoSizeText textDefaultDosLineasSmall(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 8,
    maxFontSize: 12,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleDefault,
  );
}

AutoSizeText textCuatroUnaLineaSmall(String titulo) {
  return AutoSizeText(
    titulo,
    maxLines: 2,
    minFontSize: 8,
    maxFontSize: 12,
    textScaleFactor: 1.0,
    overflow: TextOverflow.ellipsis,
    style: textStyleBoldCuarto,
  );
}
