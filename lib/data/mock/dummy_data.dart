import 'package:flutter/material.dart';

// FILE: lib/data/mock/dummy_data.dart
// Rich demo data combining best-in-class messaging app patterns

class Contact {
  const Contact({
    required this.id,
    required this.name,
    required this.status,
    this.role = '',
    this.online = false,
    this.verified = false,
    this.avatarColor = 0xFF1A237E,
  });
  final String id, name, status, role;
  final bool online, verified;
  final int avatarColor;
}

class Message {
  const Message({
    required this.text,
    required this.isMe,
    required this.time,
    this.status = 'read',
    this.reactions = const [],
    this.isVoice = false,
    this.duration = '',
    this.replyTo,
    this.isAI = false,
  });
  final String text, time, status;
  final List<String> reactions;
  final bool isMe, isVoice, isAI;
  final String duration;
  final String? replyTo;
}

class Conversation {
  const Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    this.isGroup = false,
    this.isPinned = false,
    this.isMuted = false,
    this.isEncrypted = true,
    this.isTyping = false,
    this.avatarColor = 0xFF1A237E,
    this.members = 0,
    this.isAI = false,
  });
  final String id, name, lastMessage, time;
  final int unread, members;
  final bool isGroup, isPinned, isMuted, isEncrypted, isTyping, isAI;
  final int avatarColor;
}

class DummyData {
  // ── Conversations ──────────────────────────────────────────
  static const conversations = [
    Conversation(
      id: '1', name: 'Elena Vance',
      lastMessage: 'The new Liquid UI looks incredible 🔥',
      time: '10:42 AM', unread: 3, isPinned: true,
      isTyping: false, avatarColor: 0xFF7B1FA2, isEncrypted: true,
    ),
    Conversation(
      id: '2', name: 'Project Alpha ⚡',
      lastMessage: 'Marcus: Ship it — the demo is tomorrow!',
      time: '10:31 AM', unread: 7, isGroup: true, members: 8,
      avatarColor: 0xFF00695C, isEncrypted: true,
    ),
    Conversation(
      id: '3', name: 'Marcus Reid',
      lastMessage: 'Did you review the Q4 deck?',
      time: '09:58 AM', unread: 1, avatarColor: 0xFFB71C1C,
    ),
    Conversation(
      id: '4', name: 'Leadership Circle',
      lastMessage: 'Priya: Board meeting moved to 3 PM',
      time: '09:15 AM', unread: 0, isGroup: true, members: 12,
      avatarColor: 0xFF0D47A1, isMuted: true,
    ),
    Conversation(
      id: '5', name: 'Sarah Miller',
      lastMessage: '🎤 Voice message · 0:24',
      time: 'Yesterday', unread: 0, avatarColor: 0xFF1B5E20,
    ),
    Conversation(
      id: '6', name: 'James Okonkwo',
      lastMessage: 'You: Got it, see you at 2.',
      time: 'Yesterday', unread: 0, avatarColor: 0xFFE65100,
    ),
    Conversation(
      id: '7', name: 'Design Collective 🎨',
      lastMessage: 'Leo: New Figma file dropped!',
      time: 'Mon', unread: 0, isGroup: true, members: 5,
      avatarColor: 0xFF880E4F,
    ),
    Conversation(
      id: '8', name: 'Priya Sharma',
      lastMessage: 'Encrypted vault shared ✓',
      time: 'Mon', unread: 0, avatarColor: 0xFF4A148C,
    ),
    Conversation(
      id: '9', name: 'Adrian AI 🤖',
      lastMessage: 'I summarised your week. Here\'s what matters…',
      time: 'Sun', unread: 2, isAI: true, avatarColor: 0xFF1A237E,
    ),
  ];

