# Backend API - Servicio de Saludo

## API simple construida con Node.js que proporciona un endpoint de saludo.

1.- 🚀 Características

- Endpoint GET `/saludo` que devuelve un mensaje de saludo
- Configuración mínima con Express.js
- Puerto configurable (3000 por defecto)

2.- 📦 Prerrequisitos

- Node.js v16+
- npm o yarn

3.- 🔧 Instalación

3.1. Clonar el repositorio:
	git clone [URL_DEL_REPOSITORIO]
	cd mi-backend-api
3.2. Instalar dependencias:
	npm install
	o
	yarn install
4.- 🏃 Ejecución
Para iniciar el servidor en desarrollo:
	npm start
	o
	yarn start
El servidor estará disponible en:
	http://localhost:3000

5.- 🌐 Endpoints
	GET /saludo
	Devuelve un mensaje de saludo en formato JSON.

	Ejemplo de respuesta:
		json
		{
		  "mensaje": "¡Hola desde el backend!"
		}
6.- 🔧 Configuración
	Puedes modificar el puerto creando un archivo .env:
		PORT=4000
	O pasando la variable de entorno al ejecutar:
		PORT=4000 npm start
7.- 🧪 Testing
Para ejecutar pruebas (si existen):
	npm test
8.- 🛠️ Estructura del Proyecto
mi-backend-api/
├── node_modules/
├── src/
│   ├── app.js          # Configuración principal de Express
│   ├── routes/         # Definición de rutas
│   └── controllers/    # Lógica de los endpoints
├── .env                # Variables de entorno (opcional)
├── package.json
└── README.md
9.- 🤝 Contribución
Haz fork del proyecto
Crea una rama (git checkout -b feature/nueva-funcionalidad)
Haz commit de tus cambios (git commit -am 'Añade nueva funcionalidad')
Haz push a la rama (git push origin feature/nueva-funcionalidad)
Abre un Pull Request

> ⌨️ Atentamente, María Alina Vargas García