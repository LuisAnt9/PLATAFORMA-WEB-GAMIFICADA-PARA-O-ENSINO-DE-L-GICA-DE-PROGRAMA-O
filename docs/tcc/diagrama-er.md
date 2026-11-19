# Diagrama entidade-relacionamento

> Gerado automaticamente das migrations por `npm run docs:er` (não edite à mão). Colunas marcadas PK (chave primária) e FK (chave estrangeira). Só as tabelas do esquema `public`; as contas de login ficam em `auth.users` (Supabase Auth) e se ligam a `profiles`.

```mermaid
erDiagram
  ai_hints {
    bigint id PK
    uuid user_id FK
    text exercise_id FK
    date day
    timestamptz created_at
  }
  assessment_keys {
    bigint question_id PK
    jsonb answer
  }
  assessment_questions {
    bigint id PK
    bigint assignment_id FK
    text source_exercise_id FK
    integer position
    text kind
    text title
    text statement
    jsonb payload
    integer points
  }
  assessment_submissions {
    bigint id PK
    bigint assignment_id FK
    uuid user_id FK
    timestamptz submitted_at
    jsonb answers
    jsonb details
    integer score
    integer max_score
  }
  assignment_items {
    bigint assignment_id PK
    text exercise_id PK
    integer position
    integer points
  }
  assignments {
    bigint id PK
    uuid class_id FK
    uuid teacher_id FK
    text kind
    text title
    text instructions
    timestamptz available_from
    timestamptz due_at
    boolean required
    text result_rule
    boolean archived
    timestamptz created_at
  }
  attempts {
    bigint id PK
    uuid user_id FK
    text exercise_id FK
    timestamptz created_at
    text kind
    boolean passed
    text answer
    integer tests_passed
    integer tests_total
    text error_category
    text misconception
    integer duration_ms
    text mode
    bigint assignment_id FK
    smallint hint_level
  }
  class_members {
    uuid class_id PK
    uuid student_id PK
    timestamptz joined_at
  }
  classes {
    uuid id PK
    text name
    text code
    uuid teacher_id FK
    timestamptz created_at
    boolean archived
  }
  concepts {
    text id PK
    text title
    text description
    text world_id FK
    integer position
  }
  daily_activity {
    uuid user_id PK
    date day PK
    integer attempts
    integer solved
  }
  exercise_concepts {
    text exercise_id PK
    text concept_id PK
    smallint weight
  }
  exercise_progress {
    uuid user_id PK
    text exercise_id PK
    integer attempts
    boolean solved
    boolean first_try
    integer xp
    timestamptz solved_at
    timestamptz updated_at
  }
  exercise_solutions {
    text exercise_id PK
    text solution
    text commentary
  }
  exercises {
    text id PK
    text module_id FK
    text title
    text difficulty
    text statement
    text function_name
    text starter_code
    jsonb tests
    text hint
    integer position
    boolean published
    uuid created_by FK
    timestamptz created_at
    timestamptz updated_at
    text kind
    jsonb config
    text lesson
    text origem
  }
  mission_claims {
    uuid user_id PK
    text mission_id PK
    date day PK
    integer xp
    timestamptz claimed_at
  }
  missions {
    text id PK
    text title
    text description
    text kind
    integer target
    integer xp
    integer position
  }
  modules {
    text id PK
    text title
    text focus
    integer position
    text intro
    text world_id FK
    text example
    text review
    text origem
    boolean optional
  }
  profiles {
    uuid id PK
    text name
    text role
    timestamptz created_at
    boolean show_in_ranking
    timestamptz consent_at
    text consent_version
    boolean over_18
    boolean ai_hints_enabled
  }
  survey_done {
    uuid user_id PK
    text kind PK
    timestamptz done_at
  }
  survey_responses {
    bigint id PK
    text kind
    uuid user_id FK
    uuid class_id FK
    boolean anonymous
    jsonb answers
    numeric score
    text comment
    timestamptz created_at
  }
  user_badges {
    uuid user_id PK
    text badge_id PK
    timestamptz earned_at
  }
  world_bonuses {
    uuid user_id PK
    text world_id PK
    integer xp
    timestamptz claimed_at
  }
  worlds {
    text id PK
    text title
    text objective
    integer position
  }
  exercises ||--o{ ai_hints : "exercise_id"
  profiles ||--o{ ai_hints : "user_id"
  assessment_questions ||--o{ assessment_keys : "question_id"
  assignments ||--o{ assessment_questions : "assignment_id"
  exercises ||--o{ assessment_questions : "source_exercise_id"
  assignments ||--o{ assessment_submissions : "assignment_id"
  profiles ||--o{ assessment_submissions : "user_id"
  assignments ||--o{ assignment_items : "assignment_id"
  exercises ||--o{ assignment_items : "exercise_id"
  classes ||--o{ assignments : "class_id"
  profiles ||--o{ assignments : "teacher_id"
  assignments |o--o{ attempts : "assignment_id"
  exercises ||--o{ attempts : "exercise_id"
  profiles ||--o{ attempts : "user_id"
  classes ||--o{ class_members : "class_id"
  profiles ||--o{ class_members : "student_id"
  profiles ||--o{ classes : "teacher_id"
  worlds |o--o{ concepts : "world_id"
  profiles ||--o{ daily_activity : "user_id"
  concepts ||--o{ exercise_concepts : "concept_id"
  exercises ||--o{ exercise_concepts : "exercise_id"
  exercises ||--o{ exercise_progress : "exercise_id"
  profiles ||--o{ exercise_progress : "user_id"
  exercises ||--o{ exercise_solutions : "exercise_id"
  modules ||--o{ exercises : "module_id"
  profiles |o--o{ exercises : "created_by"
  missions ||--o{ mission_claims : "mission_id"
  profiles ||--o{ mission_claims : "user_id"
  worlds |o--o{ modules : "world_id"
  profiles ||--o{ survey_done : "user_id"
  classes |o--o{ survey_responses : "class_id"
  profiles |o--o{ survey_responses : "user_id"
  profiles ||--o{ user_badges : "user_id"
  profiles ||--o{ world_bonuses : "user_id"
  worlds ||--o{ world_bonuses : "world_id"
```

## Tabelas

Total: 24 tabelas e 35 relacionamentos.
