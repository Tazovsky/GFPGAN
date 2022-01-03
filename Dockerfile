FROM python:3.7.12

ARG REPO_DIR=/GFPGAN

WORKDIR ${REPO_DIR}

RUN apt-get update && \
    apt-get install ffmpeg libsm6 libxext6  -y && \
    python -m pip install --upgrade pi && \
    git clone https://github.com/TencentARC/GFPGAN.git ${REPO_DIR} && \
    pip install basicsr && \
    pip install facexlib && \
    pip install -r requirements.txt && \
    python setup.py develop

### Pretrained models
## GFPGANCleanv1-NoCE-C2.pth: No colorization; no CUDA extensions are required. It is still in training. Trained with more data with pre-processing.
RUN wget https://github.com/TencentARC/GFPGAN/releases/download/v0.2.0/GFPGANCleanv1-NoCE-C2.pth -P experiments/pretrained_models

# GFPGANv1.pth: The paper model, with colorization.
RUN wget https://github.com/TencentARC/GFPGAN/releases/download/v0.1.0/GFPGANv1.pth -P experiments/pretrained_models
