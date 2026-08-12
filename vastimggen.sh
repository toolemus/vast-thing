#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    "sageattention"
    #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/crystian/comfyui-crystools"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/Smirnov75/ComfyUI-mxToolkit"
    "https://github.com/jamesWalker55/comfyui-various"
    "https://github.com/willmiao/ComfyUI-Lora-Manager"
    "https://github.com/MoonGoblinDev/Civicomfy"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/AstrionX/ComfyUI-Tensor-Prism-Node-Pack"
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/KirtiKousik/pony_checkpoints/resolve/main/xavier_v10.safetensors"
    "https://huggingface.co/JackyCoo/CivitAI_backups/resolve/main/xavierVOIDFUSED_v10.safetensors"
    "https://huggingface.co/Ba96/dss/resolve/main/indigoFurryMixXL_cknoobEPS11.safetensors"
    "https://huggingface.co/LeFeujitif/sandbox/resolve/main/waiIllustriousSDXL_v160.safetensors"
    "https://huggingface.co/cirno723/ab/resolve/main/waiIllustriousSDXL_v170.safetensors"
)

DIFFUSION_MODELS=(
)

CLIP_MODELS=(
)

TEXT_ENCODERS=(
)

LORA_MODELS=(
    "https://huggingface.co/Alptekinege/iluslora/resolve/main/zy_illustrious_Realism_Enhancer_v1.safetensors"
    "https://huggingface.co/nyaa314/lora/resolve/main/illustrious/ILXL_Realism_Slider_V.1.safetensors"
    "https://huggingface.co/Nomanola/sdxl_loras/resolve/main/StS-Illustrious-Detail-Slider-v1.0.safetensors"
    "https://huggingface.co/JackyCoo/CivitAI_backups/resolve/main/BlueCat_modified.safetensors"
    "https://huggingface.co/quarantineearth/wan/resolve/main/BallsDeep-IL-V2.2-S.safetensors"
    "https://huggingface.co/SurpassHR/ConceptLoraBackup/resolve/main/analtuggingill_333.safetensors"
    "https://huggingface.co/LyliaEngine/cfg_scale_boost/resolve/main/cfg_scale_boost.safetensors"
    "https://huggingface.co/minaiosu/Volnovik/resolve/main/NOOB_vp1_detailer_by_volnovik_v1.safetensors"
)

VAE_MODELS=(
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
)

ESRGAN_MODELS=(
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"
)

CONTROLNET_MODELS=(
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    provisioning_print_header
    provisioning_get_aria2
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_files \
        "${COMFYUI_DIR}/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/diffusion_models" \
        "${DIFFUSION_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/text_encoders" \
        "${TEXT_ENCODERS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/loras" \
        "${LORA_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/clip_vision" \
        "${CLIP_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/upscale_models" \
        "${ESRGAN_MODELS[@]}"
    provisioning_print_end
}

function provisioning_get_aria2() {
    if ! command -v aria2c &> /dev/null; then
        printf "Installing aria2 package...\n"
        sudo apt-get update && sudo apt-get install -y aria2
    fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip install --no-cache-dir -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip install --no-cache-dir -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_files() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Application will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    local url="$1"
    local out_dir="$2"
    local filename=$(basename "$url")
    local auth_header=""

    local size_mb=0
    local size_bytes

    size_bytes=$(curl -sI -L ${auth_header/--header=/ -H } "$url" | grep -i 'content-length' | awk '{print $2}' | tr -d '\r' | tail -n1)

    if [[ -n "$size_bytes" && "$size_bytes" -gt 0 ]]; then
        size_mb=$(( size_bytes / 1024 / 1024 ))
    fi

    local connections=4
    local splits=8
    local chunk_size="16M"

    if [[ $size_mb -eq 0 || $size_mb -lt 900 ]]; then
        echo "Detected small file (${size_mb}MB). Using lightweight download profile..."
        connections=2
        splits=2
        chunk_size="1M"
    else
        echo "Detected large file (${size_mb}MB). Using heavy multi-threaded profile..."
    fi

    aria2c \
        --continue=true \
        --disk-cache=64M \
        --max-connection-per-server="$connections" \
        --split="$splits" \
        --min-split-size="$chunk_size" \
        --max-tries=15 \
        --retry-wait=5 \
        --no-netrc=true \
        --timeout=20 \
        --summary-interval=10 \
        --dir="$out_dir" \
        --out="$filename" \
        "$url"
}

# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start

fi





































