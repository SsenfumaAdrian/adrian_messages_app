# Design System Documentation: Adrian Messages

## 1. Overview & Creative North Star: "The Intelligent Correspondent"
This design system moves away from the transactional nature of "chat apps" and pivots toward the sophisticated ethos of **Adrian Messages**. Our Creative North Star is **"The Intelligent Correspondent."** 

We are building a digital concierge experience that feels like a high-end editorial publication—authoritative yet breathable. We break the "template" look by rejecting rigid grids and boxy containers. Instead, we utilize intentional white space, asymmetric type treatments, and tonal depth to create a sense of bespoke service. Every interaction in Adrian Messages should feel like a curated response, not a programmed output.

---

## 2. Colors: Tonal Architecture
The palette is anchored by the deep, authoritative `#1A237E` (Primary Container), balanced against a pristine, expansive light mode.

### The "No-Line" Rule
**Strict Mandate:** Designers are prohibited from using 1px solid borders for sectioning. Structural boundaries must be defined solely through background color shifts.
- To separate a sidebar from a feed, transition from `surface` (#fbf8ff) to `surface-container-low` (#f5f2fb).
- High-priority interaction zones should sit on `surface-container-high` (#eae7ef) to naturally draw the eye without the "caged" feeling of a stroke.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers. We use "Tonal Nesting" to define importance:
1.  **Base Layer:** `surface` (#fbf8ff) - The canvas.
2.  **Secondary Zones:** `surface-container-low` (#f5f2fb) - Subtle differentiation for utility areas.
3.  **Actionable Content:** `surface-container-lowest` (#ffffff) - Cards or message bubbles that "pop" forward against the off-white base.

### The "Glass & Gradient" Rule
To elevate Adrian Messages beyond standard UI, use **Glassmorphism** for floating headers or action bars. 
- **Token:** `surface` at 80% opacity with a `20px` backdrop-blur.
- **Signature Textures:** Apply a subtle linear gradient from `primary` (#000666) to `primary_container` (#1a237e) for Hero CTAs to provide a velvet-like depth that flat hex codes cannot replicate.

---

## 3. Typography: The Manrope Editorial
We use **Manrope** exclusively. Its geometric yet humanist qualities provide the "Digital Concierge" feel—modern but approachable.

*   **Display (lg/md/sm):** Used for "Welcome" states and major brand moments. Use `display-lg` (3.5rem) with tight letter-spacing (-0.02em) to create an editorial impact.
*   **Headline (lg/md/sm):** Reserved for section titles. `headline-sm` (1.5rem) should be used with generous top-padding to allow the content to breathe.
*   **Title (lg/md/sm):** Used for message headers and card titles. Use `title-md` (1.125rem) in `on_surface` (#1b1b21).
*   **Body (lg/md/sm):** The workhorse for messages. `body-lg` (1rem) is the default for chat bubbles to ensure premium legibility.
*   **Label (md/sm):** Used for timestamps and metadata. Use `label-sm` in `on_surface_variant` (#454652).

---

## 4. Elevation & Depth: Atmospheric Layering
Hierarchy in Adrian Messages is achieved through **Tonal Layering**, not structural lines.

*   **The Layering Principle:** Place a `surface-container-lowest` card on a `surface-container-low` section. This creates a soft, natural lift that mimics fine paper resting on a desk.
*   **Ambient Shadows:** For floating elements (like a "New Message" FAB), use an extra-diffused shadow: `box-shadow: 0 12px 32px rgba(26, 35, 126, 0.06);`. The shadow is tinted with our primary blue to feel like natural ambient light.
*   **The "Ghost Border" Fallback:** If a boundary is strictly required for accessibility, use the `outline_variant` (#c6c5d4) at **15% opacity**. Never use a 100% opaque border.

---

## 5. Components: The Concierge Toolkit

### Buttons
*   **Primary:** Gradient fill (`primary` to `primary_container`), `xl` roundedness (1.5rem), and `title-sm` typography.
*   **Secondary:** No fill. `surface-container-high` background on hover. Use `primary` color for text.
*   **Tertiary:** Text-only with a `2px` underline in `surface_tint` (#4c56af) to evoke a handwritten note.

### Message Bubbles (Cards & Lists)
*   **Incoming:** `surface-container-highest` (#e4e1ea) with `lg` roundedness (1rem).
*   **Outgoing:** `primary_container` (#1a237e) with `on_primary` (#ffffff) text.
*   **Forbid Dividers:** Do not use lines between messages. Use a `spacing-3` (0.75rem) gap to separate thoughts.

### Input Fields
*   **Styling:** A single, expansive `surface-container-lowest` area. No border. Use a `4%` ambient shadow on focus.
*   **Label:** Use `label-md` floating above the field in `primary` to indicate active focus.

### Additional Signature Component: The "Concierge Pulse"
*   A small, animated gradient ring using `tertiary_fixed_dim` (#ffb59d) that appears next to "Adrian" when the system is generating a response, providing a warm, humanistic feedback loop.

---

## 6. Do's and Don'ts

### Do
*   **DO** use asymmetric padding (e.g., more padding on the left than the right in headers) to create a high-end editorial feel.
*   **DO** use `tertiary` (#380b00) sparingly for "Warning" or "Urgent" concierge alerts to provide a sophisticated alternative to "Error Red."
*   **DO** lean into the `spacing-12` (3rem) and `spacing-16` (4rem) values for top-of-page margins to ensure the app feels premium.

### Don't
*   **DON'T** use 100% black. All "dark" text must use `on_surface` (#1b1b21).
*   **DON'T** use "Standard" 4px corner radii. Stick to the Roundedness Scale (`md` 0.75rem or `lg` 1rem) to maintain the soft, approachable concierge aesthetic.
*   **DON'T** use horizontal rules (`<hr>`). Separate content sections with a `surface-container` background shift.

---
**Director's Note:** Adrian Messages is not a tool; it is a service. Every pixel should reflect the care of a personal assistant. If the layout feels crowded, add more `surface`. If it feels "default," check your border-radius and remove your lines.