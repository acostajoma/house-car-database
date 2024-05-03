CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE personal_data(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    profile_id UUID NOT NULL UNIQUE REFERENCES profile(id),
    name TEXT NOT NULL,
    last_name TEXT,
    email TEXT NOT NULL
);

-- Row Level Security
ALTER TABLE personal_data ENABLE ROW LEVEL SECURITY;

  -- Personal Information Policies
CREATE POLICY "Personal is viewable by users who created them."
  ON personal_data FOR SELECT
  USING ( ( SELECT auth.uid() ) = profile_id);

CREATE POLICY "Users can insert their own profile."
  ON personal_data FOR INSERT
  WITH CHECK ( ( SELECT auth.uid() ) = profile_id);

CREATE POLICY "Users can update own profile."
  ON personal_data FOR UPDATE
  USING ( ( SELECT auth.uid()) = profile_id);


  

-- Inserts a row into public.personal_data
-- CREATE OR REPLACE FUNCTION public.handle_new_personal_data()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     INSERT INTO public.personal_data (profile_id, name, last_name, email)

--EXAMPLE:
-- CREATE OR REPLACE FUNCTION public.handle_new_user()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     INSERT INTO public.profile (id, email, name, last_name, phone, is_admin)
--     VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data ->> 'name', NEW.raw_user_meta_data ->> 'last_name', NEW.raw_user_meta_data ->> 'phone', FALSE);
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql SECURITY DEFINER;