# Plantilla de la evaluación final Ciencia Social Abierta 2026


## Estructura principal del repositorio


El repositorio organiza el contenido en capítulos base (`00–06`), apéndices, e includes para portadas y metadatos. La identidad visual se controla en `assets/styles.scss` y el diseño PDF en `reportes-facso-plantilla.tex`. La carpeta `refs/` aloja `apa.csl` y `referencias.bib`. Se sigue el [protocolo IPO](https://lisacoes.com/protocolos/a-ipo-rep/) con `input/` (datos), `procesamiento/` (scripts/notebooks) y `output/` (tablas/figuras listas).

La plantilla permite integrar tablas y gráficos que se actualizan al cambiar los datos. Las citas se gestionan con Pandoc usando claves de `refs/referencias.bib` (formato BibTeX/CSL JSON), con estilo APA por defecto (`refs/apa.csl`). Esto asegura consistencia entre texto, evidencias y bibliografía en ambas salidas (HTML y PDF).

El despliegue web se puede realizar mediante [**GitHub Pages**](https://www.youtube.com/watch?v=8IdBAysf-U4) desde `docs/`. 

## Flujo de trabajo sugerido

1. Organizar datos brutos en `input/data-orig/` y documentarlos brevemente.
2. Procesar la informacion dentro de `procesamiento/` usando scripts o notebooks; guardar productos limpios en `input/data-proc/` o `output/` segun corresponda.
3. Referenciar tablas y graficos listos desde los capitulos usando rutas relativas (por ejemplo `output/tables/tabla-01.html`).
4. Usar `freeze: auto` (configurado) para mantener resultados reproducibles y evitar re-ejecuciones innecesarias.
5. Antes de liberar una version final, ejecutar `quarto render --to html pdf` para garantizar paridad entre formatos.

## Elementos a considerar en la evaluación

- Preregistro de hipótesis
- Registro del proyecto en OSF
- Elaboración de pre-print
- Generación de GitHub Pages para la publicación de resultados

# Análisis Longitudinal de la Cohesión Social

Este proyecto analiza los datos de la encuesta ELSOC entre los años 2016 y 2023.

## Estructura del Proyecto

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