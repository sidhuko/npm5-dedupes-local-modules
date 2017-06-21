# NPM v5 dedupes necessary modules causing failures at runtime
If local module A depends on local module B, which has a dependency on module D and local module C, if module D was also installed in local module C. The package will not be installed or be available at runtime to module C.
```
/A
 -> B
/B
 -> C
 -> D
/C
 -> D
```

## How to run
Using npm v5 `npm i npm@latest -g` within the `module-a` folder.

Run `npm install` and error occurs at runtime with `npm start`.

## Debugging
The output from `npm ls` will show the module was correctly identified within the nested module although the package has been deduped.

```console
module-a@1.0.0 /Users/james/Work/npm-problem/module-a
└─┬ module-b@1.0.0 -> /Users/james/Work/npm-problem/module-b
  ├── lodash@4.17.4
  └─┬ module-c@1.0.0
    └── lodash@4.17.4 deduped
```


## Known limitations
It might be a known limitation mentioned in ["Limitations of npm's Install Algorithm"](https://docs.npmjs.com/cli/install).

## Possible related tickets
https://github.com/npm/npm/issues/7742
