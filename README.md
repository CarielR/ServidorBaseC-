# Servidor TCP en C++ con Docker y Tailscale

Este proyecto implementa un servidor TCP en C++ que escucha en el puerto `15015` para recibir mensajes de clientes. El servidor está contenido en un contenedor Docker, y se puede acceder a él desde redes remotas mediante Tailscale.

## 🧱 Componentes

- **main.cpp**: Código fuente del servidor TCP.
- **Dockerfile**: Define la imagen para compilar y ejecutar el servidor.
- **docker-compose.yml**: Orquesta la creación del contenedor.
- **Tailscale**: Permite acceder de forma segura desde cualquier parte del mundo como si fuera una red local.

---

## 🚀 Ejecución con Docker

### 1. Compilar y levantar el contenedor

```bash
docker-compose up --build
```

Esto:
- Compila `main.cpp` dentro del contenedor.
- Expone el puerto `15015` para escuchar conexiones TCP.

### 2. Probar el servidor localmente

Desde otra terminal o máquina:

```bash
nc localhost 15015
```

Escribe un mensaje y deberías recibir como respuesta:

```
Comando Recibido
```

---

## 🌐 Acceso remoto seguro con Tailscale

### 1. Autenticarse con Tailscale dentro del contenedor

Abre un bash dentro del contenedor:

```bash
docker exec -it tcp-server bash
```

Luego ejecuta:

```bash
tailscale up
```

Esto te pedirá autenticación desde el navegador. Sigue el enlace proporcionado para iniciar sesión.

### 2. Ver la IP de Tailscale asignada

Dentro del contenedor:

```bash
tailscale ip -4
```

Obtendrás una IP del tipo `100.x.x.x`.

### 3. Conectarse remotamente

Desde otra máquina conectada a la misma red Tailscale:

```bash
nc 100.x.x.x 15015
```

---

## 📦 Archivos importantes

- `main.cpp`: Código del servidor.
- `Dockerfile`: 
  - Usa una imagen base de C++ (`gcc`).
  - Compila el código y ejecuta el binario.
- `docker-compose.yml`: Define los puertos expuestos y facilita el despliegue.
- `tailscale`: Debe estar instalado dentro del contenedor o como parte de la imagen base.

---

## 🛠 Requisitos

- Docker y Docker Compose
- Cuenta en [Tailscale](https://tailscale.com/)
- Acceso a navegador para autenticación Tailscale

---

## 🧾 Créditos

Desarrollado como ejemplo de servidor TCP accesible remotamente mediante VPN con Docker + Tailscale.