  // ── Contacts ───────────────────────────────────────────────
  static const contacts = [
    Contact(id: 'c1', name: 'Elena Vance', status: 'Online', role: 'Product Lead', online: true, verified: true, avatarColor: 0xFF7B1FA2),
    Contact(id: 'c2', name: 'Marcus Reid', status: 'In a meeting', role: 'Engineering', avatarColor: 0xFFB71C1C),
    Contact(id: 'c3', name: 'Sarah Miller', status: 'Last seen 2h ago', role: 'Design', avatarColor: 0xFF1B5E20),
    Contact(id: 'c4', name: 'James Okonkwo', status: 'Online', role: 'Strategy', online: true, avatarColor: 0xFFE65100),
    Contact(id: 'c5', name: 'Priya Sharma', status: 'Busy', role: 'Finance', avatarColor: 0xFF4A148C),
    Contact(id: 'c6', name: 'Leo Fontaine', status: 'Online', role: 'Creative', online: true, avatarColor: 0xFF880E4F),
    Contact(id: 'c7', name: 'Amara Diallo', status: 'Do not disturb', role: 'Legal', avatarColor: 0xFF004D40),
    Contact(id: 'c8', name: 'Ravi Krishnan', status: 'Online', role: 'Data Science', online: true, avatarColor: 0xFF33691E),
  ];

  // ── Chat messages ──────────────────────────────────────────
  static const chatMessages = [
    Message(text: 'Hey! Did you see the new Liquid Glass design?', isMe: false, time: '10:30 AM', status: 'read'),
    Message(text: 'Yes! It looks absolutely incredible. The blur and refraction effects are next level.', isMe: true, time: '10:31 AM', status: 'read', reactions: ['❤️']),
    Message(text: 'Adrian AI already summarised all our Q4 messages 🤯', isMe: false, time: '10:32 AM', status: 'read'),
    Message(text: 'That\'s the Stitch Intelligence engine. It\'s been indexing everything silently.', isMe: true, time: '10:33 AM', status: 'read'),
    Message(text: 'Should we share the vault access with the team?', isMe: false, time: '10:35 AM', status: 'read', replyTo: 'That\'s the Stitch Intelligence engine...'),
    Message(text: 'Already done. I set role-based permissions — Leads get full access, Contributors get read-only.', isMe: true, time: '10:36 AM', status: 'read'),
    Message(text: 'Perfect. Demo is at 2 PM tomorrow.', isMe: false, time: '10:38 AM', status: 'read', reactions: ['🔥', '👍']),
    Message(text: '', isMe: false, time: '10:39 AM', status: 'read', isVoice: true, duration: '0:18'),
    Message(text: 'Got it. I\'ll have the deck ready. Let\'s ship it 🚀', isMe: true, time: '10:42 AM', status: 'delivered'),
  ];

  // ── Status stories ─────────────────────────────────────────
  static const statusUpdates = [
    ('Elena Vance', 'Just shipped v3.0 ✨', '2m ago', 0xFF7B1FA2),
    ('Marcus Reid', 'In deep work mode 🧠', '1h ago', 0xFFB71C1C),
    ('Leo Fontaine', 'New design system drop', '3h ago', 0xFF880E4F),
    ('Amara Diallo', 'Closing the Nexus deal 💼', '5h ago', 0xFF004D40),
  ];

  // ── Discover sections ──────────────────────────────────────
  static const trendingTopics = [
    'Q4 Strategy', 'New Design System', 'Platform Launch', 'Team Offsite', 'AI Integration',
  ];

  static const suggestedCircles = [
    ('Flutter Devs', '891 members', Icons.code_rounded),
    ('Product Leaders', '612 members', Icons.rocket_launch_outlined),
    ('Design Systems', '1.2K members', Icons.design_services_outlined),
  ];

  /// Legacy Map-based list — used by StitchAggregator and LiquidProvider.
  static List<Map<String, dynamic>> get chatList => conversations.map((c) => {
    'id': c.id,
    'name': c.name,
    'lastMessage': c.lastMessage,
    'time': c.time,
    'unread': c.unread,
    'isStitched': false,
  }).toList();
}
