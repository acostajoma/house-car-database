-- COUNTRY
INSERT INTO country (id, name)
  VALUES (1, 'Costa Rica');

-- STATES
INSERT INTO state (id, name, country_id)
VALUES
    (11, 'San José', 1),
    (12, 'Alajuela', 1),
    (13, 'Cartago', 1),
    (14, 'Heredia', 1),
    (15, 'Guanacaste', 1),
    (16, 'Puntarenas', 1),
    (17, 'Limón', 1);

