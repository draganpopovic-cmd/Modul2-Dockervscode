# Basis-Image: schlankes Ubuntu LTS für breite Kompatibilität
FROM ubuntu:22.04

# Aktualisieren der Paketquellen und Installation grundlegender Tools und Laufzeiten
RUN apt-get update && apt-get install -y \
    git curl wget gnupg2 ca-certificates apt-transport-https lsb-release \
    python3 python3-pip build-essential vim docker.io \
    && rm -rf /var/lib/apt/lists/*

# Node.js (für z.B. Newman CLI) – Installation der aktuellen LTS-Version über NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g newman   # Newman: CLI für Postman-Collections

# Trivy installieren (CVE-Scanner für Container/Dateien)
RUN apt-get install -y apt-transport-https gnupg \
    && curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add - \
    && echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" > /etc/apt/sources.list.d/trivy.list \
    && apt-get update && apt-get install -y trivy

# (Optional) Gitleaks installieren (Secret-Scanning als eigenständiges Binary)
RUN wget -O /usr/local/bin/gitleaks https://github.com/gitleaks/gitleaks/releases/download/v8.30.0/gitleaks_8.30.0_linux_x64.tar.gz \
    && chmod +x /usr/local/bin/gitleaks

# Arbeitsverzeichnis einrichten
WORKDIR /workspace

# (Optional) Vorkonfigurierte VS Code Settings/Extensions ins Image kopieren
# COPY .devcontainer/settings.json /home/vscode/.vscode-remote/data/Machine/settings.json

# Container im Leerlauf halten (oder alternativ Start einer Shell)
CMD ["sleep", "infinity"]
