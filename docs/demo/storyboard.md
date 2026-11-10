# Sherpa Demo Video — Storyboard

A ~2-minute developer walkthrough of Sherpa, the voice-first offline survival assistant **built for anyplace** (demonstrated with Yosemite National Park).

**Target length:** ~127 s · **Resolution:** 1280×720 (16:9) · **Voiceover:** studio voice *Charon* · **Score:** custom instrumental electronic-ambient.

## Shot list

| # | Time | Shot | Visual | Voiceover / Sound |
|---|---|---|---|---|
| 1 | 0:00–0:14 | Title | Branded title card: Sherpa, "built for anyplace — demonstrated with Yosemite", platform list | "Meet Sherpa — a voice-first offline survival assistant built for any wild place, powered by Gemma, running entirely on-device. Here we're demonstrating it with Yosemite National Park." |
| 2 | 0:14–0:26 | Problem | 0 backcountry cell bars · universal wilderness problem | "Cell service disappears in every wilderness backcountry. Every season, hikers are caught by darkness, hypothermia, or swollen rivers — often less than a mile from a trail." |
| 3 | 0:26–0:34 | Strategy | Four-tier answer cards: instant / guide / Gemma / emergency | "Sherpa answers in four tiers. Deterministic quick cards give you verified map answers in under one hundred milliseconds." |
| 4 | 0:34–0:38 | Guide | First-aid guide slide: 10 urgent topics | "The official first aid guide covers known hazards." |
| 5 | 0:38–0:44 | Instant answers | Composite: offline map-data answer with verified action badge | (Music continues — visual proof of the <100 ms verified answer) |
| 6 | 0:44–0:50 | Gemma brief | Composite: streaming Gemma brief with live inference telemetry | "And for open-ended judgement questions, Gemma 4 E2B runs locally on Google Tensor." |
| 7 | 0:50–0:59 | Dashboard | Composite: survival dashboard with daylight computation + elevation | "On the home screen, the daylight card computes remaining daylight and your elevation in real time from a local NOAA solar model and offline elevation data." |
| 8 | 0:59–1:07 | Voice | Composite: hold-to-talk button, ASR/TTS flow | "Hold the mic button to talk. Zipformer transcribes locally, and KittenTTS speaks the answer back." |
| 9 | 1:07–1:16 | 2D map | Composite: offline trail map with automatic route-out + breadcrumbs | "The offline trail map computes the route to the nearest trailhead with walking time estimates, logs breadcrumbs, and marks nearby water and help." |
| 10 | 1:16–1:23 | 3D HUD | Composite: tactical 3D HUD with live compass | "And the full 3D map renders aerial imagery or the printed park map draped over terrain completely offline." |
| 11 | 1:23–1:37 | 3D fly-through | **Real recorded offline 3D fly-through** of Yosemite (Half Dome → El Capitan, MapLibre 3D) | (No voiceover — music swells under real gameplay, 14 s) |
| 12 | 1:37–1:46 | Emergency | Composite: full-screen emergency takeover + 911/Satellite SOS banner | "Emergency situations trigger immediate scripted guidance and a direct call to 911 or Satellite SOS. No model latency in the loop." |
| 13 | 1:46–1:52 | Region packs | Any-region pipeline: drop in any GeoPDF park map | "The platform is region agnostic. Drop in any park map and it works anywhere." |
| 14 | 1:52–1:58 | Hardware | NPU/GPU/CPU backends, latency table, Android + iOS architecture | "Both Android and iOS supported. Seventeen Flutter tests passing." |
| 15 | 1:58–2:07 | Closing | GitHub link, 100% offline badge, test counters | "Sherpa: survival intelligence, anywhere, offline." + music fade-out |

## Frame inventory

All slide frames are rendered at 1280×720 from the app's real design tokens and real screenshots. Yosemite is the **demonstration dataset**; the same pipeline accepts any park map:

- Title: [frame_s01_title.png](frame_s01_title.png)
- Problem: [frame_s02_problem.png](frame_s02_problem.png)
- Strategy: [frame_s03_strategy.png](frame_s03_strategy.png)
- Guide slide: [frame_s03b_guide.png](frame_s03b_guide.png)
- Instant answers: [frame_s06_instant.png](frame_s06_instant.png)
- Gemma brief: [frame_s07_streaming.png](frame_s07_streaming.png)
- Dashboard: [frame_s04_dashboard.png](frame_s04_dashboard.png)
- Voice: [frame_s05_voice.png](frame_s05_voice.png)
- 2D map: [frame_s08_map2d.png](frame_s08_map2d.png)
- 3D HUD: [frame_s09_map3d_hud.png](frame_s09_map3d_hud.png)
- 3D fly-through: real MapLibre recording ([tools/map-viewer/serve.py](../../tools/map-viewer/serve.py))
- Emergency: [frame_s10_emergency.png](frame_s10_emergency.png)
- Hardware: [frame_s11_hardware.png](frame_s11_hardware.png)
- Closing: [frame_s12_close.png](frame_s12_close.png)

## Verification checklist

- [ ] Every claim verified: 17 Flutter tests + 58 map-tool tests passing
- [ ] Gemma 4 E2B via LiteRT-LM on Google Tensor documented in ARCHITECTURE.md
- [ ] All 3D map shots are real MapLibre renders of the bundled offline tilesets
- [ ] "Built for anyplace" premise consistent across all narration and slides
- [ ] No cloud calls shown; fully offline operation documented
