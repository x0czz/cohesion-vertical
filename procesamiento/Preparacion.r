# ============================================================
# PARTE 1: PREPARACIÓN DE DATOS
# ============================================================

library(haven)
library(dplyr)
library(tidyr)
library(lme4)
library(DIGCLASS)
options(scipen = 999)
rm(list = ls())

# ------------------------------------------------------------
# 1.1) Lectura y limpieza inicial de códigos perdidos
# ------------------------------------------------------------
elsoc <- haven::read_dta("input\\ELSOC_Long_2016_2023.dta")
elsoc$tipo_atricion %>% table()

data <- elsoc %>%
  mutate(
    across(
      where(is.numeric),
      ~ na_if(na_if(na_if(na_if(.x, -999), -888), -777), -666)
    ),
    across(
      where(is.character) | where(is.factor),
      ~ na_if(na_if(na_if(na_if(as.character(.x), "-999"), "-888"), "-777"), "-666")
    )
  ) %>%
  {
    if ("tipo_atricion" %in% names(.)) {
      dplyr::filter(., .data[["tipo_atricion"]] == 1)
    } else {
      .
    }
  }

# ------------------------------------------------------------
# 1.2) Construcción de variables base
# ------------------------------------------------------------
data <- data %>%
  mutate(
    ola = factor(ola, levels = 1:7, labels = paste0("Ola ", 1:7)),
    c32_01 = readr::parse_number(as.character(c32_01)),
    c32_01_ord = factor(c32_01, levels = 1:5, ordered = TRUE),
    m53_label = haven::as_factor(m53, levels = "labels"),
    indigena = case_when(
      m53_label == "Ninguno" ~ 0,
      m53_label %in% c(
        "Otro", "Yagan o Yamana", "Kawesqar", "Diaguita", "Colla",
        "Quechua", "Likan Antai", "Linkan Antai", "Rapa Nui",
        "Aimara", "Mapuche"
      ) ~ 1,
      m53_label %in% c(
        "No Responde", "No Sabe",
        "Valor perdido por error tecnico",
        "Valor perdido por encuesta incompleta"
      ) ~ NA_real_,
      TRUE ~ NA_real_
    ),
    c05_total = rowSums(pick(c05_01:c05_09), na.rm = TRUE),
    trato_digno = rowSums(pick(c35_01:c35_03), na.rm = TRUE)
  )

# Imputación por arrastre de `indigena` desde Ola 3
data <- data %>%
  group_by(idencuesta) %>%
  mutate(
    indigena_ola3 = if (any(ola == "Ola 3" & !is.na(indigena)))
      indigena[which(ola == "Ola 3" & !is.na(indigena))[1]]
    else NA_real_
  ) %>%
  ungroup() %>%
  mutate(indigena = coalesce(indigena, indigena_ola3)) %>%
  select(-indigena_ola3)

# ------------------------------------------------------------
# 1.3) Variables temporales y generación de cohortes
# ------------------------------------------------------------
safe_max <- function(x) {
  x <- x[!is.na(x)]
  if (length(x) == 0) NA_real_ else max(x)
}

data <- data %>%
  group_by(idencuesta) %>%
  mutate(
    edad_2023 = safe_max(m0_edad),
    anio_nac = 2023 - edad_2023,
    Generacion = case_when(
      between(anio_nac, 1930, 1948) ~ "Silent",
      between(anio_nac, 1949, 1968) ~ "boom",
      between(anio_nac, 1969, 1980) ~ "X",
      between(anio_nac, 1981, 1993) ~ "Y",
      between(anio_nac, 1994, 2010) ~ "Z",
      TRUE ~ NA_character_
    ),
    Generacion = factor(Generacion, levels = c("Silent", "boom", "X", "Y", "Z"))
  ) %>%
  ungroup()

