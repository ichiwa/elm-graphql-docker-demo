import express from 'express';
import graphqlHTTP from 'express-graphql';
import {buildSchema} from 'graphql';
import logger from 'morgan';
import config from 'config';
import rdb from './rdb';

const port = process.env.PORT || 3000;
const models = rdb(config.get('DB'));

const schema = buildSchema(`
  type User {
    id: Int!
    name: String!
    email: String!
  }
  type Query {
    user(id: Int) : User
  }
  input UserData {
    name: String!
    email: String!
  }
  type Mutation {
    createUser(data: UserData!) : User
    updateUser(id: Int!, data: UserData!) : User
    deleteUser(id: Int!) : Int
  }
`);

const rootValue = {
  user: ({id}) => {
    return models.User.findOne({where:{id}});
  },
  createUser: ({data}) => {
    return models.User.create(data);
  },
  updateUser: ({id, data}) => {
    return models
      .User
      .findOne({where: {id}})
      .then((user) => {
        if (user) {
          return user.update(data).then((updated) => updated);
        } else {
          return null;
        }
      }
    );
  },
  deleteUser: ({id}) => {
    return models.User.destroy({where: {id}});
  }
};

const app = express();
app.use('/graphql', graphqlHTTP({
  schema,
  rootValue,
  graphiql: true,
  pretty: true
}));
app.use(logger('dev'));
app.use(express.static('public'));
app.listen(port, () => 
  console.log('Now browse to localhost:3000/graphql')
);