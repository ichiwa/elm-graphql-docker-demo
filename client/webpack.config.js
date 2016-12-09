module.exports = {
  entry: './index.js',

  output: {
    path: './dist',
    filename: 'index.js'
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
  },
  debug: true,
  stats: {
    colors: true,
    reasons: false
  },  
  watchOptions: {
    poll: true
  },
  module: {
    loaders: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-hot!elm-webpack?verbose=true&warn=true&debug=true&cache=false'
      },
    ],
    noParse: [/\.elm$/]
  },

  devServer: {
    inline: true,
    stats: 'errors-only',
    progress: true
  }
};