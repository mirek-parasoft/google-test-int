# baseline image
FROM debian:11

ARG USER_ID=1001

# install toolchains and utilities
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gcc g++ make cmake git mc vim wget curl fontconfig sudo openssh-client ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# install python and jre
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python3 python-is-python3 openjdk-11-jre-headless unzip && \
    rm -rf /var/lib/apt/lists/*

# configure default user
RUN groupadd parasoft && \
    useradd -d /home/parasoft --uid ${USER_ID} -m -g parasoft -G sudo -s /bin/bash parasoft && \
    echo "parasoft:parasoft" | chpasswd

RUN cd /home/parasoft && mkdir actions-runner && cd actions-runner \
    && curl -o actions-runner-linux-x64-2.301.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz

RUN chown -R parasoft:parasoft /home/parasoft/actions-runner && /home/parasoft/actions-runner/bin/installdependencies.sh

# install cpptest-coverage toolchain
# be sure to set docker context to the root folder of the local cpptest-coverage app
WORKDIR /opt/parasoft
COPY . cpptest-coverage/
RUN chown -R parasoft:parasoft /opt/parasoft/

# pre-install parasoft.vscode-cpptest-2022.2.0 extension
WORKDIR /home/parasoft
# COPY integration/vscode/parasoft_cpptest_vscode-2022.2.0.vsix .vscode-server/extensions/
RUN if [ -f /opt/parasoft/cpptest-coverage/integration/vscode/parasoft_cpptest_vscode-2022.2.0.vsix ] ; then \
        mkdir -p .vscode-server/extensions && \
        cp /opt/parasoft/cpptest-coverage/integration/vscode/parasoft_cpptest_vscode-2022.2.0.vsix .vscode-server/extensions/ && \
        chown -R parasoft:parasoft .vscode-server && \
        cd .vscode-server/extensions && \
        unzip *.vsix && \
        mv extension parasoft.vscode-cpptest-2022.2.0 && \
        mv extension.vsixmanifest parasoft.vscode-cpptest-2022.2.0/.vsixmanifest && \
        rm *.vsix && rm *.xml \
    ; else \
        echo "Skipped pre-installing Visual Studio Code extension" \
    ; fi

# configure environment
ENV PATH="/opt/parasoft/cpptest-coverage/bin:${PATH}" CPPTEST_HOME="/opt/parasoft/cpptest-coverage"
WORKDIR /home/parasoft
USER parasoft:parasoft
