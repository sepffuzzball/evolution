module.exports = {
  1: async (client) => {
    const tables = [
      "evolution.character_types",
      "evolution.characters",
    ];

    for (const table of tables) {
      await client.query(`
        ALTER TABLE ${table}
          ALTER COLUMN guid SET DEFAULT gen_random_uuid();
      `);
    }
  },
};
