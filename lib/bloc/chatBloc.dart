import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_pod/Model/chatMessageModel.dart';
import 'package:gemini_pod/Repositries/chatTextGeneration.dart';
import 'package:gemini_pod/bloc/blocEvent.dart';
import 'package:gemini_pod/bloc/chatState.dart';

class chatBloc extends Bloc<blocEvents, blocState> {
  chatBloc() : super(ChatSuccessState(messages: [])) {
    on<chatGenerateNewTextMessageEvent>(ChatGenerateNewTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];
  bool generatingText = false;
  FutureOr<void> ChatGenerateNewTextMessageEvent(
      chatGenerateNewTextMessageEvent event, Emitter<blocState> emit) async {
    messages.add(ChatMessageModel(role: "user", parts: [
      ChatPartsModel(text: event.inputMessage),
    ]));
    generatingText = true;
    emit(ChatSuccessState(messages: messages));
    await ChatRepo.chatTextGeneration(messages);
    String generatedText = await ChatRepo.chatTextGeneration(messages);
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(role: 'model', parts: [
        ChatPartsModel(text: generatedText),
      ]));
      emit(ChatSuccessState(messages: messages));
      generatingText = false;
    }
  }
}
