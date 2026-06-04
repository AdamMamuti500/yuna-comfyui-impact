# Yuna ComfyUI Impact baked image.
# Contains ComfyUI FLUX fp8 base + custom nodes/dependencies.
# No tokens, no Yuna LoRA, no private references.
FROM runpod/worker-comfyui:5.8.5-flux1-dev-fp8

ENV COMFYUI_PATH=/comfyui
ENV COMFYUI_MODEL_PATH=/comfyui/models
ENV PIP=/opt/venv/bin/pip
ENV PYTHON=/opt/venv/bin/python3

WORKDIR /comfyui

RUN $PIP install --no-cache-dir \
    torchvision \
    opencv-python-headless \
    scikit-image

RUN cd /comfyui/custom_nodes \
    && git clone --quiet --recursive https://github.com/ltdrdata/ComfyUI-Impact-Pack.git \
    && git clone --quiet --recursive https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git

RUN cd /comfyui/custom_nodes/ComfyUI-Impact-Pack \
    && $PYTHON install.py

RUN cd /comfyui/custom_nodes/ComfyUI-Impact-Subpack \
    && $PYTHON install.py

RUN if [ -f /comfyui/custom_nodes/ComfyUI-Impact-Pack/requirements.txt ]; then \
        $PIP install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-Impact-Pack/requirements.txt; \
    fi \
    && if [ -f /comfyui/custom_nodes/ComfyUI-Impact-Subpack/requirements.txt ]; then \
        $PIP install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-Impact-Subpack/requirements.txt; \
    fi

RUN $PYTHON -c "import skimage.measure; import cv2; print('skimage+cv2 OK')"

# Keep the base image entrypoint/CMD so RunPod worker/proxy behavior remains intact.
