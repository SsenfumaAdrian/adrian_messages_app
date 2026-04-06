// FILE: lib/ui/screens/developer_console_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class DeveloperConsoleScreen extends StatefulWidget {
  const DeveloperConsoleScreen({super.key});
  @override
  State<DeveloperConsoleScreen> createState() => _State();
}

class _State extends State<DeveloperConsoleScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => AppScaffold(
      title: 'Developer API Console',
      child: Column(children: [
        Container(
            color: Palette.surface,
            child: TabBar(
                controller: _tabs,
                labelColor: Palette.primary,
                unselectedLabelColor: Palette.outline,
                indicator: BoxDecoration(
                    color: Palette.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(99)),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'API Keys'),
                  Tab(text: 'Webhooks'),
                  Tab(text: 'Logs')
                ])),
        Expanded(
            child: TabBarView(
                controller: _tabs,
                children: [_ApiKeysTab(), _WebhooksTab(), _LogsTab()])),
      ]));
}

class _ApiKeysTab extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) =>
      ListView(padding: EdgeInsets.all(20), children: [
        _CodeBlock(
            code:
                'curl -H "Authorization: Bearer sk_live_•••••••••••"\n     https://api.adrian.ai/v1/messages'),
        const SizedBox(height: 20),
        ...[
          ('Production Key', 'sk_live_••••••••', true),
          ('Test Key', 'sk_test_••••••••', false)
        ].map((k) => Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Palette.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.04), blurRadius: 8)
                ]),
            child: Row(children: [
              Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: k.$3 ? Palette.success : Palette.outline,
                      shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(k.$1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Palette.onSurface)),
                    Text(k.$2,
                        style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Palette.onSurfaceVariant)),
                  ])),
              const Icon(Icons.copy_rounded, color: Palette.outline, size: 18),
              const SizedBox(width: 8),
              const Icon(Icons.more_vert_rounded,
                  color: Palette.outline, size: 18),
            ]))),
        GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    border: Border.all(color: Palette.outlineVariant),
                    borderRadius: BorderRadius.circular(14)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_rounded, color: Palette.primary, size: 18),
                      const SizedBox(width: 6),
                      Text('Generate New Key',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Palette.primary,
                              fontSize: 13)),
                    ]))),
      ]);
}

class _WebhooksTab extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) =>
      ListView(padding: EdgeInsets.all(20), children: [
        ...[
          ('Message Received', 'https://api.yourapp.com/webhooks/msg', true),
          ('User Joined Circle', 'https://api.yourapp.com/webhooks/join', true),
          ('Vault Upload', 'https://api.yourapp.com/webhooks/vault', false)
        ].map((w) => Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Palette.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.04), blurRadius: 8)
                ]),
            child: Row(children: [
              Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: w.$3 ? Palette.success : Palette.error)),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(w.$1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Palette.onSurface)),
                    Text(w.$2,
                        style: const TextStyle(
                            fontSize: 11, color: Palette.onSurfaceVariant)),
                  ])),
              const Icon(Icons.more_vert_rounded,
                  color: Palette.outline, size: 18),
            ]))),
      ]);
}

class _LogsTab extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Container(
      color: const Color(0xFF0D1117),
      child: ListView(padding: EdgeInsets.all(16), children: [
        _LogLine('2026-03-29 14:32:01', '200 GET /v1/messages', true),
        _LogLine('2026-03-29 14:31:58', '201 POST /v1/messages', true),
        _LogLine('2026-03-29 14:30:45', '404 GET /v1/users/unknown', false),
        _LogLine('2026-03-29 14:29:12', '200 GET /v1/circles', true),
        _LogLine('2026-03-29 14:28:03', '401 POST /v1/vault/upload', false),
      ]));
}

class _LogLine extends StatelessWidget {
  const _LogLine(this.time, this.msg, this.ok);
  final String time, msg;
  final bool ok;
  @override
  Widget build(BuildContext ctx) => Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(time,
            style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: Color(0xFF8B949E))),
        const SizedBox(width: 10),
        Text(msg,
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: ok ? const Color(0xFF3FB950) : const Color(0xFFF85149))),
      ]));
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});
  final String code;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(14)),
      child: Text(code,
          style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF3FB950),
              height: 1.6)));
}
