DO $$
BEGIN
    -- Verificar y crear/alterar la política para SELECT
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Property Posts are viewable by everyone.' AND tablename = 'property_post') THEN
        ALTER POLICY "Property Posts are viewable by everyone." ON property_post
        USING (
            (SELECT auth.uid()) = owner_id
            OR published
        );
    ELSE
        CREATE POLICY "Property Posts are viewable by everyone." ON property_post FOR SELECT
        USING (
            (SELECT auth.uid()) = owner_id
            OR published
        );
    END IF;

    -- Verificar y crear/alterar la política para INSERT
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Users can insert their own Property posts.' AND tablename = 'property_post') THEN
        ALTER POLICY "Users can insert their own Property posts." ON property_post
        WITH CHECK (
            (SELECT auth.uid()) = owner_id
            AND NOT published
        );
    ELSE
        CREATE POLICY "Users can insert their own Property posts." ON property_post FOR INSERT
        WITH CHECK (
            (SELECT auth.uid()) = owner_id
            AND NOT published
        );
    END IF;

    -- Verificar y crear/alterar la política para UPDATE
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Users can update their own Property post.' AND tablename = 'property_post') THEN
        ALTER POLICY "Users can update their own Property post." ON property_post
        USING (
            (SELECT auth.uid()) = owner_id
            AND NOT published
        );
    ELSE
        CREATE POLICY "Users can update their own Property post." ON property_post FOR UPDATE
        USING (
            (SELECT auth.uid()) = owner_id
            AND NOT published
        );
    END IF;

    -- Verificar y crear/alterar la política para DELETE
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Property Posts can be deleted by owner.' AND tablename = 'property_post') THEN
        ALTER POLICY "Property Posts can be deleted by owner." ON property_post
        USING (
            (SELECT auth.uid()) = owner_id
        );
    ELSE
        CREATE POLICY "Property Posts can be deleted by owner." ON property_post FOR DELETE
        USING (
            (SELECT auth.uid()) = owner_id
        );
    END IF;
END
$$;


DO $$
BEGIN
    -- Verificar y crear/alterar la política para SELECT
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Property additional info is viewable by everyone.' AND tablename = 'property_additional_info') THEN
        ALTER POLICY "Property additional info is viewable by everyone." ON property_additional_info
        USING ( TRUE );
    ELSE
        CREATE POLICY "Property additional info is viewable by everyone." ON property_additional_info FOR SELECT
        USING ( TRUE );
    END IF;

    -- Verificar y crear/alterar la política para INSERT
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Users can insert their own Property additional info.' AND tablename = 'property_additional_info') THEN
        ALTER POLICY "Users can insert their own Property additional info." ON property_additional_info
        WITH CHECK (
            (SELECT auth.uid()) = owner_id
        );
    ELSE
        CREATE POLICY "Users can insert their own Property additional info." ON property_additional_info FOR INSERT
        WITH CHECK (
            (SELECT auth.uid()) = owner_id
        );
    END IF;

    -- Verificar y crear/alterar la política para UPDATE
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Users can update their own Property additional info.' AND tablename = 'property_additional_info') THEN
        ALTER POLICY "Users can update their own Property additional info." ON property_additional_info
        USING (
            (SELECT auth.uid()) = owner_id
        );
    ELSE
        CREATE POLICY "Users can update their own Property additional info." ON property_additional_info FOR UPDATE
        USING (
            (SELECT auth.uid()) = owner_id
        );
    END IF;

    -- Verificar y crear/alterar la política para DELETE
    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Property additional info can be deleted by owner.' AND tablename = 'property_additional_info') THEN
        ALTER POLICY "Property additional info can be deleted by owner." ON property_additional_info
        USING (
            (SELECT auth.uid()) = owner_id
        );
    ELSE
        CREATE POLICY "Property additional info can be deleted by owner." ON property_additional_info FOR DELETE
        USING (
            (SELECT auth.uid()) = owner_id
        );
    END IF;
END
$$;