# ------------------------------------------------------------
# 1.4) Construcción de clase social (EGP-7)
# ------------------------------------------------------------
if (requireNamespace("DIGCLASS", quietly = TRUE)) {

  data <- data %>%
    arrange(idencuesta, ola) %>%
    mutate(
      isco88_raw = case_when(
        ola == "Ola 1" ~ formatC(suppressWarnings(as.integer(ciuo88_m03)), width = 4, flag = "0"),
        TRUE ~ NA_character_
      ),
      isco88_raw = na_if(isco88_raw, "  NA"),
      ciuo08_clean = case_when(
        ola %in% c("Ola 3", "Ola 5", "Ola 7") ~ formatC(suppressWarnings(readr::parse_number(as.character(ciuo08_m03))), width = 4, flag = "0"),
        TRUE ~ NA_character_
      ),
      ciuo08_clean = na_if(ciuo08_clean, "  NA")
    )

  data$isco88_from08 <- NA_character_
  idx08 <- !is.na(data$ciuo08_clean)
  data$isco88_from08[idx08] <- DIGCLASS::isco08_to_isco88(data$ciuo08_clean[idx08])

  data <- data %>%
    mutate(isco88 = coalesce(isco88_raw, isco88_from08)) %>%
    select(-isco88_raw, -ciuo08_clean, -isco88_from08)

  data <- data %>%
    group_by(idencuesta) %>%
    tidyr::fill(isco88, .direction = "downup") %>%
    ungroup()

  data <- data %>%
    arrange(idencuesta, ola) %>%
    mutate(
      m07 = suppressWarnings(as.integer(m07)),
      m07 = if_else(m07 %in% c(1, 2, 4, 5, 7), m07, NA_integer_),
      is_supervisor = case_when(
        !is.na(m06) & m06 > 0 ~ 1,
        !is.na(m06) & m06 == 0 ~ 0,
        TRUE ~ NA_real_
      )
    ) %>%
    group_by(idencuesta) %>%
    tidyr::fill(m07, .direction = "downup") %>%
    tidyr::fill(is_supervisor, .direction = "downup") %>%
    ungroup() %>%
    mutate(
      rel_empleo = m07,
      self_employed = case_when(
        rel_empleo %in% c(4, 5) ~ 1,
        rel_empleo %in% c(1, 2, 7) ~ 0,
        TRUE ~ NA_real_
      ),
      n_employees = case_when(
        is_supervisor == 1 ~ suppressWarnings(as.numeric(m06)),
        is_supervisor == 0 ~ 0,
        TRUE ~ NA_real_
      )
    )

  data <- data %>%
    arrange(idencuesta, ola) %>%
    group_by(idencuesta) %>%
    tidyr::fill(n_employees, .direction = "downup") %>%
    ungroup()

  data <- data %>%
    mutate(isco88 = DIGCLASS::repair_isco(isco88))

  data <- data %>%
    mutate(
      egp7 = DIGCLASS::isco88_to_egp(
        x = isco88,
        self_employed = self_employed,
        n_employees = n_employees,
        n_classes = 7,
        label = TRUE
      )
    )

} else {
  warning("DIGCLASS no está instalado.")
  data <- data %>%
    mutate(
      ciuo08_num = readr::parse_number(as.character(ciuo08_m03)),
      ciuo88 = occupar::isco08to88(ciuo08_num),
      egp7 = occupar::isco88toEGP(
        isco88        = ciuo88,
        self.employed = ifelse(m07 %in% c(4, 5), 1, 0),
        n.employees   = ifelse(m07 == 4, 1, 0),
        n.classes     = 7
      )
    )
}

# Verificación rápida del resultado ocupacional
if ("egp7" %in% names(data)) {
  table(data$egp7, useNA = "ifany")
  cat("\nNA en egp7:", sum(is.na(data$egp7)), "de", nrow(data),
      sprintf("(%.1f%%)\n", 100 * mean(is.na(data$egp7))))
} else {
  warning("egp7 todavía no existe en data.")
}

# ------------------------------------------------------------
# 1.5) Imputación hacia atrás de c38
# ------------------------------------------------------------
data <- data %>%
  arrange(idencuesta, ola) %>%
  mutate(c38 = readr::parse_number(as.character(c38))) %>%
  group_by(idencuesta) %>%
  tidyr::fill(c38, .direction = "up") %>%
  ungroup()

# Comprobación
data %>%
  filter(ola %in% c("Ola 1", "Ola 2")) %>%
  group_by(ola) %>%
  summarise(
    c38_no_faltante = sum(!is.na(c38)),
    total = n(),
    pct_c38_no_faltante = round(100 * c38_no_faltante / total, 1),
    .groups = "drop"
  )

# ------------------------------------------------------------
# 1.6) Subconjunto analítico: casos completos
# ------------------------------------------------------------
data_f <- data %>%
  select(c05_total, c38, m0_edad, egp7, trato_digno, c15, c32_01_ord,
         Generacion, ola, idencuesta, indigena, m0_sexo, m01) %>%
  mutate(
    sexo = case_when(
      m0_sexo == 1 ~ 1,  # Hombre
      m0_sexo == 2 ~ 2,  # Mujer
      TRUE ~ NA_real_
    ),
    sexo = factor(sexo, levels = c(1, 2), labels = c("Hombre", "Mujer")),
    
    nedu = case_when(
  m01 == 1              ~ 1,  # Sin estudios
  m01 %in% c(2, 3, 4, 5) ~ 2,  # Educación Básica (completa e incompleta, media completa e incompleta)
  m01 %in% c(6, 7, 8, 9) ~ 3,  # Educación Superior (técnica y universitaria, completa e incompleta)
  m01 == 10             ~ 4,  # Posgrado
  TRUE ~ NA_real_
),
nedu = factor(nedu, levels = 1:4, labels = c(
  "Sin estudios",
  "Educación Básica",
  "Educación Superior",
  "Posgrado"
))

  )
cat("N observaciones en data_f:", nrow(data_f), "\n")
cat("N individuos en data_f:", n_distinct(data_f$idencuesta), "\n")

