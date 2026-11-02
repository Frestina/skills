# skills

Skills for [Claude Code](https://claude.com/claude-code).

| Skill | What it does |
| --- | --- |
| [`audit`](skills/audit/SKILL.md) | Audits a whole project, not just the current diff, for bugs, security, cleanup, tests, dependencies and docs. Run it with `/audit`; flags pick the areas and `-fix` applies the safe results. Reports are saved to `audits/<date>.md` in the audited project, which is added to its `.gitignore`. |
| [`prior-art`](skills/prior-art/SKILL.md) | Checks whether an idea already exists before anyone builds it, including on your machine and in the open pull requests and release candidates of the platform it depends on. |

## Install

```
git clone https://github.com/Frestina/skills.git
cd skills
./install.sh
```

This symlinks each skill into `~/.claude/skills`, so a `git pull` updates them. New
skills need `./install.sh` again. To remove the links, run `./install.sh --uninstall`.

To take just one skill, copy its folder from `skills/` into `~/.claude/skills`.

## License

MIT, see [LICENSE](LICENSE). `prior-art` is adapted from
[who-built-this-before-me](https://github.com/iagochavarry/who-built-this-before-me),
whose MIT license is in that skill's folder.
