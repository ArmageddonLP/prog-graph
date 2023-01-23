CREATE TABLE IF NOT EXISTS roles (
  role_id SERIAL PRIMARY KEY,
  role_name VARCHAR(50),
  role_unique_shorthand VARCHAR(10) UNIQUE
);