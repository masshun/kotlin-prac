DROP FUNCTION IF EXISTS add_product(VARCHAR(30)[]);

CREATE OR REPLACE FUNCTION add_product(nms VARCHAR(30)[])
RETURNS VOID AS $$
    DECLARE
        nm VARCHAR(30);
        idx INTEGER;
    BEGIN
        FOR idx IN SELECT generate_subscripts(nms, 1)
        LOOP
            INSERT INTO public.m_product(product_id, name, price, created_at, updated_at)
                VALUES(idx, nms[idx], random() * (5000 + 1  - 1000), now(), now());
            RAISE NOTICE 'element % = %', idx, nms[idx];
        END LOOP;
    END;
$$ LANGUAGE plpgsql;

