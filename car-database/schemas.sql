CREATE TABLE carpost (
    id SERIAL PRIMARY KEY,
    category car_category NOT NULL,
    combustible combustible_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    currency currency_type NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    exterior_color TEXT NOT NULL,
    is_automatic_transmission BOOLEAN NOT NULL,
    kilometers INT NOT NULL,
    location_id INT NOT NULL,
    main_image_public_id TEXT NOT NULL,
    make TEXT  NOT NULL,
    model TEXT  NOT NULL,
    owner_id UUID NOT NULL,
    passengers SMALLINT,
    price INT NOT NULL,
    published BOOLEAN NOT NULL DEFAULT FALSE,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    year SMALLINT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES location(id),
    FOREIGN KEY (owner_id) REFERENCES profile(id) ON DELETE CASCADE
);

CREATE TABLE carpost_additional_information(
  id SERIAL PRIMARY KEY,
  carpost_id INT UNIQUE,
  drive_type TEXT,
  interior_color TEXT,
  is_price_negotiable BOOLEAN NOT NULL,
  motor_size SMALLINT,
  owner_id UUID NOT NULL,
  plaque_ending_number CHAR(1),
  seats_material TEXT,
  sunroof BOOLEAN,
  FOREIGN KEY (owner_id) REFERENCES profile(id) ON DELETE CASCADE,
  FOREIGN KEY (carpost_id) REFERENCES carpost(id) ON DELETE CASCADE
); 

-- Create indexes
CREATE INDEX idx_carpost_additional_information_owner_id ON carpost(owner_id);
CREATE INDEX idx_carpost_location_id ON carpost(location_id);
CREATE INDEX idx_carpost_additional_information_carpost ON carpost_additional_information(carpost_id);
CREATE INDEX idx_carpost_make ON carpost(make);
CREATE INDEX idx_photo_carpost ON photo(carpost_id);


-- CAR POST POLICIES
CREATE POLICY "Car Posts are viewable by everyone." ON carpost FOR
SELECT
  USING (TRUE);

CREATE POLICY "Users can insert their own Car posts." ON carpost FOR INSERT
WITH CHECK (
  auth.uid() = owner_id
  AND NOT published
);

CREATE POLICY "Users can update their own Car post." ON carpost
FOR UPDATE
  USING (
    auth.uid() = owner_id
    AND NOT published
  );

-- Car additional Informatio policies
CREATE POLICY "Car Additional info is viewable by everyone." ON carpost_additional_information FOR
SELECT
  USING (TRUE);

CREATE POLICY "Users can insert their own car additional info." ON carpost_additional_information FOR INSERT
WITH CHECK (
  auth.uid() = owner_id
);

CREATE POLICY "Users can update their own car additional info." ON carpost_additional_information
FOR UPDATE
  USING (
    auth.uid() = owner_id
  );


-- Row Level Security
ALTER TABLE carpost ENABLE ROW LEVEL SECURITY;
ALTER TABLE carpost_additional_information ENABLE ROW LEVEL SECURITY;