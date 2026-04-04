# CLAUDE.md — Adrian Messages Flutter Project

> This file is the single source of truth for the project.
> Read this FIRST before touching any file. Follow every rule here exactly.

---

## 1. Project Identity

| Field | Value |
|-------|-------|
| **App name** | Adrian Messages |
| **Package** | `adrian_messages` |
| **Flutter SDK** | Latest stable |
| **Dart version** | Dart 3+ (records, patterns, `sealed`, etc.) |
| **Design system** | Stitch — light theme |
| **Design source** | `/stitch/` folder (HTML/CSS reference screens) |
| **Primary color** | `#1A237E` (deep indigo) |
| **Surface color** | `#fbf8ff` (off-white blue tint) |
| **Fonts** | Manrope (display/headlines), Inter (body/labels) |

---

## 2. Architecture

```
lib/
├── main.dart                          ← Entry point. NO home: + routes['/'] conflict.
├── core/
│   ├── constants/palette.dart         ← ALL color tokens + ThemeData factories
│   ├── navigation/liquid_router.dart  ← ALL named routes registered here
│   ├── theme/                         ← DELETED. Use Palette instead.
│   └── ...
├── data/mock/dummy_data.dart          ← Demo data (no real backend yet)
├── ui/
│   ├── components/                    ← Shared reusable widgets
│   │   ├── app_shell.dart             ← Scaffold with sidebar (desktop) / header (mobile)
│   │   ├── liquid_glass.dart          ← 🔑 Liquid Glass component library
│   │   ├── shared_widgets.dart        ← SectionTitle, GradientButton, KpiCard, etc.
│   │   └── glass_text_field.dart      ← Dark-mode glass text field (auth screens)
│   └── screens/
│       ├── main_shell.dart            ← 🔑 App-level nav shell (mobile/tablet/desktop)
│       └── [30 screen files]
```

---

## 3. Navigation — CRITICAL RULES

### Flow
```
Splash (/) → Auth (/auth) → Onboarding (/onboarding) → Shell (/shell) → [tabs]
```

### main.dart — exact correct pattern
```dart
MaterialApp(
  theme: Palette.lightTheme,
  darkTheme: Palette.darkTheme,
  initialRoute: LiquidRouter.splash,   // ← use initialRoute ONLY
  routes: LiquidRouter.routes,
  onGenerateRoute: LiquidRouter.onGenerateRoute,
  // NO home: property — it conflicts with routes['/']
)
```

### Navigation helpers (always use these, never push strings directly)
```dart
LiquidRouter.go(context, LiquidRouter.chat, arguments: {'name': 'Elena'});
LiquidRouter.replace(context, LiquidRouter.onboarding);
LiquidRouter.clearAndGo(context, LiquidRouter.shell);  // clears back stack
```

### All named routes
| Constant | Path | Screen |
|----------|------|--------|
| `splash` | `/` | LiquidSplashScreen |
| `auth` | `/auth` | AuthScreen |
| `onboarding` | `/onboarding` | OnboardingScreen |
| `shell` | `/shell` | MainShell |
| `conversations` | `/conversations` | ConversationsListScreen |
| `chat` | `/chat` | ChatRoomScreen (args: `name`) |
| `contacts` | `/contacts` | ContactsScreen |
| `profile` | `/profile` | UserProfileScreen |
| `groupCreation` | `/group/create` | GroupCreationScreen |
| `sharedMedia` | `/media` | SharedMediaScreen |
| `privacy` | `/privacy` | PrivacySecurityScreen |
| `callScreen` | `/call` | CallScreen (args: `name`, `isVideo`) |
| `voiceStudio` | `/voice` | VoiceStudioScreen |
| `discovery` | `/discovery` | GlobalDiscoveryScreen |
| `archive` | `/archive` | ArchivedVaultScreen |
| `circleManage` | `/circles/manage` | CircleManagementScreen |
| `scheduledDraft` | `/drafts` | ScheduledDraftingScreen |
| `insights` | `/insights` | CommunicationInsightsScreen |
| `personalization` | `/personalize` | PersonalizationGalleryScreen |
| `vault` | `/vault` | EncryptedVaultScreen |
| `adminDashboard` | `/admin` | AdminDashboardScreen |
| `auditLog` | `/audit` | AuditLogScreen |
| `aiAssistant` | `/ai` | AiAssistantScreen |
| `aiConflict` | `/ai/conflict` | AiConflictResolutionScreen |
| `aiTraining` | `/ai/training` | AiTrainingWorkspaceScreen |
| `compliance` | `/compliance` | ComplianceAuditScreen |
| `devConsole` | `/dev` | DeveloperConsoleScreen |
| `enterprise` | `/enterprise` | EnterpriseSupportScreen |
| `marketplace` | `/marketplace` | ExtensionsMarketplaceScreen |
| `systemHealth` | `/system/health` | SystemHealthScreen |

