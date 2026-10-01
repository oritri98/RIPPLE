---
name: Mindful Journal & Task Manager
colors:
  surface: '#181210'
  surface-dim: '#181210'
  surface-bright: '#3f3835'
  surface-container-lowest: '#120d0b'
  surface-container-low: '#201a18'
  surface-container: '#251e1c'
  surface-container-high: '#2f2826'
  surface-container-highest: '#3b3331'
  on-surface: '#ede0dc'
  on-surface-variant: '#d4c4b5'
  inverse-surface: '#ede0dc'
  inverse-on-surface: '#362f2d'
  outline: '#9d8e81'
  outline-variant: '#50453a'
  surface-tint: '#f5bc7e'
  primary: '#fec486'
  on-primary: '#482900'
  primary-container: '#e0a96d'
  on-primary-container: '#633d09'
  inverse-primary: '#805521'
  secondary: '#ffb689'
  on-secondary: '#512300'
  secondary-container: '#71370a'
  on-secondary-container: '#f4a26d'
  tertiary: '#ffc395'
  on-tertiary: '#4d2600'
  tertiary-container: '#ff9c42'
  on-tertiary-container: '#6c3800'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffddbb'
  primary-fixed-dim: '#f5bc7e'
  on-primary-fixed: '#2b1700'
  on-primary-fixed-variant: '#653e0b'
  secondary-fixed: '#ffdbc8'
  secondary-fixed-dim: '#ffb689'
  on-secondary-fixed: '#321300'
  on-secondary-fixed-variant: '#71370a'
  tertiary-fixed: '#ffdcc3'
  tertiary-fixed-dim: '#ffb77d'
  on-tertiary-fixed: '#2f1500'
  on-tertiary-fixed-variant: '#6e3900'
  background: '#181210'
  on-background: '#ede0dc'
  surface-variant: '#3b3331'
typography:
  display-lg:
    fontFamily: Literata
    fontSize: 40px
    fontWeight: '500'
    lineHeight: 52px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Literata
    fontSize: 30px
    fontWeight: '500'
    lineHeight: 40px
    letterSpacing: -0.015em
  headline-lg:
    fontFamily: Literata
    fontSize: 32px
    fontWeight: '500'
    lineHeight: 42px
    letterSpacing: -0.015em
  headline-lg-mobile:
    fontFamily: Literata
    fontSize: 24px
    fontWeight: '500'
    lineHeight: 34px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Literata
    fontSize: 24px
    fontWeight: '400'
    lineHeight: 34px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Literata
    fontSize: 20px
    fontWeight: '500'
    lineHeight: 28px
    letterSpacing: 0em
  title-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: 0.005em
  body-lg:
    fontFamily: Literata
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 30px
    letterSpacing: 0.01em
  body-md:
    fontFamily: Literata
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 26px
    letterSpacing: 0.005em
  task-item:
    fontFamily: Plus Jakarta Sans
    fontSize: 15px
    fontWeight: '450'
    lineHeight: 22px
    letterSpacing: 0.005em
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '550'
    lineHeight: 18px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.04em
  caption:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
    letterSpacing: 0.01em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1.25rem
  gutter-desktop: 2rem
  margin: 1rem
  margin-desktop: 3rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2.5rem
---

## Brand & Style

This design system channels the quiet, sensory sanctuary of a leather-bound notebook beside an evening hearth. Conceived for thoughtful practitioners, writers, and professionals seeking intentional productivity, it reconciles contemplation with execution. The experience evokes calm restraint, timeless focus, and grounding warmth, removing cognitive stress and frantic urgency.

The aesthetic fuses **Tactile Ambient Luxury** with quiet **Editorial Minimalism**:
- Subtly layered, warm espresso surfaces that mimic thick, untreated paperboards and dyed burnished leather.
- Deliberate typography that establishes two cognitive modes: a meditative serif for contemplative thought and freeform journaling, paired with an exacting geometric sans-serif for pragmatic task execution, metadata, and schedules.
- Subtle inner glows and hairline warmth instead of stark synthetic drop shadows, creating the sensation of an intimate, physical desktop bathed in amber lamplight.

## Colors

