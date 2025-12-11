#!/bin/bash

echo "Desinstalando Bluetooth Auto-Switch..."

# 1. Detener y deshabilitar servicios activos
echo "Deteniendo servicios..."
systemctl stop bluealsa-aplay
systemctl disable bluealsa-aplay

# 2. Borrar archivos copiados (Limpieza)
echo "Eliminando archivos del sistema..."

# El script interruptor
if [ -f /usr/local/bin/bt-switch.sh ]; then
    rm /usr/local/bin/bt-switch.sh
fi

# La regla del vigilante UDEV
if [ -f /etc/udev/rules.d/99-bluetooth-audio.rules ]; then
    rm /etc/udev/rules.d/99-bluetooth-audio.rules
fi

# El servicio systemd
if [ -f /etc/systemd/system/bluealsa-aplay.service ]; then
    rm /etc/systemd/system/bluealsa-aplay.service
fi

# 3. Eliminar el "Override" de aptX (Esto restaura la config original de Volumio)
echo "Restaurando configuración original de codecs..."
if [ -d /etc/systemd/system/bluealsa.service.d ]; then
    rm -rf /etc/systemd/system/bluealsa.service.d
fi

# 4. Recargar demonios para que olviden las configuraciones
echo "Recargando sistema..."
udevadm control --reload-rules
systemctl daemon-reload

# 5. Reiniciar el servicio principal de Bluetooth (para volver a SBC/Default)
systemctl restart bluealsa

echo "Desinstalación completada. Tu sistema está limpio."
