# CROWN DEFENDER — Step-by-Step Implementation Plan

## Overall approach

Ship one **compilable vertical slice at a time** and commit small stable states. Do not jump to full boss/fx before Crown input and real watch performance prove feasible. Public repository already exists at https://github.com/hero1356-kor/crown-defender. **Do not create a new repo, delete current commits, force-push or change visibility**.

## M0: toolchain + input spike

**Read-only inspection first**
1. Run sw_vers, uname -m, xcodebuild -version, xcode-select -p, xcrun simctl list devices available, git --version, and gh auth status without printing secrets.
2. Inspect installed Xcode watchOS SDK, simulators, connected paired Apple Watch and signing options.
3. Clone or safely reuse the existing repository. Confirm origin is hero1356-kor/crown-defender, main base, no unrelated local changes.
4. Write docs/ENVIRONMENT_REPORT.md with exact versions and unresolved dependencies.

**Code**
5. Create real Xcode watchOS SwiftUI app target. No iPhone companion required for v0.1.
6. Present SpriteKit SKScene with center turret, transparent arena ticks.
7. Capture Crown rotation with focus management, map signed deltas to angle wrapping, show numerical debug angle only in debug builds.
8. Add a minimal second screen with rotate-to-highlight / 1s dwell-to-confirm, requiring deliberate motion.

**Gate**: actual watch Simulator xcodebuild exit 0; Crown responds through full 360° without teleport at wrap; no accidental selection on transition. Commit: feat: crown aim and menu input spike. If SDK unavailable, stop claiming build success and document blocker.

## M1: playable shooting slice

1. Add GameEngine with seeded random and deterministic fixed-tick update.
2. Spawn Drone at ring, approach core, auto-fire bullet at fixed 0.40s.
3. Implement swept collision, enemy death/despawn, core HP 5, score and game-over.
4. Render with pooled SKNodes and clear HUD. Add unit tests.
5. Test Crown while projectiles spawn and hit. Confirm no tap is required.

**Gate**: short playable round completed with Crown only, no duplicate hit or projectile tunneling. Commit: feat: playable single-wave combat.

## M2: full run skeleton

1. Define 4 timed wave budgets + 3 enemy types.
2. Add between-wave upgrade card chooser (3 distinct eligible options, Crown selection/dwell).
3. Implement eight upgrades with stacking caps.
4. Implement MAIN_MENU, WAVE, UPGRADE, RESULTS, RETRY flows.
5. Add local settings and result persistence with schema version.
6. Add scenePhase handling and paused/resume flow. Test background/resume.

**Gate**: deterministic unit tests and full run to pre-boss result with Crown-only input; no idle-confirm. Commit: feat: roguelite run and upgrades.

## M3: boss and original art

1. Implement Warden Phase 1 and 2 with always-shootable charged-orb counterplay.
2. Make boss attacks legible >=800ms before danger.
3. Replace basic primitives with original asset drawings and clean animations.
4. Add capped event haptics and reduced-effects mode.
5. Generate **actual app screenshots** separately from concept art.
6. Add boss loop tests and score/save tests.

**Gate**: victory and defeat both reachable; no guaranteed unavoidable boss hit. Commit: feat: Warden boss and presentation.

## M4: physical Apple Watch QA + release preparation

1. Confirm actual SE2 model/watchOS rather than assuming.
2. Pair or detect Watch through Xcode; follow Apple signing requirements, no credentials in logs.
3. Install on user's physical watch with explicit user-mediated device trust.
4. Test Crown sensitivity, transition focus, wrist-down/interruptions, 40/44 mm layout, three consecutive runs, warmth/battery.
5. Record measured frame times and tune particle/bullet caps to stable >=30 fps target.
6. Review accessibility, licensing, icon, screenshots and README.

**Gate**: evidence-backed install + measured playtest only after actual tests. Commit: test: SE2 verification and tuning.

## Git / PR guidance

- Work from clean main and feature branches (m0-crown, m1-combat, m2-run, m3-boss, m4-device); use PRs if appropriate.
- Each milestone should include implementation, test evidence and a short docs/TEST_RESULTS.md update.
- No force-push main or blanket destructive cleanup. Never touch user's Alpha Council, Samsung Server, SSH configs.
- Keep all game mechanics/config deterministic and unit tested; avoid large one-shot commits.

## Agent stop conditions

Stop before changing repository privacy, installing privileged/untrusted tooling, exposing credentials, or modifying unrelated user projects. If a build is blocked, leave a verifiable local working state, write the blocker exactly, and continue with bounded work without misreporting success.

## Deliverable report template

1. Current repository URL, branch, commit SHA, visibility
2. Local Xcode project path and actual schemes
3. Machine/Xcode/watchOS versions and devices
4. Features really built, explicitly separate mocked vs implemented
5. Build/test exact command, exit code, console summary
6. Screenshots + log locations; simulator vs real watch clearly labeled
7. Risks, first three next tasks
