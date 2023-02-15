import 'dart:async';

import 'package:flutter/material.dart';
import 'package:MetaHelp/meta_app/src/model/mh_chat.dart';
import 'package:MetaHelp/meta_app/src/riverpod/chat_text_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final mhChatProvider = StateNotifierProvider<ChatList, List<MhChat>>((ref) => ChatList([], ref));

class ChatList extends StateNotifier<List<MhChat>> {
  Ref ref;
  Timer? receiveTimer;
  ChatList(List<MhChat> state, this.ref) : super(state);

  // ScrollController _scrollController =  ScrollController();

  add() {
    String msg = ref.read(chatTextProvider).text.trim();

    print("add: msg: $msg");
    state = [
      ...state,
      MhChat(
          profileImg: "https://cdn.pixabay.com/photo/2021/10/07/12/56/robot-6688548_960_720.jpg",
          isSend: true,
          msg: msg,
          time: DateFormat("HH:mm").format(DateTime.now()),
          uid: const Uuid().v4())
    ];
    receiveTimer ??= Timer(const Duration(milliseconds: 500), () {
      state = [
        ...state,
        MhChat(
            profileImg: "https://cdn.pixabay.com/photo/2021/10/07/12/56/robot-6688548_960_720.jpg",
            isSend: false,
            msg: "How are you?",
            time: DateFormat("HH:mm").format(DateTime.now()),
            uid: const Uuid().v4())
      ];
      receiveTimer?.cancel();
      receiveTimer = null;
    });
  }
}
