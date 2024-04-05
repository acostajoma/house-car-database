CREATE TABLE favorite (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    property_post_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES profile(id) ON DELETE CASCADE,
    FOREIGN KEY (property_post_id) REFERENCES property_post(id) ON DELETE CASCADE
);

ALTER TABLE favorite ENABLE ROW LEVEL SECURITY;

-- Favorites Policies
CREATE POLICY "Favorites are only viewable by users who add them."
  ON favorite FOR SELECT
  USING (SELECT( auth.uid() )= user_id);

CREATE POLICY "Users can insert their own favorites."
  ON favorite FOR INSERT
  WITH CHECK (SELECT( auth.uid() ) = user_id);

CREATE POLICY "Users can update own favorites."
  ON favorite FOR UPDATE
  USING (SELECT( auth.uid() ) = user_id);

  CREATE POLICY "Favorites are only deletable by users who add them."
  ON favorite FOR DELETE
  USING (SELECT( auth.uid() ) = user_id);