---

## 4. MainShell — Responsive Navigation

`lib/ui/screens/main_shell.dart` is the authenticated app shell. It owns navigation — no screen should add its own bottom nav.

| Width | Nav Style |
|-------|-----------|
| `< 600px` | Curved glass bottom bar with notch bump + active icon bubble |
| `600–900px` | Floating centred glass pill — hides on scroll-down, reappears on scroll-up |
| `> 900px` | Each screen's `AppShell` sidebar handles desktop nav |

**5 main tabs:**
1. Chats → `ConversationsListScreen`
2. Contacts → `ContactsScreen`
3. Discover → `GlobalDiscoveryScreen`
4. Adrian AI → `AiAssistantScreen`
5. Profile → `UserProfileScreen`

**Rules:**
- `MainShell` uses `extendBody: true` on mobile so content flows under the glass bar
- Individual screens MUST NOT have their own `BottomNavigationBar`
- `ConversationsListScreen` has NO nav bar — MainShell provides it

---

## 5. Liquid Glass Design Language

**File:** `lib/ui/components/liquid_glass.dart`

This is Apple's iOS 26 / macOS Tahoe Liquid Glass aesthetic. Glass elements blur content behind them, show specular highlights, and respond to press with scale animation.

### Components

#### `LiquidGlassButton`
Circular glass button with `BackdropFilter` blur + 3-stop gradient simulating real glass refraction.
```dart
LiquidGlassButton(
  icon: Icons.settings_rounded,
  size: 44,           // diameter
  iconSize: 20,
  tint: Palette.primary,   // optional brand tint
  tooltip: 'Settings',
  onTap: () {},
)
```

#### `LiquidGlassBackButton`
Pre-configured back button. Used on EVERY sub-screen automatically via `AppShell._Header`.
```dart
LiquidGlassBackButton(size: 40)
// Calls Navigator.maybePop(context) by default
// Override: LiquidGlassBackButton(size: 40, onTap: myCallback)
```

#### `LiquidGlassSurface`
Generic glass card container.
```dart
LiquidGlassSurface(
  borderRadius: 24,
  blurSigma: 20,
  opacity: 0.65,
  tint: Colors.white,   // optional
  child: myContent,
)
```

#### `LiquidGlassBar`
Glass top app bar with blur.
```dart
LiquidGlassBar(
  title: 'Settings',
  leading: LiquidGlassBackButton(),
  actions: [LiquidGlassButton(...)],
)
```

#### `LiquidGlassChip`
Pill badge/label.
```dart
LiquidGlassChip(label: 'AI-Powered', icon: Icons.auto_awesome, tint: Palette.primary)
```

### Glass gradient formula (3-stop)
```dart
LinearGradient(
  stops: [0.0, 0.45, 1.0],
  colors: [
    Colors.white.withValues(alpha: 0.75),  // top-left specular highlight
    tintColor.withValues(alpha: 0.18),      // mid: brand tint
    Colors.white.withValues(alpha: 0.20),  // bottom-right refraction shadow
  ],
)
```

### AppShell headers are already glass
`AppShell` uses `_Header` with `BackdropFilter` and shows `LiquidGlassBackButton` automatically when `Navigator.canPop(context)` is true. You don't need to add back buttons manually to AppShell screens.

---

## 6. Palette Tokens

**File:** `lib/core/constants/palette.dart`

### DO NOT use these deleted aliases
| ❌ Old (deleted) | ✅ Use instead |
|-----------------|---------------|
| `Palette.textPrimary` | `Palette.onSurface` |
| `Palette.textMuted` | `Palette.onSurfaceVariant` |
| `Palette.accentBlue` | `const Color(0xFF0F6FFF)` |
| `Palette.background` | `Palette.darkBackground` |

### Key tokens
```dart
Palette.primary           // #1A237E — brand indigo
Palette.surface           // #fbf8ff — page background
Palette.onSurface         // #191C1D — primary text
Palette.onSurfaceVariant  // #454652 — secondary text
Palette.outline           // #767683 — muted/hint text
Palette.outlineVariant    // #C6C5D4 — borders
Palette.accentCyan        // #00DAF3 — highlights, links, online dots
Palette.surfaceContainerLowest  // #ffffff — card background
Palette.surfaceContainerLow     // #F3F4F5 — input fill
Palette.surfaceContainerHigh    // #EAE7EF — active/selected rows
Palette.darkBackground    // #060D1F — auth/splash dark bg
Palette.success           // #00695C
Palette.error             // #B3261E
Palette.fontDisplay       // 'Manrope'
Palette.fontBody          // 'Inter'
```

