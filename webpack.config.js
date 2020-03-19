const webpack = require("webpack");
const exec = require("child_process").exec;
const path = require("path");
const MODE =
  process.env.npm_lifecycle_event === "build" ? "production" : "development";
const entry = "./index.ts";

module.exports = function(env) {
  return {
    mode: MODE,
    entry: entry,
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "bundle.js"
    },
    plugins:
      MODE === "development"
        ? [
            // Adapted from https://stackoverflow.com/a/49786887
            // The `invalid` hook seems to work properly.
            {
              apply: compiler => {
                compiler.hooks.invalid.tap(
                  "Elm-TypeScript-Interop",
                  filename => {
                    if (filename.endsWith(".elm")) {
                      console.log(
                        "Generating types with elm-typescript-interop."
                      );
                      // Execute elm-typescript-interop and invalidate index.ts
                      exec(
                        `npx elm-typescript-interop && touch ${entry}`,
                        (err, stdout, stderr) => {
                          if (stdout) process.stdout.write(stdout);
                          if (stderr) process.stderr.write(stderr);
                        }
                      );
                    }
                  }
                );
              }
            },
            // Suggested for hot-loading
            new webpack.NamedModulesPlugin(),
            // Prevents compilation errors causing the hot loader to lose state
            new webpack.NoEmitOnErrorsPlugin(),
            // Ignore generated .d.ts files
            new webpack.WatchIgnorePlugin([/src\/.+\.d\.ts$/])
          ]
        : [],
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
        {
          test: /\.ts$/,
          loader: "ts-loader"
        }
      ]
    },
    resolve: {
      extensions: [".js", ".ts", ".elm"]
    },
    serve: {
      inline: true,
      stats: "errors-only"
    },
    devServer: {
      watchOptions: {
        ignored: [
          path.resolve(__dirname, "dist"),
          path.resolve(__dirname, "node_modules")
        ]
      }
    }
  };
};
