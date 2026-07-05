# local-setup

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Brenda Carolina Galeano Ramírez | Equipo: Desarrollo Supermercado "La Esquina"

## Requisitos

- Python 3.10+
- pip
- Navegador web moderno

## Pasos

```bash
git clone <repo-del-proyecto>
cd supermercado-la-esquina-app
python -m venv venv
source venv/bin/activate        # En Windows: venv\Scripts\activate
pip install -r requirements.txt

# Crear/inicializar la base de datos SQLite
python init_db.py

# Levantar el servidor de desarrollo
flask run
```

La aplicación queda disponible en `http://localhost:5000`.

## Variables de entorno

| Variable | Descripción |
|----------|-------------|
| `FLASK_APP` | Punto de entrada de la app (ej. `app.py`) |
| `FLASK_ENV` | `development` en local |
| `SECRET_KEY` | Clave para firmar la sesión de Flask |
