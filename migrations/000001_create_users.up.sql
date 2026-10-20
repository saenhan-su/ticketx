CREATE TABLE users (
    id UUID PRIMARY KEY,
    email TEXT UNIQUE,
    phone_number TEXT UNIQUE,
    password_hash TEXT,
    status TEXT NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT users_email_or_phone_present CHECK (email IS NOT NULL OR phone_number IS NOT NULL)
);
