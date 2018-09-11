const webpack = require("webpack");
const path = require("path");
const MODE =
  process.env.npm_lifecycle_event === "prod" ? "production" : "development";

module.exports = function(env) {
  return {
    entry: "./index.ts",
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "bundle.js"
    },
    plugins:
      MODE === "development" ? [new webpack.HotModuleReplacementPlugin()] : [],
    module: {
      rules: [
        {
          test: /\.html$/,
          exclude: /node_modules/,
          loader: "file-loader?name=[name].[ext]"
        },
        {
          test: [/\.elm$/],
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            { loader: "elm-hot-webpack-loader" },
            {
              loader: "elm-webpack-loader",
              options:
                MODE === "production" ? {} : { debug: true, forceWatch: true }
            }
          ]
        },
        { test: /\.ts$/, loader: "ts-loader" }
      ]
    },
    resolve: {
      extensions: [".js", ".ts", ".elm"]
    },
    devServer: {
      inline: true,
      hot: true,
      stats: "errors-only"
    }
  };
};
