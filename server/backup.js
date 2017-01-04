import express from 'express';
import graphqlHTTP from 'express-graphql';
import {
  buildSchema,
  graphql,
  GraphQLSchema,
  GraphQLInt,
  GraphQLList,
  GraphQLObjectType,
  GraphQLString,
  GraphQLNonNull,
  GraphQLInputObjectType
} from 'graphql';
import config from 'config';
import rdb from './rdb';

const port = process.env.PORT || 3000;
const models = rdb(config.get('DB'));

// User Schema
const UserSchema = new GraphQLObjectType({
  name: 'User',
  description: 'A user',
  fields: {
    id: {
      type: new GraphQLNonNull(GraphQLInt),
      description: 'ID of the user.'
    },
    name: {
      type: GraphQLString,
      description: 'Name of the user.'
    },
    email: {
      type: GraphQLString,
      description: 'Email of the user.'
    }
  }
});
// Input User
const UserData = new GraphQLInputObjectType({
  name: 'UserData',
  fields: {
    name: {type: new GraphQLNonNull(GraphQLString)},
    email: {type: new GraphQLNonNull(GraphQLString)}
  }
});
// Users
const createUser = {
  type: UserSchema,
  args: {
    data: {
      type: UserData
    }
  },
  resolve: (source, args) => models.User.create(args.data)
};
const updateUser = {
  type: UserSchema,
  args: {
    id: {
      description: 'ID of the user',
      type: new GraphQLNonNull(GraphQLInt)
    },
    data: {
      type: UserData
    }
  },
  resolve: (source, args) => {
    return models
      .User
      .findOne({where: {id: args.id}})
      .then(user => {
        if (user) {
          return user.update(args.data).then(updated => updated);
        } else {
          return null;
        }
      }
    );
  }
};
const deleteUser = {
  type: new GraphQLNonNull(GraphQLInt),
  args: {
    id: {
      description: 'ID of the User',
      type: new GraphQLNonNull(GraphQLInt)
    }
  },
  resolve: (source, args) => models.User.destroy({where: {id: args.id}})
};
// Mutations
const Mutations = new GraphQLObjectType({
  name: 'Mutations',
  description: 'Mutations of users',
  fields: () => ({
    createUser,
    updateUser,
    deleteUser
  })
});
const RootQuery = new GraphQLObjectType({
  name: 'RootQuery',
  description: 'Root Queries',
  fields: {
    user: {
      type: UserSchema,
      args: {
        id: {
          description: 'ID of the user',
          type: new GraphQLNonNull(GraphQLInt)
        }
      },
      resolve: (source, args) => {
        return models.User.findOne({where: {id: args.id}});
      }
    }
  }
});

const schema = new GraphQLSchema({
  query: RootQuery,
  mutation: Mutations
});

const app = express();
app.use('/graphql', graphqlHTTP({
  schema,
  graphiql: true,
  pretty: true
}));

app.listen(port, () =>
  console.log('Now browse to localhost:3000/graphql')
);

