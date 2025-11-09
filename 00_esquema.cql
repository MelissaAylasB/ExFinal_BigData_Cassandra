-- 00_esquema.cql
-- (Opcional) Si quieres recrear desde cero:
-- DROP KEYSPACE IF EXISTS proyecto_final;

CREATE KEYSPACE IF NOT EXISTS proyecto_final
WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
}
AND durable_writes = true;

USE proyecto_final;

-- 1. Catálogo de videos por curso
CREATE TABLE IF NOT EXISTS videos_by_course (
    course_id        text,
    video_id         uuid,
    title            text,
    unit_topic       text,
    duration_seconds int,
    video_url        text,
    PRIMARY KEY (course_id, video_id)
);

-- 2. Recursos (lecturas / videos extra) por tema
CREATE TABLE IF NOT EXISTS resources_by_topic (
    topic_id      text,
    resource_id   uuid,
    resource_type text,   -- 'video', 'lectura', etc.
    title         text,
    url           text,
    PRIMARY KEY (topic_id, resource_id)
);

-- 3. Eventos de experiencia por estudiante y video
CREATE TABLE IF NOT EXISTS experience_by_student_video (
    student_id   uuid,
    video_id     uuid,
    event_time   timestamp,
    event_type   text,   -- 'no_entiendo', 'muy_rapido', 'ok', 'pause', 'seek_back'
    second_mark  int,
    comment_text text,
    PRIMARY KEY ((student_id, video_id), event_time)
) WITH CLUSTERING ORDER BY (event_time ASC);

-- 4. Métricas agregadas por video y minuto
CREATE TABLE IF NOT EXISTS class_metrics_by_video_minute (
    video_id          uuid,
    minute_bucket     int,  -- minuto 0, 1, 2, ...
    no_entiendo_count int,
    muy_rapido_count  int,
    ok_count          int,
    pause_count       int,
    seek_back_count   int,
    PRIMARY KEY (video_id, minute_bucket)
);

-- 5. Resumen de fricción a nivel de video dentro del curso
CREATE TABLE IF NOT EXISTS class_summary_by_course (
    course_id               text,
    video_id                uuid,
    friction_index          double,
    critical_segments_count int,
    PRIMARY KEY (course_id, video_id)
);

-- 6. Perfil agregado de dificultad por estudiante / tema
CREATE TABLE IF NOT EXISTS student_profile_by_student (
    student_id              uuid,
    topic_id                text,
    total_no_entiendo       int,
    total_critical_segments int,
    PRIMARY KEY (student_id, topic_id)
);

-- 7. Resumen global por programa y periodo académico
CREATE TABLE IF NOT EXISTS course_summary_by_program_period (
    program_id            text,
    period_id             text,
    course_id             text,
    global_friction_index double,
    PRIMARY KEY ((program_id, period_id), course_id)
);
