import sequelize from 'sequelize';
export default (config) => {
  const Sequelize = new sequelize(config.database, config.username, config.password, {
    host: config.host,
    port: config.port
  });
  const User = require('./models/users').default(Sequelize, sequelize);
  Sequelize.sync(
    {logging: console.log}
  );
  return {User};
};
