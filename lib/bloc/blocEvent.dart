
import 'package:flutter/material.dart';
// part of chatBloc;
@immutable
sealed class blocEvents{}

class chatGenerateNewTextMessageEvent extends blocEvents{
  final String inputMessage;

  chatGenerateNewTextMessageEvent({required this.inputMessage});
}