# ------------------------------------------------------------
# 1.7) Diagnóstico de faltantes por variable y ola
# ------------------------------------------------------------
# Por variable (exclusión por caso completo)
vars <- c("c05_total", "c38", "m0_edad", "egp7", "trato_digno", "indigena", "c15", "c32_01_ord", "ola")

n_total <- nrow(data)
n_complete_all <- sum(complete.cases(data[vars]))
n_missing <- sapply(vars, function(v) sum(is.na(data[[v]])))
n_excluded_only_by_var <- sapply(vars, function(v) {
  sum(is.na(data[[v]]) & complete.cases(data[setdiff(vars, v)]))
})

res_missing <- tibble::tibble(
  var = vars,
  n_missing = n_missing,
  n_excluded_only_by_var = n_excluded_only_by_var,
  pct_excluded_of_total = round(100 * n_excluded_only_by_var / n_total, 1)
) %>%
  arrange(desc(n_excluded_only_by_var))

list(n_total = n_total, n_complete_all = n_complete_all, table = res_missing)

# Por ola
vars_respuestas <- c("c05_total", "c38", "m0_edad", "egp7",
                     "trato_digno", "indigena", "c15", "c32_01_ord", "Generacion")

respuestas_por_ola <- data %>%
  group_by(ola) %>%
  summarise(
    across(all_of(vars_respuestas), ~ sum(!is.na(.x)), .names = "n_{.col}"),
    n_total = n(),
    .groups = "drop"
  ) %>%
  pivot_longer(cols = starts_with("n_"), names_to = "variable", values_to = "n_respuestas") %>%
  mutate(
    variable = sub("^n_", "", variable),
    pct_respuestas = round(100 * n_respuestas / n_total, 1)
  ) %>%
  select(ola, variable, n_respuestas, n_total, pct_respuestas) %>%
  arrange(variable, ola)

respuestas_por_ola

# ------------------------------------------------------------
# 1.8) Centrado grand-mean y within-person
# ------------------------------------------------------------
vars_continuas <- c("c05_total", "c38", "m0_edad", "trato_digno", "c15")

data_centrada <- data_f %>%
  group_by(idencuesta) %>%
  mutate(
    across(all_of(vars_continuas),
           ~ .x - mean(.x, na.rm = TRUE),
           .names = "{.col}_within")
  ) %>%
  ungroup() %>%
  mutate(
    across(all_of(vars_continuas),
           ~ .x - mean(.x, na.rm = TRUE),
           .names = "{.col}_grand")
  )

# Verificación
data_centrada %>%
  select(idencuesta, ola, m0_edad, m0_edad_within, m0_edad_grand, c05_total) %>%
  head(10)

# ------------------------------------------------------------
# 1.10) Medias between-person (promedio individual por variable)
# ------------------------------------------------------------
vars_continuas <- c("c05_total", "c38", "m0_edad", "trato_digno", "c15")

data_centrada <- data_centrada %>%
  group_by(idencuesta) %>%
  mutate(
    across(
      all_of(vars_continuas),
      ~ mean(.x, na.rm = TRUE),
      .names = "{.col}_between"
    )
  ) %>%
  ungroup()

# Verificación
data_centrada %>%
  select(idencuesta, ola, c05_total, c05_total_within, c05_total_between, c05_total_grand) %>%
  head(10)

data_centrada <- data_centrada %>%
  mutate(c32_num = as.numeric(as.character(c32_01_ord))) %>% 
  mutate(c32_grand = c32_num - mean(c32_num, na.rm = TRUE)) %>%
  group_by(idencuesta) %>%
  mutate(
    c32_within  = c32_num - mean(c32_num, na.rm = TRUE),
    c32_between = mean(c32_num, na.rm = TRUE)
  ) %>%
  ungroup()

# ------------------------------------------------------------
# 1.9) Guardado de bases procesadas
# ------------------------------------------------------------
proc_dir <- "input"
dir.create(proc_dir, recursive = TRUE, showWarnings = FALSE)

archivos_regresion <- list(
  data          = file.path(proc_dir, "data_regresion.rds"),
  data_f        = file.path(proc_dir, "data_f_regresion.rds"),
  data_centrada = file.path(proc_dir, "data_centrada_regresion.rds")
)

guardar_si_no_existe <- function(objeto, ruta) {
  if (file.exists(ruta)) FALSE else { saveRDS(objeto, ruta); TRUE }
}

mapply(
  guardar_si_no_existe,
  objeto = list(data, data_f, data_centrada),
  ruta = unname(archivos_regresion),
  SIMPLIFY = TRUE
)


data %>%
  group_by(ola) %>%
  summarise(
    n_total = n(),
    n_c32_01 = sum(!is.na(c32_01)),
    n_c32_01_ord = sum(!is.na(c32_01_ord)),
    pct = round(100 * n_c32_01 / n_total, 1)
  )





 