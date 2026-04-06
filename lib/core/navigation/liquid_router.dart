// FILE: lib/core/navigation/liquid_router.dart
//
// Single source of truth for all app routes.
// Every screen is registered here. Add new screens in one place only.

import 'package:flutter/material.dart';

import '../../ui/screens/admin_dashboard_screen.dart';
import '../../ui/screens/ai_assistant_screen.dart';
import '../../ui/screens/ai_conflict_resolution_screen.dart';
import '../../ui/screens/ai_training_workspace_screen.dart';
import '../../ui/screens/archived_vault_screen.dart';
import '../../ui/screens/audit_log_screen.dart';
import '../../ui/screens/auth_screen.dart';
import '../../ui/screens/call_screen.dart';
import '../../ui/screens/chat_room_screen.dart';
import '../../ui/screens/circle_management_screen.dart';
import '../../ui/screens/communication_insights_screen.dart';
import '../../ui/screens/compliance_audit_screen.dart';
import '../../ui/screens/contacts_screen.dart';
import '../../ui/screens/conversations_list_screen.dart';
import '../../ui/screens/developer_console_screen.dart';
import '../../ui/screens/encrypted_vault_screen.dart';
import '../../ui/screens/enterprise_support_screen.dart';
import '../../ui/screens/extensions_marketplace_screen.dart';
import '../../ui/screens/global_discovery_screen.dart';
import '../../ui/screens/group_creation_screen.dart';
import '../../ui/screens/liquid_splash_screen.dart';
import '../../ui/screens/onboarding_screen.dart';
import '../../ui/screens/personalization_gallery_screen.dart';
import '../../ui/screens/privacy_security_screen.dart';
import '../../ui/screens/scheduled_drafting_screen.dart';
import '../../ui/screens/shared_media_screen.dart';
import '../../ui/screens/system_health_screen.dart';
import '../../ui/screens/user_profile_screen.dart';
import '../../ui/screens/main_shell.dart';
import '../../ui/screens/voice_studio_screen.dart';

class LiquidRouter {
  LiquidRouter._();

  // ── Route name constants ───────────────────────────────────
  static const String shell           = '/shell';
  static const String splash          = '/';
  static const String auth            = '/auth';
  static const String onboarding      = '/onboarding';
  static const String conversations   = '/conversations';
  static const String chat            = '/chat';
  static const String contacts        = '/contacts';
  static const String profile         = '/profile';
  static const String groupCreation   = '/group/create';
  static const String sharedMedia     = '/media';
  static const String privacy         = '/privacy';
  static const String callScreen      = '/call';
  static const String voiceStudio     = '/voice';
  static const String discovery       = '/discovery';
  static const String archive         = '/archive';
  static const String circleManage    = '/circles/manage';
  static const String scheduledDraft  = '/drafts';
  static const String insights        = '/insights';
  static const String personalization = '/personalize';
  static const String vault           = '/vault';
  static const String adminDashboard  = '/admin';
  static const String auditLog        = '/audit';
  static const String aiAssistant     = '/ai';
  static const String aiConflict      = '/ai/conflict';
  static const String aiTraining      = '/ai/training';
  static const String compliance      = '/compliance';
  static const String devConsole      = '/dev';
  static const String enterprise      = '/enterprise';
  static const String marketplace     = '/marketplace';
  static const String systemHealth    = '/system/health';

  // ── Route map ─────────────────────────────────────────────
  // Full map including splash — use with initialRoute (no home:)
  static Map<String, WidgetBuilder> get routes => {
    splash:          (_) => const LiquidSplashScreen(),
    shell:           (_) => const MainShell(),
    auth:            (_) => const AuthScreen(),
    onboarding:      (_) => const OnboardingScreen(),
    conversations:   (_) => const ConversationsListScreen(),
    contacts:        (_) => const ContactsScreen(),
    profile:         (_) => const UserProfileScreen(),
    groupCreation:   (_) => const GroupCreationScreen(),
    sharedMedia:     (_) => const SharedMediaScreen(),
    privacy:         (_) => const PrivacySecurityScreen(),
    voiceStudio:     (_) => const VoiceStudioScreen(),
    discovery:       (_) => const GlobalDiscoveryScreen(),
    archive:         (_) => const ArchivedVaultScreen(),
    circleManage:    (_) => const CircleManagementScreen(),
    scheduledDraft:  (_) => const ScheduledDraftingScreen(),
    insights:        (_) => const CommunicationInsightsScreen(),
    personalization: (_) => const PersonalizationGalleryScreen(),
    vault:           (_) => const EncryptedVaultScreen(),
    adminDashboard:  (_) => const AdminDashboardScreen(),
    auditLog:        (_) => const AuditLogScreen(),
    aiAssistant:     (_) => const AiAssistantScreen(),
    aiConflict:      (_) => const AiConflictResolutionScreen(),
    aiTraining:      (_) => const AiTrainingWorkspaceScreen(),
    compliance:      (_) => const ComplianceAuditScreen(),
    devConsole:      (_) => const DeveloperConsoleScreen(),
    enterprise:      (_) => const EnterpriseSupportScreen(),
    marketplace:     (_) => const ExtensionsMarketplaceScreen(),
    systemHealth:    (_) => const SystemHealthScreen(),
  };

  /// Routes without the splash '/' entry.
  /// Use this when MaterialApp has home: set, to avoid the
  /// "home + routes['/'] conflict" assertion.
  static Map<String, WidgetBuilder> get routesNoSplash {
    final m = Map<String, WidgetBuilder>.from(routes);
    m.remove(splash);
    return m;
  }

  // ── Named route generator (handles routes with arguments) ──
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case shell:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _fade(MainShell(
          initialIndex: args['index'] as int? ?? 0,
        ));
      case chat:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _fade(ChatRoomScreen(
          chatName: args['name'] as String? ?? 'Chat',
        ));
      case callScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _fade(CallScreen(
          contactName: args['name'] as String? ?? 'Unknown',
          isVideo: args['isVideo'] as bool? ?? false,
        ));
      default:
        return null; // Let MaterialApp.routes handle registered routes
    }
  }

  // ── Liquid fade+scale transition ──────────────────────────
  static PageRoute<T> _fade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration(milliseconds: 340),
      reverseTransitionDuration: Duration(milliseconds: 240),
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  // ── Navigation helpers ─────────────────────────────────────
  static Future<T?> go<T>(BuildContext context, String name, {Object? arguments}) =>
      Navigator.pushNamed<T>(context, name, arguments: arguments);

  static Future<T?> replace<T>(BuildContext context, String name, {Object? arguments}) =>
      Navigator.pushReplacementNamed<T, dynamic>(context, name, arguments: arguments);

  static Future<T?> clearAndGo<T>(BuildContext context, String name) =>
      Navigator.pushNamedAndRemoveUntil<T>(context, name, (_) => false);
}
