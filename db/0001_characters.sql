-- Created: 2026-05-17

CREATE TABLE IF NOT EXISTS evolution.character_types (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  tag_name text NOT NULL,
  tag_color text NOT NULL,
  multiplier double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);

DROP TRIGGER IF EXISTS character_types_update_datetime ON evolution.character_types;
CREATE TRIGGER character_types_update_datetime
  BEFORE UPDATE ON evolution.character_types
  FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.characters (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_guid uuid NOT NULL REFERENCES genrpg.characters(guid) ON DELETE CASCADE,
  character_type_guid uuid REFERENCES evolution.character_types(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);

DROP TRIGGER IF EXISTS characters_update_datetime ON evolution.characters;
CREATE TRIGGER characters_update_datetime
  BEFORE UPDATE ON evolution.characters
  FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();
