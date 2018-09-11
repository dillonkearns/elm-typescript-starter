import * as webpack from "webpack";
import * as path from "path";

module.exports = function(env: any): webpack.Configuration {
  return {
    entry: "./index.ts",
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "bundle.js"
    },
    module: {
      rules: [
        {
          test: [/\.elm$/],
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            { loader: "elm-hot-webpack-loader" },
            {
              loader: "elm-webpack-loader",
              options:
                env && env.production ? {} : { debug: true, forceWatch: true }
            }
          ]
        },
        { test: /\.ts$/, loader: "ts-loader" }
      ]
    },
    resolve: {
      extensions: [".js", ".ts", ".elm"]
    }
  };
};
