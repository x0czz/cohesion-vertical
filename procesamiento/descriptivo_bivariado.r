data_f <- readRDS("input/data_f_regresion.rds")
data_centrada <- readRDS("input/data_centrada_regresion.rds")

library(tidyverse)
library(dplyr)
library(ggplot2)
library(tibble)
library(ggdist)
library(lme4)
library(gtsummary)

output_tables_dir <- file.path("output", "tables")
output_graphs_dir <- file.path("output", "graphs")
dir.create(output_tables_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(output_graphs_dir, recursive = TRUE, showWarnings = FALSE)


label_map <- c(
  "(Intercept)"            = "Intercept",
  
  # Corruption perception
  "c38"                    = "Corruption perception",
  "c38_grand"              = "Corruption perception (Grand-mean centered)",
  "c38_within"             = "Corruption perception (Sspecific-mean centered)",
  "c38_between"            = "Corruption perception (Person historical mean)",
  "c38_within:c38_between"  = "Corruption perception (Cross-level Interaction)",
  
  # Age
  "m0_edad"                = "Age",
  "m0_edad_grand"          = "Age (Grand-mean centered)",
  "m0_edad_within"         = "Age (Specific-mean centered)",
  "m0_edad_between"        = "Age (Person historical mean)",
  
  # Meritocracy perception
  "c32_01_ord"             = "Meritocracy perception",
  "c32_01_ord.L"           = "Meritocracy perception (Linear trend)",
  "c32_01_ord.Q"           = "Meritocracy perception (Quadratic trend)",
  "c32_01_ord.C"           = "Meritocracy perception (Cubic trend)",
  "c32_01_ord^4"           = "Meritocracy perception (4th degree trend)",
  "c32_grand"              = "Identificación nacional (Grand-mean centered)",
  "c32_within"             = "Identificación nacional (Specific-mean centered)",
  "c32_between"            = "Identificación nacional (Person historical mean)",
  
  # Dignified treatment
  "trato_digno"            = "Dignified treatment",
  "trato_digno_grand"      = "Dignified treatment (Grand-mean centered)",
  "trato_digno_within"     = "Dignified treatment (Specific-mean centered)",
  "trato_digno_between"    = "Dignified treatment (Person historical mean)",
  
  # Political self-identification
  "c15"                    = "Political self-identification",
  "c15_grand"              = "Political self-identification (Grand-mean centered)",
  "c15_within"             = "Political self-identification (Specific-mean centered)",
  "c15_between"            = "Political self-identification (Person historical mean)",
  
  # Indigenous self-identification
  "indigena"               = "Indigenous self-identification",
  
  # Sex & Education
  "sexoMujer"              = "Sex: Female",
  "neduEducación Básica"   = "Education: Basic",
  "neduEducación Superior" = "Education: Higher education",
  "neduPosgrado"           = "Education: Postgraduate",
  
  # Generation (ref. = Silent)
  "Generacionboom"         = "Generation: Boom",
  "GeneracionX"            = "Generation: X",
  "GeneracionY"            = "Generation: Y",
  "GeneracionZ"            = "Generation: Z",
  
  # Social class EGP-7 (ref. = Service class I)
  "egp7'II  Service class II'"                              = "Service class II",
  "egp7'III Routine non-manual'"                            = "Routine non-manual",
  "egp7'IIIa: Routine Nonmanual'"                           = "Routine non-manual (IIIa)",
  "egp7'V   Manual supervisors/Lower grade technicians'"    = "Manual supervisors",
  "egp7'VI  Skilled workers'"                               = "Skilled workers",
  "egp7'VII Unskilled workers/Farm labours'"                = "Unskilled workers",
  
  # Wave (ref. = Ola 1 / 2016)
  "olaOla 2"               = "Wave 2017",
  "olaOla 3"               = "Wave 2018",
  "olaOla 4"               = "Wave 2019",
  "olaOla 5"               = "Wave 2021",
  "olaOla 6"               = "Wave 2022",
  "olaOla 7"               = "Wave 2023",
  "m0_edad_within:m0_edad_between" = "Interaction: Age (within) × Age (between)",
  # DV
  "c05_total"              = "Organizational participation (DV)"
)
```


tabla_descriptivos <- data_f %>% 
  select(c05_total, c38, m0_edad, egp7, trato_digno, c15, c32_01_ord, Generacion, ola) %>% 
  mutate(
    c38      = as.numeric(haven::zap_labels(c38)),
    c15      = as.numeric(haven::zap_labels(c15)),
    c32_01_ord  = as.numeric(haven::zap_labels(c32_01_ord)),
    egp7     = as.factor(egp7)
  ) %>% 
  tbl_summary(
    statistic = list(all_continuous() ~ "{mean} ({sd}) [{min}; {max}]",
                      all_categorical() ~ "{n} ({p}%)"),
    label = list(
      c05_total   ~ "Cohesión social vertical",
      c38         ~ "Percepción de corrupción",
      m0_edad     ~ "Edad",
      egp7        ~ "Clase social (EGP-7)",
      trato_digno ~ "Trato digno",
      c15         ~ "Autoidentificación política",
      c32_01_ord  ~ "Orgullo de ser chileno",
      Generacion  ~ "Generación",
      ola         ~ "Ola"
    ),
    missing = "no"
  ) %>% 
  add_n() %>% 
  bold_labels() %>% 
  modify_caption("**Tabla 1. Estadísticos descriptivos (N obs = {N}, casos completos)**")

tabla_descriptivos
tabla_descriptivos_path <- file.path(output_tables_dir, "tabla_descriptivos.html")
if (!file.exists(tabla_descriptivos_path)) {
  gt::gtsave(gtsummary::as_gt(tabla_descriptivos), tabla_descriptivos_path)
}






resumen_clase_gen <- data_f %>%
  group_by(egp7, Generacion) %>%
  summarise(
    media = mean(c05_total, na.rm = TRUE),
    se = sd(c05_total, na.rm = TRUE) / sqrt(n()),
    n = n(),
    .groups = "drop"
  ) %>%
  mutate(
    ci_low  = media - 1.96 * se,
    ci_high = media + 1.96 * se
  )
```

```{r}
grafico_clase_gen <- resumen_clase_gen %>%
  ggplot(aes(x = Generacion, y = media, group = egp7)) +
  geom_line(linewidth = 0.8, color = "#0571B0") +
  geom_point(size = 2, color = "#0571B0") +
  geom_errorbar(aes(ymin = ci_low, ymax = ci_high), width = 0.15, alpha = .5, color = "#0571B0") +
  facet_wrap(~ egp7, ncol = 3) +
  labs(
    title = "Vertical social cohesion by social class and generation",
    x = "Generation", y = "Vertical social cohesion (mean)"
  ) +
  theme_ggdist() +
  theme(strip.text = element_text(size = 8))

grafico_clase_gen
grafico_clase_gen_path <- file.path(output_graphs_dir, "cohesion_clase_generacion.png")
if (!file.exists(grafico_clase_gen_path)) {
  ggplot2::ggsave(
    filename = grafico_clase_gen_path,
    plot = grafico_clase_gen,
    width = 8,
    height = 6,
    dpi = 300
  )
}

```




table(data_f$sexo)
table(data_f$nedu)
