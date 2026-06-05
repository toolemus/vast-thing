#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"sageattention-2.2.0-cp312-cp312-linux_x86_64.whl"
    "sageattention"
    "mediapipe"
    "soundfile"
)

NODES=(
    "https://github.com/LAOGOU-666/Comfyui-Memory_Cleanup"
    "https://github.com/MoonGoblinDev/Civicomfy"
    "https://github.com/crystian/comfyui-crystools"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/jamesWalker55/comfyui-various"
    "https://github.com/TenStrip/10S-Comfy-nodes"
    "https://github.com/Smirnov75/ComfyUI-mxToolkit"
    "https://github.com/Lightricks/ComfyUI-LTXVideo"
    "https://github.com/evanspearman/ComfyMath"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/Comfy-Org/Nvidia_RTX_Nodes_ComfyUI"
    "https://github.com/ClownsharkBatwing/RES4LYF"
    "https://github.com/willmiao/ComfyUI-Lora-Manager"
    "https://github.com/gseth/ControlAltAI-Nodes"
    "https://github.com/jamesWalker55/comfyui-various"
)

LATENT_UPSCALE_MODELS=(
    "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.1.safetensors"
)

INPUT=(
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/TenStrip/LTX2.3-10Eros/resolve/main/10Eros_v1-fp8mixed_learned.safetensors"
)

DIFFUSION_MODELS=(
)

CLIP_MODELS=(
)

TEXT_ENCODERS=(
    "https://huggingface.co/GitMylo/LTX-2-comfy_gemma_fp8_e4m3fn/resolve/main/gemma_3_12B_it_fp8_e4m3fn.safetensors"
)

LORA_MODELS=(
    "https://huggingface.co/TenStrip/LTX2.3_Distilled_Lora_1.1_Experiments/resolve/main/ltx-2.3-22b-distilled-lora-1.1_fro90_ceil72_condsafe.safetensors"
    "https://huggingface.co/malias/ltx-stack/resolve/main/LTX2.3_Breasts_Jiggle_Physics.safetensors"
    "https://huggingface.co/olivv-cs/ltx2_vast/resolve/main/LTX2.3_reasoning_I2V_V3.safetensors"
    "https://huggingface.co/Sentinel7/ltxv/resolve/main/2344781/2778953/LTX2.3-NSFWMOTION_00750.safetensors"
    "https://huggingface.co/jmew1989/CMFUI/resolve/main/ltx23/nsfw_riding_backshot_frontshot_ltx23_v1.0.safetensors"
    "https://huggingface.co/XLB666/LTXloras/resolve/main/DR34ML4Y_LTXXX_V2.safetensors"

)

VAE_MODELS=(
)

ESRGAN_MODELS=(
)

CONTROLNET_MODELS=(
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_update_comfyui
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_files \
        "${workflows_dir}" \
        "${WORKFLOWS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/input" \
        "${INPUT[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/latent_upscale_models" \
        "${LATENT_UPSCALE_MODELS[@]}"
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

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            #wget --content-disposition -P /workspace/ComfyUI "https://huggingface.co/Kijai/PrecompiledWheels/resolve/main/sageattention-2.2.0-cp312-cp312-linux_x86_64.whl"
            pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

# We must be at release tag v0.3.49 or greater for fp8 support
provisioning_update_comfyui() {
    required_tag="v0.22.0"
    cd ${COMFYUI_DIR}
    git fetch --all --tags
    current_commit=$(git rev-parse HEAD)
    required_commit=$(git rev-parse "$required_tag")
    if git merge-base --is-ancestor "$current_commit" "$required_commit"; then
        git checkout "$required_tag"
        pip install --no-cache-dir -r requirements.txt
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
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start

fi














