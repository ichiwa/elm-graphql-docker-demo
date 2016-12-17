var path = require('path');
var WriteFilePlugin = require('write-file-webpack-plugin');

module.exports = {
  entry: './index.js',

  output: {
    path: path.join(__dirname, './dist'),
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
    contentBase: path.join(__dirname, "dist"),
    outputPath: path.join(__dirname, './dist'),
    inline: true,
    stats: 'errors-only',
    progress: true
  },
  
  plugins: [
      new WriteFilePlugin()
  ],  
};