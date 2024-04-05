CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- TABLE
CREATE TABLE profile (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    last_name TEXT,
    phone TEXT NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE
);

-- Row Level Security
ALTER TABLE profile ENABLE ROW LEVEL SECURITY;

-- Profile Policies
CREATE POLICY "Profiles are viewable by users who created them."
  ON profile FOR SELECT
  USING ( ( SELECT auth.uid() ) = id);

CREATE POLICY "Users can insert their own profile."
  ON profile FOR INSERT
  WITH CHECK ( ( SELECT auth.uid() ) = id);

CREATE POLICY "Users can update own profile."
  ON profile FOR UPDATE
  USING ( ( SELECT auth.uid()) = id);

-- Inserts a row into public.profiles
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profile (id, email, name, last_name, phone, is_admin)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data ->> 'name', NEW.raw_user_meta_data ->> 'last_name', NEW.raw_user_meta_data ->> 'phone', FALSE);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Auth Trigger
CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- Delete User Hook
CREATE OR REPLACE FUNCTION public.handle_user_delete()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM auth.users WHERE id = OLD.id;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- User deletion trigger
CREATE OR REPLACE TRIGGER on_profile_user_deleted
  AFTER DELETE ON public.profile
  FOR EACH ROW EXECUTE PROCEDURE public.handle_user_delete();