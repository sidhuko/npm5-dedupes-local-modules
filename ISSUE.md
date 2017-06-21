#### I'm opening this issue because:

  - [ ] npm is crashing.
  - [x] npm is producing an incorrect install.
  - [ ] npm is doing something I don't understand.
  - [ ] Other (_see below for feature requests_):

#### What's going wrong?
For context, we are attempting to migrate an existing monolithic repository to use npm@5. Most functionality does work well, it sets up symlinks and runs a barebones application, the blocker for us is that the dedupe process is removing modules within nested local modules causing failures at runtime. A scenario which seems common across most monoliths.

```console
/A
 -> B
/B
 -> C
 -> D
/C
 -> D
```

If local module A depends on local module B, which has a dependency on module D and local module C, if module D was also installed into local module C the package will not be installed or be available at runtime to module C.

```console
module-a@1.0.0 /Users/james/Work/npm-problem/module-a
└─┬ module-b@1.0.0 -> /Users/james/Work/npm-problem/module-b
  ├── lodash@4.17.4
  └─┬ module-c@1.0.0
    └── lodash@4.17.4 deduped
```

The `npm ls` above structures the application with symlinks how we would expect but the dedupe process means module-c does not install a `node_modules/` folder with module D (shown as lodash). It's notable to mention the module-c is symlinked into module-b but this is not visible in the output above. I'd expect to see `module-c@1.0.0 -> /Users/james/Work/npm-problem/module-c` as well as the module-a and module-b being symlinks.  

#### How can the CLI team reproduce the problem?
The problem can be reproduced using the repository below.

https://github.com/sidhuko/npm5-dedupes-local-modules


<!--
    Please a complete description of how to reproduce the problem.
    Include a gist of your npm-debug.log file.
    If you've never used gist.github.com, start here:
      https://github.com/EmmaRamirez/how-to-submit-your-npm-debug-log
-->

### supporting information:

 - `npm -v` prints: 5.0.3
 - `node -v` prints: 8.1.2
 - `npm config get registry` prints: https://registry.npmjs.org/
 - Windows, OS X/macOS, or Linux?: macOS
 - Network issues: N/A
 - Container: N/A
