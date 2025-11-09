# Proyecto Final de Big Data – Radar de fricción en clases de video (Cassandra + Flask)

Este repositorio contiene el proyecto final de base de datos NoSQL usando **Apache Cassandra** y una aplicación web en **Flask** como panel de visualización.

La idea principal es modelar y analizar la **experiencia de los estudiantes** mientras consumen clases en video (por ejemplo, alojadas en YouTube), registrando eventos como:

- `no_entiendo`
- `muy_rapido`
- `ok`
- `pause`
- `seek_back`

Con esa información se construyen:

- Mapas de fricción por minuto del video  
- Índices de fricción por clase y curso  
- Perfiles agregados por estudiante y por tema  

---

## Contenido del repositorio

### 1. Scripts CQL (Cassandra)

En la carpeta `cql/` (o donde los coloques) se incluyen **tres scripts**:

#### `00_esquema.cql`
Definición completa del esquema en Cassandra:

- Crea el **keyspace** `proyecto_final`
- Crea las tablas de acuerdo con el modelado por consultas:

  - `videos_by_course`  
  - `resources_by_topic`  
  - `experience_by_student_video`  
  - `class_metrics_by_video_minute`  
  - `class_summary_by_course`  
  - `student_profile_by_student`  
  - `course_summary_by_program_period`

Cada tabla está pensada para responder directamente a una vista o caso de uso específico del sistema (panel de cursos, detalle de video, perfil de estudiante, etc.).

#### `01_datos.cql`
Carga de **datos de ejemplo**:

- Inserta videos reales de YouTube usados como “clases”:
  - Introducción a Big Data  
  - Modelo de datos en Cassandra  
  - Introducción al Deep Learning  
- Inserta recursos complementarios por tema (`resources_by_topic`)
- Inserta eventos simulados de 3 estudiantes:
  - Ana (Big Data)
  - Bruno (Cassandra)
  - Carla (Deep Learning)
- Inserta métricas agregadas por minuto para construir el “heatmap” de fricción
- Inserta resúmenes a nivel:
  - **clase** (`class_summary_by_course`)
  - **estudiante / tema** (`student_profile_by_student`)
  - **curso / programa / período** (`course_summary_by_program_period`)

#### `02_consultas.cql`
Colección de **consultas de referencia** (SELECT):

- Consultas usadas por la app Flask:
  - Listar cursos y su índice de fricción global
  - Listar videos de un curso
  - Obtener detalle de un video
  - Obtener métricas por minuto de un video
  - Obtener eventos de estudiantes
  - Obtener perfil agregado de un estudiante
- Consultas adicionales para demo y análisis:
  - Cursos ordenados por fricción
  - Minutos más problemáticos de un video
  - Recursos complementarios por tema

Estos scripts permiten reproducir completamente el estado de la base para efectos de demo y documentación.

---

### 2. Aplicación Flask (`proyectofinal_flask/`)

La carpeta `proyectofinal_flask/` contiene la aplicación web construida con **Flask** (Python) que actúa como panel de visualización para docentes y coordinación académica.

Estructura principal:

- `app.py`  
  - Configura la conexión a Cassandra (`cassandra-driver`)  
  - Expone las rutas principales:
    - `/` – Panel de cursos y su índice de fricción global  
    - `/course/<course_id>` – Detalle de un curso y sus videos  
    - `/course/<course_id>/video/<video_id>` – Detalle de un video:
      - Reproductor embebido (YouTube)
      - Tabla de eventos de estudiantes
      - Mapa de fricción por minuto
    - `/student/<student_id>` – Perfil agregado del estudiante:
      - Temas con mayor dificultad
      - Historial de eventos
    - `/vista_estudiante_demo` – Vista de ejemplo del lado estudiante:
      - Video + botones de reacción (`no_entiendo`, `muy_rapido`, `ok`)
      - Comentario opcional (maqueta visual)
    - (Opcional) `/simulador_evento` – formulario para simular inserción de eventos
- `templates/`
  - `base.html` – layout general, modo “glassmorphism” con tonos azul/celeste
  - `index.html` – panel de cursos / home
  - `course_detail.html` – detalle de curso y videos
  - `video_detail.html` – detalle de video (panel docente)
  - `student_detail.html` – perfil de estudiante
  - `student_player.html` – mock de la interfaz de estudiante (botones de reacción)
  - `student_event.html` – simulador de eventos (formulario) *(si se usa)*
- `static/css/style.css`
  - Estilos personalizados:
    - fondo oscuro futurista
    - tarjetas “glass”
    - botones con glow
    - estilos para los botones de reacción del estudiante

---

## Requisitos

- Python 3.10+  
- Docker (para levantar Cassandra en contenedor)  
- Apache Cassandra (lado servidor, dentro del contenedor)  
- Librerías Python:
  - `flask`
  - `cassandra-driver`

---

## Cómo levantar el entorno (resumen)

### 1. Levantar Cassandra con Docker

Ejemplo básico:

```bash
sudo docker run -d --name cass_cluster \
  -e CASSANDRA_CLUSTER_NAME=sistemafinal_cluster \
  -p 9042:9042 \
  cassandra:latest
