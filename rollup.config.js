// rollup.config.js
import resolve from 'rollup-plugin-node-resolve';
import babel from 'rollup-plugin-babel';
import replace from 'rollup-plugin-replace';
import { uglify } from 'rollup-plugin-uglify';
import commonjs from 'rollup-plugin-commonjs';

export default {
  input: 'src/index.js',

  plugins: [
    resolve({
      mainFields: ['main', 'jsnext:main', 'browser'],
      extensions: ['.js'],
    }),
    commonjs(),
    babel({
      exclude: 'node_modules/**', // only transpile our source code
    }),
    replace({
      exclude: 'node_modules/**',
      ENVIRONMENT: JSON.stringify(process.env.NODE_ENV),
    }),
    uglify({ mangle: false }),
  ],
  external: ['lodash/isUndefined', 'lodash/isFunction', 'lodash/isEmpty', 'angular'],

  output: {
    name: 'AngularPagination',
    sourcemap: true,
    file: 'index.js',
    format: 'umd',
    globals: {
      // map 'some-npm-package' to 'SomeNPMPackage' global variable
      angular: 'angular',
      'lodash/isUndefined': 'isUndefined',
      'lodash/isFunction': 'isFunction',
      'lodash/isEmpty': 'isEmpty',
    },
  },
};
