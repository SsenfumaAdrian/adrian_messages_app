// FILE: lib/ui/screens/encrypted_vault_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class EncryptedVaultScreen extends StatelessWidget {
  const EncryptedVaultScreen({super.key});

  static const _files = [
    (
      'Project Chimera Brief.pdf',
      '2.4 MB',
      'Uploaded by Elena Vance',
      Icons.picture_as_pdf_outlined
    ),
    (
      'Architecture Diagram.fig',
      '18 MB',
      'Uploaded by Marcus Reid',
      Icons.design_services_outlined
    ),
    (
      'NDA — Signed Copy.pdf',
      '340 KB',
      'Uploaded by Sarah Miller',
      Icons.gavel_rounded
    ),
    (
      'Budget Forecast 2026.xlsx',
      '1.1 MB',
      'Uploaded by James Okonkwo',
      Icons.table_chart_outlined
    ),
    (
      'Server Credentials.enc',
      '4 KB',
      'Encrypted key bundle',
      Icons.key_rounded
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      activeRoute: LiquidRouter.vault,
      title: 'Encrypted Team Vault',
      actions: [
        _Badge('AES-256', Palette.accentCyan),
        const SizedBox(width: 8)
      ],
      child: Column(children: [
        // Vault header
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF00363D), Color(0xFF004F58)]),
              borderRadius: BorderRadius.circular(22)),
          child: Row(children: [
            const Icon(Icons.enhanced_encryption_rounded,
                color: Palette.accentCyan, size: 36),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text('Project Chimera Vault',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800)),
                  const Text('Zero-knowledge · 5 files · 21.9 MB used',
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 10),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                          value: 0.22,
                          minHeight: 5,
                          backgroundColor: Colors.white12,
                          color: Palette.accentCyan)),
                ])),
          ]),
        ),
        // Upload button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Palette.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Palette.outlineVariant.withOpacity(0.3),
                      style: BorderStyle.solid)),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file_outlined,
                        color: Palette.primary, size: 20),
                    SizedBox(width: 8),
                    Text('Upload encrypted file',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Palette.primary)),
                  ]),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // File list
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: _files.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final f = _files[i];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Palette.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Palette.primary.withOpacity(0.04),
                        blurRadius: 10)
                  ]),
              child: Row(children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        color: Palette.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(13)),
                    child: Icon(f.$4, color: Palette.primary, size: 22)),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(f.$1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Palette.onSurface)),
                      Text('${f.$2} · ${f.$3}',
                          style: const TextStyle(
                              fontSize: 11, color: Palette.onSurfaceVariant)),
                    ])),
                const Icon(Icons.lock_outline_rounded,
                    color: Palette.outline, size: 16),
                const SizedBox(width: 6),
                const Icon(Icons.more_vert_rounded,
                    color: Palette.outline, size: 18),
              ]),
            );
          },
        )),
      ]),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.label, this.color);
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(99)),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w700, color: color)));
}
