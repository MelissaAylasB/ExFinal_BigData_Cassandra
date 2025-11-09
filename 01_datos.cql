-- 01_datos.cql

USE proyecto_final;

-- =========================================
-- 1. VIDEOS POR CURSO (catálogo)
-- =========================================

-- Usamos UUIDs fijos que ya viste en tus SELECT
-- BD101 - Introducción a Big Data
INSERT INTO videos_by_course (
    course_id, video_id, title, unit_topic, duration_seconds, video_url
) VALUES (
    'BD101',
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    'Introducción a Big Data',
    'Conceptos básicos',
    900,
    'https://www.youtube.com/watch?v=1oMThuGDZwg'
);

-- BD101 - Modelo de datos en Cassandra
INSERT INTO videos_by_course (
    course_id, video_id, title, unit_topic, duration_seconds, video_url
) VALUES (
    'BD101',
    282aa041-5152-40a4-98d3-75c0932e699e,
    'Modelo de datos en Cassandra',
    'Modelado por consultas',
    1200,
    'https://www.youtube.com/watch?v=7bM5e2xa6Ic'
);

-- DL101 - Introducción al Deep Learning
INSERT INTO videos_by_course (
    course_id, video_id, title, unit_topic, duration_seconds, video_url
) VALUES (
    'DL101',
    e1502709-f7cf-4393-bd31-aad7cc95f306,
    'Introducción al Deep Learning',
    'Fundamentos de redes neuronales',
    1800,
    'https://www.youtube.com/watch?v=dKqwnCKrpVI'
);


-- =========================================
-- 2. RECURSOS POR TEMA
-- =========================================

INSERT INTO resources_by_topic (
    topic_id, resource_id, resource_type, title, url
) VALUES (
    'joins_y_agrupaciones',
    93c97d9f-352d-4736-8709-b736e679ba12,
    'video',
    'Repaso de Joins',
    'https://youtu.be/joins'
);

INSERT INTO resources_by_topic (
    topic_id, resource_id, resource_type, title, url
) VALUES (
    'joins_y_agrupaciones',
    1a7c2053-1507-4b82-b484-8d36891ba7c3,
    'lectura',
    'Guía de Joins y Group By',
    'https://midominio/joins.pdf'
);


-- =========================================
-- 3. EVENTOS DE ESTUDIANTES POR VIDEO
--    (Ana, Bruno, Carla)
-- =========================================

-- Estudiante Ana (Big Data)
-- ID: 11111111-1111-1111-1111-111111111111

INSERT INTO experience_by_student_video (
    student_id, video_id, event_time, event_type, second_mark, comment_text
) VALUES (
    11111111-1111-1111-1111-111111111111,
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    toTimestamp(now()),
    'no_entiendo',
    320,
    'No me queda claro el ejemplo de MapReduce'
);

INSERT INTO experience_by_student_video (
    student_id, video_id, event_time, event_type, second_mark, comment_text
) VALUES (
    11111111-1111-1111-1111-111111111111,
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    toTimestamp(now()),
    'ok',
    900,
    'Ya entendí después de la explicación final'
);


-- Estudiante Bruno (Cassandra)
-- ID: 22222222-2222-2222-2222-222222222222

INSERT INTO experience_by_student_video (
    student_id, video_id, event_time, event_type, second_mark, comment_text
) VALUES (
    22222222-2222-2222-2222-222222222222,
    282aa041-5152-40a4-98d3-75c0932e699e,
    toTimestamp(now()),
    'muy_rapido',
    450,
    'Modelo físico muy rápido, me perdí'
);

INSERT INTO experience_by_student_video (
    student_id, video_id, event_time, event_type, second_mark, comment_text
) VALUES (
    22222222-2222-2222-2222-222222222222,
    282aa041-5152-40a4-98d3-75c0932e699e,
    toTimestamp(now()),
    'no_entiendo',
    780,
    'No entiendo bien las claves de partición'
);


-- Estudiante Carla (Deep Learning)
-- ID: 33333333-3333-3333-3333-333333333333

