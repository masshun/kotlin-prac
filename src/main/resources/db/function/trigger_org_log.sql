CREATE TRIGGER org_log_trigger
AFTER INSERT OR UPDATE ON m_organization FOR EACH ROW EXECUTE PROCEDURE create_org_log()
