CREATE OR REPLACE FUNCTION insert_carpost_with_profile(
    profile_id UUID,
    carpost_category car_category,
    carpost_combustible combustible_type,
    carpost_currency currency_type,
    carpost_expires_at TIMESTAMP WITH TIME ZONE,
    carpost_exterior_color TEXT,
    carpost_is_automatic_transmission BOOLEAN,
    carpost_kilometers INT,
    carpost_location_id INT,
    carpost_main_image_path TEXT,
    carpost_make TEXT,
    carpost_model TEXT,
    carpost_passengers SMALLINT,
    carpost_price INT,
    carpost_year SMALLINT,
    additional_information_is_price_negotiable BOOLEAN,
    additional_information_plaque_ending_number CHAR(1),
    photo_data JSONB,
    additional_information_seats_material TEXT DEFAULT NULL,
    additional_information_interior_color TEXT DEFAULT NULL,
    additional_information_sunroof BOOLEAN DEFAULT NULL,
    additional_information_drive_type TEXT DEFAULT NULL,
    additional_information_motor_size SMALLINT DEFAULT NULL
) RETURNS INT AS $$
DECLARE
    carpost_id INT;
BEGIN
    -- Insert carpost
    INSERT INTO carpost (category, combustible, currency, expires_at, exterior_color, is_automatic_transmission, kilometers, location_id, main_image_path, make, model, owner_id, passengers, price, year)
    VALUES (carpost_category, carpost_combustible, carpost_currency, carpost_expires_at, carpost_exterior_color, carpost_is_automatic_transmission, carpost_kilometers, carpost_location_id, carpost_main_image_path, carpost_make, carpost_model, profile_id, carpost_passengers, carpost_price, carpost_year)
    RETURNING id INTO carpost_id;

    -- Insert carpost_additional_information
    INSERT INTO carpost_additional_information (carpost_id, drive_type, interior_color, is_price_negotiable, motor_size, owner_id, plaque_ending_number, seats_material, sunroof)
    VALUES (carpost_id, additional_information_drive_type, additional_information_interior_color, additional_information_is_price_negotiable, additional_information_motor_size, profile_id, additional_information_plaque_ending_number, additional_information_seats_material, additional_information_sunroof);

    -- Insert photo
    INSERT INTO photo (data, carpost_id, owner_id)
    VALUES (photo_data, carpost_id, profile_id);

    RETURN carpost_id;
END;
$$ LANGUAGE plpgsql;
