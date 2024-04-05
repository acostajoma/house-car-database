-- ENUM
CREATE  OR ALTER TYPE combustible_type AS ENUM ( 'Super', 'Regular','Diésel', 'Eléctrico', 'Híbrido', 'Gas GLP');

CREATE OR ALTER TYPE car_category AS ENUM ('Automóvil', 'Buseta', 'Convertible', 'Coupé', 'Deportivo', 'Hatchback', 'Mini Van', 'Pickup', 'SUV', 'Sedán');

CREATE OR ALTER TYPE currency_type AS ENUM ('Colónes', 'Dólares');