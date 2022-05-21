DESCRIBE medicament;

-- alternativni prikaz:

SHOW COLUMNS FROM medicament;



-- Příklad optimalizace dotazu
SELECT * FROM list_of_medicaments lom WHERE amount = 3;


CREATE INDEX medicament_amount_index ON list_of_medicaments USING hash (amount);