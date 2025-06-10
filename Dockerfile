FROM debian:bullseye

# Instalar compilador y herramientas necesarias
RUN apt update && \
    apt install -y build-essential cmake curl gnupg2 iptables && \
    curl -fsSL https://tailscale.com/install.sh | sh

# Crear carpeta de trabajo
WORKDIR /app

# Copiar el código fuente
COPY . .

# Compilar el servidor
RUN cmake . && make

# Exponer el puerto TCP
EXPOSE 15015

# Ejecutar tailscaled y esperar login manual, luego lanzar el servidor
CMD tailscaled & sleep 3 && tailscale up && ./tcp_server
