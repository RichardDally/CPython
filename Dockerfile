ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG PYTHON_VERSION

ENV PYTHON_BINARY=python${PYTHON_MAJOR}.${PYTHON_MINOR}
ENV PYTHON_ARCHIVE_DIRECTORY=Python-${PYTHON_VERSION}
ENV PYTHON_ARCHIVE_FILENAME=${PYTHON_ARCHIVE_DIRECTORY}.tgz
ENV PYTHON_ARCHIVE_URL=https://www.python.org/ftp/python/${PYTHON_VERSION}/${PYTHON_ARCHIVE_FILENAME}
ENV ROOT_DIRECTORY=/tmp
ENV ARCHIVES_DIRECTORY=${ROOT_DIRECTORY}/PythonArchives
ENV EXTRACT_DIRECTORY=${ARCHIVES_DIRECTORY}/${PYTHON_ARCHIVE_DIRECTORY}

RUN apt-get update -qq && \
    apt-get install --yes --no-install-recommends \
    bash \
    bc \
    ca-certificates \
    coreutils \
    debianutils \
    build-essential \
    file \
    findutils \
    gawk \
    grep \
    libc-bin \
    lsb-release \
    mount \
    passwd \
    procps \
    sed \
    tar \
    vim \
    emacs-nox \
    wget \
    uuid-dev \
    tk-dev \
    zlib1g-dev \
    liblzma-dev \
    libbz2-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libreadline6-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev && \
    echo "Preparing CPython ${PYTHON_VERSION}" && \
    mkdir --parents ${ARCHIVES_DIRECTORY} && \
    wget --quiet ${PYTHON_ARCHIVE_URL} --directory ${ARCHIVES_DIRECTORY} && \
    tar --extract --file ${ARCHIVES_DIRECTORY}/${PYTHON_ARCHIVE_FILENAME} --directory ${ARCHIVES_DIRECTORY} && \
    echo "Compiling CPython ${PYTHON_VERSION} with `nproc` cores" && \
    cd ${EXTRACT_DIRECTORY} && ./configure --enable-optimizations --with-lto && \
    cd ${EXTRACT_DIRECTORY} && make --jobs `nproc` && \
    cd ${EXTRACT_DIRECTORY} && make altinstall && \
    echo "Reset default python3 symbolic link" && \
    ln -sv /usr/local/bin/${PYTHON_BINARY} /usr/bin/python3 && \
    echo "Cleanup archives" && \
    rm -rf ${ARCHIVES_DIRECTORY} && \
    echo "Remove shebang from /usr/bin/lsb_release to unblock pip (c.f. https://stackoverflow.com/q/44967202/5037799)" && \
    sed -i 1d /usr/bin/lsb_release
