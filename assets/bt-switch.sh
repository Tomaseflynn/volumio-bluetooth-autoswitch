#!/bin/bash
# 1. Detener Volumio
/usr/local/bin/volumio stop
# 2. Esperar un momento a que suelte la tarjeta de sonido
sleep 2
# 3. Reiniciar el servicio de audio bluetooth para forzar la reconexión limpia
systemctl restart bluealsa-aplay
