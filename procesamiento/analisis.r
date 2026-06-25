# ============================================================
# PARTE 2: ANÁLISIS EXPLORATORIO
# ============================================================

library(lme4)
library(performance)
library(psych)
library(texreg)
library(modelsummary)



output_tables_dir <- file.path("output", "tables")
dir.create(output_tables_dir, recursive = TRUE, showWarnings = FALSE)

data <- readRDS("input/data_regresion.rds")
data_f <- readRDS("input/data_f_regresion.rds")
data_centrada <- readRDS("input/data_centrada_regresion.rds")
data_centrada <- data_centrada %>%
  mutate(c32_01_ord = as.factor(c32_01_ord))

data_centrada <- data_centrada %>%
  mutate(c32_num = as.numeric(as.character(c32_01_ord))) %>% 
  
  mutate(c32_grand = c32_num - mean(c32_num, na.rm = TRUE)) %>%
  
  group_by(idencuesta) %>%
  mutate(c32_within = c32_num - mean(c32_num, na.rm = TRUE)) %>%
  ungroup()

  data_centrada <- data_centrada %>% drop_na()




# ------------------------------------------------------------
# 2.1) Consistencia interna de la escala de trato digno
# ------------------------------------------------------------
alpha_trato_digno <- data %>%
  select(c35_01:c35_03) %>%
  alpha()

alpha_trato_digno

# ------------------------------------------------------------
# 2.2) Modelos nulos (ICC)
# ------------------------------------------------------------
model_0      <- lmer(c05_total ~ (1 | idencuesta), data = data_f)
model_0_cent <- lmer(c05_total ~ (1 | idencuesta), data = data_centrada)

performance::r2(model_0)

# ------------------------------------------------------------
# 2.3) Modelos temporales
# ------------------------------------------------------------
model_temp      <- lmer(c05_total ~ ola + (1 | idencuesta), data = data_f)
model_temp_cent <- lmer(c05_total ~ ola + (1 | idencuesta), data = data_centrada)

summary(model_temp_cent)
performance::r2(model_temp)

# ------------------------------------------------------------
# 2.4) Modelos con predictores individuales (sin centrar)
# ------------------------------------------------------------
model_1 <- lmer(c05_total ~ c38 + m0_edad + egp7 + trato_digno + c15 + c32_01_ord +
                  (1 | idencuesta), data = data_f)

model_2 <- lmer(c05_total ~ Generacion + indigena +
                  (1 | idencuesta), data = data_f)

model_3 <- lmer(c05_total ~ c38 + m0_edad + egp7 + trato_digno + indigena +
                  c15 + c32_01_ord + Generacion + (1 | idencuesta), data = data_f)

model_3b <- lmer(c05_total ~ c38 + m0_edad + egp7 + trato_digno + indigena +
                   c15 + c32_01_ord + Generacion + ola + (1 | idencuesta), data = data_f)

summary(model_1)
summary(model_2)
summary(model_3)
summary(model_3b)

performance::r2(model_1)
performance::r2(model_2)
performance::r2(model_3)
performance::r2(model_3b)

# ------------------------------------------------------------
# 2.5) Modelos centrados (BE/WE)
# ------------------------------------------------------------
model_0_time <- lmer(c05_total ~ ola + (1 | idencuesta), data = data_centrada)

model_1_cent <- lmer(c05_total ~ c38_grand + m0_edad_grand + trato_digno_grand +
                       c15_grand + c32_grand + (1 | idencuesta), data = data_centrada)

model_2_cent <- lmer(c05_total ~ Generacion + egp7 + sexo + nedu + c38_between + m0_edad_between + trato_digno_between + c15_between + c32_between +
                       (1 | idencuesta), data = data_centrada)

model_3b_cent <- lmer(c05_total ~ c38_grand + m0_edad_grand + egp7 +
                        trato_digno_grand + c15_grand + c32_grand + Generacion + ola + sexo + nedu + c38_between + m0_edad_between + trato_digno_between + c15_between + c32_between +
                        (1 | idencuesta), data = data_centrada)

summary(model_1_cent)
summary(model_2_cent)
summary(model_3b_cent)
summary(model_3c_cent)

# ------------------------------------------------------------
# 2.6) Modelos con pendientes aleatorias
# ------------------------------------------------------------
model_4_cent <- lmer(c05_total ~ c38_grand + m0_edad_within + egp7 +
                       trato_digno_grand + c15_grand + c32_grand + Generacion + ola + sexo + nedu +
                       (1 + m0_edad_within | idencuesta), data = data_centrada)

