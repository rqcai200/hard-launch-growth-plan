---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, polished code that avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

The user provides frontend requirements: a component, page, application, or interface to build. They may include context about the purpose, audience, or technical constraints.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial and Inter; opt instead for distinctive choices that elevate the frontend's aesthetics; unexpected, characterful font choices. Pair a distinctive display font with a refined body font.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes.
- **Motion**: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density.
- **Backgrounds & Visual Details**: Create atmosphere and depth rather than defaulting to solid colors. Add contextual effects and textures that match the overall aesthetic. Apply creative forms like gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays.

NEVER use generic AI-generated aesthetics like overused font families (Inter, Roboto, Arial, system fonts), cliched color schemes (particularly purple gradients on white backgrounds), predictable layouts and component patterns, and cookie-cutter design that lacks context-specific character.

Interpret creatively and make unexpected choices that feel genuinely designed for the context. No design should be the same. Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices (Space Grotesk, for example) across generations.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

Remember: Claude is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.

## Maven Brand System

When building for Maven, always use the official brand assets below.

### Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Lapis-900 | `#080C28` | Primary text, dark backgrounds |
| Lapis-800 | `#101B57` | Secondary dark |
| Lapis-700 | `#1C368D` | Brand primary, buttons, accents |
| Lapis-600 | `#1C41AB` | Brand primary alt |
| Lapis-200 | `#71AEFF` | Brand secondary |
| Lapis-100 | `#B2D3FA` | Brand secondary light |
| Lapis-50 | `#DEEFFF` | Light background tint |
| Brand-highlight | `#CDFF92` | CTA buttons, highlights (lime green) |
| Brand-light | `#7CBEFF` | Light accent |
| Brand-medium | `#0E88FF` | Medium accent |

CSS variables:
```css
:root {
  --accent: #1C368D;
  --accent-light: #DEEFFF;
  --highlight: #CDFF92;
  --text: #080C28;
}
```

### Typography

- **Headlines**: Bureau Serif (STK Bureau Serif) — weights: Light (300), Book (400)
- **Body**: Bureau Sans (STK Bureau Sans) — weights: Book (400), Medium (500), SemiBold (600), plus italics
- Local woff2 files are in the `plans/` directory (e.g. `STKBureauSerif-Book.woff2`, `STKBureauSans-Medium.woff2`)

### Logos

- **Wordmark (SVG, dark theme)**: `https://cdn.brandfetch.io/idIp45c7Hp/theme/dark/logo.svg?c=1bxid64Mup7aczewSAYMX&t=1772482451686`
- **Wordmark (PNG, dark theme)**: `https://cdn.brandfetch.io/idIp45c7Hp/w/800/h/174/theme/dark/logo.png?c=1bxid64Mup7aczewSAYMX&t=1772482451686`
- **Icon (PNG)**: `https://cdn.brandfetch.io/idIp45c7Hp/w/1000/h/1000/theme/dark/icon.png?c=1bxid64Mup7aczewSAYMX&t=1772481898837`
