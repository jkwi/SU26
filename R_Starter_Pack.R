# R Starter Pack: PSY220 Behavioral Statistics ----------------------------
# Summer 2026 | 5-Week Version
#
# Purpose:
# This file gives you starter code for practicing statistics in RStudio.
# We will use ONE practice dataset across the whole course:
#
#   student_success_practice_SU26.csv
#
# You do NOT need to understand every section right away.
# Each week, use only the section that matches the current week.
#
# Recommended object name for the dataset:
#
#   studentData
#
# Keeping the same object name all semester will make the code easier to follow.


# -------------------------------------------------------------------------
# 0) INSTALL AND LOAD PACKAGES
# -------------------------------------------------------------------------

# Install packages ONCE if you do not already have them:
# install.packages(c("tidyverse", "broom", "effectsize", "pwr"))

# Load packages every time you start a new RStudio session:
library(tidyverse)
library(broom)

# Optional packages used later in the course:
# library(effectsize)
# library(pwr)


# -------------------------------------------------------------------------
# 1) LOAD THE PRACTICE DATASET
# -------------------------------------------------------------------------

# Option A: Load the file from your computer.
# Put the CSV file in the same folder as this script, then run:
studentData <- read_csv("student_success_practice_SU26.csv")

# Option B: Load the file from a URL.
# If your instructor gives you a GitHub/raw URL, paste it between the quotes:
# studentData <- read_csv("PASTE_URL_HERE")


# -------------------------------------------------------------------------
# 2) FIRST LOOK AT THE DATA
# -------------------------------------------------------------------------

# View the dataset in a spreadsheet-style window:
View(studentData)

# See the first few rows:
head(studentData)

# See variable names:
names(studentData)

# Check variable types:
glimpse(studentData)

# Get a basic summary:
summary(studentData)


# =========================================================================
# WEEK 1: FOUNDATIONS, R, DESCRIPTIVE STATISTICS, AND BASIC GRAPHS
# =========================================================================

# Goal:
# Learn what is in the dataset, identify variable types, calculate descriptive
# statistics, and create basic visualizations.


# -------------------------------------------------------------------------
# 1A) IDENTIFY CATEGORICAL AND NUMERICAL VARIABLES
# -------------------------------------------------------------------------

# Examples of categorical variables:
# class_year, first_gen, athlete, major_group, tutoring_use, pass_course

# Examples of numerical variables:
# exercise_days, sleep_hours, study_hours, stress_score,
# belonging_score, academic_confidence, exam_score, gpa


# Frequency table for a categorical variable:
table(studentData$class_year)

table(studentData$tutoring_use)

# Proportions:
prop.table(table(studentData$class_year))

prop.table(table(studentData$tutoring_use))


# -------------------------------------------------------------------------
# 1B) DESCRIPTIVE STATISTICS FOR ONE NUMERICAL VARIABLE
# -------------------------------------------------------------------------

mean(studentData$exam_score)
median(studentData$exam_score)
sd(studentData$exam_score)

mean(studentData$stress_score)
median(studentData$stress_score)
sd(studentData$stress_score)


# -------------------------------------------------------------------------
# 1C) DESCRIPTIVE STATISTICS FOR SEVERAL VARIABLES
# -------------------------------------------------------------------------

studentData %>%
  summarise(
    mean_sleep = mean(sleep_hours),
    sd_sleep = sd(sleep_hours),
    mean_stress = mean(stress_score),
    sd_stress = sd(stress_score),
    mean_exam = mean(exam_score),
    sd_exam = sd(exam_score)
  )


# -------------------------------------------------------------------------
# 1D) DESCRIPTIVE STATISTICS BY GROUP
# -------------------------------------------------------------------------

studentData %>%
  group_by(tutoring_use) %>%
  summarise(
    n = n(),
    mean_exam = mean(exam_score),
    sd_exam = sd(exam_score)
  )

