module.exports = {
  env: {
    browser: true,
    es2021: true,
    mocha: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:prettier/recommended',
    'plugin:cypress/recommended',
  ],
  overrides: [
    {
      env: {
        node: true,
      },
      files: ['.eslintrc.{js,cjs}'],
      parserOptions: {
        sourceType: 'script',
      },
    },
  ],
  globals: {
    Turbo: true,
  },
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: [
    'disallow-methods'
  ],
  rules: {
    semi: [2, 'always'],
    'cypress/unsafe-to-chain-command': 0,
    'cypress/no-unnecessary-waiting': 0,
    'disallow-methods/disallow-methods': [2, [
      {
        'object': 'it',
        'method': 'only'
      },
      {
        'object': 'describe',
        'method': 'only'
      }
    ]]
  },
};
