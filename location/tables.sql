CREATE TABLE country (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE state (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(id) ON DELETE CASCADE
);

CREATE TABLE canton (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    state_id INT NOT NULL,
    FOREIGN KEY (state_id) REFERENCES state(id) ON DELETE CASCADE
);


CREATE TABLE district (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    canton_id INT NOT NULL,
    FOREIGN KEY (canton_id) REFERENCES canton(id) ON DELETE CASCADE
);


ALTER TABLE country ENABLE ROW LEVEL SECURITY;
ALTER TABLE state ENABLE ROW LEVEL SECURITY;
ALTER TABLE canton ENABLE ROW LEVEL SECURITY;
ALTER TABLE district ENABLE ROW LEVEL SECURITY;

-- Location and related policies
  
CREATE POLICY "District is viewable by everyone." ON district FOR
SELECT
  USING (TRUE);

CREATE POLICY "Canton is viewable by everyone." ON canton FOR
SELECT
  USING (TRUE);

CREATE POLICY "State is viewable by everyone." ON state FOR
SELECT
  USING (TRUE);

CREATE POLICY "Country is viewable by everyone." ON country FOR
SELECT
  USING (TRUE);
