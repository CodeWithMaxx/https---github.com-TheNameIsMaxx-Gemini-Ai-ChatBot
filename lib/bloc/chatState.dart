import 'package:gemini_pod/Model/chatMessageModel.dart';

abstract class blocState{}

class chatInitialState extends blocState{}

class ChatSuccessState extends blocState{
  final List<ChatMessageModel>messages;

  ChatSuccessState({required this.messages});
}