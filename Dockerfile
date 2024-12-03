FROM quay.io/jupyter/datascience-notebook:python-3.11.9
USER root

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 必要なファイルをコピー
COPY requirements.txt .
# pythonパッケージのインストール
RUN pip install --upgrade pip
RUN pip install jupyterlab
#pip install -r requirements.txt \

# ポートを公開
EXPOSE 8888

# Jupyter Labを起動
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root"]

