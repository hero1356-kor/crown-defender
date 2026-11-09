# CROWN DEFENDER — Technical Design v0.1

## 1. Environment and deployment validation

- Primary hardware: Apple Watch SE 2 (claimed approximately, model and watchOS not yet verified), 40 mm/44 mm.
- Paired phone: iPhone 15. Dev machine: MacBook Neo.
- Build a **standalone native watchOS app** using SwiftUI app lifecycle and SpriteKit scene rendering.
- Do not hardcode watchOS deployment until installed Xcode/watchOS SDK and real watch compatibility are checked.
- Do not infer device testing from successful Simulator build.
- SpriteKit's watchOS support and the exact SpriteView behavior must be confirmed with the locally installed toolchain.

## 2. Suggested directory / module architecture

CrownDefenderWatchApp/
- App/CrownDefenderApp.swift — Watch App entry, scenePhase.
- UI/MainMenuView.swift — Crown-only menu with visible dwell.
- UI/UpgradeView.swift — 3 choices; discrete menu Crown input.
- UI/ResultsView.swift — retry / menu.
- UI/SettingsView.swift — sensitivity, inverted axis, haptic toggles.
- UI/GameContainerView.swift — SwiftUI shell hosting SpriteKit.
- Input/CrownInputCoordinator.swift — reads Crown changes; focus and relative delta.
- Engine/GameEngine.swift — pure model, state, damage, wave transitions.
- Engine/Entities.swift — Enemy, Projectile, Turret, Boss, Upgrade.
- Engine/Collision.swift — swept or segment collision for fast bullets.
- Engine/WaveDirector.swift — seeded wave scheduler; spawn caps.
- Engine/UpgradeDeck.swift — eligible upgrade selection; stacking.
- Engine/SeededRNG.swift — deterministic PRNG wrapper.
- Engine/GameConfig.swift — all tunables defined centrally.
- Rendering/CombatScene.swift — render model into SKNodes, no business rules.
- Persistence/LocalSaveStore.swift — best runs, preferences, version.
- Assets.xcassets/ — original runtime sprites (later).
CrownDefenderTests/ — pure-engine XCTest cases.

Use naming close to the above, but do not create every file as an empty placeholder. Prioritize compilable vertical slices.

## 3. Digital Crown capture and mapping

### SwiftUI path

Use focusable view and digitalCrownRotation binding. Capture **delta = currentBindingValue - lastBindingValue**, rather than treating the absolute value as perpetual direction, and feed the delta into an InputCoordinator.

- Configure a continuous, unbounded sensitivity suitable for aim input, if the supported overload permits it.
- Assign focus deliberately (e.g. @FocusState or watchOS focus APIs) on gameplay entry; confirm in Simulator and on device.
- Reset the reference reading when focus changes or scene state transitions. Avoid a 0->new-value jump interpreted as movement.
- Bearing change = delta * sensitivity in radians; wrap to [0, 2π).
- Keep Crown rotation domain independent from SpriteKit state updates.
- If the SwiftUI crown binding overload behaves poorly in SpriteKit host, document and prototype WKCrownSequencer/WKCrownDelegate as a **fallback**, not an assumed fix.
- **Never** depend on side button or Crown press as game input: those are system interactions.

### Discrete menus

Define MenuCrownSelector with step accumulator, selected index, lastMotionTime, armed flag, dwellProgress, and consumed flag.

1. Enter menu -> disarmed; clear pending delta and countdown.
2. First deliberate Crown rotation crossing threshold selects an item and arms dwell.
3. Further rotation steps wrap index and cancel/restart countdown.
4. After 1.0 seconds of motionless, armed state -> confirm exactly once.
5. Ignore delayed Crown input during transition.
6. When returning from inactive lifecycle -> disarm and require fresh motion.

**Important:** do not start dwell countdown automatically when a menu first appears. Idle-after-pause must never accidentally start/confirm upgrades.

## 4. Simulation and rendering contract

