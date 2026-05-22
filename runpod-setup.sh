#!/bin/bash

COMFYUI_DIR="/workspace/runpod-slim/ComfyUI"

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
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2-i2v-high-oral-insertion-v1.0.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan2.2-i2v-low-oral-insertion-v1.0.safetensors"
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
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan22_i2v_hip_shake_high_v2.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/wan22_i2v_hip_shake_low_v2.safetensors"
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
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/plug_pull_hn_2250.safetensors"
    "https://huggingface.co/JackyCoo/I2V_good_models_to_use/resolve/main/wan%202.2/plug_pull_ln_5000.safetensors"
)

VAE_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
)

ESRGAN_MODELS=(
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"
)


function provisioning_start() {
    provisioning_print_header
    provisioning_get_nodes
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

function provisioning_print_header() {
    echo "============================================="
    echo "PHASE 1: Processing Custom Nodes..."
    echo "============================================="
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
                   python3 -m pip install --no-cache-dir -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                python3 -m pip install --no-cache-dir -r "${requirements}"
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
    
    printf "\n=============================================\n"
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    printf "=============================================\n"
    
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_download() {
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
}

function provisioning_print_end() {
    echo "============================================="
    echo "🎉 Setup complete! All items successfully processed."
    echo "============================================="
}

provisioning_start






