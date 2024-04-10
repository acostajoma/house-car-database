CREATE OR REPLACE FUNCTION insert_property_post_with_profile(
    profile_id UUID,
    property_post_area NUMERIC(10, 2),
    property_post_canton TEXT,
    property_post_country TEXT,
    property_post_currency currency_type,
    property_post_district TEXT,
    property_post_expires_at TIMESTAMP WITH TIME ZONE,
    property_post_is_price_negotiable BOOLEAN,
    property_post_main_image_public_id TEXT,
    property_post_price NUMERIC(12, 2),
    property_post_property_type property_type,
    property_post_published BOOLEAN,
    property_post_sale_type sale_type,
    property_post_state TEXT,
    property_post_images TEXT[],
    property_post_address TEXT DEFAULT NULL,
    property_post_bathrooms NUMERIC(12, 1) DEFAULT NULL,
    property_post_bedrooms INT DEFAULT NULL,
    property_post_construction_area NUMERIC(10, 2) DEFAULT NULL,
    property_post_construction_year SMALLINT DEFAULT NULL,
    property_post_description TEXT DEFAULT NULL,
    property_post_floors INT DEFAULT NULL,
    property_post_latitude NUMERIC(9, 6) DEFAULT NULL,
    property_post_longitude NUMERIC(9, 6) DEFAULT NULL,
    property_post_rent_to_own_option BOOLEAN DEFAULT NULL
) RETURNS INT AS $$
DECLARE
    property_post_id INT;
BEGIN
    -- Insert property_post
    INSERT INTO property_post (
        area,
        bathrooms,
        bedrooms,
        canton,
        country,
        currency,
        district,
        expires_at,
        is_price_negotiable,
        main_image_public_id,
        owner_id,
        price,
        property_type,
        published,
        rent_to_own_option,
        sale_type,
        state
    )
    VALUES (
        property_post_area,
        property_post_bathrooms,
        property_post_bedrooms,
        property_post_canton,
        property_post_country,
        property_post_currency,
        property_post_district,
        property_post_expires_at,
        property_post_is_price_negotiable,
        property_post_main_image_public_id,
        profile_id,
        property_post_price,
        property_post_property_type,
        property_post_published,
        property_post_rent_to_own_option,
        property_post_sale_type,
        property_post_state
    )
    RETURNING id INTO property_post_id;
    
    -- Insert on property_additional_info with sane post id
    INSERT INTO property_additional_info (
        property_post_id,
        owner_id,
        address,
        latitude,
        longitude,
        construction_area,
        construction_year,
        floors,
        description
    )
    VALUES (
        property_post_id,
        profile_id,
        property_post_address,
        property_post_latitude,
        property_post_longitude,
        property_post_construction_area,
        property_post_construction_year,
        property_post_floors,
        property_post_description
    );

    -- Insert on photo with same ID
    INSERT INTO photo (
        data,
        property_post_id,
        owner_id
    )
    VALUES(
        property_post_images,
        property_post_id,
        profile_id
    );

    RETURN property_post_id;

EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'No se ha cumplido con alguno de los requisitos.';
        -- Handle the unique violation exception
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'Una relacion con llave foranea no se ha cumplido';
        -- Handle the foreign key violation exception
    WHEN others THEN
        RAISE NOTICE 'Ha ocurrido un error inesperado';
        -- Handle other exceptions
END;
$$ LANGUAGE plpgsql;
