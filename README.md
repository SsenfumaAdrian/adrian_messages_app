# 💧 Adrian Messages: The Liquid Glass Revolution

Adrian Messages is a high-performance, refractive messaging ecosystem designed to surpass legacy giants (WhatsApp, iMessage, Signal). It utilizes a modular **Stitch Architecture** and the **Flutter 3.41+ Impeller Engine** to deliver a 120Hz glassmorphic experience.

## 🏗️ The Stitch Workflow

Every component in this repository follows the **Stitch Pattern**:

1. **Refractive UI**: All views are built using `LiquidGlassContainer`.
2. **Modular Aggregation**: Messages are "stitched" into summaries via `StitchAggregator`.
3. **Crystallized Security**: Private data is stored in the `LiquidVault`.

---

## 🚀 Getting Started

### 1. Prerequisites

* **Flutter SDK**: `^3.24.0` or higher (Required for Impeller Shaders).
* **Hardware**: iOS (Metal) or Android (Vulkan) compatible device for 120Hz rendering.
* **Assets**: Ensure `Inter-Bold.ttf`, `Inter-Medium.ttf`, and `Inter-Regular.ttf` are in `assets/fonts/`.

### 2. Installation

```bash
# Clone the repository
git clone [https://github.com/adrian/messages-liquid.git](https://github.com/adrian/messages-liquid.git)

# Install 'Stitched' dependencies
flutter pub get

# Pre-warm the Liquid Shaders
flutter run --release --enable-impeller
