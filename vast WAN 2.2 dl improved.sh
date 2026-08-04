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
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/crystian/comfyui-crystools"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
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
    "https://github.com/LAOGOU-666/Comfyui-Memory_Cleanup"
)

CHECKPOINT_MODELS=(
)

DIFFUSION_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp16.safetensors"  
)

TEXT_ENCODERS=(
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
)

LORA_MODELS=(
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/DR34ML4Y_I2V_14B_HIGH.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/DR34ML4Y_I2V_14B_LOW.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/furry_nsfw_1.1_e22.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/NSFW-22-H-e8.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/NSFW-22-L-e8.safetensors"
    "https://huggingface.co/ostris/wan22_i2v_14b_orbit_shot_lora/resolve/main/wan22_14b_i2v_orbit_high_noise.safetensors"
    "https://huggingface.co/ostris/wan22_i2v_14b_orbit_shot_lora/resolve/main/wan22_14b_i2v_orbit_low_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/maleejac2_low_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/maleejac2_high_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan-thiccum-v3.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/slop_twerk_HighNoise_merged3_7_v2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/slop_twerk_LowNoise_merged3_7_v2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/SmoothXXXAnimation_High.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/SmoothXXXAnimation_Low.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/Furry_Enhancer_Wan22_V3_High_Noise_I2V.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/Furry_Enhancer_Wan22_V3_Low_Noise_I2V.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/TRANSCOWGIRLHIGH.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/TRANSCOWGIRLLOW.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan22.r3v3rs3_c0wg1rl-14b-High-i2v_e70.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan22.r3v3rs3_c0wg1rl-14b-Low-i2v_e70.safetensors"
    "https://huggingface.co/lightx2v/Wan2.2-Distill-Loras/resolve/main/wan2.2_i2v_A14b_low_noise_lora_rank64_lightx2v_4step_1022.safetensors"
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_Lightx2v/Wan_2_2_I2V_A14B_HIGH_lightx2v_4step_lora_v1030_rank_64_bf16.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/WAN22_HighNoise_TransTwerk.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/WAN22_LowNoise_TransTwerk.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/i2v-anus-squirt_high_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/i2v-anus-squirt_low_noise.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/WAN2.2AssholeHIGHI2Ve68.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/WAN2.2AssholeLOWI2Ve41.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/I2V-WAN2.2-POVFaceSitting-2.0-HighNoise_-000032.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/I2V-WAN2.2-POVFaceSitting-2.0-LowNoise_-000020.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2_i2v_high_ulitmate_pussy_asshole.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2_i2v_low_ulitmate_pussy_asshole.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/DR34ML4Y_I2V_14B_HIGH_V2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/DR34ML4Y_I2V_14B_LOW_V2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan22-jellyhips-i2v-13epoc-high-k3nk.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan22-jellyhips-i2v-23epoc-low-k3nk.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/TWERKI2VHIGH.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/TWERKI2VLOW.safetensors"
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Stable-Video-Infinity/v2.0/SVI_v2_PRO_Wan2.2-I2V-A14B_LOW_lora_rank_128_fp16.safetensors"
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Stable-Video-Infinity/v2.0/SVI_v2_PRO_Wan2.2-I2V-A14B_HIGH_lora_rank_128_fp16.safetensors"
    "https://huggingface.co/KeyOpening8063587/FutaCumshot/resolve/main/cum4_h_30.safetensors"
    "https://huggingface.co/KeyOpening8063587/futacumshotlow/resolve/main/cum4_l_75.safetensors"
    "https://huggingface.co/Sentinel7/wan/resolve/main/2371603/2682405/wan22_i2v_zxtp_hip_sway_high_type2_r1.safetensors"
    "https://huggingface.co/Sentinel7/wan/resolve/main/2371603/2682415/wan22_i2v_zxtp_hip_sway_low_type2_r1.safetensors"
)

VAE_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
)

ESRGAN_MODELS=(
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"
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
            #wget --content-disposition -P /workspace/ComfyUI "https://huggingface.co/Kijai/PrecompiledWheels/resolve/main/sageattention-2.2.0-cp312-cp312-linux_x86_64.whl"
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






































