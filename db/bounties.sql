DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  homeworld VARCHAR(255),
  danger_level VARCHAR(255),
  bounty_value INT
);
