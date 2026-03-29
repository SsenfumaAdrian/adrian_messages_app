import 'dart:async';

import 'package:adrian_messages_app/features/messaging/data/messaging_repository.dart';
import 'package:adrian_messages_app/models/conversation_model.dart';
import 'package:adrian_messages_app/models/message_model.dart';
import 'package:adrian_messages_app/providers/messages_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeMessagingRepo implements MessagingRepository {
  final _controller = StreamController<MessageModel>.broadcast();
  final List<MessageModel> seeded;

  _FakeMessagingRepo(this.seeded);

  @override
  Stream<MessageModel> get incomingMessages => _controller.stream;

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    return seeded.where((m) => m.conversationId == conversationId).toList();
  }

  @override
  Future<List<ConversationModel>> getConversations(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<MessageModel> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return MessageModel(
      id: 'server_1',
      conversationId: conversationId,
      senderId: senderId,
      content: content,
      sentAt: DateTime(2020, 1, 1),
      isSentByMe: true,
      isRead: false,
    );
  }

  void dispose() => _controller.close();
}

void main() {
  test('MessagesNotifier adds a pending message then replaces it', () async {
    final repo = _FakeMessagingRepo([
      MessageModel(
        id: 'm1',
        conversationId: 'c1',
        senderId: 'u2',
        content: 'hello',
        sentAt: DateTime(2020, 1, 1),
      ),
    ]);

    final container = ProviderContainer(
      overrides: [
        messagingRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(() {
      repo.dispose();
      container.dispose();
    });

    final args = (conversationId: 'c1', userId: 'me');
    final notifier = container.read(messagesProvider(args).notifier);

    // Wait for initial load to finish (poll briefly).
    for (var i = 0; i < 50; i++) {
      if (container.read(messagesProvider(args)).isNotEmpty) break;
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }

    final before = container.read(messagesProvider(args));
    expect(before.length, 1);

    final sendFuture = notifier.sendMessage('new');
    await Future<void>.delayed(Duration.zero);
    final during = container.read(messagesProvider(args));
    expect(during.length, 2); // pending appended

    await sendFuture;
    final after = container.read(messagesProvider(args));
    expect(after.length, 2);
    expect(after.last.id, 'server_1');
  });
}

