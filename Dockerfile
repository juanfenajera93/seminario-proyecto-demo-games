# imagen oficial de python ligera
FROM python:3.10-slim

# creación de la carpeta app dentro del contenedor 
WORKDIR /app

# copia del archivo requirements-api.txt 
COPY requirements-api.txt .

# instalación de dependencias 
# paquetes de linux
# librería del sistema
RUN apt-get update && apt-get install -y libgomp1

# instalación de dependencias de python
# no guarda caché dentro del directorio
RUN pip install --no-cache-dir -r requirements-api.txt

# copia todo lo demás de nuestro proyecto local 
# al WORKDIR (/app) dentro del contenedor
COPY . . 

# comando de arranque para ejecutar la app cuando el contenedor se inicia
# 0.0.0.0 es una dirección IP especial que le dice al servidor que escuche peticiones
# desde cualquier interfaz de red, permitiendo que las peticiones de la máquina anfitriona
# lleguen al contenedor
CMD ["uvicorn", "api_app:app", "--host", "0.0.0.0", "--port", "8080"] 