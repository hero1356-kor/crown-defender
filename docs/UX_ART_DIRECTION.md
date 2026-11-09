# CROWN DEFENDER — UX / Visual Art Direction v0.1

## 1. Art identity

**Minimal arcade pixel art rather than ornamental sci-fi UI.** The watch screen is nearly-black with one thin radar circle, a cyan turret, coral enemies, yellow bullets and a compact high-contrast HUD. Avoid gradients, scanlines, decorative HUD panels, excessive particles, metallic textures, and tiny type inside the actual watch screen.

The concept SVG is original vector reference, **not** a playable screenshot, shipped spritesheet, purchased design or precise 40 mm layout guarantee: [watch concept](../assets/concept/crown-defender-watch-concept.svg).

## 2. Color and style tokens

| Token | Hex | Role |
|---|---|---|
| night | #0B0F14 | Watch gameplay background |
| panel | #263238 | Cards / noncritical border |
| radar | #354B56 | Single thin arena ring |
| friendly | #4DD0E1 | Turret and player feedback |
| enemy | #FF5252 | Enemy shapes and warnings |
| boss | #FF5252 | Boss accents |
| amber | #FFD54A | Bullets, coins and focused card |
| text | #FFFFFF | Primary text |
| muted | #8BA1AD | Secondary data |

No illegible microtext, heavy bloom, derivative Nintendo-like sprites or third-party logos. Favor vector-first geometry until original pixel sprites are ready.

## 3. Screens: exact content and interaction

### Home
- Show icon/small animated turret, title, PLAY, HOW TO PLAY, SETTINGS.
- First Crown step actively moves focus; a 1-second dwell confirms. No auto-launch on idle.
- Maintain visible focus ring and countdown, small concise guidance: TURN / WAIT.
- Avoid more than 3 choices per page if text wraps on 40 mm.

### Tutorial
- 3 concise cards: (1) Rotate Crown -> aim; (2) Gun auto-fires; (3) Stop charging projectiles before reactor contact.
- Rotate Crown cycles card; dwell to advance. Teach using a safe target to observe aim.
- Can be skipped with the same Crown-only menu pattern after first play.

### Combat
- Radar arena central fixed turret, circle rings, radial enemy approach.
- HUD top: 5 small HP pips (or clear hearts), WAVE number, optional minimal score.
- Dynamic aim barrel is most legible saturated cyan feature.
- Fired projectiles bright amber; enemies coral with different silhouettes. Score appears briefly near kills, capped.
- Bottom edge minimal temporary toast for upgrade effects; do not obscure threats.
- Viewport target 40 mm and 44 mm with independent screenshot review. Prefer HUD overlaid but leave upper battle safe margins.
- Warn of imminent threats by outline pulse / shape plus hue, avoid flashing.

### Upgrade
- Because three wide cards would be tiny on 40 mm, display one **large focused card** with narrow left/right neighbors or stack with vertical scrolling.
- Three choices are shown, crown turns index, selected card shows effect and name, 1s dwell ring progresses.
- First 200ms after entering screen disarms input and syncs reference rotation. Require a meaningful subsequent turn.
- Clear start-of-dwell state after inactivity/focus loss.

### Boss
- Preserve battle layout; boss HP bar occupies one consistent strip.
- Attack charge corridor/sector is visible for >=0.8s and ends in a **shootable orb** (cannot dodge when center turret cannot move). Guide player to aim at orb.
- Phase 2 differences visible by silhouette/animation and audio optional; mute safe.
- Victory should be communicated with clear color + text and short haptic, not a full-screen strobe.

### Results
- VICTORY or DEFEAT, score, best score, time, waves, upgrades, RETRY / MENU.
- Crown rotates focus; dwell executes once. Full interaction possible without touchscreen.

### Settings
- Crown sensitivity presets: Low / Standard / High.
- Invert direction on/off, haptics on/off, reduce effects on/off.
- Crown-selectable navigation and action confirmation; for complex settings simplify into pages.

## 4. Interaction feedback timing

| Event | Target effect | Duration |
|---|---|---|
| Aim rotation | Barrel updates within one render frame | immediate |
| Fire | Small muzzle flash, bullet appears | 60–90ms |
| Enemy kill | Tiny fragments fade | 120–180ms |
| Reactor hit | Short coral perimeter ripple + one haptic | 150ms |
| Upgrade focus | 2px amber ring, slight size change | live |
| Upgrade confirm | Confirmation pulse, one haptic | ~150ms |
| Boss charge | Warning geometry + moving charge orb | >=800ms before dangerous state |
| Win/lose | Brief icon + transition | <1.5s |

Never vibrate for every bullet. Do not present impossible-to-dodge attack without shootable/interruptible counterplay.

## 5. Asset production

M0/M1 can use primitives. Later, original 16x16 / 24x24 / 32x32 transparent sprites:
- turret: 8-way barrel preview but runtime may rotate continuously; recoil + muzzle states.
- drone: simple angular diamond; spinner: toothed circle; sprinter: sharp triangle.
- projectiles: amber circular bead with restrained trail.
- boss Warden: symmetric mechanical arms, amber interruptible core, charcoal shield plates.
- no copyrighted characters/music, no sprites ripped from existing watch games.
- asset scale: nearest-neighbor only for intentionally pixelated art; test watch resolution.

## 6. Performance and accessibility acceptance

- In 2 seconds from screenshot, unfamiliar observer can locate turret, aim, nearest danger, HP.
- Colorblind distinction via shape and outline, not hue alone.
- Safe rounded corners; no essential controls under system time/header or Crown clipping.
- WatchOS reduce motion honored where available. Default no rapid flashes.
- 40mm and 44mm simulator screenshots plus one real-device screenshot required for final signoff.

## 7. Minimalism revision (2026-11-09)

The repository concept SVG has been **updated** to a simpler four-screen visual. It is the canonical current design reference. Key rules: just one radar ring plus four cardinal ticks; 5–6 colors including background; enemy icons as small high-contrast red shapes; clear top HP/WAVE, no detailed décor; upgrade screen uses three large stacked entries with only one yellow selected border; results screen uses single primary retry action but must remain Crown-only. Prefer 40 mm readability over pixel fidelity and polish. The external earlier elaborate concept board is superseded.