### ThemeData
```dart
theme: Palette.lightTheme    // all 30 main screens
darkTheme: Palette.darkTheme // auth/splash glass screens
```

---

## 7. Shared Components — `shared_widgets.dart`

Always import from here, never duplicate:

```dart
SectionTitle('My Section', trailing: myWidget)
FieldLabel('Email')
GradientButton(label: 'Submit', icon: Icons.check, onTap: _submit)
OutlineButton(label: 'Cancel', onTap: _cancel)
StatusBadge(label: 'Live', color: Palette.accentCyan)
KpiCard(label: 'Users', value: '48K', icon: Icons.people, delta: '+12%', deltaUp: true)
SurfaceCard(child: myContent)
InitialsAvatar(initials: 'EV', size: 44, online: true)
LabeledTextField(label: 'Email', hint: 'you@example.com', controller: _ctrl)
```

---

## 8. AppShell — Sub-screen Scaffold

Every authenticated screen that is NOT a main tab uses `AppShell`:

```dart
AppShell(
  activeRoute: LiquidRouter.settings,   // highlights sidebar item
  title: 'Settings',                    // shown in glass header
  actions: [myActionWidget],            // right-side header buttons
  child: myScrollableContent,
)
```

`AppShell` auto-applies:
- Desktop: 256px sidebar + glass header
- Mobile/Tablet: glass top header with `LiquidGlassBackButton` (when back is possible)

---

## 9. Auth Flow

**Demo mode:** Any email (must contain `@`) + password ≥ 4 chars → login succeeds.

**Files:**
- `lib/ui/screens/auth_screen.dart` — responsive layout picker
- `lib/ui/screens/auth/components/glass_login_card.dart` — login logic + demo validation
- `lib/ui/screens/auth/components/glass_text_field.dart` — dark glass input field
- `lib/ui/screens/auth/layouts/` — mobile/tablet/desktop layouts

**Login card behaviour:**
- `TextEditingController` on email + password fields
- Inline red error messages clear on typing
- 900ms fake network delay with `CircularProgressIndicator`
- On success: `LiquidRouter.clearAndGo(context, LiquidRouter.onboarding)`
- "Create an Account" also goes to onboarding

---

## 10. Dart & Flutter Rules — NEVER VIOLATE

### const rules
```dart
// ✅ OK — these ARE const constructors
const EdgeInsets.all(16)
const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
const Radius.circular(12)
const Duration(milliseconds: 300)
const Offset(0, 4)
const TextStyle(fontSize: 14, color: Palette.onSurface)

// ❌ NEVER add const to these — they are NOT const constructors
BoxDecoration(...)        // not const
LinearGradient(...)       // not const in non-const context
BackdropFilter(...)       // not const
Container(...)            // not const
AnimatedContainer(...)    // not const
```

### withValues — ALWAYS use, never withOpacity
```dart
// ✅ Correct
color.withValues(alpha: 0.5)

// ❌ Deprecated — never use
color.withOpacity(0.5)
```

### Default parameter values must be const
```dart
// ✅
const SurfaceCard({this.padding = const EdgeInsets.all(16)});

// ❌ Error: non_constant_default_value
SurfaceCard({this.padding = EdgeInsets.all(16)});
```

### Futures must be awaited or marked unawaited
```dart
import 'dart:async' show unawaited;

// Navigation futures
unawaited(LiquidRouter.clearAndGo(context, LiquidRouter.shell));

// Fire-and-forget delays
unawaited(Future.delayed(const Duration(milliseconds: 300), () { ... }));

// ScrollController
unawaited(_scroll.animateTo(_scroll.position.maxScrollExtent, ...));
//                                   ↑ .position.maxScrollExtent NOT .maxScrollExtent
```

### Private types in public API
```dart
// ✅ Correct — return type is State<WidgetClass>
@override
State<MyWidget> createState() => _MyWidgetState();

// ❌ Error — exposes private type
_MyWidgetState createState() => _MyWidgetState();
```

### Non-constant identifier names
```dart
// ✅ lowerCamelCase for functions/variables
Widget _fieldLabel(String t) => ...
Widget _inputField({required TextEditingController ctrl}) => ...

// ❌ UpperCamelCase reserved for classes only
Widget _FieldLabel(String t) => ...
Widget _TextField(...) => ...
```

### Const constructors and function fields
```dart
// ✅ OK — remove const from constructor when field is VoidCallback?
class _MyWidget extends StatelessWidget {
  _MyWidget({this.onTap});         // no const
  final VoidCallback? onTap;
}

// ❌ Error — const constructor can't have function-type field initialized via this.param
class _MyWidget extends StatelessWidget {
  const _MyWidget({this.onTap});   // const + VoidCallback? = error
  final VoidCallback? onTap;
}
```

