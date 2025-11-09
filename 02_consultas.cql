-- 02_consultas.cql

USE proyecto_final;

-- =========================================
-- A. Consultas de “home” (panel de cursos)
-- =========================================

-- A1. Ver resumen de fricción por curso (para el home)
SELECT program_id, period_id, course_id, global_friction_index
FROM course_summary_by_program_period
WHERE program_id = 'ING-SOFT'
  AND period_id  = '2025-1';

-- A2. Ver un título representativo por curso (Flask usa LIMIT 1)
SELECT course_id, title
FROM videos_by_course
WHERE course_id = 'BD101'
LIMIT 1;


-- =========================================
-- B. Consultas de detalle de curso
-- =========================================

-- B1. Listar todos los videos de un curso (para /course/<course_id>)
SELECT course_id, video_id, title, unit_topic, duration_seconds, video_url
FROM videos_by_course
WHERE course_id = 'BD101';

-- B2. Ver el resumen de fricción de esos videos
SELECT course_id, video_id, friction_index, critical_segments_count
FROM class_summary_by_course
WHERE course_id = 'BD101';


-- =========================================
-- C. Consultas de detalle de video
-- =========================================

-- C1. Datos de un video concreto (para el reproductor)
SELECT course_id, video_id, title, unit_topic, duration_seconds, video_url
FROM videos_by_course
WHERE course_id = 'BD101'
  AND video_id  = 282aa041-5152-40a4-98d3-75c0932e699e;

-- C2. Mapa de fricción por minuto (heatmap)
SELECT minute_bucket,
       no_entiendo_count,
       muy_rapido_count,
       ok_count,
       pause_count,
       seek_back_count
FROM class_metrics_by_video_minute
WHERE video_id = f01dcb8a-d05e-4fb0-a9a6-422e2982d07d
ORDER BY minute_bucket ASC;

-- C3. Eventos de estudiantes en ese video
-- (En diseño real evitarías ALLOW FILTERING, pero
--  para el laboratorio está bien porque hay pocos datos)
SELECT student_id, event_time, event_type, second_mark, comment_text
FROM experience_by_student_video
WHERE video_id = f01dcb8a-d05e-4fb0-a9a6-422e2982d07d
ALLOW FILTERING;


-- =========================================
-- D. Consultas de perfil por estudiante
-- =========================================

-- D1. Ver perfil agregado de un estudiante
SELECT topic_id, total_no_entiendo, total_critical_segments
FROM student_profile_by_student
WHERE student_id = 22222222-2222-2222-2222-222222222222;

-- D2. Ver todos los eventos de un estudiante
SELECT video_id, event_time, event_type, second_mark, comment_text
FROM experience_by_student_video
WHERE student_id = 22222222-2222-2222-2222-222222222222
ALLOW FILTERING;


-- =========================================
-- E. Consultas para recursos complementarios
-- =========================================

-- E1. Ver recursos asociados a un tema
SELECT topic_id, resource_type, title, url
FROM resources_by_topic
WHERE topic_id = 'joins_y_agrupaciones';


-- =========================================
-- F. Ejemplos de consultas “analíticas” simples
--    (para mostrar en el informe)
-- =========================================

-- F1. Cursos ordenados por fricción (mayor a menor)
-- (ordenamiento lo harías en la capa de aplicación)
SELECT course_id, global_friction_index
FROM course_summary_by_program_period
WHERE program_id = 'ING-SOFT'
  AND period_id  = '2025-1';

-- F2. Minutos más conflictivos de un video (filtrando los que tienen eventos)
SELECT minute_bucket,
       no_entiendo_count,
       muy_rapido_count
FROM class_metrics_by_video_minute
WHERE video_id = f01dcb8a-d05e-4fb0-a9a6-422e2982d07d
  AND (no_entiendo_count > 0 OR muy_rapido_count > 0)
ORDER BY minute_bucket ASC;
