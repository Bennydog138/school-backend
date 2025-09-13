CREATE EXTENSION IF NOT EXISTS pgcrypto;


CREATE TABLE users (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
name TEXT NOT NULL,
email TEXT UNIQUE NOT NULL,
password_hash TEXT NOT NULL,
role TEXT NOT NULL DEFAULT 'teacher',
created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE students (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
name TEXT NOT NULL,
year TEXT,
class TEXT,
created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE notes (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
student_id UUID REFERENCES students(id) ON DELETE CASCADE,
type TEXT NOT NULL,
content TEXT NOT NULL,
created_by UUID REFERENCES users(id),
created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE points (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
student_id UUID REFERENCES students(id) ON DELETE CASCADE,
kind TEXT NOT NULL,
value INT NOT NULL,
reason TEXT NOT NULL,
created_by UUID REFERENCES users(id),
created_at TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE oncalls (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
requested_by UUID REFERENCES users(id),
room TEXT NOT NULL,
category TEXT NOT NULL,
details TEXT,
created_at TIMESTAMPTZ DEFAULT now()
);
