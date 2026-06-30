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
|-- 04-resultados_files
|   |-- figure-html
|   |   `-- grafico-ejemplo-1.png
|   `-- figure-pdf
|       `-- grafico-ejemplo-1.pdf
|-- 05-resultados.qmd
|-- 05-resultados_files
|   |-- execute-results
|   |   |-- html.json
|   |   `-- tex.json
|   |-- figure-html
|   |   |-- fig-bivariado-1.png
|   |   |-- unnamed-chunk-2-1.png
|   |   |-- unnamed-chunk-2-2.png
|   |   `-- unnamed-chunk-3-1.png
|   `-- figure-pdf
|       |-- fig-bivariado-1.pdf
|       `-- unnamed-chunk-2-1.pdf
|-- 06-conclusiones.qmd
|-- README.html
|-- README.md
|-- README_files
|   `-- libs
|       |-- bootstrap
|       |   |-- bootstrap-efbb37e9afcc02144ebbc7afd12a776f.min.css
|       |   |-- bootstrap-icons.css
|       |   |-- bootstrap-icons.woff
|       |   `-- bootstrap.min.js
|       |-- clipboard
|       |   `-- clipboard.min.js
|       `-- quarto-html
|           |-- anchor.min.js
|           |-- popper.min.js
|           |-- quarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
|           |-- quarto.js
|           |-- tabsets
|           |   `-- tabsets.js
|           |-- tippy.css
|           `-- tippy.umd.min.js
|-- _freeze
|   |-- 03-metodologia
|   |   `-- execute-results
|   |       |-- html.json
|   |       `-- tex.json
|   |-- 04-resultados
|   |   |-- execute-results
|   |   |   |-- html.json
|   |   |   `-- tex.json
|   |   |-- figure-html
|   |   |   `-- grafico-ejemplo-1.png
|   |   `-- figure-pdf
|   |       `-- grafico-ejemplo-1.pdf
|   `-- 05-resultados
|       |-- execute-results
|       |   |-- html.json
|       |   `-- tex.json
|       |-- figure-html
|       |   |-- fig-bivariado-1.png
|       |   |-- unnamed-chunk-2-1.png
|       |   |-- unnamed-chunk-2-2.png
|       |   `-- unnamed-chunk-3-1.png
|       `-- figure-pdf
|           |-- fig-bivariado-1.pdf
|           `-- unnamed-chunk-2-1.pdf
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
|   |-- citefix.html
|   |-- code-toggle.html
|   |-- cover-config.tex
|   |-- justify.html
|   |-- logo-link.html
|   |-- pdf-config-scrbook.yml
|   |-- preamble.tex
|   |-- reference.docx
|   |-- renumber.html
|   |-- reportes-facso-plantilla.tex
|   |-- title-html.html
|   |-- title-pdf.tex
|   `-- toc-enhance.html
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
|       |-- tabla_comparacion.html
|       |-- tabla_comparacion_cent.html
|       |-- tabla_descriptiva_ola7.html
|       |-- tabla_descriptivos.html
|       |-- tabla_modelos.html
|       `-- tabla_test.html
|-- procesamiento
|   |-- Preparacion.html
|   |-- Preparacion.qmd
|   |-- Preparacion_files
|   |   `-- libs
|   |       |-- bootstrap
|   |       |   |-- bootstrap-03bd07e4458e7f118467a4d2741871ca.min.css
|   |       |   |-- bootstrap-icons.css
|   |       |   |-- bootstrap-icons.woff
|   |       |   `-- bootstrap.min.js
|   |       |-- clipboard
|   |       |   `-- clipboard.min.js
|   |       `-- quarto-html
|   |           |-- anchor.min.js
|   |           |-- popper.min.js
|   |           |-- quarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
|   |           |-- quarto.js
|   |           |-- tabsets
|   |           |   `-- tabsets.js
|   |           |-- tippy.css
|   |           `-- tippy.umd.min.js
|   |-- README.md
|   |-- analisis.html
|   |-- analisis.qmd
|   |-- analisis_files
|   |   `-- libs
|   |       |-- bootstrap
|   |       |   |-- bootstrap-03bd07e4458e7f118467a4d2741871ca.min.css
|   |       |   |-- bootstrap-icons.css
|   |       |   |-- bootstrap-icons.woff
|   |       |   `-- bootstrap.min.js
|   |       |-- clipboard
|   |       |   `-- clipboard.min.js
|   |       `-- quarto-html
|   |           |-- anchor.min.js
|   |           |-- popper.min.js
|   |           |-- quarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
|   |           |-- quarto.js
|   |           |-- tabsets
|   |           |   `-- tabsets.js
|   |           |-- tippy.css
|   |           `-- tippy.umd.min.js
|   |-- descriptivo_bivariado.html
|   |-- descriptivo_bivariado.qmd
|   |-- descriptivo_bivariado_files
|   |   |-- figure-html
|   |   |   |-- grafico-clase-generacion-1.png
|   |   |   |-- grafico-corrupcion-1.png
|   |   |   |-- grafico-distribucion-dv-1.png
|   |   |   |-- grafico-educacion-1.png
|   |   |   |-- grafico-identificacion-1.png
|   |   |   |-- grafico-meritocracia-1.png
|   |   |   |-- grafico-temporal-1.png
|   |   |   |-- grafico-temporal-clase-1.png
|   |   |   `-- grafico-temporal-generacion-1.png
|   |   `-- libs
|   |       |-- bootstrap
|   |       |   |-- bootstrap-03bd07e4458e7f118467a4d2741871ca.min.css
|   |       |   |-- bootstrap-icons.css
|   |       |   |-- bootstrap-icons.woff
|   |       |   `-- bootstrap.min.js
|   |       |-- clipboard
|   |       |   `-- clipboard.min.js
|   |       |-- kePrint-0.0.1
|   |       |   `-- kePrint.js
|   |       |-- lightable-0.0.1
|   |       |   `-- lightable.css
|   |       `-- quarto-html
|   |           |-- anchor.min.js
|   |           |-- popper.min.js
|   |           |-- quarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
|   |           |-- quarto.js
|   |           |-- tabsets
|   |           |   `-- tabsets.js
|   |           |-- tippy.css
|   |           `-- tippy.umd.min.js
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
|           |-- tabla_comparacion.html
|           |-- tabla_descriptiva_ola7.html
|           |-- tabla_descriptivos.html
|           `-- tabla_modelos.html
|-- references.qmd
|-- refs
|   |-- Cohesion social.bib
|   |-- apa.csl
|   `-- referencias.bib
|-- reportes-facso-plantilla.tex
|-- search.json
|-- testnofig.tex
`-- tree.txt

59 directories, 161 files
```
<!--END_TREE-->