studentData %>%
  group_by(first_gen) %>%
  summarise(
    n = n(),
    mean_belonging = mean(belonging_score),
    sd_belonging = sd(belonging_score)
  )


# -------------------------------------------------------------------------
# 1E) HISTOGRAMS
# -------------------------------------------------------------------------

ggplot(studentData, aes(x = exam_score)) +
  geom_histogram(bins = 15) +
  labs(
    title = "Distribution of Exam Scores",
    x = "Exam Score",
    y = "Number of Students"
  )

ggplot(studentData, aes(x = stress_score)) +
  geom_histogram(bins = 15) +
  labs(
    title = "Distribution of Stress Scores",
    x = "Stress Score",
    y = "Number of Students"
  )


# -------------------------------------------------------------------------
# 1F) BOXPLOTS
# -------------------------------------------------------------------------

ggplot(studentData, aes(x = tutoring_use, y = exam_score)) +
  geom_boxplot() +
  labs(
    title = "Exam Scores by Tutoring Use",
    x = "Tutoring Use",
    y = "Exam Score"
  )

ggplot(studentData, aes(x = first_gen, y = belonging_score)) +
  geom_boxplot() +
  labs(
    title = "Belonging Scores by First-Generation Status",
    x = "First-Generation Student",
    y = "Belonging Score"
  )


# WEEK 1 INTERPRETATION REMINDERS:
# - What is the typical score?
# - How much do students vary?
# - Are there possible outliers?
# - Does the graph match the descriptive statistics?


# =========================================================================
# WEEK 2: PROBABILITY, SAMPLING, CONFIDENCE INTERVALS, AND T-TESTS
# =========================================================================

# Goal:
# Practice comparing one or two means and interpreting p-values, confidence
# intervals, and effect sizes.


# -------------------------------------------------------------------------
# 2A) ONE-SAMPLE T-TEST
# -------------------------------------------------------------------------

# Example question:
# Is the average exam score different from 75?

t.test(studentData$exam_score, mu = 75)


# -------------------------------------------------------------------------
# 2B) INDEPENDENT-SAMPLES T-TEST
# -------------------------------------------------------------------------

# Example question:
# Do students who used tutoring have different exam scores than students
# who did not use tutoring?

tutoring_ttest <- t.test(exam_score ~ tutoring_use, data = studentData)
tutoring_ttest

# Tidy version of the output:
tidy(tutoring_ttest)


# Another example:
# Do first-generation and non-first-generation students differ in belonging?

belonging_ttest <- t.test(belonging_score ~ first_gen, data = studentData)
belonging_ttest
tidy(belonging_ttest)


# -------------------------------------------------------------------------
# 2C) PAIRED-SAMPLES T-TEST TEMPLATE
# -------------------------------------------------------------------------

# This practice dataset does not have a true pre/post pair.
# Use this template only when you have two repeated-measure variables:
#
# t.test(data$score_time1, data$score_time2, paired = TRUE)


# -------------------------------------------------------------------------
# 2D) SIMPLE EFFECT SIZE: COHEN'S D
# -------------------------------------------------------------------------

# Option 1: Use the effectsize package.
# Uncomment these lines if the package is installed:

# library(effectsize)
# cohens_d(exam_score ~ tutoring_use, data = studentData)

# Option 2: Calculate Cohen's d manually for two independent groups.

tutoring_yes <- studentData %>% filter(tutoring_use == "Yes")
tutoring_no  <- studentData %>% filter(tutoring_use == "No")

mean_yes <- mean(tutoring_yes$exam_score)
mean_no  <- mean(tutoring_no$exam_score)

sd_yes <- sd(tutoring_yes$exam_score)
sd_no  <- sd(tutoring_no$exam_score)

n_yes <- nrow(tutoring_yes)
n_no  <- nrow(tutoring_no)

pooled_sd <- sqrt(((n_yes - 1)*sd_yes^2 + (n_no - 1)*sd_no^2) /
                    (n_yes + n_no - 2))

