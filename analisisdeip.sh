#!/bin/bash

# Verificar que se pase una IP como argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <IP>"
    exit 1
fi

TARGET_IP=$1

# Crear carpeta de reporte
REPORT_DIR="reporte_$TARGET_IP"
mkdir -p $REPORT_DIR

echo "Iniciando investigación sobre: $TARGET_IP"

# 1. WHOIS
whois $TARGET_IP > $REPORT_DIR/whois.txt
echo "[+] WHOIS completado."

# 2. Geo-localización
geoiplookup $TARGET_IP > $REPORT_DIR/geoip.txt
echo "[+] Geolocalización completada."

# 3. Nmap básico
nmap -T4 -F $TARGET_IP -oN $REPORT_DIR/nmap_fast.txt
echo "[+] Escaneo Nmap rápido completado."

# 4. Nmap avanzado
nmap -A -sV -O $TARGET_IP -oN $REPORT_DIR/nmap_advanced.txt
echo "[+] Escaneo Nmap avanzado completado."

# 5. Reputación (abrir en navegador)
echo "[+] Abriendo reputación pública en navegador..."
xdg-open "https://www.abuseipdb.com/check/$TARGET_IP" &
xdg-open "https://www.virustotal.com/gui/ip-address/$TARGET_IP" &
xdg-open "https://www.ipvoid.com/ip-blacklist-check/" &

# 6. DNS Enum (si la IP resuelve a dominio)
DOMAIN=$(host $TARGET_IP | grep -Eo 'pointer (.*)' | awk '{print $2}')
if [ ! -z "$DOMAIN" ]; then
    echo "[+] Dominio encontrado: $DOMAIN"
    dnsenum $DOMAIN > $REPORT_DIR/dnsenum.txt
    echo "[+] DNS Enum completado."
else
    echo "[!] No se encontró un dominio PTR asociado."
fi

# 7. Generar informe en PDF
echo "Generando informe en PDF..."
echo "Informe de investigación de IP: $TARGET_IP" > $REPORT_DIR/informe.txt
echo "\n--- WHOIS ---" >> $REPORT_DIR/informe.txt
cat $REPORT_DIR/whois.txt >> $REPORT_DIR/informe.txt
echo "\n--- GEOLOCALIZACIÓN ---" >> $REPORT_DIR/informe.txt
cat $REPORT_DIR/geoip.txt >> $REPORT_DIR/informe.txt
echo "\n--- NMAP FAST SCAN ---" >> $REPORT_DIR/informe.txt
cat $REPORT_DIR/nmap_fast.txt >> $REPORT_DIR/informe.txt
echo "\n--- NMAP ADVANCED SCAN ---" >> $REPORT_DIR/informe.txt
cat $REPORT_DIR/nmap_advanced.txt >> $REPORT_DIR/informe.txt
if [ -f $REPORT_DIR/dnsenum.txt ]; then
  echo "\n--- DNS ENUM ---" >> $REPORT_DIR/informe.txt
  cat $REPORT_DIR/dnsenum.txt >> $REPORT_DIR/informe.txt
fi

# Convertir informe.txt a PDF (requiere enscript y ps2pdf)
enscript $REPORT_DIR/informe.txt -o - | ps2pdf - $REPORT_DIR/informe.pdf
echo "✅ Informe PDF generado en: $REPORT_DIR/informe.pdf"

# 8. Finalización
echo "\n\n✅ Investigación completada. Los resultados están en $REPORT_DIR"