INSERT INTO experience_by_student_video (
    student_id, video_id, event_time, event_type, second_mark, comment_text
) VALUES (
    33333333-3333-3333-3333-333333333333,
    e1502709-f7cf-4393-bd31-aad7cc95f306,
    toTimestamp(now()),
    'pause',
    600,
    'Pausa para anotar el ejemplo de red neuronal'
);

INSERT INTO experience_by_student_video (
    student_id, video_id, event_time, event_type, second_mark, comment_text
) VALUES (
    33333333-3333-3333-3333-333333333333,
    e1502709-f7cf-4393-bd31-aad7cc95f306,
    toTimestamp(now()),
    'ok',
    1700,
    'Clase clara, solo repasar gradiente descendente'
);


-- =========================================
-- 4. MÉTRICAS POR MINUTO (MAPA DE FRICCIÓN)
--    Ejemplo para el video de Big Data
-- =========================================

-- Video Big Data: f01dcb8a-d05e-4fb0-a9a6-422e2982d07d

INSERT INTO class_metrics_by_video_minute (
    video_id, minute_bucket,
    no_entiendo_count, muy_rapido_count,
    ok_count, pause_count, seek_back_count
) VALUES (
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    5,
    3, 2,
    5, 1, 2
);

INSERT INTO class_metrics_by_video_minute (
    video_id, minute_bucket,
    no_entiendo_count, muy_rapido_count,
    ok_count, pause_count, seek_back_count
) VALUES (
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    10,
    4, 1,
    6, 0, 1
);

INSERT INTO class_metrics_by_video_minute (
    video_id, minute_bucket,
    no_entiendo_count, muy_rapido_count,
    ok_count, pause_count, seek_back_count
) VALUES (
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    15,
    1, 0,
    8, 0, 0
);

INSERT INTO class_metrics_by_video_minute (
    video_id, minute_bucket,
    no_entiendo_count, muy_rapido_count,
    ok_count, pause_count, seek_back_count
) VALUES (
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    20,
    0, 0,
    7, 0, 0
);


-- =========================================
-- 5. RESUMEN POR CLASE (VIDEO) EN EL CURSO
-- =========================================

INSERT INTO class_summary_by_course (
    course_id, video_id, friction_index, critical_segments_count
) VALUES (
    'BD101',
    282aa041-5152-40a4-98d3-75c0932e699e,
    0.80,
    3
);

INSERT INTO class_summary_by_course (
    course_id, video_id, friction_index, critical_segments_count
) VALUES (
    'BD101',
    f01dcb8a-d05e-4fb0-a9a6-422e2982d07d,
    0.40,
    1
);

INSERT INTO class_summary_by_course (
    course_id, video_id, friction_index, critical_segments_count
) VALUES (
    'DL101',
    e1502709-f7cf-4393-bd31-aad7cc95f306,
    0.55,
    2
);


-- =========================================
-- 6. PERFIL AGREGADO POR ESTUDIANTE
-- =========================================

INSERT INTO student_profile_by_student (
    student_id, topic_id,
    total_no_entiendo, total_critical_segments
) VALUES (
    11111111-1111-1111-1111-111111111111,
    'big_data_fundamentos',
    5,
    3
);

INSERT INTO student_profile_by_student (
    student_id, topic_id,
    total_no_entiendo, total_critical_segments
) VALUES (
    22222222-2222-2222-2222-222222222222,
    'diseno_cassandra',
    7,
    4
);

INSERT INTO student_profile_by_student (
    student_id, topic_id,
    total_no_entiendo, total_critical_segments
) VALUES (
    33333333-3333-3333-3333-333333333333,
    'deep_learning_intro',
    2,
    1
);


-- =========================================
-- 7. RESUMEN GLOBAL POR PROGRAMA / PERIODO
-- =========================================

INSERT INTO course_summary_by_program_period (
    program_id, period_id, course_id, global_friction_index
) VALUES (
    'ING-SOFT', '2025-1', 'BD101', 0.70
);

INSERT INTO course_summary_by_program_period (
    program_id, period_id, course_id, global_friction_index
) VALUES (
    'ING-SOFT', '2025-1', 'DL101', 0.50
);
