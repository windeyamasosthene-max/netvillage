-- ════════════════════════════════════════════
--  NETVILLAGE — Script SQL complet
--  À exécuter dans Supabase > SQL Editor
-- ════════════════════════════════════════════

-- 1. Supprimer l'ancienne table si elle existe
DROP TABLE IF EXISTS abonnes;

-- 2. Créer la nouvelle table
CREATE TABLE abonnes (
    id              UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nom             TEXT NOT NULL,
    mois            INTEGER NOT NULL CHECK (mois >= 0 AND mois <= 11),
    montant         NUMERIC(10,2) NOT NULL DEFAULT 500,
    date_paiement   DATE NOT NULL,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Index pour accélérer les filtres par mois
CREATE INDEX idx_abonnes_mois ON abonnes(mois);

-- 4. Activer Row Level Security (sécurité)
ALTER TABLE abonnes ENABLE ROW LEVEL SECURITY;

-- 5. Politique : autoriser toutes les opérations avec la clé anon
CREATE POLICY "acces_public" ON abonnes
    FOR ALL
    USING (true)
    WITH CHECK (true);

-- ════════════════════════════════════════════
--  VÉRIFICATION : liste les colonnes créées
-- ════════════════════════════════════════════
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'abonnes'
ORDER BY ordinal_position;
