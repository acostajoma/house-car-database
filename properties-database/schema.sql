CREATE TABLE property_post (
    -- Keys
    id SERIAL PRIMARY KEY,
    property_type property_type NOT NULL, -- 'Apartamento', 'Bodega', 'Casa', 'Terreno'
    sale_type sale_type NOT NULL, -- 'Alquiler', 'Venta', 'Ambos'
    
    -- Location
    country TEXT NOT NULL,
    state TEXT NOT NULL,
    canton TEXT NOT NULL,
    district TEXT NOT NULL,
      
    -- Información financiera
    price NUMERIC(12, 2) NOT NULL,
    currency currency_type NOT NULL, -- 'Colónes', 'Dólares'
    is_price_negotiable BOOLEAN NOT NULL,
    rent_to_own_option BOOLEAN DEFAULT FALSE, -- Aplicable si sale_type = 'alquiler'
    
    -- Detalles de la propiedad
    area NUMERIC(10, 2) NOT NULL, -- Área total del terreno
    -- Los siguientes campos son específicos para casas o apartamentos
    bedrooms INTEGER,
    bathrooms NUMERIC(12, 1),
    
    -- Additional data
    published BOOLEAN NOT NULL DEFAULT FALSE,
    main_image_public_id TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    
    -- Relations
    owner_id UUID NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES profile(id) ON DELETE CASCADE
);

ALTER TABLE property_post ENABLE ROW LEVEL SECURITY;


CREATE TABLE property_additional_info (
    -- Keys
    id SERIAL PRIMARY KEY,
    property_post_id INT NOT NULL UNIQUE,
    owner_id UUID NOT NULL,
    
    -- Location
    address TEXT,
    latitude NUMERIC(9, 6),
    longitude NUMERIC(9, 6),

    -- Data for Houses
    construction_area NUMERIC(10, 2), -- Área de construcción
    construction_year INTEGER,
    floors INTEGER,

    -- Additional data
    description TEXT,
    rejected_post BOOLEAN,



    -- Relations
    FOREIGN KEY (owner_id) REFERENCES profile(id) ON DELETE CASCADE,
    FOREIGN KEY (property_post_id) REFERENCES property_post(id) ON DELETE CASCADE
);

ALTER TABLE property_additional_info ENABLE ROW LEVEL SECURITY;