#!/bin/bash

BASE_DIR="/workspace/runpod-slim/ComfyUI"

declare -A NODES
NODES=["https://github.com/cubiq/ComfyUI_essentials"]="custom_nodes"
NODES=["https://github.com/kijai/ComfyUI-WanVideoWrapper"]="custom_nodes"

declare -A MODELS
MODELS=["https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"]="diffusion_models"
MODELS=["https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"]="text_encoders"
MODELS=["https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"]="loras"
MODELS=["https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"]="upscale_models"
MODELS=["https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth"]="vae"

echo "============================================="
echo "Processing Custom Nodes..."
echo "============================================="

for repo in "${!NODES[@]}"; do
    sub_dir="${NODES[$repo]}"
    target_path="$BASE_DIR/$sub_dir"
    
    mkdir -p "$target_path"
    cd "$target_path" || exit
    
    folder_name=$(basename "$repo" .git)
    
    # Check if node already exists
    if [ -d "$folder_name" ]; then
        echo "⚠️  [NODES] $folder_name already exists. Skipping download."
        cd "$folder_name" || exit
    else
        # 🟢 PRINTING CURRENT NODE DOWNLOAD
        echo "📥 [NODES] Downloading node: $folder_name ($repo)..."
        if git clone "$repo"; then
            cd "$folder_name" || exit
        else
            echo "❌ [NODES] Failed to download node: $folder_name"
            continue
        fi
    fi

    # Execute dependencies
    if [ -f "requirements.txt" ]; then
        echo "📦 [NODES] Running pip install for $folder_name..."
        python3 -m pip install --no-cache-dir -r requirements.txt
    fi
    echo "----------------------------------------"
done

echo "============================================="
echo "PHASE 2: Downloading Model Files..."
echo "============================================="

for url in "${!MODELS[@]}"; do
    model_folder="${MODELS[$url]}"
    target_path="$BASE_DIR/models/$model_folder"
    
    mkdir -p "$target_path"
    cd "$target_path" || exit
    
    # Extract file name from the URL
    file_name=$(basename "$url" | cut -d? -f1)
    
    if [ -f "$file_name" ]; then
        echo "⚠️  [MODELS] Model '$file_name' already exists. Skipping download."
    else
        # 🟢 PRINTING CURRENT MODEL DOWNLOAD
        echo "📥 [MODELS] Downloading model: $file_name into models/$model_folder..."
        # wget outputs its own real-time progress bar right underneath this print statement
        wget -c --show-progress "$url" -O "$file_name"
    fi
    echo "----------------------------------------"
done

echo "============================================="
echo "Setup complete! All nodes and models processed."
echo "============================================="

