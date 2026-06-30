## Sobre este repositorio

Este repositorio contiene el informe del trabajo final del curso de **Ciencia Social Abierta**, correspondiente a la Facultad de Ciencias Sociales (FACSO). El trabajo aborda la **confianza institucional**, analizada mediante **modelado multinivel**.

Informe completo disponible en: https://x0czz.github.io/cohesion-vertical/

Pre-registro disponible en : https://osf.io/6kw3f/overview

Para reproducir la totalidad de las salidas presentadas en el documento final, basta con renderizar el proyecto completo. Los gráficos y las tablas incluidos son generados y exportados mediante los códigos adjuntos en procesamiento, e incorporados al reporte final mediante un llamado desde su respectiva ruta de guardado. De este modo, cualquier modificación realizada sobre los códigos de generación de archivos se reflejará automáticamente en el documento final al momento de renderizar nuevamente el proyecto, garantizando la consistencia entre el código y los resultados reportados.

Los datos provienen de la base de datos ELSOC. La base de datos adjunta en este proyecto contiene únicamente las variables necesarias para el análisis dado el peso de la base de datos completa.

La base de datos completa orignal se accesible mediante Harvar Dataverse: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/LD4BPH

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

11 directories, 40 files
```
<!--END_TREE-->