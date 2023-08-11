FROM python:3

RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get install -y vim less unzip
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN python -m pip install jupyterlab \
    autopep8 \
    bokeh \
    folium \
    jupyter_contrib_nbextensions \
    jupyter-nbextensions-configurator \
    matplotlib \
    numpy \
    pandas \
    scikit-learn \
    scipy \
    seaborn \
    tqdm

# 拡張機能を有効化する
RUN jupyter contrib nbextension install
RUN jupyter nbextensions_configurator enable

ARG USERNAME=shin
ARG GROUPNAME=shin
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME
