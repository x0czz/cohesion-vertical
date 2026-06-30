## Sobre este repositorio

Este repositorio contiene el informe del trabajo final del curso de **Ciencia Social Abierta**, correspondiente a la Facultad de Ciencias Sociales (FACSO). El trabajo aborda la **confianza institucional**, analizada mediante **modelado multinivel**.

Informe completo disponible en: https://x0czz.github.io/cohesion-vertical/

### Bases de datos

- `ELSOC_variables_estudio.rds`: base de datos original con las variables de estudio.
- `data_f_regresion.rds`: base de datos tratada (variables procesadas para el análisis).
- `data_centrada_regresion.rds`: base de datos centrada, usada en los modelos de regresión.

### Scripts de procesamiento

Los siguientes archivos `.qmd` dentro de `procesamiento/` contienen el código y la explicación del tratamiento de variables:

- `Preparacion.qmd`: preparación y limpieza de las bases de datos.
- `descriptivo_bivariado.qmd`: análisis descriptivo y bivariado de las variables.
- `analisis.qmd`: análisis de regresión y resultados del modelo.

Estos documentos generan las salidas (gráficos y tablas) que se encuentran en:
- `output/graphs/` y `output/tables/` en la raíz del proyecto.

(Estas carpetas no muestran su contenido completo en el árbol de abajo porque los archivos `.html` están omitidos del listado automático.)

<!--START_TREE-->
```
.
|-- 01-introduccion.qmd
|-- 02-antecedentes.qmd
|-- 03-hipotesis.qmd
|-- 04-metodos.qmd
|-- 05-resultados.qmd
|-- 06-conclusiones.qmd
|-- README.md
|-- _metadata.yml
|-- _quarto.yml
|-- apendices
|   |-- A-encuestas.qmd
|   `-- B-tablas.qmd
|-- assets
|   |-- cover.png
|   |-- favicon-2025-20251031.svg
|   |-- favicon.svg
|   |-- file.svg
|   |-- sharing-default.png
|   `-- styles.scss
|-- includes
|   |-- backmatter.tex
|   |-- cover-config.tex
|   |-- pdf-config-scrbook.yml
|   |-- preamble.tex
|   |-- reference.docx
|   |-- reportes-facso-plantilla.tex
|   `-- title-pdf.tex
|-- index.qmd
|-- input
|   |-- ELSOC_subset.rds
|   |-- ELSOC_variables_estudio.rds
|   |-- README.md
|   |-- data_centrada_regresion.rds
|   |-- data_f_regresion.rds
|   `-- data_regresion.rds
|-- output
|   |-- README.md
|   |-- graphs
|   |   `-- cohesion_clase_generacion.png
|   `-- tables
|-- procesamiento
|   |-- Preparacion.qmd
|   |-- README.md
|   |-- analisis.qmd
|   |-- descriptivo_bivariado.qmd
|   |-- index.qmd
|   |-- input
|   |   |-- data_centrada_regresion.rds
|   |   |-- data_f_regresion.rds
|   |   `-- data_regresion.rds
|   `-- output
|       |-- graphs
|       |   |-- cohesion_clase_generacion.png
|       |   |-- cohesion_corrupcion.png
|       |   |-- cohesion_educacion.png
|       |   |-- cohesion_meritocracia.png
|       |   |-- cohesion_temporal.png
|       |   |-- cohesion_temporal_clase.png
|       |   |-- cohesion_temporal_generacion.png
|       |   `-- distribucion_dv.png
|       `-- tables
|-- references.qmd
|-- refs
|   |-- Cohesion social.bib
|   |-- apa.csl
|   `-- referencias.bib
|-- reportes-facso-plantilla.tex
`-- testnofig.tex

14 directories, 55 files
```
<!--END_TREE-->