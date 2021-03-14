CREATE OR REPLACE FUNCTION create_org_log() RETURNS TRIGGER AS $$
DECLARE
  rec record;
  log record;
BEGIN
  IF (TG_OP = 'INSERT') THEN
    SELECT org_id, org_name INTO rec FROM m_organization WHERE org_id = NEW.org_id AND org_name = NEW.org_name;
    SELECT old_org_id, old_org_name INTO log FROM l_org_log WHERE old_org_id = rec.org_id AND old_org_name = rec.org_name;

    IF log IS NULL THEN
        INSERT INTO l_org_log(log_id, new_org_id, new_org_name, created_at, updated_at) VALUES
            (nextval('log_id_seq'), rec.org_id, rec.org_name, now(), now());
    ELSE
        UPDATE l_org_log SET old_org_id = log_old_org_id, old_org_name = log_old_org_name,
         new_org_id = rec_org_id, new_org_name = rec_org_name, updated_at = now() WHERE log_id = log_log_id;
    END IF;

  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
