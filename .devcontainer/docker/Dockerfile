# Use default base image
FROM mcr.microsoft.com/vscode/devcontainers/base:jammy

# Add Microsoft APT server
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb

# Add required dependencies
# - gnupg2: Support for signed commits
# - powershell: Object oriented script language with cross-platform
RUN apt-get update && \
    apt-get install -y \
    gnupg2 \
    powershell
