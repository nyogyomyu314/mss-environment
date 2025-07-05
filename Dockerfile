# 1. ベースイメージの選択
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# 環境変数を設定
ENV DEBIAN_FRONTEND=noninteractive

# 2. 必要なライブラリやツールのインストール
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    wget \
    ffmpeg \
    build-essential \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

# 3. 作業ディレクトリの設定
WORKDIR /workspace

# 4. Pythonライブラリのインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir jupyterlab

# 5. ポートの指定
EXPOSE 8888

# 6. コンテナ起動時のデフォルトコマンド
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]