### Curly braces in flow control
```dart
// ✅ Always use braces
if (!_unlocked) {
  return Center(...);
}

// ❌ Error
if (!_unlocked)
  return Center(...);
```

### No duplicate imports
Each `import` statement must appear exactly once per file.

---

## 11. analysis_options.yaml

```yaml
linter:
  rules:
    always_declare_return_types: true
    avoid_unused_constructor_parameters: true
    prefer_final_fields: true
    prefer_final_locals: true
    unawaited_futures: true
    # Disabled — these const rules block builds:
    unnecessary_const: false
    prefer_const_constructors: false
    prefer_const_literals_to_create_immutables: false
    prefer_const_constructors_in_immutables: false
    # const_with_non_const is a compiler error, NOT a lint rule — never add it here
```

---

## 12. Bugs Burned Into Memory — Never Repeat

| Bug | Cause | Fix |
|-----|-------|-----|
| `Borderconst Radius.circular(N)` | Regex matched `Radius.circular` inside `BorderRadius.circular` | Never run regex on `Radius.circular` alone; scope to standalone usage |
| `home:` + `routes['/']` conflict | `main.dart` had both `home: LiquidSplashScreen()` and `'/'` in routes | Remove `home:` — use `initialRoute` only |
| `builder(null as BuildContext)` | Router's default case called `builder(null as BuildContext)` | `default: return null;` and let routes map handle it |
| `_BlurFilter extends ImageFilter` | Invalid subclass of sealed `ImageFilter` | Use `ImageFilter.blur(sigmaX: N, sigmaY: N)` directly |
| `SectionTitle` ambiguous import | Defined in both `app_shell.dart` and `shared_widgets.dart` | `SectionTitle` lives ONLY in `shared_widgets.dart` |
| `ScrollController.maxScrollExtent` | `maxScrollExtent` is on `.position`, not directly on controller | `_scroll.position.maxScrollExtent` |
| `const_with_non_const` as lint rule | `const_with_non_const` is a compiler error code, not a lint name | Do not add to `analysis_options.yaml` |
| Duplicate `import 'dart:ui'` | Script prepended import that already existed | Check for existing imports before adding |

---

## 13. Stitch Screens — Implementation Status

### ✅ Implemented (30 screens)
All screens in `lib/ui/screens/` are fully built and connected via `LiquidRouter`.

### ❌ Not yet implemented (13 Stitch screens still in `/stitch/` folder)
These have HTML designs but no Flutter implementation yet:

1. `automated_workflow_builder` → `AutomatedWorkflowBuilderScreen`
2. `biometric_hardware_key_management` → `BiometricKeyManagementScreen`
3. `circle_onboarding_rules` → `CircleOnboardingRulesScreen`
4. `community_public_channels` → `CommunityChannelsScreen`
5. `cross_platform_device_management` → `DeviceManagementScreen`
6. `custom_ai_persona_builder` → `AiPersonaBuilderScreen`
7. `data_export_portability` → `DataExportScreen`
8. `digital_will_data_legacy` → `DigitalWillScreen`
9. `encrypted_notes_whiteboard` → `EncryptedNotesScreen`
10. `enterprise_usage_analytics` → `EnterpriseAnalyticsScreen`
11. `global_translation_localization` → `TranslationScreen`
12. `platform_wide_search_archive` → `SearchArchiveScreen`
13. `security_audit_report` → `SecurityAuditReportScreen`

**When implementing any of the above:**
1. Reference the HTML in `/stitch/[folder_name]/code.html`
2. Extract colours, layout, component structure
3. Add class to `lib/ui/screens/[name]_screen.dart`
4. Add route constant to `LiquidRouter`
5. Add import + entry to `LiquidRouter.routes` map
6. Wrap with `AppShell`

---

## 14. Demo Login Credentials

Any of these work (demo mode):
- Email: anything with `@` (e.g. `demo@test.com`)  
- Phone: 7+ digits (e.g. `+256700000000`)
- Password: any 4+ characters (e.g. `1234`)

---

## 15. File Conventions

- `// FILE: lib/...` comment at the top of every dart file
- No file should exceed ~400 lines — split into sub-components if needed
- Screen files go in `lib/ui/screens/`
- Shared components go in `lib/ui/components/`
- Private helper widgets inside a screen file use `_PascalCase` for classes, `_camelCase` for functions
- Always `const` on widget constructors when possible
- Use named record fields (Dart 3): `(name: 'x', time: 'y', icon: Icons.x)` not positional `('x', 'y', Icons.x)`

---

## 16. Running the App

```powershell
cd "d:\Adrian Messages\adrian_messages_app"
flutter pub get
flutter analyze          # must say "No issues found!"
flutter run -d chrome    # web
flutter run -d windows   # desktop
```
