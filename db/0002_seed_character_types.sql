-- Created: 2026-05-17
-- Seed the default evolution character types

INSERT INTO evolution.character_types (guid, name, tag_name, tag_color, multiplier) VALUES
  (gen_random_uuid(), 'Humanoid', 'H', '#3b82f6', 1.0),
  (gen_random_uuid(), 'Half-Monster', 'HM', '#a855f7', 2.0),
  (gen_random_uuid(), 'Monster', 'M', '#ef4444', 3.0);
