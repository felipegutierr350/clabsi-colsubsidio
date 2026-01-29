-- =====================================================
-- TABLAS PARA SONDA VESICAL (CAUTI)
-- Ejecutar en Supabase SQL Editor
-- =====================================================

-- Tabla de pacientes con sonda vesical
CREATE TABLE sonda_patients (
    id SERIAL PRIMARY KEY,
    document VARCHAR(50) NOT NULL,
    name VARCHAR(200) NOT NULL,
    service VARCHAR(100),
    bed VARCHAR(20),
    insertion_date DATE NOT NULL,
    sonda_tipo VARCHAR(50), -- FOLEY 2 VIAS, FOLEY 3 VIAS, SILICONA, NELATON
    sonda_calibre VARCHAR(10), -- 6, 8, 10, 12, 14, 16, 18, 20 Fr
    sonda_indicacion VARCHAR(100), -- RETENCION_URINARIA, CONTROL_DIURESIS, etc
    sonda_removed BOOLEAN DEFAULT FALSE,
    removal_date DATE,
    removal_reason VARCHAR(200),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de auditorias/seguimientos de sonda
CREATE TABLE sonda_audits (
    id SERIAL PRIMARY KEY,
    patient_doc VARCHAR(50) NOT NULL,
    audit_type VARCHAR(50) NOT NULL, -- primera_vez, seguimiento, retiro
    auditor VARCHAR(200),
    bed VARCHAR(20),
    sonda_days INTEGER,
    bundle_data JSONB,
    compliance INTEGER,
    needs_attention BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indices para mejor performance
CREATE INDEX idx_sonda_patients_document ON sonda_patients(document);
CREATE INDEX idx_sonda_patients_removed ON sonda_patients(sonda_removed);
CREATE INDEX idx_sonda_audits_patient_doc ON sonda_audits(patient_doc);
CREATE INDEX idx_sonda_audits_created_at ON sonda_audits(created_at);

-- Habilitar RLS (Row Level Security)
ALTER TABLE sonda_patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE sonda_audits ENABLE ROW LEVEL SECURITY;

-- Politicas de acceso (permitir todo para anon key)
CREATE POLICY "Allow all for sonda_patients" ON sonda_patients FOR ALL USING (true);
CREATE POLICY "Allow all for sonda_audits" ON sonda_audits FOR ALL USING (true);

-- =====================================================
-- VERIFICACION
-- =====================================================
-- Despues de ejecutar, verifica con:
-- SELECT * FROM sonda_patients LIMIT 1;
-- SELECT * FROM sonda_audits LIMIT 1;
