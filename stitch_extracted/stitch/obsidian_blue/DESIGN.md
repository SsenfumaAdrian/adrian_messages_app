# Design System Strategy: The Intangible Layer

## 1. Overview & Creative North Star: "The Digital Concierge"
This design system moves away from the "chat bubble" cliché. Instead, it adopts the North Star of **"The Digital Concierge"**—an interface that feels like a quiet, high-end editorial publication rather than a cluttered utility. 

We break the "template" look by rejecting the rigid, boxed-in grids typical of messaging apps. Instead, we use **intentional asymmetry**, generous white space, and **tonal depth**. By layering surfaces rather than drawing lines, the UI feels organic and expansive. The goal is "High-End Functionalism": every element must earn its place, and every transition must feel like a deliberate movement through a physical space.

---

## 2. Colors & Surface Philosophy
The palette centers on sophisticated deep blues (`primary: #0e1c2b`) and refined neutrals. 

### The "No-Line" Rule
Standard 1px borders are strictly prohibited for sectioning. To define boundaries, designers must use **background color shifts**. For example, a chat input area should not have a border; it should be a `surface-container-low` element sitting on a `surface` background. This creates a soft, modern distinction that feels "baked into" the UI.

### Surface Hierarchy & Nesting
Think of the UI as a series of stacked materials. 
- **Base Layer:** `surface` (#f8f9fa)
- **Content Cards:** `surface-container-lowest` (#ffffff) for maximum "pop" and clarity.
- **Secondary Actions/Sidebars:** `surface-container` (#edeeef) to provide a recessive visual weight.

### The "Glass & Gradient" Rule
To elevate the experience, floating elements (like top navigation bars or "New Message" FABs) should utilize **Glassmorphism**.
- **Token Use:** Apply `surface` at 80% opacity with a `20px` backdrop-blur. 
- **Signature Textures:** For primary CTAs, do not use flat colors. Use a subtle linear gradient from `primary` (#0e1c2b) to `primary-container` (#233141) at a 135° angle to add "soul" and a sense of premium material.

---

### 3. Typography: Editorial Authority
We utilize a dual-font strategy to balance character with utility.

*   **Display & Headlines (Manrope):** Used for "moment" headers and user names. The wide apertures of Manrope provide a modern, welcoming feel. 
    *   *Example:* `headline-md` (1.75rem) for the "Messages" main header.
*   **Body & Labels (Inter):** Used for the actual conversation. Inter’s tall x-height ensures maximum legibility even in rapid-fire text exchanges.
    *   *Hierarchy Tip:* Use `title-sm` (Inter, 1rem) for message text to give it an "airy" feel, reserving `body-sm` (0.75rem) for timestamps and metadata.

---

## 4. Elevation & Depth: Tonal Layering
Traditional drop shadows are too heavy for this aesthetic. We achieve hierarchy through **Tonal Layering**.

*   **The Layering Principle:** Place a `surface-container-lowest` message bubble on a `surface-container-low` background. The subtle 1-2% shift in brightness provides all the separation needed without visual noise.
*   **Ambient Shadows:** For high-priority floating elements (like a profile modal), use a shadow tinted with the `on-surface` color:
    *   `box-shadow: 0 12px 32px rgba(25, 28, 29, 0.04);`
*   **The "Ghost Border" Fallback:** If accessibility requires a stroke (e.g., in high-glare environments), use `outline-variant` (#c6c5d4) at **15% opacity**. It should be felt, not seen.
*   **Glassmorphism:** Apply to the "active" message thread header. As users scroll, the message content should blur softly behind the header, maintaining a sense of spatial awareness.

---

## 5. Components: Refined Primitives

### Buttons
- **Primary:** Gradient (`primary` to `primary-container`), `xl` (1.5rem) corner radius. No border.
- **Secondary:** `surface-container-high` background with `primary` text.
- **Tertiary:** Transparent background, `primary` text, with a `surface-variant` hover state.

### Message Bubbles (The Signature Component)
- **Sender:** `primary` background, `on-primary` text. Corners: `md` (0.75rem) on all sides except the bottom-right which is `sm` (0.25rem).
- **Receiver:** `surface-container-highest` background, `on-surface` text. Corners: `md` except bottom-left which is `sm`.
- **Spacing:** Use `spacing-4` (1rem) for message groupings and `spacing-1` (0.25rem) for individual bubbles within a group.

### Input Fields
- **Styling:** Never use a box. Use a `surface-container-low` pill-shaped (`full` roundedness) container.
- **States:** On focus, transition the background to `surface-container-lowest` and apply a `px` "Ghost Border" at 20% opacity.

### Navigation Bar
- **The "Floating Dock":** Instead of a pinned bottom bar, use a floating dock style centered at the bottom. Use `surface` with glassmorphism and an `xl` corner radius. This breaks the edge of the screen and feels more like a modern OS.

---

## 6. Do’s and Don’ts

### Do:
- **Do** use `tertiary_fixed_dim` (#00daf3) for "Online" status indicators; its vibrancy against the deep blue primary creates a premium "glow."
- **Do** lean into `spacing-10` (2.5rem) for top-level page margins to create an editorial, airy feel.
- **Do** use `on-surface-variant` (#454652) for secondary text like "Typing..." or "Read 12:45 PM."

### Don’t:
- **Don’t** use dividers or horizontal rules. Use a `spacing-6` (1.5rem) gap or a change from `surface` to `surface-container-low` to separate sections.
- **Don’t** use pure black (#000000). Even in dark mode, the darkest shade should be a deep charcoal to maintain the "ink and paper" sophistication.
- **Don’t** use `DEFAULT` (0.5rem) corners for everything. Use `xl` for large containers and `md` for smaller ones to create a "nested" visual rhythm.