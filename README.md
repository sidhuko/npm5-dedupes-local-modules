# NPM v5 dedupes necessary modules causing failures
If module A requires module B which has a dependency of external module D. And module B has another module C which also includes D. The package will not be installed.
```
/A
 -> B
/B
 -> C
 -> D
/C
 -> D
```

It might be a known limitation mentioned in ["Limitations of npm's Install Algorithm"](https://docs.npmjs.com/cli/install).

## Possible related tickets
https://github.com/npm/npm/issues/7742
