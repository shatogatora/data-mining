FROM quay.io/jupyter/datascience-notebook:python-3.11.9

USER root

# 必要なシステムパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Mecab辞書のシンボリックリンクを作成
RUN ln -s /etc/mecabrc /usr/local/etc/mecabrc

WORKDIR /app

# 必要なPythonパッケージをインストール
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install jupyterlab mecab-python3

# ポートを公開
EXPOSE 8888

# Jupyter Labを起動
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
