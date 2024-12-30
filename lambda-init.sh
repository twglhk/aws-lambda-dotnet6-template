#!/bin/bash

# 사용자 입력 받기
read -p "Enter Lambda Name (which will be used for Lambda Name, Assembly Name, S3 Prefix, and Stack Name): " lambda_name
read -p "Enter IAM Role: " iam_role

# template.yaml 파일 수정
sed -i '' "s/ASSEMBLY_NAME/$lambda_name/g" template.yaml
sed -i '' "s/LAMBDA_NAME/$lambda_name/g" template.yaml
sed -i '' "s/ROLE/$iam_role/g" template.yaml

# samconfig.toml 파일 수정
sed -i '' "s/{S3_PREFIX}/$lambda_name/g" samconfig.toml
sed -i '' "s/{STACK_NAME}/$lambda_name/g" samconfig.toml

# Lambda 디렉토리 및 csproj 파일 변경
original_dir_name="src/LAMBDA_NAME"  # 기존 디렉토리 이름
new_dir_name="src/$lambda_name"  # 새 디렉토리 이름

if [ -d "$original_dir_name" ]; then
    # 기존 디렉토리를 새 디렉토리로 이동
    mv "$original_dir_name" "$new_dir_name"

    # csproj 파일 이름 변경
    if [ -f "$new_dir_name/ASSEMBLY_NAME.csproj" ]; then
        mv "$new_dir_name/ASSEMBLY_NAME.csproj" "$new_dir_name/$lambda_name.csproj"
    else
        echo "Error: $new_dir_name/ASSEMBLY_NAME.csproj file not found."
    fi

    # 기존 디렉토리 삭제
    rm -rf "$original_dir_name"
else
    echo "Error: $original_dir_name directory not found."
fi

# Function.cs 내의 namespace 변경
function_file="$new_dir_name/Function.cs"
if [ -f "$function_file" ]; then
    sed -i '' "s/namespace WardGames.Zooports.Lambda.LAMBDA_NAME/namespace WardGames.Zooports.Lambda.$lambda_name/g" "$function_file"
else
    echo "Error: $function_file file not found."
fi

echo "Configuration updated successfully."