- GameEngine uses explicit GameState enum: mainMenu, tutorial, wave(index), upgrade(index), boss, results, paused.
- Fixed tick simulation at 60 Hz; rendering can use target 30/60 FPS as observed. dt accumulator uses clamp and catch-up limit, no huge return-from-background ticks.
- A small command/event queue transports Crown delta and menu choices into GameEngine.
- GameEngine is independent from SpriteKit so deterministic unit tests can replay the same input/seed.
- SpriteKit nodes use stable IDs and pooling for bullets/enemies; avoid rebuild-every-frame SKShapeNodes.
- Render positions in normalized units using available content safe bounds. All per-frame effects are optional/capped.
- Stable sorted entity collision ordering avoids nondeterministic ties. Fast bullets use swept segment-circle collision, not only endpoint overlap.
- Use score/hp mutation only once for each collision or despawn event.
- Never access Keychain, network, disk, or UserDefaults inside per-frame update.

## 5. Scene lifecycle and persistence

- On scenePhase inactive/background: pause spawn, physics, bullets, timers, dwell, countdown and animations that affect decisions.
- On return: clear accumulated dt, restore focus safely, show deliberate RESUME/LEAVE menu.
- On memory pressure, retain only necessary state, reduce node count and particles.
- Save simple preferences/best score only at state transitions via Codable / UserDefaults or atomic file write.
- Save schema has version and sane defaults; corrupted store should not crash launch.
- Offline by default, zero analytics, no server traffic, no microphone/camera/location access.

## 6. Watch UI and accessibility

- Layout in normalized logical coordinates, respecting 40 mm/44 mm viewport and rounded safe bounds.
- Color and silhouette must both communicate state. Critical warning uses warning geometry in addition to coral color.
- Crown menu highlight 2+ visible px and clear confirmation timer.
- Respect reduce motion if possible; avoid screen flash and excessive haptic pulses. Haptic only when core gets hit, weapon upgrades, boss defeat.
- Real physical crown direction can feel inverted depending on wrist orientation. Offer invert-direction setting.
- Do not render dense HUD with unreadable tiny type.

## 7. Performance and battery

- First goal: reliable >30 FPS under representative Wave 4 and boss load on SE 2 after measurement.
- Aim for 60 FPS only if thermals/power permit on actual hardware. Record frame-time percentiles and longest frames, not merely average.
- Max 12 regular enemies + bounded active projectiles; cap add-ons and visual effects.
- Prefer atlas reuse, pooling, small textures and few draw calls.
- Test 3 consecutive runs for dropped frames, watch temperature behavior and responsiveness.
- Avoid background execution promises; the game pauses when not active.

## 8. Testing requirements / commands

- Read available Xcode schemes/destinations before forming exact command.
- Example skeleton (replace scheme/destination with queried values): xcodebuild -project CrownDefender.xcodeproj -scheme <actual scheme> -destination <actual watch simulator> build
- Unit tests: angle wrapping, wrap boundaries, Crown focus reset, menu dwell once-only, seeded spawn schedule, bullet collision, HP lockout, eligible upgrade cards, boss counterplay, resume no catch-up.
- Record actual command, exit code, toolchain, Watch Simulator device, screenshot and logs in docs/TEST_RESULTS.md. Do not claim test success from source inspection.

## 9. Risk register

| Risk | Severity | Mitigation |
|---|---|---|
| Crown focus lost on transition | Critical | automated focus state guard + physical QA |
| Menu starts itself while idle | Critical | disarm until meaningful user rotation |
| Side button unavailable as game input | Critical | Crown-only architecture |
| Boss attack requires impossible dodge | Critical | shootable charge-orb counterplay |
| Return from inactive causes instant death | Critical | simulation clock reset and paused overlay |
| Hit detection tunneling | High | swept collision |
| Unreadable 40 mm UI | High | normalized layout, real screenshots |
| 60 FPS unrealistic on SE 2 | Medium | benchmark 30 FPS floor and adapt |
| Many haptics drain battery | Medium | event-level haptic policy |
