-- liquibase formatted sql
-- changeset MYAPP:1781168126437 stripComments:false  logicalFilePath:ords/myapp/ords.sql
-- sqlcl_snapshot {"hash":"504810c48160c1a31a988a453debaf1185c77440","type":"ORDS_SCHEMA","name":"ords","schemaName":"MYAPP","sxml":""}
--
        
DECLARE
  l_current_schema varchar(40);

  l_roles     OWA.VC_ARR;
  l_modules   OWA.VC_ARR;
  l_patterns  OWA.VC_ARR;

BEGIN
  SELECT sys_context('USERENV', 'CURRENT_USER') INTO l_current_schema FROM dual;

  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => l_current_schema,
      p_auto_rest_auth      => FALSE);

  ORDS.DEFINE_MODULE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_base_path      => '/demo-dashboard/',
      p_items_per_page => 100,
      p_status         => 'PUBLISHED',
      p_comments       => 'Read-only dashboard endpoints for the SQLcl Projects CI/CD demo');

  ORDS.SET_MODULE_ORIGINS_ALLOWED(
      p_module_name     => '' || l_current_schema || '.demo_dashboard',
      p_origins_allowed => 'http://localhost:8088,http://127.0.0.1:8088'); 

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'health/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Environment health and metadata');

  ORDS.DEFINE_HANDLER(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'health/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 0,
      p_mimes_allowed  => NULL,
      p_comments       => 'Environment health and metadata',
      p_source         => 
'
DECLARE
  l_json CLOB;
BEGIN
  SELECT JSON_OBJECT(
           ''schemaName'' VALUE SYS_CONTEXT(''USERENV'', ''CURRENT_SCHEMA''),
           ''sessionUser'' VALUE SYS_CONTEXT(''USERENV'', ''SESSION_USER''),
           ''databaseName'' VALUE SYS_CONTEXT(''USERENV'', ''DB_NAME''),
           ''serverTime'' VALUE TO_CHAR(SYSTIMESTAMP, ''YYYY-MM-DD"T"HH24:MI:SS.FF3TZH:TZM''),
           ''projectControlExists'' VALUE CASE WHEN EXISTS (
             SELECT 1 FROM user_tables WHERE table_name = ''PROJECT_CONTROL''
           ) THEN ''Y'' ELSE ''N'' END,
           ''databaseChangelogExists'' VALUE CASE WHEN EXISTS (
             SELECT 1 FROM user_tables WHERE table_name = ''DATABASECHANGELOG''
           ) THEN ''Y'' ELSE ''N'' END,
           ''invalidObjectCount'' VALUE (
             SELECT COUNT(*) FROM user_objects WHERE status <> ''VALID''
           )
           RETURNING CLOB
         )
  INTO   l_json
  FROM   dual;

  OWA_UTIL.MIME_HEADER(''application/json'', FALSE);
  OWA_UTIL.HTTP_HEADER_CLOSE;
  FOR i IN 0 .. FLOOR((DBM' || 'S_LOB.GETLENGTH(l_json) - 1) / 30000) LOOP
    HTP.PRN(DBMS_LOB.SUBSTR(l_json, 30000, (i * 30000) + 1));
  END LOOP;
END;
');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'summary/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Aggregated schema and deployment summary');

  ORDS.DEFINE_HANDLER(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'summary/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 0,
      p_mimes_allowed  => NULL,
      p_comments       => 'Aggregated schema and deployment summary',
      p_source         => 
'
DECLARE
  l_object_counts     CLOB := ''[]'';
  l_latest_deployment CLOB := ''null'';
  l_latest_changeset  CLOB := ''null'';
  l_json              CLOB;
  l_table_count       NUMBER;
BEGIN
  SELECT COALESCE(
           JSON_ARRAYAGG(
             JSON_OBJECT(
               ''objectType'' VALUE object_type,
               ''totalCount'' VALUE total_count,
               ''invalidCount'' VALUE invalid_count
               RETURNING CLOB
             )
             RETURNING CLOB
           ),
           TO_CLOB(''[]'')
         )
  INTO   l_object_counts
  FROM (
    SELECT object_type,
           COUNT(*) total_count,
           SUM(CASE WHEN status <> ''VALID'' THEN 1 ELSE 0 END) invalid_count
    FROM   user_objects
    GROUP  BY object_type
    ORDER  BY object_type
  );

  SELECT COUNT(*)
  INTO   l_table_count
  FROM   user_tables
  WHERE  table_name = ''PROJECT_CONTROL'';

  IF l_table_count > 0 THEN
    EXECUTE IMMEDIATE q''[
      SELECT COALESCE(
               (
                 SELECT JSON_O' || 'BJECT(
                          ''projectName'' VALUE project_name,
                          ''targetSchema'' VALUE target_schema,
                          ''releaseVersion'' VALUE release_version,
                          ''releaseTag'' VALUE release_tag,
                          ''artifactName'' VALUE artifact_name,
                          ''artifactSha256'' VALUE artifact_sha256,
                          ''previousReleaseVersion'' VALUE previous_release_version,
                          ''deployedAt'' VALUE TO_CHAR(deployed_at, ''YYYY-MM-DD"T"HH24:MI:SS.FF3TZH:TZM''),
                          ''deployedBy'' VALUE deployed_by,
                          ''githubRepository'' VALUE github_repository,
                          ''githubRunId'' VALUE github_run_id,
                          ''githubRunAttempt'' VALUE github_run_attempt,
                          ''githubSha'' VALUE github_sha,
                          ''deployStatus'' VALUE deploy_status,
                          ''notes'' VALUE notes
       ' || '                   RETURNING CLOB
                        )
                 FROM (
                   SELECT *
                   FROM   project_control
                   ORDER  BY deployed_at DESC NULLS LAST
                   FETCH FIRST 1 ROW ONLY
                 )
               ),
               TO_CLOB(''null'')
             )
      FROM dual
    ]'' INTO l_latest_deployment;
  END IF;

  SELECT COUNT(*)
  INTO   l_table_count
  FROM   user_tables
  WHERE  table_name = ''DATABASECHANGELOG'';

  IF l_table_count > 0 THEN
    EXECUTE IMMEDIATE q''[
      SELECT COALESCE(
               (
                 SELECT JSON_OBJECT(
                          ''id'' VALUE id,
                          ''author'' VALUE author,
                          ''filename'' VALUE filename,
                          ''dateExecuted'' VALUE TO_CHAR(dateexecuted, ''YYYY-MM-DD"T"HH24:MI:SS''),
                          ''orderExecuted'' VALUE orderexecuted,
                          ''execType'' VALUE exectype,
           ' || '               ''description'' VALUE description
                          RETURNING CLOB
                        )
                 FROM (
                   SELECT *
                   FROM   databasechangelog
                   ORDER  BY orderexecuted DESC
                   FETCH FIRST 1 ROW ONLY
                 )
               ),
               TO_CLOB(''null'')
             )
      FROM dual
    ]'' INTO l_latest_changeset;
  END IF;

  SELECT JSON_OBJECT(
           ''schemaName'' VALUE SYS_CONTEXT(''USERENV'', ''CURRENT_SCHEMA''),
           ''serverTime'' VALUE TO_CHAR(SYSTIMESTAMP, ''YYYY-MM-DD"T"HH24:MI:SS.FF3TZH:TZM''),
           ''objectCounts'' VALUE l_object_counts FORMAT JSON,
           ''latestDeployment'' VALUE l_latest_deployment FORMAT JSON,
           ''latestChangeset'' VALUE l_latest_changeset FORMAT JSON
           RETURNING CLOB
         )
  INTO   l_json
  FROM   dual;

  OWA_UTIL.MIME_HEADER(''application/json'', FALSE);
  OWA_UTIL.HTTP_HEADER_CLOSE;
  FOR i IN 0 .. FLOOR((DBMS' || '_LOB.GETLENGTH(l_json) - 1) / 30000) LOOP
    HTP.PRN(DBMS_LOB.SUBSTR(l_json, 30000, (i * 30000) + 1));
  END LOOP;
END;
');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'objects/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Schema objects with application or metadata classification');

  ORDS.DEFINE_HANDLER(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'objects/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 0,
      p_mimes_allowed  => NULL,
      p_comments       => 'Schema objects with application or metadata classification',
      p_source         => 
'
DECLARE
  l_items CLOB;
  l_json CLOB;
BEGIN
  SELECT JSON_ARRAYAGG(
           JSON_OBJECT(
             ''objectName'' VALUE object_name,
             ''objectType'' VALUE object_type,
             ''status'' VALUE status,
             ''objectGroup'' VALUE object_group,
             ''created'' VALUE TO_CHAR(created, ''YYYY-MM-DD"T"HH24:MI:SS''),
             ''lastDdlTime'' VALUE TO_CHAR(last_ddl_time, ''YYYY-MM-DD"T"HH24:MI:SS'')
             RETURNING CLOB
           )
           RETURNING CLOB
         )
  INTO   l_items
  FROM (
    SELECT object_name,
           object_type,
           status,
           created,
           last_ddl_time,
           CASE
             WHEN object_name = ''PROJECT_CONTROL''
               OR object_name LIKE ''DATABASECHANGELOG%''
               OR object_name LIKE ''DBTOOLS$%''
             THEN ''DEMO_METADATA''
             ELSE ''APPLICATION''
           END object_group
    FROM   user_objects
    ORDER  BY object_group, object_type, object_name
  );

  l_items := ' || 'COALESCE(l_items, TO_CLOB(''[]''));

  SELECT JSON_OBJECT(
           ''items'' VALUE l_items FORMAT JSON
           RETURNING CLOB
         )
  INTO   l_json
  FROM   dual;

  OWA_UTIL.MIME_HEADER(''application/json'', FALSE);
  OWA_UTIL.HTTP_HEADER_CLOSE;
  FOR i IN 0 .. FLOOR((DBMS_LOB.GETLENGTH(l_json) - 1) / 30000) LOOP
    HTP.PRN(DBMS_LOB.SUBSTR(l_json, 30000, (i * 30000) + 1));
  END LOOP;
END;
');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'tables/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Table columns, data types, and key flags');

  ORDS.DEFINE_HANDLER(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'tables/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 0,
      p_mimes_allowed  => NULL,
      p_comments       => 'Table columns, data types, and key flags',
      p_source         => 
'
DECLARE
  l_items CLOB;
  l_json CLOB;
BEGIN
  SELECT JSON_ARRAYAGG(
           JSON_OBJECT(
             ''tableName'' VALUE table_name,
             ''columnId'' VALUE column_id,
             ''columnName'' VALUE column_name,
             ''dataType'' VALUE data_type,
             ''dataLength'' VALUE data_length,
             ''dataPrecision'' VALUE data_precision,
             ''dataScale'' VALUE data_scale,
             ''dataTypeDisplay'' VALUE data_type_display,
             ''nullable'' VALUE nullable,
             ''isPrimaryKey'' VALUE is_primary_key,
             ''isForeignKey'' VALUE is_foreign_key,
             ''objectGroup'' VALUE object_group
             RETURNING CLOB
           )
           RETURNING CLOB
         )
  INTO   l_items
  FROM (
    WITH key_columns AS (
      SELECT acc.table_name,
             acc.column_name,
             MAX(CASE WHEN ac.constraint_type = ''P'' THEN ''Y'' ELSE ''N'' END) is_primary_key,
             MAX(CASE WHEN ac.constraint_type = ''R'' THEN ''Y'' ELSE ''N'' END) ' || 'is_foreign_key
      FROM   user_cons_columns acc
      JOIN   user_constraints ac
      ON     ac.constraint_name = acc.constraint_name
      WHERE  ac.constraint_type IN (''P'', ''R'')
      GROUP  BY acc.table_name, acc.column_name
    )
    SELECT utc.table_name,
           utc.column_id,
           utc.column_name,
           utc.data_type,
           utc.data_length,
           utc.data_precision,
           utc.data_scale,
           CASE
             WHEN utc.data_type IN (''VARCHAR2'', ''CHAR'', ''NVARCHAR2'', ''NCHAR'')
             THEN utc.data_type || ''('' || utc.char_length || '')''
             WHEN utc.data_type = ''NUMBER'' AND utc.data_precision IS NOT NULL AND utc.data_scale IS NOT NULL
             THEN utc.data_type || ''('' || utc.data_precision || '','' || utc.data_scale || '')''
             WHEN utc.data_type = ''NUMBER'' AND utc.data_precision IS NOT NULL
             THEN utc.data_type || ''('' || utc.data_precision || '')''
             ELSE utc.data_type
           END data_type_displa' || 'y,
           utc.nullable,
           COALESCE(kc.is_primary_key, ''N'') is_primary_key,
           COALESCE(kc.is_foreign_key, ''N'') is_foreign_key,
           CASE
             WHEN utc.table_name = ''PROJECT_CONTROL''
               OR utc.table_name LIKE ''DATABASECHANGELOG%''
               OR utc.table_name LIKE ''DBTOOLS$%''
             THEN ''DEMO_METADATA''
             ELSE ''APPLICATION''
           END object_group
    FROM   user_tab_columns utc
    JOIN   user_tables ut
    ON     ut.table_name = utc.table_name
    LEFT   JOIN key_columns kc
    ON     kc.table_name = utc.table_name
    AND    kc.column_name = utc.column_name
    ORDER  BY object_group, utc.table_name, utc.column_id
  );

  l_items := COALESCE(l_items, TO_CLOB(''[]''));

  SELECT JSON_OBJECT(
           ''items'' VALUE l_items FORMAT JSON
           RETURNING CLOB
         )
  INTO   l_json
  FROM   dual;

  OWA_UTIL.MIME_HEADER(''application/json'', FALSE);
  OWA_UTIL.HTTP_HEADER_CLOSE;
  FOR i IN 0 .. FLOOR((DBMS_LOB.GE' || 'TLENGTH(l_json) - 1) / 30000) LOOP
    HTP.PRN(DBMS_LOB.SUBSTR(l_json, 30000, (i * 30000) + 1));
  END LOOP;
END;
');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'changelog/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'SQLcl Project and Liquibase changelog rows');

  ORDS.DEFINE_HANDLER(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'changelog/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 0,
      p_mimes_allowed  => NULL,
      p_comments       => 'SQLcl Project and Liquibase changelog rows',
      p_source         => 
'
DECLARE
  l_items       CLOB := TO_CLOB(''[]'');
  l_json        CLOB := TO_CLOB(''{"items":[]}'');
  l_table_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO   l_table_count
  FROM   user_tables
  WHERE  table_name = ''DATABASECHANGELOG'';

  IF l_table_count > 0 THEN
    EXECUTE IMMEDIATE q''[
      SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                 ''id'' VALUE id,
                 ''author'' VALUE author,
                 ''filename'' VALUE filename,
                 ''dateExecuted'' VALUE TO_CHAR(dateexecuted, ''YYYY-MM-DD"T"HH24:MI:SS''),
                 ''orderExecuted'' VALUE orderexecuted,
                 ''execType'' VALUE exectype,
                 ''description'' VALUE description,
                 ''comments'' VALUE comments,
                 ''tag'' VALUE tag,
                 ''liquibase'' VALUE liquibase
                 RETURNING CLOB
               )
               RETURNING CLOB
             )
      FROM (
        SELECT *
        FROM   databasechangelog
        ORDER  BY orderex' || 'ecuted DESC
        FETCH FIRST 80 ROWS ONLY
      )
    ]'' INTO l_items;
  END IF;

  l_items := COALESCE(l_items, TO_CLOB(''[]''));

  SELECT JSON_OBJECT(
           ''items'' VALUE l_items FORMAT JSON
           RETURNING CLOB
         )
  INTO   l_json
  FROM   dual;

  OWA_UTIL.MIME_HEADER(''application/json'', FALSE);
  OWA_UTIL.HTTP_HEADER_CLOSE;
  FOR i IN 0 .. FLOOR((DBMS_LOB.GETLENGTH(l_json) - 1) / 30000) LOOP
    HTP.PRN(DBMS_LOB.SUBSTR(l_json, 30000, (i * 30000) + 1));
  END LOOP;
END;
');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'project-control/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Production deployment control history');

  ORDS.DEFINE_HANDLER(
      p_module_name    => '' || l_current_schema || '.demo_dashboard',
      p_pattern        => 'project-control/',
      p_method         => 'GET',
      p_source_type    => 'plsql/block',
      p_items_per_page => 0,
      p_mimes_allowed  => NULL,
      p_comments       => 'Production deployment control history',
      p_source         => 
'
DECLARE
  l_items       CLOB := TO_CLOB(''[]'');
  l_json        CLOB := TO_CLOB(''{"items":[]}'');
  l_table_count NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO   l_table_count
  FROM   user_tables
  WHERE  table_name = ''PROJECT_CONTROL'';

  IF l_table_count > 0 THEN
    EXECUTE IMMEDIATE q''[
      SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
                 ''projectName'' VALUE project_name,
                 ''targetSchema'' VALUE target_schema,
                 ''releaseVersion'' VALUE release_version,
                 ''releaseTag'' VALUE release_tag,
                 ''artifactName'' VALUE artifact_name,
                 ''artifactSha256'' VALUE artifact_sha256,
                 ''previousReleaseVersion'' VALUE previous_release_version,
                 ''deployedAt'' VALUE TO_CHAR(deployed_at, ''YYYY-MM-DD"T"HH24:MI:SS.FF3TZH:TZM''),
                 ''deployedBy'' VALUE deployed_by,
                 ''githubRepository'' VALUE github_repository,
                 ''githubRunId'' VALUE github_run_id,
       ' || '          ''githubRunAttempt'' VALUE github_run_attempt,
                 ''githubSha'' VALUE github_sha,
                 ''deployStatus'' VALUE deploy_status,
                 ''notes'' VALUE notes
                 RETURNING CLOB
               )
               RETURNING CLOB
             )
      FROM (
        SELECT *
        FROM   project_control
        ORDER  BY deployed_at DESC NULLS LAST
        FETCH FIRST 50 ROWS ONLY
      )
    ]'' INTO l_items;
  END IF;

  l_items := COALESCE(l_items, TO_CLOB(''[]''));

  SELECT JSON_OBJECT(
           ''items'' VALUE l_items FORMAT JSON
           RETURNING CLOB
         )
  INTO   l_json
  FROM   dual;

  OWA_UTIL.MIME_HEADER(''application/json'', FALSE);
  OWA_UTIL.HTTP_HEADER_CLOSE;
  FOR i IN 0 .. FLOOR((DBMS_LOB.GETLENGTH(l_json) - 1) / 30000) LOOP
    HTP.PRN(DBMS_LOB.SUBSTR(l_json, 30000, (i * 30000) + 1));
  END LOOP;
END;
');

  ORDS.CREATE_ROLE(
      p_role_name=> 'oracle.dbtools.role.autorest.' || l_current_schema || '');
  ORDS.CREATE_ROLE(
      p_role_name=> 'oracle.dbtools.role.autorest.any.' || l_current_schema || '');
  l_roles(1) := 'oracle.dbtools.auth.roles.builtin.VecDB';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.dbtools.auth.privileges.builtin.VecDB',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => NULL,
      p_description    => NULL,
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;

  l_roles(1) := 'oracle.dbtools.autorest.any.schema';
  l_roles(2) := 'oracle.dbtools.role.autorest.' || l_current_schema || '';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.dbtools.autorest.privilege.' || l_current_schema || '',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => '' || l_current_schema || ' metadata-catalog access',
      p_description    => 'Provides access to the metadata catalog of the objects in the ' || l_current_schema || ' schema.',
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;

  l_roles(1) := 'SODA Developer';
  l_patterns(1) := '/soda/*';

  ORDS.DEFINE_PRIVILEGE(
      p_privilege_name => 'oracle.soda.privilege.developer',
      p_roles          => l_roles,
      p_patterns       => l_patterns,
      p_modules        => l_modules,
      p_label          => NULL,
      p_description    => NULL,
      p_comments       => NULL); 

  l_roles.DELETE;
  l_modules.DELETE;
  l_patterns.DELETE;

  ORDS.FINALIZE_IMPORT(
      p_prune => FALSE,
      p_objects => null);

COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;

END;
/


