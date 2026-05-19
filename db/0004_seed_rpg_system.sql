-- Created: 2026-05-18

INSERT INTO evolution.stat_categories (name, description, order_num) VALUES
('Physical', 'Stats related to physical attributes and traits', 1),
('Movement', 'Stats related to speed and physical traversal', 2),
('Mental', 'Stats representing intellect, memory, and cognitive processing', 3),
('Social', 'Stats governing interpersonal interactions and influence', 4),
('Magical', 'Stats controlling magical power and mystical affinity', 5),
('Sensory', 'Stats covering awareness, observation, and perception', 6);

INSERT INTO evolution.stat_roles (name, description, order_num) VALUES
('Aggressive', 'Stats used primarily for offensive or active actions', 1),
('Defensive', 'Stats used primarily for survival, resistance, or passive reactions', 2);

INSERT INTO evolution.primary_stats (name, description, order_num, tag_name, tag_color, stat_role_guid, stat_category_guid) VALUES
('Strength', 'Measures sheer physical power and carrying capacity', 1, 'STR', '#ef4444', (SELECT guid FROM evolution.stat_roles WHERE name = 'Aggressive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Physical')),
('Dexterity', 'Measures hand-eye coordination and precision', 2, 'DEX', '#3b82f6', (SELECT guid FROM evolution.stat_roles WHERE name = 'Aggressive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Movement')),
('Intelligence', 'Measures reasoning, learning capability, and memory', 1, 'INT', '#a855f7', (SELECT guid FROM evolution.stat_roles WHERE name = 'Aggressive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Mental')),
('Charisma', 'Measures force of personality, persuasiveness, and leadership', 2, 'CHA', '#f59e0b', (SELECT guid FROM evolution.stat_roles WHERE name = 'Aggressive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Social')),
('Mana', 'Measures raw magical energy capacity and magical potency', 1, 'MAN', '#ec4899', (SELECT guid FROM evolution.stat_roles WHERE name = 'Aggressive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Magical')),
('Perception', 'Measures environmental awareness and sensory acuity', 1, 'PER', '#10b981', (SELECT guid FROM evolution.stat_roles WHERE name = 'Aggressive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Sensory')),
('Fortitude', 'Measures physical resilience and ability to withstand punishment', 2, 'FOR', '#ef4444', (SELECT guid FROM evolution.stat_roles WHERE name = 'Defensive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Physical')),
('Agility', 'Measures gross motor control, balance, and physical reflexes', 1, 'AGI', '#3b82f6', (SELECT guid FROM evolution.stat_roles WHERE name = 'Defensive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Movement')),
('Willpower', 'Measures mental fortitude and resistance to psychological effects', 2, 'WIL', '#a855f7', (SELECT guid FROM evolution.stat_roles WHERE name = 'Defensive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Mental')),
('Wisdom', 'Measures intuition, insight, and common sense', 1, 'WIS', '#f59e0b', (SELECT guid FROM evolution.stat_roles WHERE name = 'Defensive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Social')),
('Mana Control', 'Measures efficiency and resistance when wielding magical energies', 2, 'MAC', '#ec4899', (SELECT guid FROM evolution.stat_roles WHERE name = 'Defensive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Magical')),
('Stealth', 'Measures ability to remain unnoticed and operate covertly', 2, 'STL', '#10b981', (SELECT guid FROM evolution.stat_roles WHERE name = 'Defensive'), (SELECT guid FROM evolution.stat_categories WHERE name = 'Sensory'));

INSERT INTO evolution.secondary_stats (name, description, order_num, tag_name, tag_color, tier_scaled_stat_guid, added_stat_guid) VALUES
('Health Points', 'Total physical vitality before succumbing to death', 1, 'HP', '#ef4444', (SELECT guid FROM evolution.primary_stats WHERE name = 'Fortitude'), (SELECT guid FROM evolution.primary_stats WHERE name = 'Strength')),
('Mana Points', 'Current reserve of expendable magical energy', 2, 'MP', '#ec4899', (SELECT guid FROM evolution.primary_stats WHERE name = 'Mana'), (SELECT guid FROM evolution.primary_stats WHERE name = 'Intelligence')),
('Stamina Points', 'Current reserve of physical energy for exertion', 3, 'SP', '#f59e0b', (SELECT guid FROM evolution.primary_stats WHERE name = 'Fortitude'), (SELECT guid FROM evolution.primary_stats WHERE name = 'Agility')),
('Divine Points', 'Special resource fueled by faith or higher powers', 4, 'DP', '#ffffff', (SELECT guid FROM evolution.primary_stats WHERE name = 'Charisma'), (SELECT guid FROM evolution.primary_stats WHERE name = 'Wisdom'));

