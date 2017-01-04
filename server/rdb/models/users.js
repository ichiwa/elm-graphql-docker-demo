export default (sequelize, dataType) => {
  return sequelize.define('user', {
    id: {type: dataType.BIGINT(11), primaryKey: true, autoIncrement: true},
    name: {type: dataType.STRING},
    email: {type: dataType.STRING}
  }, {
    underscored: true,
    charset: 'utf8',
    timestamps: true,
    paranoid: false
  }
  );
};
