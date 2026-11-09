# GROK START HERE — Crown Defender project execution brief

**User goal:** Build an **original**, high-quality, stand-alone Apple Watch arcade roguelite named Crown Defender. The user has a MacBook Neo, iPhone 15, and an Apple Watch believed to be SE 2. They want a real app installed on their watch, NOT another design-only proposal.

**Existing GitHub remote (already created, PUBLIC as of initial review):** https://github.com/hero1356-kor/crown-defender.git

**Must not do:** Do not create another repository, force-push main, change repository visibility, delete unrelated data, access Alpha Council or Samsung server, require Apple Watch side button/Crown press for gameplay, hardcode credentials, assume watch model, or report unexecuted builds as passing.

## Step 0 — READ SPEC BEFORE WRITING CODE

Read these repository files entirely in this order:
1. README.md
2. docs/GAME_DESIGN.md
3. docs/TECHNICAL_DESIGN.md
4. docs/UX_ART_DIRECTION.md
5. docs/IMPLEMENTATION_PLAN.md
6. docs/QA_ACCEPTANCE.md
7. assets/concept/crown-defender-watch-concept.svg (concept mockup only)

If you see a contradiction, prioritize platform feasibility, no-touch gameplay, actual observed build results and user's stated Apple Watch SE 2 target. Write a short design-decision log in docs/DECISIONS.md.

## Step 1 — MacBook Neo environment audit

Inspect without modifying existing settings:
- sw_vers; uname -m
- xcode-select -p; xcodebuild -version; xcodebuild -showsdks
- xcrun simctl list devices available
- git --version; gh auth status (DO NOT paste token or emails)
- actual available watchOS Simulators and paired watch state
- local available disk space if needed for Xcode install.

Check whether Xcode installed on this Mac actually provides watchOS SDK and can build a stand-alone watch app. Check current real Watch model/watchOS in Xcode/Watch app if accessible. SE 2 is **a guess**, not verified. If software is missing, present the exact official install action needed; do not claim the watch can already run the app.

Write docs/ENVIRONMENT_REPORT.md with precise commands and results.

## Step 2 — Checkout this exact GitHub repository

Use existing repository, not a new project:
- git clone https://github.com/hero1356-kor/crown-defender.git (or SSH remote if authenticated).
- If directory already exists, inspect its git status, branch and origin. Never delete uncommitted user work.
- Do not run git init, gh repo create, or a destructive reset.
- Work on a feature branch, commit small working checkpoints, and push with normal auth.
- If GitHub auth unavailable, work locally and report remote push as pending; don't request passwords/tokens.

## Step 3 — Build the real watchOS application, milestone by milestone

### M0 (do this first)
- Generate Xcode SwiftUI watchOS app target with SpriteKit render view and correct asset handling.
- Center turret rotates to Digital Crown input; visual bearing indicator and arena rings.
- Solve Crown focus for this exact watchOS SDK. Use .focusable / .digitalCrownRotation supported overload and explicit focus control; test carefully on screen transitions. WKCrownSequencer is alternative if needed.
- Menu has 3 options; rotate steps to focus; settle for ~1.0 seconds to confirm. On entry it is disarmed and will not accidentally confirm until the player has intentionally rotated.
- No mandatory touchscreen, side button, Crown button or remote service.
- Add tests for angle wrapping and menu focus/dwell.
- Build actual watch simulator via xcodebuild; record exact scheme, destination, exit code.
- Make a small commit. If this milestone fails due toolchain, document blocker, do not fake pass.

### M1
- Deterministic GameEngine separate from SKScene.
- Drone spawn at outer ring, radial approach, automatic fire every .40 seconds.
- Correct swept bullet collision, 5 reactor HP, hits, kills, score, game-over; a one-wave playable vertical slice.
- Frame delta caps and scenePhase pause; zero catch-up after inactive.
- Tests for damage, no double hit, seeded reproducibility.
- Build/test/commit.

### M2
- Waves 1–4, 3 enemy types, 3 between-wave upgrade selections.
- Eight upgrade types with caps and eligibility; rotate to select and dwell to confirm.
- Core state navigation and retry, local save.
- Maintain an end-to-end **Crown-only** run from menu to results.
- Build/test/commit.

### M3
- Add Warden boss with 2 phases. **Important design correction**: the turret does NOT move; attacks must be countered by shooting charged orbs or interrupting weakpoint, NOT by dodging movement.
- Boss warnings >=800ms; actual original sprites; sparse haptics; reduced effects.
- Build/test/commit and capture actual screenshot separately from concept art.

### M4
- Confirm actual Watch model and watchOS; install on user's paired watch with normal Apple signing/trust flow.
- Verify Crown focus, 40mm/44mm layout, gameplay 3 runs, interruptions and measured sustained FPS (target >=30, 60 only if benchmarked).
- Record real watch vs simulator distinctly. Commit QA results.

Detailed acceptance criteria: docs/QA_ACCEPTANCE.md. Exact game numbers and enemy designs: docs/GAME_DESIGN.md. Use docs/IMPLEMENTATION_PLAN.md for sequencing.

## Visual direction

Artwork available at assets/concept/crown-defender-watch-concept.svg is an **original concept reference, NOT SpriteKit runtime art**. Recreate clean turret/enemies/projectiles with simple SKShapeNodes then original transparent sprites. Maintain palette:
- Background #0B1520
- Turret #5FE0D2
- Enemies #FA715B
- Shots/selected highlight #F3B55B
- Primary type #EBF2EE

Use concise SF font for actual 40mm interface. No imitation/copying of other game sprites, sound/music or trademarks.

## Required verification/reporting style

Do not claim game installed or build succeeded unless a real command was run. At each milestone write:
1. GitHub branch and exact commit
2. Xcode/project path; Xcode/watchOS SDK and scheme
3. Implemented vs not implemented
4. Build and test commands with exit code
5. Simulator and physical Watch results **separately**
6. Screenshots and performance metrics, where actually measured
7. Blocking issue and next 3 steps

Run meaningful code and builds, not only planning. If unable to finish, leave latest known-compiling commit and a precise TODO. Do not modify unrelated repos or Apple system security configuration to bypass restrictions.