cohens_d_manual <- (mean_yes - mean_no) / pooled_sd
cohens_d_manual


# -------------------------------------------------------------------------
# 2E) BOOTSTRAP CONFIDENCE INTERVAL FOR A MEAN
# -------------------------------------------------------------------------

# Example:
# Bootstrap the mean exam score.

set.seed(220)

bootstrap_means <- replicate(1000, {
  sample_data <- sample(studentData$exam_score, size = nrow(studentData), replace = TRUE)
  mean(sample_data)
})

# View the bootstrap distribution:
hist(bootstrap_means)

# 95% bootstrap confidence interval:
quantile(bootstrap_means, probs = c(.025, .975))


# WEEK 2 INTERPRETATION REMINDERS:
# - What is the null hypothesis?
# - What does the p-value tell you?
# - What does the confidence interval suggest?
# - Is the effect meaningful, not just statistically significant?


# =========================================================================
# WEEK 3: ONE-WAY ANOVA AND MIDTERM PROJECT PRACTICE
# =========================================================================

# Goal:
# Practice comparing means across three or more groups.


# -------------------------------------------------------------------------
# 3A) ONE-WAY ANOVA
# -------------------------------------------------------------------------

# Example question:
# Does academic confidence differ by class year?

confidence_anova <- aov(academic_confidence ~ class_year, data = studentData)

summary(confidence_anova)


# -------------------------------------------------------------------------
# 3B) GROUP DESCRIPTIVES FOR ANOVA
# -------------------------------------------------------------------------

studentData %>%
  group_by(class_year) %>%
  summarise(
    n = n(),
    mean_confidence = mean(academic_confidence),
    sd_confidence = sd(academic_confidence)
  )


# -------------------------------------------------------------------------
# 3C) ANOVA VISUALIZATION
# -------------------------------------------------------------------------

ggplot(studentData, aes(x = class_year, y = academic_confidence)) +
  geom_boxplot() +
  labs(
    title = "Academic Confidence by Class Year",
    x = "Class Year",
    y = "Academic Confidence"
  )


# -------------------------------------------------------------------------
# 3D) POST HOC TESTS
# -------------------------------------------------------------------------

# Use Tukey's HSD after a statistically significant ANOVA
# to see which groups differ from each other.

TukeyHSD(confidence_anova)


# -------------------------------------------------------------------------
# 3E) EFFECT SIZE FOR ANOVA
# -------------------------------------------------------------------------

# Option 1: Use the effectsize package.
# Uncomment these lines if the package is installed:

# library(effectsize)
# eta_squared(confidence_anova)

# Option 2:
# In an intro course, focus first on interpreting the ANOVA result,
# the group means, and the size of the visible differences.


# WEEK 3 INTERPRETATION REMINDERS:
# - Why is ANOVA better than running many t-tests?
# - Are the group means meaningfully different?
# - Which groups appear most different?
# - What real-world interpretation would you give?


# =========================================================================
# WEEK 4: CORRELATION AND REGRESSION
# =========================================================================

# Goal:
# Practice describing relationships between numerical variables and using
# one variable to predict another.


# -------------------------------------------------------------------------
# 4A) SCATTERPLOTS
# -------------------------------------------------------------------------

