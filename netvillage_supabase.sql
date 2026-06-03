-- ════════════════════════════════════════════
--  NETVILLAGE — Script SQL complet v2
--  À exécuter dans Supabase > SQL Editor
-- ════════════════════════════════════════════

DROP TABLE IF EXISTS abonnes;

CREATE TABLE abonnes (
    id                UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
    nom               TEXT    NOT NULL,
    mois              INTEGER NOT NULL CHECK (mois >= 0 AND mois <= 11),
    montant           NUMERIC(10,2) NOT NULL DEFAULT 500,
    date_paiement     DATE    NOT NULL,   -- date fibre (activation routeur, commune au groupe)
    date_inscription  DATE    NOT NULL,   -- date perso d'inscription de cet abonné
    created_at        TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_mois          ON abonnes(mois);
CREATE INDEX idx_inscription   ON abonnes(date_inscription);
CREATE INDEX idx_paiement      ON abonnes(date_paiement);

ALTER TABLE abonnes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "acces_public" ON abonnes
    FOR ALL USING (true) WITH CHECK (true);

-- Vérification
SELECT column_name, data_type FROM information_schema.columns
WHERE table_name = 'abonnes' ORDER BY ordinal_position;
