# Sherpa Survival: Offline AI Assistant for Outdoor Adventures

## The problem

You’re on a camping trip, walking on a quiet trail when it starts to rain. It’s getting dark, and it’s been a while since you passed a trail marker. You stop to check the map on your phone. No signal.

Then you remember you installed Sherpa Survival. You open it and see your position, the nearby trails, and the path you’ve walked so far.

On your way back to the trailhead, you make out the shape of a bear in the distance. You whisper, “I see a bear. What should I do?” Sherpa can pull up its offline wildlife guide right away. You keep your distance and give the bear room. Later, back at the campsite, you ask how to start a fire.

We built Sherpa Survival to make that possible on Android and iOS.

Out on a hike or a bike ride, you might have half a battery left and both hands busy. We built Sherpa to run on the phone so you can still look up a route or ask for help when you lose service.

## What we built

We started with the questions we’d ask on a trail. “Where’s the nearest water?” needs a position and a route. “What do I do if I see a bear?” can use the field guide. “I’m cold, wet, and losing light. Should I keep going?” is the kind of question we send to Gemma. We give it the phone’s location, recent progress, time to sunset, a route out, and relevant guide excerpts.

![Sherpa’s on-device architecture showing how text and photos reach the answer paths and how offline data feeds the assistant and Trail Map.](blog-assets/architecture.png)

On a Pixel, hold the mic to record and release it when you’re done. Zipformer transcribes up to 16 seconds of 16 kHz audio on the phone. Laya takes that transcript just as it would a typed question. It scores intent, urgency, and whether the question needs reasoning. Our routing rules use those scores and cues in the question to choose the map, the guide, or Gemma. If the app detects an emergency, it shows the scripted guidance first.

![Decision tree for text questions showing the emergency script, map lookup, field guide, and Gemma branches.](blog-assets/decision-tree.png)

We considered using Gemma’s native audio input. With a transcript, we can route a spoken question before we load Gemma. A photo takes its own path. We resize it to a maximum of 640 pixels on the longest edge, compress it as JPEG, and send it to Gemma with the question.

![Audio is transcribed on the phone for routing. A resized JPEG goes to Gemma with the question.](blog-assets/multimodal.png)

### Getting back to the trailhead

In Yosemite, we use Dijkstra’s algorithm on a trail graph, with a higher cost for uphill segments. Distance and climb give us a walking estimate. We also keep a breadcrumb when a GPS fix is at least 25 metres from the last point or at least two minutes newer. The recorded coordinates and timestamps let us draw your track in reverse for **Retrace** and tell Gemma how far you moved in the past hour.

![Sherpa in Retrace mode, with the recorded track toward Happy Isles Trailhead.](blog-assets/trail-map.jpg)

*Retrace with a simulated GPS track in Yosemite.*

MapLibre draws the route and track over the map. With the local elevation tiles installed, it drapes the Park map or aerial imagery over the terrain. Tap **3D** to tilt the camera over whichever layer you’re looking at.

![The Yosemite Park map around Half Dome, shown north-up and tilted with the same layer selected.](blog-assets/park-map-tilt.jpg)

## How we used LiteRT

We used preconverted models from LiteRT Community on Hugging Face and spent the hackathon getting them to work together on a Pixel. Flutter handles the interface and route calculations. On Android, a method channel sends requests to Kotlin, and an event channel carries generated tokens back to Flutter.

| Stage | Model | Runtime | Pixel backend |
| --- | --- | --- | --- |
| Speech recognition | Zipformer CTC | LiteRT | GPU |
| Text classification | Laya Multilingual | LiteRT | GPU |
| Text and image generation | Gemma 4 E2B-it | LiteRT-LM | Tensor G5 TPU with the optimized bundle |
| Text-to-speech | KittenTTS nano | LiteRT | CPU |

We chose Gemma 4 E2B because it handles text and photos in a 2.59 GB standard bundle. The standard E4B bundle is 3.66 GB. LiteRT-LM runs Gemma on Android and iOS. On a compatible Pixel, we use the Tensor G5 bundle and can retry with the standard GPU bundle if loading fails. [E2B model files](https://huggingface.co/litert-community/gemma-4-E2B-it-litert-lm/tree/main) · [E4B model files](https://huggingface.co/litert-community/gemma-4-E4B-it-litert-lm/tree/main)

The map and field guide are ready while Gemma is unloaded. We load the model when the first question needs it, keep it around for follow-ups, and free the memory after five minutes of inactivity. On Pixel, we also check location less often in battery saver.

### Pixel GPU vs. TPU

| Hardware & backend | Prefill (tok/s) | Time to first token | Decode (tok/s) | Peak CPU RAM |
| --- | ---: | ---: | ---: | ---: |
| Pixel TPU (Tensor delegate) | 2,500–3,500 | ~0.2–0.4 s | 30–45 | ~0.7–1.0 GB |
| Pixel GPU (OpenCL/Vulkan) | 2,000–3,000 | ~0.3–0.5 s | 40–50 | ~1.0–1.2 GB |

*Reference ranges for Pixel inference.*

## Demo

[Watch the two-minute hackathon demo](https://github.com/dev-ansung/sherpa-survival/blob/238d878bbd37f44df30574fbe2f1dabc3bef2d48/docs/demo/sherpa_demo_2min.mp4) · [Explore the GitHub repo](https://github.com/dev-ansung/sherpa-survival)

## What we learned

From the start, we had fun challenging each other on which problem was worth solving. We had a few hours and a stack that was new to most of us. Narrowing the build early gave us time to try the app on a real Pixel while we were still making changes.

Our biggest surprise was how useful a simple Settings screen became. We could switch the model, the hardware it ran on, and the voice on the spot. That made the app easier to test and much easier to demo. If you’re building something similar, get it running on the device early and keep those controls within reach.

## What’s next

We’d like to bring Sherpa to more parks. Download a region before you leave and take the same offline map, field guide, and assistant with you.

## Team

- An Sung · [LinkedIn](https://www.linkedin.com/in/dev-ansung/)
- Anirudh Kulkarni · [LinkedIn](https://www.linkedin.com/in/anirudh-kulkarni1/)
- Chengjiang Long · [LinkedIn](https://www.linkedin.com/in/chengjiang-long-a7702478)
- Min Thant Kyaw · [LinkedIn](https://www.linkedin.com/in/min-thant-kyaw-3075901b7)