The palette is rooted in roasted botanicals, aged paper, and glowing resin. Rather than defaulting to cold digital grays or pure pitch blacks, every tone carries organic brown-amber undertones to support eye comfort during long writing sessions.

### Surface Tiers
- **Canvas Base (`#1C1614`):** Deep espresso; ground zero for the application viewport.
- **Surface Low (`#261E1A`):** Roasted chestnut; applied to grouped task boards, sidebar containers, and subtle recessed cards.
- **Surface Mid (`#322823`):** Warm cacao; primary card background, popovers, and elevated modal panels.
- **Surface High (`#3E322C`):** Hover states, active inputs, and elevated floating sheets.

### Accent Roles
- **Primary Accent (`#E0A96D`):** Warm caramel glow. Used for primary CTAs, active cursor highlights, key journal focus states, and progress completions.
- **Secondary Accent (`#C27847`):** Burnished amber. Used for secondary toggles, category badges, and active state indicators.
- **Tertiary Accent (`#D97706`):** Vibrant spiced honey. Reserved for intentional highlights, reminder indicators, and streak markers.

### Text & Hairline Hierarchy
- **Parchment Primary (`#F3ECE7`):** Uncoated heavy cream; maximum legibility for titles and long-form journal paragraphs.
- **Linen Secondary (`#D1C5BD`):** Muted oatmeal; used for task items, subheadings, and secondary metadata.
- **Pewter Tertiary (`#9C8E85`):** Faded umber; used for timestamps, inactive placeholders, and helper text.
- **Warm Border Outline (`rgba(224, 169, 109, 0.12)`): Hairline border accent providing refined containment without clinical contrast.

## Typography

The typography intentionally splits cognitive domains between expression and structure:

- **Literata (Editorial Voice):** A literary serif chosen for reflection, deep journaling, and daily prompts. Its organic curves, subtle calligraphic origins, and generous x-height prevent reader fatigue and impart a tactile, bookish dignity.
- **Plus Jakarta Sans (Operational Voice):** A modern, warm geometric sans employed strictly for productivity layers: task item labels, checklists, micro-copy, timestamps, calendar grids, and navigation. It provides crisp clarity without cold clinical sterility.

### Compositional Principles
- Maintain comfortable journal line measures between 58 and 72 characters (`max-w-prose`) to preserve the feeling of a bespoke notebook page.
- Apply relaxed line heights to `body-lg` and `body-md` (1.6x to 1.7x font size) allowing reflective writing to breathe.
- All functional labels and tags in `label-sm` use subtle uppercase tracking (`letter-spacing: 0.04em`) to establish visual order above card components.

## Layout & Spacing

The layout is governed by a quiet, rhythmically centered grid architecture designed to prevent visual clutter and induce mental stillness.

### Grid Structure
- **Mobile (<768px):** Single-column layout with fluid breathing room. Margin is `1rem`, allowing edge cards to extend gracefully.
- **Tablet (768px–1199px):** An 8-column layout with `1.25rem` gutters. Journaling forms the dominant 5-column span, while task priorities occupy a supporting 3-column dock.
- **Desktop (1200px+):** A 12-column layout framed by `3rem` canvas margins. Daily reflection anchors a centered 7-column column (`max-width: 820px`), flanked by contextual schedule drawers and mindful habit trackers.

### Spacing Cadence
- Use `space-xs` and `space-sm` for compact internal alignments: checkbox-to-label spacing, badge padding, and icon metadata pairings.
- Use `space-md` for standard card interiors, list item vertical separations, and text input padding.
- Use `space-lg` and `space-xl` strictly between conceptual sections (e.g., separating "Morning Intention" from "Action Items").

## Elevation & Depth

This design system avoids harsh physical drops and cold volumetric shadows. Elevation is conveyed through warm tonal stratification paired with warm, low-opacity ambient back-radiance.

### Tonal Stratification
Depth is created by stepping upward through espresso shades:
1. **Basement (App Background):** `#1C1614`
2. **First Level (Resting Cards & Lists):** `#261E1A` with a delicate hairline stroke: `1px solid rgba(224, 169, 109, 0.08)`.
3. **Second Level (Hovered Containers & Focus Blocks):** `#322823` with `1px solid rgba(224, 169, 109, 0.16)`.
4. **Third Level (Modals, Overlays, and Date Pickers):** `#3E322C` with `1px solid rgba(224, 169, 109, 0.22)`.