ggplot(studentData, aes(x = study_hours, y = exam_score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Study Hours and Exam Score",
    x = "Study Hours",
    y = "Exam Score"
  )

ggplot(studentData, aes(x = stress_score, y = gpa)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Stress Score and GPA",
    x = "Stress Score",
    y = "GPA"
  )


# -------------------------------------------------------------------------
# 4B) CORRELATION
# -------------------------------------------------------------------------

cor(studentData$study_hours, studentData$exam_score)

cor.test(studentData$study_hours, studentData$exam_score)

cor.test(studentData$stress_score, studentData$gpa)

cor.test(studentData$belonging_score, studentData$academic_confidence)


# -------------------------------------------------------------------------
# 4C) SIMPLE LINEAR REGRESSION
# -------------------------------------------------------------------------

# Example question:
# Do study hours predict exam score?

study_model <- lm(exam_score ~ study_hours, data = studentData)

summary(study_model)

tidy(study_model)


# -------------------------------------------------------------------------
# 4D) MULTIPLE REGRESSION
# -------------------------------------------------------------------------

# Example question:
# Do study hours, sleep, stress, and academic confidence predict exam score?

exam_model <- lm(exam_score ~ study_hours + sleep_hours + stress_score + academic_confidence,
                 data = studentData)

summary(exam_model)

tidy(exam_model)


# -------------------------------------------------------------------------
# 4E) RESIDUALS
# -------------------------------------------------------------------------

# Add predicted values and residuals to the dataset:
studentData_with_residuals <- studentData %>%
  mutate(
    predicted_exam = predict(exam_model),
    residual_exam = residuals(exam_model)
  )

# View residuals:
head(studentData_with_residuals)

# Plot predicted values and residuals:
ggplot(studentData_with_residuals, aes(x = predicted_exam, y = residual_exam)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(
    title = "Residual Plot for Exam Score Regression Model",
    x = "Predicted Exam Score",
    y = "Residual"
  )


# WEEK 4 INTERPRETATION REMINDERS:
# - Is the relationship positive or negative?
# - Is the relationship weak, moderate, or strong?
# - What does the slope mean?
# - What does R-squared mean?
# - What does a residual represent?


# =========================================================================
# WEEK 5: CATEGORICAL INFERENCE AND FINAL PROJECT PRACTICE
# =========================================================================

# Goal:
# Practice analyzing relationships between categorical variables using tables
# and chi-square tests.


# -------------------------------------------------------------------------
# 5A) FREQUENCY TABLES
# -------------------------------------------------------------------------

table(studentData$first_gen)

table(studentData$tutoring_use)

table(studentData$pass_course)


# -------------------------------------------------------------------------
# 5B) CONTINGENCY TABLES
# -------------------------------------------------------------------------

# Example question:
# Is first-generation status related to tutoring use?

firstgen_tutoring_table <- table(studentData$first_gen, studentData$tutoring_use)
firstgen_tutoring_table

# Row proportions:
prop.table(firstgen_tutoring_table, margin = 1)

# Column proportions:
prop.table(firstgen_tutoring_table, margin = 2)


# -------------------------------------------------------------------------
# 5C) CHI-SQUARE TEST OF INDEPENDENCE
# -------------------------------------------------------------------------

chisq.test(firstgen_tutoring_table)


# Another example:
# Is tutoring use related to whether students passed the course?

tutoring_pass_table <- table(studentData$tutoring_use, studentData$pass_course)
tutoring_pass_table

prop.table(tutoring_pass_table, margin = 1)

chisq.test(tutoring_pass_table)


# -------------------------------------------------------------------------
# 5D) EXPECTED FREQUENCIES
# -------------------------------------------------------------------------

chi_result <- chisq.test(tutoring_pass_table)

chi_result$expected


# -------------------------------------------------------------------------
# 5E) CRAMER'S V EFFECT SIZE
# -------------------------------------------------------------------------

# Option 1: Use effectsize package.
# Uncomment these lines if the package is installed:

# library(effectsize)
# cramers_v(tutoring_pass_table)


# WEEK 5 INTERPRETATION REMINDERS:
# - What are the two categorical variables?
# - What does the contingency table show?
# - Are the observed counts different from expected counts?
# - What does the chi-square test tell you?
# - What is the practical meaning of the association?


# =========================================================================
# FINAL REMINDER
# =========================================================================

# R is a tool for thinking with data.
# Do not worry about memorizing every command.
# Focus on:
#   1. What question am I asking?
#   2. What kind of variables do I have?
#   3. What statistical test fits the question?
#   4. What do the results mean?
#   5. How would I explain the findings clearly?
