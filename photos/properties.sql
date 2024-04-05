CREATE TABLE photo (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL,
    property_post_id INT NOT NULL,
    owner_id UUID NOT NULL,
    FOREIGN KEY (property_post_id) REFERENCES property_post(id) ON DELETE CASCADE
);

ALTER TABLE photo ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Photo is viewable by everyone." ON photo FOR
SELECT
  USING (TRUE);

CREATE POLICY "Users can insert their own photos."
  ON photo FOR INSERT
  WITH CHECK (SELECT( auth.uid() ) = owner_id);

CREATE POLICY "Users can update own photos."
  ON photo FOR UPDATE
  USING (SELECT( auth.uid() ) = owner_id);

  CREATE POLICY "Photo is deletable by owner." ON photo FOR
DELETE  USING (
    SELECT( auth.uid() ) = owner_id
);