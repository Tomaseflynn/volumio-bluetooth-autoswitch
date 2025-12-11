#!/bin/bash
echo "Instalando Bluetooth Auto-Switch..."

# 1. Copiar el script interruptor
echo "Copiando script switch..."
cp ./assets/bt-switch.sh /usr/local/bin/
chmod +x /usr/local/bin/bt-switch.sh

# 2. Copiar la regla UDEV
echo "Configurando reglas UDEV..."
cp ./assets/99-bt-audio.rules /etc/udev/rules.d/
udevadm control --reload-rules

# 3. Configurar el servicio BlueALSA Aplay
echo "Configurando servicio systemd..."
cp ./assets/bluealsa-aplay.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable bluealsa-aplay
systemctl restart bluealsa-aplay

# 4. EL TRUCO PRO: Configurar aptX sin romper el sistema
# En lugar de editar /lib/systemd/system/bluealsa.service directamente (que es peligroso),
# creamos un "override" (drop-in file).
echo "Forzando codecs aptX..."
mkdir -p /etc/systemd/system/bluealsa.service.d
echo "[Service]" > /etc/systemd/system/bluealsa.service.d/override.conf
echo "ExecStart=" >> /etc/systemd/system/bluealsa.service.d/override.conf
echo "ExecStart=/usr/bin/bluealsa -p a2dp-sink --profile=a2dp-source --codec=aptX --codec=aptX-HD --codec=SBC" >> /etc/systemd/system/bluealsa.service.d/override.conf

# Reiniciar el servicio principal
systemctl daemon-reload
systemctl restart bluealsa

echo "Instalación completada con éxito."