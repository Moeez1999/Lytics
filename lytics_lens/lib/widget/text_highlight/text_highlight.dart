// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:math';

class TextHighlighting extends StatelessWidget {
  //DynamicTextHighlighting
  final String text;
  final List<String> highlights;
  final Color color;
  final TextStyle style;
  final bool caseSensitive;

  //RichText
  final TextAlign textAlign;

  final TextOverflow overflow;
  final double textScaleFactor;

  final TextWidthBasis textWidthBasis;

  TextHighlighting({
    //DynamicTextHighlighting
    Key? key,
    required this.text,
    required this.highlights,
    this.color = Colors.orange,
    this.style = const TextStyle(
      color: Colors.black,
    ),
    this.caseSensitive = true,

    //RichText
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.textWidthBasis = TextWidthBasis.parent,
  })  : assert(text != null),
        assert(highlights != null),
        assert(color != null),
        assert(style != null),
        assert(caseSensitive != null),
        assert(textAlign != null),
        assert(overflow != null),
        assert(textScaleFactor != null),
        assert(textWidthBasis != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controls
    if (text == '') {
      return _richText(_normalSpan(text));
    }
    if (highlights.isEmpty) {
      return _richText(_normalSpan(text));
    }
    for (int i = 0; i < highlights.length; i++) {
      if (highlights[i] == null) {
        assert(highlights[i] != null);
        return _richText(_normalSpan(text));
      }
      if (highlights[i].isEmpty) {
        assert(highlights[i].isNotEmpty);
        return _richText(_normalSpan(text));
      }
    }

    //Main code
    List<TextSpan> _spans = [];
    int _start = 0;

    //For "No Case Sensitive" option
    String _lowerCaseText = text.toLowerCase();
    List<String> _lowerCaseHighlights = [];

    highlights.forEach((element) {
      _lowerCaseHighlights.add(element.toLowerCase());
    });

    while (true) {
      Map<int, String> _highlightsMap = Map(); //key (index), value (highlight).

      if (caseSensitive) {
        for (int i = 0; i < highlights.length; i++) {
          int _index = text.indexOf(highlights[i], _start);
          if (_index >= 0) {
            _highlightsMap.putIfAbsent(_index, () => highlights[i]);
          }
        }
      } else {
        for (int i = 0; i < highlights.length; i++) {
          int _index = _lowerCaseText.indexOf(_lowerCaseHighlights[i], _start);
          if (_index >= 0) {
            _highlightsMap.putIfAbsent(_index, () => highlights[i]);
          }
        }
      }

      if (_highlightsMap.isNotEmpty) {
        List<int> _indexes = [];
        _highlightsMap.forEach((key, value) => _indexes.add(key));

        int _currentIndex = _indexes.reduce(min);
        String _currentHighlight = text.substring(_currentIndex,
            _currentIndex + _highlightsMap[_currentIndex]!.length);

        if (_currentIndex == _start) {
          _spans.add(_highlightSpan(_currentHighlight));
          _start += _currentHighlight.length;
        } else {
          _spans.add(_normalSpan(text.substring(_start, _currentIndex)));
          _spans.add(_highlightSpan(_currentHighlight));
          _start = _currentIndex + _currentHighlight.length;
        }
      } else {
        _spans.add(_normalSpan(text.substring(_start, text.length)));
        break;
      }
    }

    return _richText(TextSpan(children: _spans));
  }

  TextSpan _highlightSpan(String value) {
    if (style.color == null) {
      return TextSpan(
        text: value,
        style: style.copyWith(
          fontSize: 12,
          color: Colors.black,
          backgroundColor: color,
        ),
      );
    } else {
      return TextSpan(
        text: value,
        style: style.copyWith(
          fontSize: 12,
          backgroundColor: color,
        ),
      );
    }
  }

  TextSpan _normalSpan(String value) {
    if (style.color == null) {
      return TextSpan(
        text: value,
        style: style.copyWith(
          fontSize: 12,
          color: Colors.black,
        ),
      );
    } else {
      return TextSpan(
        text: value,
        style: style,
      );
    }
  }

  RichText _richText(TextSpan text) {
    return RichText(
      key: key,

      text: text,
      textAlign: textAlign,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
