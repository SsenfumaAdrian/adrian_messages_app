// FILE: lib/core/navigation/liquid_router.dart
//
// Named routes for every screen in the Stitch design.
// Usage:
//   Navigator.pushNamed(context, LiquidRouter.conversations);
//   Navigator.pushNamed(context, LiquidRouter.chat, arguments: chatArgs);

import 'package:flutter/material.dart';

// Import all screens (add imports as screens are created)
import '../../ui/screens/auth_screen.dart';
import '../../ui/screens/liquid_splash_screen.dart';
import '../../ui/screens/onboarding_screen.dart';
import '../../ui/screens/conversations_list_screen.dart';
import '../../ui/screens/contacts_screen.dart';
import '../../ui/screens/chat_room_screen.dart';
// import '../../ui/screens/user_profile_screen.dart';
// import '../../ui/screens/group_creation_screen.dart';
// import '../../ui/screens/shared_media_screen.dart';
// import '../../ui/screens/privacy_security_screen.dart';
// import '../../ui/screens/call_screen.dart';
// import '../../ui/screens/voice_studio_screen.dart';
// import '../../ui/screens/global_discovery_screen.dart';
// import '../../ui/screens/archived_vault_screen.dart';
// import '../../ui/screens/circle_management_screen.dart';
// import '../../ui/screens/scheduled_drafting_screen.dart';
// import '../../ui/screens/communication_insights_screen.dart';
// import '../../ui/screens/personalization_gallery_screen.dart';
// import '../../ui/screens/encrypted_vault_screen.dart';
// import '../../ui/screens/admin_dashboard_screen.dart';
// import '../../ui/screens/audit_log_screen.dart';
// import '../../ui/screens/ai_assistant_screen.dart';
// import '../../ui/screens/ai_conflict_resolution_screen.dart';
// import '../../ui/screens/ai_training_workspace_screen.dart';
// import '../../ui/screens/compliance_audit_screen.dart';
// import '../../ui/screens/developer_console_screen.dart';
// import '../../ui/screens/enterprise_support_screen.dart';
// import '../../ui/screens/extensions_marketplace_screen.dart';
// import '../../ui/screens/system_health_screen.dart';

class LiquidRouter {
  LiquidRouter._();

  // ── Route name constants ───────────────────────────────────
  static const String splash = '/';
  static const String auth = '/auth';
  static const String onboarding = '/onboarding';
  static const String conversations = '/conversations';
  static const String chat = '/chat';
  static const String contacts = '/contacts';
  static const String profile = '/profile';
  static const String groupCreation = '/group/create';
  static const String sharedMedia = '/media';
  static const String privacy = '/privacy';
  static const String callScreen = '/call';
  static const String voiceStudio = '/voice';
  static const String discovery = '/discovery';
  static const String archive = '/archive';
  static const String circleManage = '/circles/manage';
  static const String scheduledDraft = '/drafts';
  static const String insights = '/insights';
  static const String personalization = '/personalize';
  static const String vault = '/vault';
  static const String adminDashboard = '/admin';
  static const String auditLog = '/audit';
  static const String aiAssistant = '/ai';
  static const String aiConflict = '/ai/conflict';
  static const String aiTraining = '/ai/training';
  static const String compliance = '/compliance';
  static const String devConsole = '/dev';
  static const String enterprise = '/enterprise';
  static const String marketplace = '/marketplace';
  static const String systemHealth = '/system/health';

  // ── Route map for MaterialApp.routes ──────────────────────
  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const LiquidSplashScreen(),
        auth: (_) => const AuthScreen(),
        onboarding: (_) => const OnboardingScreen(),
        conversations: (_) => const ConversationsListScreen(),
        contacts: (_) => const ContactsScreen(),
        // Screens below: uncomment as each dart file is created
        // profile:       (_) => const UserProfileScreen(),
        // groupCreation: (_) => const GroupCreationScreen(),
        // sharedMedia:   (_) => const SharedMediaScreen(),
        // privacy:       (_) => const PrivacySecurityScreen(),
        // voiceStudio:   (_) => const VoiceStudioScreen(),
        // discovery:     (_) => const GlobalDiscoveryScreen(),
        // archive:       (_) => const ArchivedVaultScreen(),
        // circleManage:  (_) => const CircleManagementScreen(),
        // scheduledDraft:(_) => const ScheduledDraftingScreen(),
        // insights:      (_) => const CommunicationInsightsScreen(),
        // personalization:(_)=> const PersonalizationGalleryScreen(),
        // vault:         (_) => const EncryptedVaultScreen(),
        // adminDashboard:(_) => const AdminDashboardScreen(),
        // auditLog:      (_) => const AuditLogScreen(),
        // aiAssistant:   (_) => const AiAssistantScreen(),
        // aiConflict:    (_) => const AiConflictResolutionScreen(),
        // aiTraining:    (_) => const AiTrainingWorkspaceScreen(),
        // compliance:    (_) => const ComplianceAuditScreen(),
        // devConsole:    (_) => const DeveloperConsoleScreen(),
        // enterprise:    (_) => const EnterpriseSupportScreen(),
        // marketplace:   (_) => const ExtensionsMarketplaceScreen(),
        // systemHealth:  (_) => const SystemHealthScreen(),
      };

  // ── Named route generator (handles arguments) ─────────────
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chat:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return _fade(ChatRoomScreen(
          chatName: args['name'] as String? ?? 'Chat',
        ));
      default:
        // Fall through to routes map
        final builder = routes[settings.name];
        if (builder != null) return _fade(builder(null as BuildContext));
        return null;
    }
  }

  // ── Transition builder ────────────────────────────────────
  /// Fade + micro-scale — the "liquid" transition used app-wide.
  static PageRoute<T> _fade<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 340),
      reverseTransitionDuration: const Duration(milliseconds: 240),
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

  /// Convenience: push a named route.
  static Future<T?> go<T>(BuildContext context, String name,
          {Object? arguments}) =>
      Navigator.pushNamed<T>(context, name, arguments: arguments);

  /// Convenience: replace current route.
  static Future<T?> replace<T>(BuildContext context, String name,
          {Object? arguments}) =>
      Navigator.pushReplacementNamed<T, dynamic>(context, name,
          arguments: arguments);

  /// Clear stack and go to a route (e.g. after logout).
  static Future<T?> clearAndGo<T>(BuildContext context, String name) =>
      Navigator.pushNamedAndRemoveUntil<T>(context, name, (_) => false);
}
