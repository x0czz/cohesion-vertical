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
.
(0tqq (B01-introduccion.qmd
(0tqq (B02-antecedentes.qmd
(0tqq (B03-hipotesis.qmd
(0tqq (B04-metodos.qmd
(0tqq (B04-resultados_files
(0x   tqq (Bfigure-html
(0x   x   mqq (Bgrafico-ejemplo-1.png
(0x   mqq (Bfigure-pdf
(0x       mqq (Bgrafico-ejemplo-1.pdf
(0tqq (B05-resultados.qmd
(0tqq (B05-resultados_files
(0x   tqq (Bexecute-results
(0x   x   tqq (Bhtml.json
(0x   x   mqq (Btex.json
(0x   tqq (Bfigure-html
(0x   x   tqq (Bfig-bivariado-1.png
(0x   x   tqq (Bunnamed-chunk-2-1.png
(0x   x   tqq (Bunnamed-chunk-2-2.png
(0x   x   mqq (Bunnamed-chunk-3-1.png
(0x   mqq (Bfigure-pdf
(0x       tqq (Bfig-bivariado-1.pdf
(0x       mqq (Bunnamed-chunk-2-1.pdf
(0tqq (B06-conclusiones.qmd
(0tqq (BREADME.html
(0tqq (BREADME.md
(0tqq (BREADME_files
(0x   mqq (Blibs
(0x       tqq (Bbootstrap
(0x       x   tqq (Bbootstrap-efbb37e9afcc02144ebbc7afd12a776f.min.css
(0x       x   tqq (Bbootstrap-icons.css
(0x       x   tqq (Bbootstrap-icons.woff
(0x       x   mqq (Bbootstrap.min.js
(0x       tqq (Bclipboard
(0x       x   mqq (Bclipboard.min.js
(0x       mqq (Bquarto-html
(0x           tqq (Banchor.min.js
(0x           tqq (Bpopper.min.js
(0x           tqq (Bquarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
(0x           tqq (Bquarto.js
(0x           tqq (Btabsets
(0x           x   mqq (Btabsets.js
(0x           tqq (Btippy.css
(0x           mqq (Btippy.umd.min.js
(0tqq (B_freeze
(0x   tqq (B03-metodologia
(0x   x   mqq (Bexecute-results
(0x   x       tqq (Bhtml.json
(0x   x       mqq (Btex.json
(0x   tqq (B04-resultados
(0x   x   tqq (Bexecute-results
(0x   x   x   tqq (Bhtml.json
(0x   x   x   mqq (Btex.json
(0x   x   tqq (Bfigure-html
(0x   x   x   mqq (Bgrafico-ejemplo-1.png
(0x   x   mqq (Bfigure-pdf
(0x   x       mqq (Bgrafico-ejemplo-1.pdf
(0x   mqq (B05-resultados
(0x       tqq (Bexecute-results
(0x       x   tqq (Bhtml.json
(0x       x   mqq (Btex.json
(0x       tqq (Bfigure-html
(0x       x   tqq (Bfig-bivariado-1.png
(0x       x   tqq (Bunnamed-chunk-2-1.png
(0x       x   tqq (Bunnamed-chunk-2-2.png
(0x       x   mqq (Bunnamed-chunk-3-1.png
(0x       mqq (Bfigure-pdf
(0x           tqq (Bfig-bivariado-1.pdf
(0x           mqq (Bunnamed-chunk-2-1.pdf
(0tqq (B_metadata.yml
(0tqq (B_quarto.yml
(0tqq (Bapendices
(0x   tqq (BA-encuestas.qmd
(0x   mqq (BB-tablas.qmd
(0tqq (Bassets
(0x   tqq (Bcover.png
(0x   tqq (Bfavicon-2025-20251031.svg
(0x   tqq (Bfavicon.svg
(0x   tqq (Bfile.svg
(0x   tqq (Bsharing-default.png
(0x   mqq (Bstyles.scss
(0tqq (Bincludes
(0x   tqq (Bbackmatter.tex
(0x   tqq (Bcitefix.html
(0x   tqq (Bcode-toggle.html
(0x   tqq (Bcover-config.tex
(0x   tqq (Bjustify.html
(0x   tqq (Blogo-link.html
(0x   tqq (Bpdf-config-scrbook.yml
(0x   tqq (Bpreamble.tex
(0x   tqq (Breference.docx
(0x   tqq (Brenumber.html
(0x   tqq (Breportes-facso-plantilla.tex
(0x   tqq (Btitle-html.html
(0x   tqq (Btitle-pdf.tex
(0x   mqq (Btoc-enhance.html
(0tqq (Bindex.qmd
(0tqq (Binput
(0x   tqq (BELSOC_subset.rds
(0x   tqq (BELSOC_variables_estudio.rds
(0x   tqq (BREADME.md
(0x   tqq (Bdata_centrada_regresion.rds
(0x   tqq (Bdata_f_regresion.rds
(0x   mqq (Bdata_regresion.rds
(0tqq (Boutput
(0x   tqq (BREADME.md
(0x   tqq (Bgraphs
(0x   x   mqq (Bcohesion_clase_generacion.png
(0x   mqq (Btables
(0x       tqq (Btabla_comparacion.html
(0x       tqq (Btabla_comparacion_cent.html
(0x       tqq (Btabla_descriptiva_ola7.html
(0x       tqq (Btabla_descriptivos.html
(0x       tqq (Btabla_modelos.html
(0x       mqq (Btabla_test.html
(0tqq (Bprocesamiento
(0x   tqq (BPreparacion.html
(0x   tqq (BPreparacion.qmd
(0x   tqq (BPreparacion_files
(0x   x   mqq (Blibs
(0x   x       tqq (Bbootstrap
(0x   x       x   tqq (Bbootstrap-03bd07e4458e7f118467a4d2741871ca.min.css
(0x   x       x   tqq (Bbootstrap-icons.css
(0x   x       x   tqq (Bbootstrap-icons.woff
(0x   x       x   mqq (Bbootstrap.min.js
(0x   x       tqq (Bclipboard
(0x   x       x   mqq (Bclipboard.min.js
(0x   x       mqq (Bquarto-html
(0x   x           tqq (Banchor.min.js
(0x   x           tqq (Bpopper.min.js
(0x   x           tqq (Bquarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
(0x   x           tqq (Bquarto.js
(0x   x           tqq (Btabsets
(0x   x           x   mqq (Btabsets.js
(0x   x           tqq (Btippy.css
(0x   x           mqq (Btippy.umd.min.js
(0x   tqq (BREADME.md
(0x   tqq (Banalisis.html
(0x   tqq (Banalisis.qmd
(0x   tqq (Banalisis_files
(0x   x   mqq (Blibs
(0x   x       tqq (Bbootstrap
(0x   x       x   tqq (Bbootstrap-03bd07e4458e7f118467a4d2741871ca.min.css
(0x   x       x   tqq (Bbootstrap-icons.css
(0x   x       x   tqq (Bbootstrap-icons.woff
(0x   x       x   mqq (Bbootstrap.min.js
(0x   x       tqq (Bclipboard
(0x   x       x   mqq (Bclipboard.min.js
(0x   x       mqq (Bquarto-html
(0x   x           tqq (Banchor.min.js
(0x   x           tqq (Bpopper.min.js
(0x   x           tqq (Bquarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
(0x   x           tqq (Bquarto.js
(0x   x           tqq (Btabsets
(0x   x           x   mqq (Btabsets.js
(0x   x           tqq (Btippy.css
(0x   x           mqq (Btippy.umd.min.js
(0x   tqq (Bdescriptivo_bivariado.html
(0x   tqq (Bdescriptivo_bivariado.qmd
(0x   tqq (Bdescriptivo_bivariado_files
(0x   x   tqq (Bfigure-html
(0x   x   x   tqq (Bgrafico-clase-generacion-1.png
(0x   x   x   tqq (Bgrafico-corrupcion-1.png
(0x   x   x   tqq (Bgrafico-distribucion-dv-1.png
(0x   x   x   tqq (Bgrafico-educacion-1.png
(0x   x   x   tqq (Bgrafico-identificacion-1.png
(0x   x   x   tqq (Bgrafico-meritocracia-1.png
(0x   x   x   tqq (Bgrafico-temporal-1.png
(0x   x   x   tqq (Bgrafico-temporal-clase-1.png
(0x   x   x   mqq (Bgrafico-temporal-generacion-1.png
(0x   x   mqq (Blibs
(0x   x       tqq (Bbootstrap
(0x   x       x   tqq (Bbootstrap-03bd07e4458e7f118467a4d2741871ca.min.css
(0x   x       x   tqq (Bbootstrap-icons.css
(0x   x       x   tqq (Bbootstrap-icons.woff
(0x   x       x   mqq (Bbootstrap.min.js
(0x   x       tqq (Bclipboard
(0x   x       x   mqq (Bclipboard.min.js
(0x   x       tqq (BkePrint-0.0.1
(0x   x       x   mqq (BkePrint.js
(0x   x       tqq (Blightable-0.0.1
(0x   x       x   mqq (Blightable.css
(0x   x       mqq (Bquarto-html
(0x   x           tqq (Banchor.min.js
(0x   x           tqq (Bpopper.min.js
(0x   x           tqq (Bquarto-syntax-highlighting-46f66b053e56abd73bb6e954d61a315b.css
(0x   x           tqq (Bquarto.js
(0x   x           tqq (Btabsets
(0x   x           x   mqq (Btabsets.js
(0x   x           tqq (Btippy.css
(0x   x           mqq (Btippy.umd.min.js
(0x   tqq (Bindex.qmd
(0x   tqq (Binput
(0x   x   tqq (Bdata_centrada_regresion.rds
(0x   x   tqq (Bdata_f_regresion.rds
(0x   x   mqq (Bdata_regresion.rds
(0x   mqq (Boutput
(0x       tqq (Bgraphs
(0x       x   tqq (Bcohesion_clase_generacion.png
(0x       x   tqq (Bcohesion_corrupcion.png
(0x       x   tqq (Bcohesion_educacion.png
(0x       x   tqq (Bcohesion_meritocracia.png
(0x       x   tqq (Bcohesion_temporal.png
(0x       x   tqq (Bcohesion_temporal_clase.png
(0x       x   tqq (Bcohesion_temporal_generacion.png
(0x       x   mqq (Bdistribucion_dv.png
(0x       mqq (Btables
(0x           tqq (Btabla_comparacion.html
(0x           tqq (Btabla_descriptiva_ola7.html
(0x           tqq (Btabla_descriptivos.html
(0x           mqq (Btabla_modelos.html
(0tqq (Breferences.qmd
(0tqq (Brefs
(0x   tqq (BCohesion social.bib
(0x   tqq (Bapa.csl
(0x   mqq (Breferencias.bib
(0tqq (Breportes-facso-plantilla.tex
(0tqq (Bsearch.json
(0tqq (Btestnofig.tex
(0mqq (Btree.txt

59 directories, 161 files
<!--END_TREE-->