# Aplicación Flutter con autenticación Firebase y conexión a backend API.

🚀 Características principales
✅ Autenticación anónima con Firebase

🌐 Consumo de API backend (Node.js)

🛡️ Protección de rutas basada en autenticación

📱 Interfaz limpia y responsive

🔄 Manejo de estados con StreamBuilder

🔧 Requisitos técnicos
Flutter SDK >= 3.0.0
Dart >= 2.17.0
Cuenta Firebase configurada
Backend API corriendo (opcional)

🛠️ Configuración inicial
Clona el repositorio:

	git clone https://github.com/tu-usuario/mi_app_firebase.git
	cd mi_app_firebase
Configura Firebase:

	Crea un proyecto en Firebase Console
	Añade una aplicación Android/iOS
Descarga los archivos de configuración:

	google-services.json para Android
	GoogleService-Info.plist para iOS

Instala dependencias:

	flutter pub get
Configura variables de entorno:
	Crea un archivo .env en la raíz del proyecto:
🏃 Ejecutar la aplicación
	flutter run
🌐 Configuración del API
La aplicación espera un backend con:

	Endpoint GET /saludo

Respuesta en formato JSON:

	json
	{
 	 "mensaje": "Texto del saludo"
	}
Para desarrollo local en Android, usa http://10.0.2.2:3000 como URL base.

🔐 Configuración de Firebase
Asegúrate de haber habilitado:

Autenticación anónima en Firebase Console

Reglas de seguridad básicas en Firebase Auth

🤝 Contribuir
Haz fork del proyecto

Crea tu rama (git checkout -b feature/nueva-funcionalidad)

Haz commit de tus cambios (git commit -am 'Añade nueva funcionalidad')

Haz push a la rama (git push origin feature/nueva-funcionalidad)

Abre un Pull Request

📄 Licencia
MIT © [María Alina Vargas García]