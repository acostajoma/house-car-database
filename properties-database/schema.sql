CREATE TABLE property_post (
    -- Identificación y tipo de propiedad
    id SERIAL PRIMARY KEY,
    property_type property_type NOT NULL, -- 'Apartamento', 'Bodega', 'Casa', 'Terreno'
    sale_type sale_type NOT NULL, -- 'Alquiler', 'Venta', 'Ambos'
    
    -- Ubicación
    country TEXT NOT NULL,
    state TEXT NOT NULL,
    canton TEXT NOT NULL,
    district TEXT NOT NULL,
    address TEXT,
    latitude NUMERIC(9, 6),
    longitude NUMERIC(9, 6),
    
    -- Información financiera
    price NUMERIC(12, 2) NOT NULL,
    currency currency_type NOT NULL, -- 'Colónes', 'Dólares'
    is_price_negotiable BOOLEAN NOT NULL,
    rent_to_own_option BOOLEAN DEFAULT FALSE, -- Aplicable si sale_type = 'alquiler'
    
    -- Detalles de la propiedad
    area NUMERIC(10, 2) NOT NULL, -- Área total del terreno
    -- Los siguientes campos son específicos para casas o apartamentos
    bedrooms INTEGER,
    bathrooms INTEGER,
    construction_area NUMERIC(10, 2), -- Área de construcción
    construction_year INTEGER,
    floors INTEGER,
    
    -- Información adicional
    description TEXT,
    published BOOLEAN NOT NULL DEFAULT FALSE,
    main_image_public_id TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL WITH TIME ZONE NOT NULL,
    
    -- Relaciones
    owner_id UUID NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES profile(id) ON DELETE CASCADE
);

ALTER TABLE property_post ENABLE ROW LEVEL SECURITY;
