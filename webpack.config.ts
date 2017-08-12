import * as webpack from 'webpack'
import * as path from 'path'

module.exports = function(env: string): webpack.Configuration {
  return {
    entry: './index.ts',
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: 'bundle.js'
    },
    module: {
      loaders: [
        {
          test: [/\.elm$/],
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            {
              loader: 'elm-webpack-loader',
              options: { debug: true, warn: true }
            }
          ]
        },
        { test: /\.ts$/, loader: 'ts-loader' }
      ]
    },
    resolve: {
      extensions: ['.js', '.ts', '.elm']
    }
  }
}
