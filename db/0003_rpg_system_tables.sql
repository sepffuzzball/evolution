-- Created: 2026-05-18

CREATE TABLE IF NOT EXISTS evolution.stat_categories (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  order_num integer NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS stat_categories_update_datetime ON evolution.stat_categories;
CREATE TRIGGER stat_categories_update_datetime BEFORE UPDATE ON evolution.stat_categories FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.stat_roles (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  order_num integer NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS stat_roles_update_datetime ON evolution.stat_roles;
CREATE TRIGGER stat_roles_update_datetime BEFORE UPDATE ON evolution.stat_roles FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.primary_stats (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  order_num integer NOT NULL,
  tag_name text NOT NULL,
  tag_color text NOT NULL,
  stat_role_guid uuid REFERENCES evolution.stat_roles(guid) ON DELETE SET NULL,
  stat_category_guid uuid REFERENCES evolution.stat_categories(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS primary_stats_update_datetime ON evolution.primary_stats;
CREATE TRIGGER primary_stats_update_datetime BEFORE UPDATE ON evolution.primary_stats FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.secondary_stats (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  order_num integer NOT NULL,
  tag_name text NOT NULL,
  tag_color text NOT NULL,
  tier_scaled_stat_guid uuid REFERENCES evolution.primary_stats(guid) ON DELETE SET NULL,
  added_stat_guid uuid REFERENCES evolution.primary_stats(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS secondary_stats_update_datetime ON evolution.secondary_stats;
CREATE TRIGGER secondary_stats_update_datetime BEFORE UPDATE ON evolution.secondary_stats FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.tiers (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  order_num integer NOT NULL,
  tag_name text NOT NULL,
  tag_color text NOT NULL,
  max_level integer NOT NULL,
  static_tier_bonus integer NOT NULL,
  race_multiplier double precision NOT NULL,
  class_multiplier double precision NOT NULL,
  profession_multiplier double precision NOT NULL,
  item_multiplier double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS tiers_update_datetime ON evolution.tiers;
CREATE TRIGGER tiers_update_datetime BEFORE UPDATE ON evolution.tiers FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.rarities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  order_num integer NOT NULL,
  tag_name text NOT NULL,
  tag_color text NOT NULL,
  rarity_multiplier double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS rarities_update_datetime ON evolution.rarities;
CREATE TRIGGER rarities_update_datetime BEFORE UPDATE ON evolution.rarities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.currencies (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  tag_name text NOT NULL,
  tag_color text NOT NULL,
  value double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS currencies_update_datetime ON evolution.currencies;
CREATE TRIGGER currencies_update_datetime BEFORE UPDATE ON evolution.currencies FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  tag_name text,
  tag_color text,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS affinities_update_datetime ON evolution.affinities;
CREATE TRIGGER affinities_update_datetime BEFORE UPDATE ON evolution.affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.cooldowns (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS cooldowns_update_datetime ON evolution.cooldowns;
CREATE TRIGGER cooldowns_update_datetime BEFORE UPDATE ON evolution.cooldowns FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.casting_times (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS casting_times_update_datetime ON evolution.casting_times;
CREATE TRIGGER casting_times_update_datetime BEFORE UPDATE ON evolution.casting_times FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.skill_costs (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS skill_costs_update_datetime ON evolution.skill_costs;
CREATE TRIGGER skill_costs_update_datetime BEFORE UPDATE ON evolution.skill_costs FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.skills (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  min_tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  rarity_guid uuid REFERENCES evolution.rarities(guid) ON DELETE SET NULL,
  is_active boolean NOT NULL DEFAULT true,
  is_leveled boolean NOT NULL DEFAULT true,
  skill_cost_guid uuid REFERENCES evolution.skill_costs(guid) ON DELETE SET NULL,
  cost_stat_guid uuid REFERENCES evolution.secondary_stats(guid) ON DELETE SET NULL,
  cooldown_guid uuid REFERENCES evolution.cooldowns(guid) ON DELETE SET NULL,
  casting_time_guid uuid REFERENCES evolution.casting_times(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS skills_update_datetime ON evolution.skills;
CREATE TRIGGER skills_update_datetime BEFORE UPDATE ON evolution.skills FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.skill_affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  skill_guid uuid NOT NULL REFERENCES evolution.skills(guid) ON DELETE CASCADE,
  affinity_guid uuid NOT NULL REFERENCES evolution.affinities(guid) ON DELETE CASCADE,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS skill_affinities_update_datetime ON evolution.skill_affinities;
CREATE TRIGGER skill_affinities_update_datetime BEFORE UPDATE ON evolution.skill_affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.races (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  character_type_guid uuid REFERENCES evolution.character_types(guid) ON DELETE SET NULL,
  rarity_guid uuid REFERENCES evolution.rarities(guid) ON DELETE SET NULL,
  min_tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS races_update_datetime ON evolution.races;
CREATE TRIGGER races_update_datetime BEFORE UPDATE ON evolution.races FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.race_affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  race_guid uuid NOT NULL REFERENCES evolution.races(guid) ON DELETE CASCADE,
  affinity_guid uuid NOT NULL REFERENCES evolution.affinities(guid) ON DELETE CASCADE,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS race_affinities_update_datetime ON evolution.race_affinities;
CREATE TRIGGER race_affinities_update_datetime BEFORE UPDATE ON evolution.race_affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.race_stat_ratios (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  race_guid uuid NOT NULL REFERENCES evolution.races(guid) ON DELETE CASCADE,
  stat_guid uuid NOT NULL REFERENCES evolution.primary_stats(guid) ON DELETE CASCADE,
  ratio double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS race_stat_ratios_update_datetime ON evolution.race_stat_ratios;
CREATE TRIGGER race_stat_ratios_update_datetime BEFORE UPDATE ON evolution.race_stat_ratios FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.classes (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  character_type_guid uuid REFERENCES evolution.character_types(guid) ON DELETE SET NULL,
  rarity_guid uuid REFERENCES evolution.rarities(guid) ON DELETE SET NULL,
  min_tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS classes_update_datetime ON evolution.classes;
CREATE TRIGGER classes_update_datetime BEFORE UPDATE ON evolution.classes FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.class_affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_guid uuid NOT NULL REFERENCES evolution.classes(guid) ON DELETE CASCADE,
  affinity_guid uuid NOT NULL REFERENCES evolution.affinities(guid) ON DELETE CASCADE,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS class_affinities_update_datetime ON evolution.class_affinities;
CREATE TRIGGER class_affinities_update_datetime BEFORE UPDATE ON evolution.class_affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.class_stat_ratios (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  class_guid uuid NOT NULL REFERENCES evolution.classes(guid) ON DELETE CASCADE,
  stat_guid uuid NOT NULL REFERENCES evolution.primary_stats(guid) ON DELETE CASCADE,
  ratio double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS class_stat_ratios_update_datetime ON evolution.class_stat_ratios;
CREATE TRIGGER class_stat_ratios_update_datetime BEFORE UPDATE ON evolution.class_stat_ratios FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.professions (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  character_type_guid uuid REFERENCES evolution.character_types(guid) ON DELETE SET NULL,
  rarity_guid uuid REFERENCES evolution.rarities(guid) ON DELETE SET NULL,
  min_tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS professions_update_datetime ON evolution.professions;
CREATE TRIGGER professions_update_datetime BEFORE UPDATE ON evolution.professions FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.profession_affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  profession_guid uuid NOT NULL REFERENCES evolution.professions(guid) ON DELETE CASCADE,
  affinity_guid uuid NOT NULL REFERENCES evolution.affinities(guid) ON DELETE CASCADE,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS profession_affinities_update_datetime ON evolution.profession_affinities;
CREATE TRIGGER profession_affinities_update_datetime BEFORE UPDATE ON evolution.profession_affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.profession_stat_ratios (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  profession_guid uuid NOT NULL REFERENCES evolution.professions(guid) ON DELETE CASCADE,
  stat_guid uuid NOT NULL REFERENCES evolution.primary_stats(guid) ON DELETE CASCADE,
  ratio double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS profession_stat_ratios_update_datetime ON evolution.profession_stat_ratios;
CREATE TRIGGER profession_stat_ratios_update_datetime BEFORE UPDATE ON evolution.profession_stat_ratios FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.item_types (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text,
  is_equippable boolean NOT NULL DEFAULT false,
  equip_max integer,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS item_types_update_datetime ON evolution.item_types;
CREATE TRIGGER item_types_update_datetime BEFORE UPDATE ON evolution.item_types FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.item_affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_guid uuid NOT NULL REFERENCES genrpg.item_templates(guid) ON DELETE CASCADE,
  affinity_guid uuid NOT NULL REFERENCES evolution.affinities(guid) ON DELETE CASCADE,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS item_affinities_update_datetime ON evolution.item_affinities;
CREATE TRIGGER item_affinities_update_datetime BEFORE UPDATE ON evolution.item_affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.items (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_guid uuid NOT NULL UNIQUE REFERENCES genrpg.item_templates(guid) ON DELETE CASCADE,
  item_type_guid uuid REFERENCES evolution.item_types(guid) ON DELETE SET NULL,
  rarity_guid uuid REFERENCES evolution.rarities(guid) ON DELETE SET NULL,
  tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS items_update_datetime ON evolution.items;
CREATE TRIGGER items_update_datetime BEFORE UPDATE ON evolution.items FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.item_stat_ratios (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_guid uuid NOT NULL REFERENCES genrpg.item_templates(guid) ON DELETE CASCADE,
  stat_guid uuid NOT NULL REFERENCES evolution.primary_stats(guid) ON DELETE CASCADE,
  ratio double precision NOT NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS item_stat_ratios_update_datetime ON evolution.item_stat_ratios;
CREATE TRIGGER item_stat_ratios_update_datetime BEFORE UPDATE ON evolution.item_stat_ratios FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.character_races (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_guid uuid NOT NULL REFERENCES genrpg.characters(guid) ON DELETE CASCADE,
  race_guid uuid NOT NULL REFERENCES evolution.races(guid) ON DELETE CASCADE,
  tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS character_races_update_datetime ON evolution.character_races;
CREATE TRIGGER character_races_update_datetime BEFORE UPDATE ON evolution.character_races FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.character_classes (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_guid uuid NOT NULL REFERENCES genrpg.characters(guid) ON DELETE CASCADE,
  class_guid uuid NOT NULL REFERENCES evolution.classes(guid) ON DELETE CASCADE,
  tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS character_classes_update_datetime ON evolution.character_classes;
CREATE TRIGGER character_classes_update_datetime BEFORE UPDATE ON evolution.character_classes FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.character_professions (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_guid uuid NOT NULL REFERENCES genrpg.characters(guid) ON DELETE CASCADE,
  profession_guid uuid NOT NULL REFERENCES evolution.professions(guid) ON DELETE CASCADE,
  tier_guid uuid REFERENCES evolution.tiers(guid) ON DELETE SET NULL,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS character_professions_update_datetime ON evolution.character_professions;
CREATE TRIGGER character_professions_update_datetime BEFORE UPDATE ON evolution.character_professions FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();

CREATE TABLE IF NOT EXISTS evolution.character_affinities (
  guid uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  character_guid uuid NOT NULL REFERENCES genrpg.characters(guid) ON DELETE CASCADE,
  affinity_guid uuid NOT NULL REFERENCES evolution.affinities(guid) ON DELETE CASCADE,
  create_datetime timestamptz NOT NULL DEFAULT now(),
  update_datetime timestamptz NOT NULL DEFAULT now()
);
DROP TRIGGER IF EXISTS character_affinities_update_datetime ON evolution.character_affinities;
CREATE TRIGGER character_affinities_update_datetime BEFORE UPDATE ON evolution.character_affinities FOR EACH ROW EXECUTE FUNCTION genrpg.set_update_datetime();
