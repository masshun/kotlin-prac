DROP FUNCTION IF EXISTS add_producer(VARCHAR(30)[]);

CREATE OR REPLACE FUNCTION add_producer(nms VARCHAR(30)[])
RETURNS VOID AS $$
    DECLARE
        nm VARCHAR(30);
        idx INTEGER;
    BEGIN
        FOR idx IN SELECT generate_subscripts(nms, 1)
        LOOP
            INSERT INTO public.m_producer(producer_id, name, created_at, updated_at)
                VALUES(idx, nms[idx], now(), now());
            RAISE NOTICE 'element % = %', idx, nms[idx];
        END LOOP;
    END;
$$ LANGUAGE plpgsql;
