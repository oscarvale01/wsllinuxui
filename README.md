# wsllinuxui
# WSL Linux UI Automation

Este repositorio contiene un script para automatizar la instalación de la interfaz gráfica XFCE y la configuración de XRDP en Kali Linux corriendo en WSL.

## Requisitos Previos

1. **Instalar WSL**:
   - Asegúrate de tener WSL instalado en tu sistema. Si no lo tienes, sigue [estas instrucciones](https://docs.microsoft.com/en-us/windows/wsl/install).

2. **Instalar Kali Linux**:
   - Instala Kali Linux desde la Microsoft Store.

3. **Instalar Git**:
   - Abre una terminal en Kali Linux y ejecuta:
     ```sh
     sudo apt update
     sudo apt install git -y
     ```

## Instalación

1. **Clonar el repositorio**:
   - Abre una terminal en Kali Linux y ejecuta:
     ```sh
     git clone https://github.com/oscarvale01/wsllinuxui.git
     cd wsllinuxui
     ```

2. **Ejecutar el script de instalación**:
   - Ejecuta el siguiente comando:
     ```sh
     ./install-xfce.sh
     ```

## Conexión mediante RDP

1. **Obtener la IP de WSL**:
   - Ejecuta el siguiente comando para obtener la IP de tu WSL:
     ```sh
     ip addr show
     ```
   - Busca la IP bajo la interfaz `eth0` o `wsl`.

2. **Conectar mediante RDP**:
   - Abre "Remote Desktop Connection" en tu máquina Windows.
   - En el campo "Computer", ingresa la IP obtenida en el paso anterior y haz clic en "Connect".
   - Ingresa tus credenciales de Kali Linux cuando se te solicite.

## Notas

- Asegúrate de que el servicio XRDP esté corriendo antes de intentar conectarte. Puedes iniciar el servicio manualmente con:
  ```sh
  sudo /etc/init.d/xrdp start

