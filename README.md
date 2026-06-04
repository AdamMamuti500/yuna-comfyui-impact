# Yuna ComfyUI Impact Baked Image

This repository builds a RunPod ComfyUI worker image with Impact Pack and Impact Subpack preinstalled.

Image target:

```text
ghcr.io/adammamuti500/yuna-comfyui-impact:2026-06-04-base
```

Important:

- No HF token, RunPod token, Yuna LoRA, dataset, or private references are baked into this image.
- FLUX fp8 checkpoint and Yuna LoRA must stay on RunPod network volume/model storage.
- Build is manual-only through GitHub Actions `workflow_dispatch`.
- After the first successful GHCR push, make the package public if RunPod should pull it without registry credentials.

Run:

1. Push this repo/folder to GitHub.
2. Open **Actions**.
3. Run **Build Yuna ComfyUI Impact Image**.
4. Use tag `2026-06-04-base`.
5. After success, create/update the RunPod template to use:

```text
ghcr.io/adammamuti500/yuna-comfyui-impact:2026-06-04-base
```

Smoke test requirement:

- Start one cheap RunPod pod only for inventory.
- Poll `https://{pod_id}-8188.proxy.runpod.net/object_info`.
- Required nodes:
  - `FaceDetailer`
  - `UltralyticsDetectorProvider`
  - `SAMLoader`
- Also verify FLUX checkpoint and Yuna LoRA are visible from mounted volume/model storage.
- Terminate the pod and report `RUNPOD_ACTIVE 0`.
