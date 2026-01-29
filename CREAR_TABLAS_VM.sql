-- =====================================================
-- TABLAS PARA VENTILACION MECANICA (VAP/NAV)
-- Ejecutar en Supabase SQL Editor
-- =====================================================

-- Tabla de pacientes con ventilacion mecanica
CREATE TABLE vm_patients (
    id SERIAL PRIMARY KEY,
    document VARCHAR(50) NOT NULL,
    name VARCHAR(200) NOT NULL,
    service VARCHAR(100),
    bed VARCHAR(20),
    insertion_date DATE NOT NULL,
    -- Datos especificos VM
    tubo_tipo VARCHAR(50), -- TET, TRAQUEOSTOMIA
    tubo_numero VARCHAR(10), -- 3.0, 3.5, 4.0, etc
    tubo_fijacion VARCHAR(10), -- cm en comisura
    tubo_con_cuff BOOLEAN DEFAULT FALSE,
    modo_vm VARCHAR(50), -- SIMV, AC, CPAP, PSV, etc
    indicacion_vm VARCHAR(200),
    -- Estado
    vm_removed BOOLEAN DEFAULT FALSE,
    removal_date DATE,
    removal_reason VARCHAR(200),
    total_vm_days INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabla de auditorias/seguimientos de VM
CREATE TABLE vm_audits (
    id SERIAL PRIMARY KEY,
    patient_doc VARCHAR(50) NOT NULL,
    audit_type VARCHAR(50) NOT NULL, -- primera_vez, seguimiento, retiro
    auditor VARCHAR(200),
    bed VARCHAR(20),
    vm_days INTEGER,
    bundle_data JSONB,
    compliance INTEGER,
    needs_attention BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indices para mejor performance
CREATE INDEX idx_vm_patients_document ON vm_patients(document);
CREATE INDEX idx_vm_patients_removed ON vm_patients(vm_removed);
CREATE INDEX idx_vm_audits_patient_doc ON vm_audits(patient_doc);
CREATE INDEX idx_vm_audits_created_at ON vm_audits(created_at);

-- Habilitar RLS
ALTER TABLE vm_patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE vm_audits ENABLE ROW LEVEL SECURITY;

-- Politicas de acceso
CREATE POLICY "Allow all for vm_patients" ON vm_patients FOR ALL USING (true);
CREATE POLICY "Allow all for vm_audits" ON vm_audits FOR ALL USING (true);

-- =====================================================
-- VERIFICACION
-- =====================================================
-- SELECT * FROM vm_patients LIMIT 1;
-- SELECT * FROM vm_audits LIMIT 1;
