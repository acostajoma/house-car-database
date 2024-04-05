DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'property_type') THEN
        CREATE TYPE property_type AS ENUM ('Apartamento', 'Bodega', 'Casa', 'Terreno');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'currency_type') THEN
        CREATE TYPE currency_type AS ENUM ('CRC', 'USD');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sale_type') THEN
        CREATE TYPE sale_type AS ENUM ('Alquiler', 'Venta', 'Ambos');
    END IF;
END
$$;