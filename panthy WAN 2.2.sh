#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    "sageattention-2.2.0-cp312-cp312-linux_x86_64.whl"
    #"package-2"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/crystian/comfyui-crystools"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/chrisgoringe/cg-use-everywhere"
    "https://github.com/VAST-AI-Research/ComfyUI-Tripo"
    "https://github.com/Smirnov75/ComfyUI-mxToolkit"
    "https://github.com/jamesWalker55/comfyui-various"
    "https://github.com/orssorbit/ComfyUI-wanBlockswap"
    "https://github.com/aria1th/ComfyUI-LogicUtils"
    "https://github.com/chibiace/ComfyUI-Chibi-Nodes"
    "https://github.com/alt-key-project/comfyui-dream-video-batches"
    "https://github.com/stduhpf/ComfyUI-WanMoeKSampler"
    "https://github.com/plugcrypt/CRT-Nodes"
    "https://github.com/ShmuelRonen/ComfyUI-WanVideoKsampler"
    "https://github.com/willmiao/ComfyUI-Lora-Manager"
    "https://github.com/MoonGoblinDev/Civicomfy"
)

WORKFLOWS=(
)

INPUT=(
)

CHECKPOINT_MODELS=(
)

DIFFUSION_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp16.safetensors"
    "https://civitai.com/api/download/models/2260110?type=Model&format=SafeTensor&size=pruned&fp=fp8"
    
)

CLIP_MODELS=(
)

TEXT_ENCODERS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
)

LORA_MODELS=(
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/DR34ML4Y_I2V_14B_HIGH.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/DR34ML4Y_I2V_14B_LOW.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/shake-000008.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/furry_nsfw_1.1_e22.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/NSFW-22-H-e8.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/NSFW-22-L-e8.safetensors"
    "https://huggingface.co/ostris/wan22_i2v_14b_orbit_shot_lora/resolve/main/wan22_14b_i2v_orbit_high_noise.safetensors"
    "https://huggingface.co/ostris/wan22_i2v_14b_orbit_shot_lora/resolve/main/wan22_14b_i2v_orbit_low_noise.safetensors"
    "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/high_noise_model.safetensors?download=true"
    "https://huggingface.co/lightx2v/Wan2.2-Lightning/resolve/main/Wan2.2-I2V-A14B-4steps-lora-rank64-Seko-V1/low_noise_model.safetensors?download=true"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/maleejac_000004625_high_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/maleejac_000004625_low_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/23High%20noise-Cumshot%20Aesthetics.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/56Low%20noise-Cumshot%20Aesthetics.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan-jelly-hips-i2v-16epo-k3nk.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan-i2v-480p-anal-squirting-e56.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan-thiccum-v3.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/slop_twerk_HighNoise_merged3_7_v2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/slop_twerk_LowNoise_merged3_7_v2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/ass_ripple_HIGH_V01.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/ass_ripple_LOW_V01.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/SeductiveTurnsLow-000048.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/SeductiveTurnsHigh-000048.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2-i2v-high-oral-insertion-v1.0.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2-i2v-high-pov-insertion-v1.0.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2-i2v-low-pov-insertion-v1.0.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2-i2v-low-oral-insertion-v1.0.safetensors"
)

VAE_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
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
            wget --content-disposition -P /workspace "https://huggingface.co/Kijai/PrecompiledWheels/resolve/main/sageattention-2.2.0-cp312-cp312-linux_x86_64.whl"
            pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

# We must be at release tag v0.3.49 or greater for fp8 support
provisioning_update_comfyui() {
    required_tag="v0.3.60"
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
















