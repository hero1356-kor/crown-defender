# CROWN DEFENDER — QA and Definition of Done

## Evidence standard

A feature is **not complete** because it is described in docs or resembles concept art. Every completed checklist item needs reproducible source/test evidence. Do not claim real watch testing based on simulator or build only.

## M0 integration and input

- [ ] Xcode watchOS target compiles (record version, device destination, command, exit status).
- [ ] Crown binding receives clockwise and counterclockwise rotation with visible effect.
- [ ] Moving through >360° smoothly wraps aim with no snap.
- [ ] Entrance or return focus events produce zero artificial angle jump.
- [ ] A menu remains idle and cannot confirm without an intentional Crown step.
- [ ] During menu rotation, countdown cancels and restarts.
- [ ] Dwell executes exactly once after ~1.0s, no double transitions.
- [ ] No side-button / Crown-press requirement.

## Gameplay logic unit tests

- [ ] Angle wrap: -ε maps near 2π, 2π+ε maps near ε.
- [ ] Seeded RNG produces same spawns, wave result, upgrades under same simulation inputs.
- [ ] Fixed dt handles intermittent rendering and cannot jump on resume.
- [ ] A fast projectile intersects enemy even if it leaps past center within a tick.
- [ ] A shot hits only allowed number of targets, honoring piercing cap.
- [ ] One enemy reaching core causes at most one hit/damage, then despawns.
- [ ] Multiple coincident contact events respect invulnerability window.
- [ ] Enemy cap includes Carrier split children if Carrier included.
- [ ] No infinite wave after spawn budget consumed.
- [ ] Upgrade offer has 3 distinct eligible cards, respecting max stacks.
- [ ] Repair cannot raise HP >5; Rapid Fire does not reduce interval <0.16s.
- [ ] Boss charge orb can be intercepted; no attack whose only response is dodge by moving turret.
- [ ] Boss reaches victory condition; core reaching 0 yields defeat with deterministic tie ordering.
- [ ] Score is reproducible and persists across app restarts.

## UX test cases

- [ ] Crown only can navigate Home -> Tutorial -> Wave -> Upgrade -> Boss -> Results -> Retry.
- [ ] A no-touch run can be completed.
- [ ] 40 mm screen: HUD/beam/enemy/warnings readable within 2 seconds.
- [ ] 44 mm screen scales without clipping or stretched hit boxes.
- [ ] Upgrade card body and dwell progress legible; no unexpected auto choice.
- [ ] A deliberate Crown rotation from resume clears focus/arming safely.
- [ ] Audio muted / system silent does not impair understanding of warnings.
- [ ] Color-deficient tester can distinguish friendly, enemy, danger by silhouette/shape.
- [ ] Reduce Motion mode prevents rapid flashing / disorienting animations.
- [ ] Haptics occur at meaningful events, not on every bullet.

## watchOS lifecycle tests

- [ ] App becomes inactive mid-wave, spawn and damage freeze immediately.
- [ ] On resume game clock does not catch up and kill player.
- [ ] Notification interruption, wrist down, app switching tested.
- [ ] Resume menu needs deliberate Crown movement.
- [ ] Save corruption/absence handled without crash.

## SE 2 performance acceptance

- [ ] Actual physical watch model and OS recorded.
- [ ] Simulator FPS recorded separately from real-device FPS.
- [ ] Stable >=30 FPS measured in Wave 4 and Boss on SE2, or failures documented.
- [ ] Frame-time spikes and maximum live node/projectile counts reported.
- [ ] 3 consecutive full runs with responsiveness and warmth/battery observations.
- [ ] No network permission, microphone, location, camera or private-server access introduced.
- [ ] App icon/asset provenance/license audit completed before distribution.

## Final sign-off

Report test command, dated watch model, screenshot/video, observed result, unresolved issue and exact branch/commit for each release milestone. Do not mark untested items as done.
