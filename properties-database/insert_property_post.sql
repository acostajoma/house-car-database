CREATE OR REPLACE FUNCTION insert_property_post_with_profile(
    profile_id UUID,
    property_post_area INT,
    property_post_canton TEXT,
    property_post_country TEXT,
    property_post_currency currency_type,
    property_post_district TEXT,
    property_post_expires_at TIMESTAMP WITH TIME ZONE,
    property_post_is_price_negotiable BOOLEAN,
    property_post_main_image_public_id TEXT,
    property_post_price INT,
    property_post_property_type property_type,
    property_post_published BOOLEAN,
    property_post_sale_type sale_type,
    property_post_state TEXT,
    property_post_images JSONB,
    property_post_address TEXT DEFAULT NULL,
    property_post_bathrooms INT DEFAULT NULL,
    property_post_bedrooms INT DEFAULT NULL,
    property_post_construction_area INT DEFAULT NULL,
    property_post_construction_year SMALLINT DEFAULT NULL,
    property_post_description TEXT DEFAULT NULL,
    property_post_floors SMALLINT DEFAULT NULL,
    property_post_latitude NUMERIC DEFAULT NULL,
    property_post_longitude NUMERIC DEFAULT NULL,
    property_post_rent_to_own_option BOOLEAN DEFAULT NULL
) RETURNS INT AS $$
DECLARE
    property_post_id INT;
BEGIN
    -- Insert property_post
    INSERT INTO property_post (
        address,
        area,
        bathrooms,
        bedrooms,
        canton,
        construction_area,
        construction_year,
        country,
        currency,
        description,
        district,
        expires_at,
        floors,
        is_price_negotiable,
        latitude,
        longitude,
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
        property_post_address,
        property_post_area,
        property_post_bathrooms,
        property_post_bedrooms,
        property_post_canton,
        property_post_construction_area,
        property_post_construction_year,
        property_post_country,
        property_post_currency,
        property_post_description,
        property_post_district,
        property_post_expires_at,
        property_post_floors,
        property_post_is_price_negotiable,
        property_post_latitude,
        property_post_longitude,
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
END;
$$ LANGUAGE plpgsql;
