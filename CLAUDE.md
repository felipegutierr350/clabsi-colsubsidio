# CLAUDE.md - Sistema IAAS Colsubsidio

## SECCION FIJA - CONTEXTO DEL PROYECTO

### Descripcion
Sistema de prevencion de Infecciones Asociadas a la Atencion en Salud (IAAS) para UCI Pediatrica de Clinica Infantil Colsubsidio. Incluye tracking y bundles para:
- **CVC (CLABSI)** - Cateter Venoso Central
- **Sonda Vesical (CAUTI)** - Infeccion urinaria asociada a sonda
- **Ventilacion Mecanica (NAV/VAP)** - Neumonia asociada a ventilador

### Stack Tecnologico
- Frontend: HTML/CSS/JavaScript vanilla (single-page app)
- Backend: Supabase (PostgreSQL + API REST)
- Hosting: Vercel
- Repositorio: GitHub

### URLs Importantes
- **Produccion**: https://iaas-colsubsidio.vercel.app/index-iaas-completo.html
- **GitHub**: https://github.com/felipegutierr350/clabsi-colsubsidio
- **Supabase**: https://fiiqzezridpckpsueuew.supabase.co

### Archivos Principales
| Archivo | Descripcion |
|---------|-------------|
| `index-iaas-completo.html` | Sistema principal con 3 dispositivos |
| `index-integrado.html` | Sistema CVC + Sonda (version anterior) |
| `index.html` | Sistema solo CVC (original) |
| `admin-integrado.html` | Panel administrador |
| `CREAR_TABLAS_SONDA.sql` | SQL para tablas sonda |
| `CREAR_TABLAS_VM.sql` | SQL para tablas VM |

### Tablas Supabase
- `patients` / `audits` - CVC
- `sonda_patients` / `sonda_audits` - Sonda Vesical
- `vm_patients` / `vm_audits` - Ventilacion Mecanica

### Colores Institucionales
- Amarillo Colsubsidio: `#FDB913`
- Azul: `#003DA5`
- Azul oscuro: `#001F5C`
- CVC: `#3B82F6` (azul)
- Sonda: `#10B981` (verde)
- VM: `#F59E0B` (naranja)

---

## SECCION VARIABLE - ULTIMA SESION

### Estado Actual: EN PRODUCCION

**Ultima actualizacion**: 2026-01-29

**Sistema funcional con**:
- 3 dispositivos integrados (CVC, Sonda, VM)
- 4 dashboards (Todos, CVC, Sonda, VM)
- Sistema completo de curacion CVC
- Responsive design para movil
- Alertas automaticas

---

## HISTORIAL DE SESIONES

---

## SESION 2026-01-29 ~22:00

### CAMBIOS REALIZADOS
- **index-iaas-completo.html**:
  - Agregado boton DASHBOARD UCI grande
  - Cambiado colores de morado a amarillo/azul Colsubsidio
  - Agregado boton "Volver" en dashboard
  - Creados 4 dashboards separados: TODAS, CVC, SONDA, VM
  - Sistema completo de curacion CVC (tipo aposito, estado, fecha, alertas)
  - Responsive design completo (768px, 480px, 380px breakpoints)

### BUGS CORREGIDOS
- **Boton dashboard morado**: Cambiado a colores institucionales (amarillo/azul)
- **Falta de alertas CVC**: Agregado sistema completo de curacion con:
  - Tracking tipo aposito (Transparente 7d / Gasa 48h)
  - Estado aposito (Optimo/Despegado/Humedo)
  - Visibilidad punto insercion
  - Alertas urgentes automaticas
  - Calculo dias desde ultima curacion

### PENDIENTES
- Agregar columna `dressing_type` en tabla `patients` si no existe:
  ```sql
  ALTER TABLE patients ADD COLUMN IF NOT EXISTS dressing_type VARCHAR(20);
  ```
- Actualizar admin-integrado.html para 3 dispositivos
- Agregar historial de curaciones (tabla `dressing_history`)

### NOTAS IMPORTANTES
- Bundle NAV basado en SHEA/IDSA 2022, IHI (7 componentes)
- Protocolo curacion: Transparente cada 7 dias, Gasa cada 48h
- UCI tiene 13 camas (1-13)
- Password admin: iaas2025

### COMANDOS/COMMITS
```bash
# Commits realizados:
925dc06 - Add complete IAAS system with 3 devices (CVC, Sonda, VM)
bf472c3 - Add Dashboard UCI with 13 beds visual grid
33489ca - Fix dashboard colors to match Colsubsidio branding
daa83b1 - Add back button at top of dashboard
b1bdcbc - Add complete dressing/curation system and separate dashboards
efd5978 - Complete responsive design for mobile devices

# Deploy:
vercel --prod --yes
```

### ESTADO
- Compila: SI
- En produccion: SI
- URL: https://iaas-colsubsidio.vercel.app/index-iaas-completo.html
- Responsive: SI (probado 768px, 480px, 380px)

---