### Ambient Luminescence
Where elevation separation is critical:
- **Resting Elements:** Flat tonal layer; zero shadow blur.
- **Floating Modals / Selected Journal Sheets:** A diffused warm amber occlusion shadow:
  `box-shadow: 0 16px 36px -8px rgba(12, 9, 8, 0.7), 0 0 1px 1px rgba(224, 169, 109, 0.12);`
- **Active Focus:** Interactive fields gain a subtle inner warmth rather than an aggressive outer neon halo:
  `box-shadow: inset 0 0 0 1px #E0A96D, 0 0 16px -2px rgba(224, 169, 109, 0.15);`

## Shapes

The form language is organic and tactile, referencing rounded notebook corners and smooth wooden instruments.

- **Base Radius (`0.5rem` / `8px`):** Applied to inputs, interactive chips, contextual pill tags, and list hover plates.
- **Container Radius (`rounded-lg`, `1rem` / `16px`):** Applied to standard journal cards, task boards, and daily prompt containers.
- **Feature Radius (`rounded-xl`, `1.5rem` / `24px`):** Applied to full-screen modals, bottom sheets, and the main distraction-free writing canvas.
- **Pill Radius (`9999px`):** Exclusively reserved for primary floating action buttons, state toggles, and habit completion streaks.

## Components

### Buttons
- **Primary:** Background in Caramel (`#E0A96D`), text in Espresso Base (`#1C1614`), font `Plus Jakarta Sans` medium. Rounded to `0.5rem` or full pill for FABs. On hover, background transitions gently to `#E8B882` with a subtle amber glow.
- **Secondary:** Surface Mid background (`#322823`) with a hairline border `rgba(224, 169, 109, 0.18)` and text in Parchment Primary (`#F3ECE7`). On hover, background lightens to `#3E322C`.
- **Ghost / Tertiary:** No background; text in Linen Secondary (`#D1C5BD`). Hover introduces `rgba(224, 169, 109, 0.08)` surface wash.

### Cards & Writing Containers
- Encased in Roasted Chestnut (`#261E1A`) with `1rem` corner rounding and `1px` stroke of `rgba(224, 169, 109, 0.08)`.
- Cards feature asymmetric internal padding: `space-lg` (`1.5rem`) on header and content zones to emphasize spacious, quiet journaling.
- When focused for editing, cards seamlessly shift to `#322823` with a refined accent stroke.

### Task Checklists & Interactive Radios
- **Checkboxes:** Rounded squares (`0.25rem` radius), border `1.5px solid #9C8E85`, background transparent.
- **Checked State:** Fill smoothly transitions to Amber Accent (`#C27847`), displaying a Parchment tick mark (`#F3ECE7`). Completed task text shifts from Linen Secondary (`#D1C5BD`) to muted Pewter (`#9C8E85`) with an elegant thin strike-through.

### Input Fields & Reflection Prompts
- Single-line and textarea components feature a recessed background (`#1C1614`) with a soft top border shadow `inset 0 2px 4px rgba(0, 0, 0, 0.25)` to evoke depth.
- Border is `1px solid rgba(209, 197, 189, 0.14)`. Placeholder text in faded Pewter (`#9C8E85`).
- Font family toggles dynamically: reflective journal prompts utilize `Literata`, while title inputs and quick tasks use `Plus Jakarta Sans`.

### Chips & Mindful Badges
- Filter tags and mood markers (e.g., "Gratitude", "Deep Work", "Evening Review") feature Surface High (`#3E322C`), `0.5rem` radius, and `label-sm` font.
- Selected chips receive a subtle Amber tint wash (`rgba(224, 169, 109, 0.15)`) with a warm caramel outline.

### Additional Mindful Components
- **Daily Mindful Meter:** A slim, warm caramel radial or horizontal capsule indicator displaying balanced daily completion without stressful percentage metrics.
- **Ambient Audio Pill:** A discreet docked component rendered in frosted `#261E1A` with a micro amber waveform indicating background soundscapes (e.g., rain, hearth, ambient library).