# Private Social

> 🚧 **Under construction.**

A case for a small protocol for private, federated social apps.

- **Read it:** https://mattcruikshank.github.io/PrivateSocial/
- **Source:** [`src/index.md`](src/index.md) (the case) and [`src/decisions.md`](src/decisions.md) (the decisions)

## Building

The Markdown in `src/` is the source of truth. `docs/` is generated HTML, committed so that GitHub Pages can serve it directly with no build step.

Requires [Pandoc](https://pandoc.org/) 3.x and a bash shell (Git Bash works on Windows).

```sh
git config core.hooksPath .githooks   # once per clone: rebuild docs/ on every commit
build/build.sh                        # rebuild docs/ by hand
build/build.sh --check                # fail if docs/ is out of date
```

Edit locally rather than in GitHub's web editor. The web editor skips the hook, so `docs/` would fall out of date.