model_cross_a <- lmer(
  c05_total ~ c38_grand + Generacion * egp7 +
    m0_edad_within +
    trato_digno_grand + c15_grand + c32_grand +
    ola + sexo + nedu +
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

test5 <- lmer(c05_total ~ c38_grand + m0_edad_within * m0_edad_between + egp7 + c32_between + m0_edad_between + c38_between + trato_digno_between + 
c15_between + trato_digno_grand + c15_grand + c32_grand + Generacion + ola + sexo + nedu +
                    (1 + m0_edad_within | idencuesta), data = data_centrada)

summary(test5)





# Modelos adicionales con/sin indigena
model_4_a <- lmer(c05_total ~ m0_edad_within + egp7 + trato_digno_grand +
                    c15_grand + c32_01_grand + Generacion + ola +
                    (1 + m0_edad_within | idencuesta), data = data_centrada)

model_4_b <- lmer(c05_total ~ m0_edad_within + egp7 + trato_digno_grand +
                    c15_grand + c32_01_grand + Generacion + ola + indigena +
                    (1 + m0_edad_within | idencuesta), data = data_centrada)

summary(model_4_cent)
summary(model_5_cent)
summary(model_6_cent)
summary(model_4_a)
summary(model_4_b)

anova(model_4_a, model_4_b, refit = FALSE)

# ------------------------------------------------------------
# 2.7) Comparación de ajuste entre modelos
# ------------------------------------------------------------
modelos_comparacion <- list(
  model_temp_cent = model_temp_cent,
  model_1_cent    = model_1_cent,
  model_2_cent    = model_2_cent,
  model_3b_cent   = model_3b_cent,
  model_4_cent    = model_4_cent
)

tabla_comparacion_cent_path <- file.path(output_tables_dir, "tabla_comparacion_cent.html")
if (!file.exists(tabla_comparacion_cent_path)) {
  modelsummary::modelsummary(
    modelos_comparacion,
    output = tabla_comparacion_cent_path,
    coef_keep = "^(Intercept)$",
    gof_map = data.frame(
      raw = c("nobs", "AIC", "BIC", "logLik", "deviance"),
      clean = c("N obs.", "AIC", "BIC", "Log-Lik.", "Deviance"),
      fmt = c(0, 2, 2, 2, 2),
      stringsAsFactors = FALSE
    ),
    title = "Comparación de ajuste entre modelos"
  )
}

tabla_comparacion_cent <- tabla_comparacion_cent_path

# ------------------------------------------------------------
# 2.8) Tabla de regresión final (HTML): Requiere el label map
# ------------------------------------------------------------


output_tables_dir <- file.path("output", "tables")
tabla_modelos_path <- file.path(output_tables_dir, "tabla_modelos.html")
dir.create(output_tables_dir, recursive = TRUE, showWarnings = FALSE)

# Sin groups primero para verificar el orden real de filas
htmlreg(list(model_0_cent, model_temp_cent, model_1_cent, model_3b_cent, model_4_cent, test5),
        custom.model.names = c(paste0("Model ", seq(1:6))),
        caption.above = T,
        caption = NULL,
        stars = c(0.05, 0.01, 0.001),
        custom.coef.map = as.list(label_map),
        digits = 3,
        custom.note = "Note: Cells contain regression coefficients with standard errors in parentheses. %stars.",
        leading.zero = T,
        include.loglik = FALSE,
        include.aic = FALSE,
        center = T,
        custom.gof.names = c("BIC", "Numb. obs.", "Num. groups: individuals",
                              "Var: individuals (Intercept)",
                              "Var: Residual",
                              "Var: individuals, age (within)",
                              "Cov: individuals (Intercept-age)"),
        file = tabla_modelos_path)

browseURL(normalizePath(tabla_modelos_path))
rownames(coef(summary(model_4_cent)))






anova(model_4_cent, model_3b_cent, refit = FALSE)

model_4prueba <- lmer(c05_total ~ c38_within + m0_edad_within + egp7 +
                       trato_digno_grand + c15_grand + c32_within + Generacion + ola +
                       (1 + m0_edad_within + c32_within + c38_within | idencuesta), data = data_centrada)

summary(model_4prueba)
library(lmerTest)
# Vuelves a correr el modelo exactamente igual:
model_4prueba <- lmer(c05_total ~ c38_within + ... , data = data_centrada)
summary(model_4prueba)

ranova(model_4prueba)
# 1. Tu modelo completo original
mod_completo <- model_4prueba

# 2. Sin la pendiente aleatoria de EDAD (dejando las demás)
mod_sin_edad <- lmer(c05_total ~ c38_within + m0_edad_within + egp7 + trato_digno_grand + c15_grand + c32_within + Generacion + ola + 
                       (1 + c32_within + c38_within | idencuesta), 
                     data = data_centrada)

# 3. Sin la pendiente aleatoria de C32 (dejando las demás)
mod_sin_c32 <- lmer(c05_total ~ c38_within + m0_edad_within + egp7 + trato_digno_grand + c15_grand + c32_within + Generacion + ola + 
                      (1 + m0_edad_within + c38_within | idencuesta), 
                    data = data_centrada)

# 4. Sin la pendiente aleatoria de C38 (dejando las demás)
mod_sin_c38 <- lmer(c05_total ~ c38_within + m0_edad_within + egp7 + trato_digno_grand + c15_grand + c32_within + Generacion + ola + 
                      (1 + m0_edad_within + c32_within | idencuesta), 
                    data = data_centrada)

# Ahora sí, comparamos
anova(mod_completo, mod_sin_edad, mod_sin_c32, mod_sin_c38)




model_0_time <- lmer(c05_total ~ ola + (1 | idencuesta), data = data_centrada)

model_1_cent <- lmer(c05_total ~ c38_grand + m0_edad_grand + trato_digno_grand +
                       c15_grand + c32_grand + (1 | idencuesta), data = data_centrada)

model_2_cent <- lmer(c05_total ~ Generacion + egp7 +
                       (1 | idencuesta), data = data_centrada)

model_3b_cent <- lmer(c05_total ~ c38_grand + m0_edad_grand + egp7 +
                        trato_digno_grand + c15_grand + c32_grand + Generacion + ola +
                        (1 | idencuesta), data = data_centrada)

summary(model_1_cent)
summary(model_2_cent)
summary(model_3b_cent)
summary(model_3c_cent)

# ------------------------------------------------------------
# ------------------------------------------------------------
model_4_cent_test <- lmer(c05_total ~ c38_grand + m0_edad_within + egp7 +
                       trato_digno_grand + c15_grand + c32_grand + Generacion + ola + sexo + nedu +
                       (1 + m0_edad_within | idencuesta), data = data_centrada)

summary(model_4_cent_test)
 

 colnames(data_centrada)




model_cross_a <- lmer(
  c05_total ~ c38_grand + Generacion * egp7 +
    m0_edad_within +
    trato_digno_grand + c15_grand + c32_grand +
    ola + sexo + nedu +
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

model_cross_b <- lmer(
  c05_total ~ c38_grand + m0_edad_within +
    egp7 * nedu + trato_digno_grand +
   c32_grand +
    Generacion + ola + sexo + nedu +
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

model_cross_c <- lmer(
  c05_total ~ c38_grand + m0_edad_within +
   Generacion * nedu + trato_digno_grand +
    c15_grand + c32_grand +
    ola + sexo +
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

model_cross_d <- lmer(
  c05_total ~ c38_grand * Generacion + m0_edad_within +
    Generacion + egp7 + nedu + trato_digno_grand +
    c15_grand + c32_grand +
    ola + sexo +
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)


library(lmerTest)
summary(model_cross_a)
summary(model_cross_b)
summary(model_cross_c)
summary(model_cross_d)

anova(model_cross_a, model_cross_b, model_cross_c, model_cross_d, refit = FALSE)



model_cross_1 <- lmer(
  c05_total ~ c38_grand * m0_edad_within + 
    Generacion + egp7 + nedu + trato_digno_grand + 
    c15_grand + c32_grand + ola + sexo + 
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

model_cross_2 <- lmer(
  c05_total ~ trato_digno_grand * nedu + 
    c38_grand + m0_edad_within + Generacion + egp7 + 
    c15_grand + c32_grand + ola + sexo + 
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

model_cross_3 <- lmer(
  c05_total ~ c38_grand * sexo + 
    m0_edad_within + Generacion + egp7 + nedu + 
    trato_digno_grand + c15_grand + c32_grand + ola + 
    (1 + m0_edad_within | idencuesta),
  data = data_centrada
)

library(performance)

# Compara AIC, BIC y R2 de los tres modelos de interacción
compare_performance(model_cross_1, model_cross_2, model_cross_3, 
                    metrics = c("AIC", "BIC", "R2_marginal", "R2_conditional"))

summary(model_cross_1)


summary(model_0_cent)
summary(model_temp_cent)
summary(model_1_cent)
summary(model_2_cent)
summary(model_3b_cent)
summary(model_4_cent)
summary(model_cross_a)
summary(model_cross_b)
summary(model_cross_c)
summary(model_cross_d)





model_0_time <- lmer(c05_total ~ ola + (1 | idencuesta), data = data_centrada)

test1 <- lmer(c05_total ~ c38_grand + m0_edad_grand + trato_digno_grand + c15_grand + c32_grand+ (1 | idencuesta), data = data_centrada)
 
test2 <- lmer(c05_total ~ Generacion + egp7 + sexo + nedu + c38_between + m0_edad_between + trato_digno_between + c15_between + c32_between +
                       (1 | idencuesta), data = data_centrada)

test3 <- lmer(c05_total ~ c38_grand + m0_edad_grand + egp7 + c32_between + m0_edad_between + c38_between + trato_digno_between + 
c15_between + trato_digno_grand + c15_grand + c32_grand + Generacion + ola + sexo + nedu +
                        (1 | idencuesta), data = data_centrada)

summary(model_1_cent)
summary(model_2_cent)
summary(model_3b_cent)
summary(model_3c_cent)

# ------------------------------------------------------------
# 2.6) Modelos con pendientes aleatorias
# ------------------------------------------------------------


test5 <- lmer(c05_total ~ c38_grand + m0_edad_within * m0_edad_between + egp7 + c32_between + m0_edad_between + c38_between + trato_digno_between + 
c15_between + trato_digno_grand + c15_grand + c32_grand + Generacion + ola + sexo + nedu +
                    (1 + m0_edad_within | idencuesta), data = data_centrada)


summary(model_0_time)
summary(test1)
summary(test2)
summary(test3)
summary(test4)




tabla_test_path <- file.path(output_tables_dir, "tabla_test.html")

# Tabla de regresión
htmlreg(
  list(model_0_time, test1, test2, test3, test5),
  custom.model.names = c("Modelo 0", "Modelo 1", "Modelo 2", "Modelo 3", "test 5"),
  caption.above = TRUE,
  caption = NULL,
  stars = c(0.05, 0.01, 0.001),
  custom.coef.map = as.list(label_map),
  digits = 3,
  custom.note = "Note: Cells contain regression coefficients with standard errors in parentheses. %stars.",
  leading.zero = TRUE,
  include.loglik = FALSE, 
  include.aic = FALSE,    
  center = TRUE,
  # Ahora el vector tiene exactamente los 9 elementos que exige el nuevo diseño:
  custom.gof.names = c(
    "BIC",
    "Num. obs.",
    "Num. groups: individuals",
    "Var: individuals (Intercept)",
    "Var: individuals (m0_edad_within)",       # Varianza de la edad en test4
    "Cov: individuals (Intercept - m0_edad)", # Covarianza de la edad en test4   # Covarianza de c38 en test5
    "Var: Residual"
  ),
  file = tabla_test_path
)
browseURL(normalizePath(tabla_test_path))


rownames(coef(summary(test1)))
rownames(coef(summary(test2)))
rownames(coef(summary(test3)))
rownames(coef(summary(test4)))
rownames(coef(summary(modelo_final)))
extract(model_0_time)@gof.names
extract(test3)@gof.names
extract(modelo_final)@gof.names



modelo_interaccion_c32 <- lmer(c05_total ~ 
                # Interacción pura Within * Between para c32
                c32_within * c32_between + 
                
                # c38 vuelve a ser un control directo (separado en fijos)
                c38_grand + c38_between + 
                
                # El resto de tus controles directos normales
                m0_edad_grand + m0_edad_between + 
                c15_grand + trato_digno_grand + 
                c15_between + trato_digno_between + 
                egp7 + Generacion + ola + sexo + nedu +
                
                # Pendiente aleatoria en su versión WITHIN
                (1 + c32_within | idencuesta), 
              data = data_centrada,
              control = lmerControl(autoscale = TRUE))
modelo_interaccion_trato <- lmer(c05_total ~ 
                # Interacción pura Within * Between para Trato Digno
                trato_digno_within * trato_digno_between + 
                
                # El resto de tus controles directos normales
                c38_grand + c38_between +
                m0_edad_grand + m0_edad_between + 
                c32_grand + c32_between + 
                c15_grand + c15_between + 
                egp7 + Generacion + ola + sexo + nedu +
                
                # Pendiente aleatoria en su versión WITHIN
                (1 + trato_digno_within | idencuesta), 
              data = data_centrada,
              control = lmerControl(autoscale = TRUE))
modelo_interaccion_politica <- lmer(c05_total ~ 
                # Interacción pura Within * Between para Política
                c15_within * c15_between + 
                
                # El resto de tus controles directos normales
                c38_grand + c38_between +
                m0_edad_grand + m0_edad_between + 
                c32_grand + c32_between + 
                trato_digno_grand + trato_digno_between + 
                egp7 + Generacion + ola + sexo + nedu +
                
                # Pendiente aleatoria en su versión WITHIN
                (1 + c15_within | idencuesta), 
              data = data_centrada,
              control = lmerControl(autoscale = TRUE))

anova(model_4_cent, test5, refit = FALSE)


performance::r2(test5)