INSERT INTO evolution.tiers (name, description, order_num, tag_name, tag_color, max_level, static_tier_bonus, race_multiplier, class_multiplier, profession_multiplier, item_multiplier) VALUES
('Starter', 'The foundational level of power for beginners', 1, 'T1', '#6b7280', 10, 10, 20, 20, 20, 10),
('Lesser', 'A minor step above basic proficiency', 2, 'T2', '#22c55e', 15, 20, 40, 40, 40, 20),
('Standard', 'The typical power level of established adventurers', 3, 'T3', '#3b82f6', 20, 30, 60, 60, 60, 30),
('Greater', 'A marked increase in capability beyond the norm', 4, 'T4', '#a855f7', 25, 40, 80, 80, 80, 40),
('Superior', 'Highly advanced beings with significant power', 5, 'T5', '#eab308', 30, 50, 100, 100, 100, 50),
('Apex', 'At the peak of mortal capability', 6, 'T6', '#ef4444', 35, 60, 120, 120, 120, 60),
('Elite', 'Surpassing normal limits, standing above peers', 7, 'T7', '#ffffff', 40, 70, 140, 140, 140, 70),
('Ascendant', 'Beings beginning to touch upon higher realms of power', 8, 'T8', '#d1d5db', 45, 80, 160, 160, 160, 80),
('Transcendent', 'Those who have moved beyond mortal constraints', 9, 'T9', '#0ea5e9', 50, 90, 180, 180, 180, 90),
('God', 'The absolute pinnacle of existence', 10, 'T10', '#facc15', 99, 100, 200, 200, 200, 100);

INSERT INTO evolution.rarities (name, description, order_num, tag_name, tag_color, rarity_multiplier) VALUES
('Common', 'Widely available and frequently found', 1, 'CMN', '#6b7280', 1),
('Uncommon', 'Somewhat rare, often requiring specific effort to locate', 2, 'UNC', '#22c55e', 1.5),
('Rare', 'Hard to find and highly valued by collectors and adventurers', 3, 'RAR', '#3b82f6', 2),
('Epic', 'Exceptionally powerful items of renowned quality', 4, 'EPC', '#a855f7', 2.5),
('Legendary', 'Items of mythic proportion, often with unique histories', 5, 'LEG', '#eab308', 3),
('Mythical', 'Objects of legend, believed by many to not exist', 6, 'MYT', '#ef4444', 4),
('Divine', 'Artifacts touched or created by the gods themselves', 7, 'DIV', '#ffffff', 5);

INSERT INTO evolution.currencies (name, description, tag_name, tag_color, value) VALUES
('Bit', 'Basic copper coin used for small transactions', 'C', '#b87333', .01),
('Sil', 'Silver coin used for daily transactions', 'S', '#c0c0c0', .1),
('Gil', 'Gold coin used as the primary currency for adventurers', 'G', '#ffd700', 1),
('Kings', 'High end platinum coins really only used by royalty', 'K', '#e5e4e2', 10),
('Queens', 'Currency only used for country-level transactions', 'Q', '#e0115f', 100);

INSERT INTO evolution.affinities (name, description, tag_name, tag_color) VALUES
('Air', 'Affinity for wind, weather, and atmospheric manipulation', 'AIR', '#bae6fd'),
('Fire', 'Affinity for heat, combustion, and destructive energy', 'FIR', '#ef4444'),
('Ice', 'Affinity for cold, freezing, and crystalline structures', 'ICE', '#7dd3fc'),
('Light', 'Affinity for illumination, healing, and holy energy', 'LGT', '#fdf08a'),
('Lightning', 'Affinity for electricity, storms, and rapid movement', 'LTN', '#fcd34d'),
('Moon', 'Affinity for lunar cycles, tides, and subtle magic', 'MON', '#c0c0c0'),
('Nature', 'Affinity for flora, fauna, and earthly vitality', 'NAT', '#22c55e'),
('Rock', 'Affinity for stone, earth, and unyielding defense', 'RCK', '#78716c'),
('Shadow', 'Affinity for darkness, concealment, and the void', 'SHD', '#1f2937'),
('Space', 'Affinity for gravity, dimensions, and spatial distortion', 'SPC', '#8b5cf6'),
('Sun', 'Affinity for solar power, radiant energy, and life-giving warmth', 'SUN', '#f59e0b'),
('Water', 'Affinity for liquids, adaptability, and the sea', 'WTR', '#3b82f6');

INSERT INTO evolution.cooldowns (name) VALUES
('Instant'),
('A few seconds'),
('30 seconds'),
('1 minute'),
('5 minutes'),
('30 minutes'),
('1 hour'),
('4 hours'),
('1 day'),
('1 week'),
('1 month'),
('1 year');

INSERT INTO evolution.casting_times (name) VALUES
('Instant'),
('A few seconds'),
('30 seconds'),
('1 minute'),
('5 minutes'),
('30 minutes'),
('1 hour'),
('4 hours'),
('1 day'),
('1 week'),
('1 month'),
('1 year');

INSERT INTO evolution.skill_costs (name) VALUES
('None'),
('Negligible'),
('Tiny'),
('Small'),
('Average'),
('Somewhat High'),
('High'),
('Very High'),
('Gargantuan'),
('Cataclysmic');

INSERT INTO evolution.item_types (name, description, is_equippable, equip_max) VALUES
('Weapon', 'Offensive tools designed to inflict damage in combat', true, 2),
('Armor', 'Protective gear worn to mitigate incoming damage', true, 3),
('Accessory', 'Supplemental items worn for magical or utility benefits', true, 3),
('Consumable', 'Single-use or limited-use items that provide temporary effects', false, null),
('Miscellaneous', 'Various items that do not fit standard adventuring categories', false, null);
