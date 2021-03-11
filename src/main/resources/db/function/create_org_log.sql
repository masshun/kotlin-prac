CREATE OR REPLACE FUNCTION create_org_log() RETURNS TRIGGER AS $$
DECLARE
  org record;
  newOrg record;
BEGIN
  SELECT org_id, org_name INTO org FROM m_organization WHERE org_id = OLD.org_id AND org_name = OLD.org_name;
  SELECT org_id, org_name INTO newOrg FROM m_organization WHERE org_id = NEW.org_id AND org_name = NEW.org_name;
  INSERT INTO l_org_log VALUES (nextval(l_log_id_seq), org.ord_id, org.org_name, newOrg.org_id, newOrg.Org_name);
END;
$$ LANGUAGE plpgsql;
