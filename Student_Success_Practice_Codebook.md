# Student Success Practice Dataset — SU26

This synthetic dataset represents 250 fictional college students. It is designed for practice in PSY220 Behavioral Statistics and can support descriptive statistics, visualization, t-tests, ANOVA, correlation, regression, and chi-square analyses.

## Variables

| Variable | Type | Description | Example / Values |
|---|---|---|---|
| student_id | ID | Unique fictional student identifier | SU26_001 |
| class_year | Categorical | Student class standing | First-Year, Sophomore, Junior, Senior |
| first_gen | Categorical | Whether student is a first-generation college student | Yes, No |
| athlete | Categorical | Whether student is a collegiate athlete | Yes, No |
| major_group | Categorical | Broad academic major area | Psychology, Health Sciences, Business, Education, Social Sciences, STEM |
| tutoring_use | Categorical | Whether student used tutoring or academic support services | Yes, No |
| exercise_days | Numerical, discrete | Number of days per week student exercises | 0–7 |
| sleep_hours | Numerical, continuous | Average hours of sleep per night | Approximately 3.5–9.5 |
| study_hours | Numerical, continuous | Average weekly study hours for this course | Approximately 1–20 |
| stress_score | Numerical, continuous | Academic stress score; higher scores indicate greater stress | 20–95 |
| belonging_score | Numerical, continuous | Sense of belonging score; higher scores indicate stronger belonging | 20–100 |
| academic_confidence | Numerical, continuous | Academic confidence score; higher scores indicate stronger confidence | 20–100 |
| exam_score | Numerical, continuous | Final exam score | 35–100 |
| gpa | Numerical, continuous | End-of-term GPA | 1.20–4.00 |
| pass_course | Categorical | Whether the student passed the course | Yes, No |

## Suggested Uses by Week

### Week 1: Foundations, R & Descriptive Statistics
Use `sleep_hours`, `study_hours`, `stress_score`, `belonging_score`, `exam_score`, and `gpa` for descriptive statistics, histograms, and boxplots. Use `class_year`, `first_gen`, `athlete`, and `tutoring_use` to practice identifying categorical variables.

### Week 2: Probability, Sampling & t-Tests
Use two-group comparisons such as:
- `exam_score` by `tutoring_use`
- `stress_score` by `athlete`
- `belonging_score` by `first_gen`

### Week 3: ANOVA
Use multi-group comparisons such as:
- `academic_confidence` by `class_year`
- `gpa` by `class_year`
- `stress_score` by `major_group`

### Week 4: Correlation & Regression
Use relationships among:
- `study_hours`, `sleep_hours`, `stress_score`, `belonging_score`, `academic_confidence`, `exam_score`, and `gpa`

### Week 5: Categorical Inference
Use categorical associations such as:
- `first_gen` and `tutoring_use`
- `tutoring_use` and `pass_course`
- `athlete` and `pass_course`

## Note for Students

This dataset is fictional and was created for learning purposes. It is realistic enough for statistical practice but should not be interpreted as real evidence about college students.
