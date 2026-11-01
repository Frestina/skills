---
name: prior-art
description: Check whether a project, tool, plugin, skill or product idea already exists before anyone builds it, including on this machine and in the open pull requests and release candidates of the platform it depends on. Use this whenever the user describes something they or we might build, asks "does this exist", "has anyone built", "is there a tool for", or "should I build X", and before recommending any new project idea, even if the user did not ask for a check.
---

# Prior art check

Find out whether an idea is already built, about to be built, or genuinely open, and say so plainly. Most ideas have been tried. A check that stops at a repo search misses the worst cases: the tool already installed on this machine, and the platform that is about to ship the same thing.

## 1. Pin down the idea

Write the idea in one sentence: what it does, who it is for, and what makes it different, if anything. Name the platform it sits on, if any (Omarchy, Claude Code, GitHub, an exchange). If the idea is too vague to search, ask one question, then go.

## 2. Look at home first

An idea can be solved already by something the user owns or has installed. Web searches never show this, so check before going out:

- The user's own projects and notes: `~/Projects`, the memory directory, plans and idea lists.
- Installed software: `pacman -Qs <word>`, `command -v <tool>`, and the bin directory of the platform.
- The platform's built-in parts. On Omarchy, read `omarchy plugin list` and the manifests in `/usr/share/omarchy/shell/plugins/`. Read what a built-in does before ruling it in or out; a name is not enough.

## 3. Write the vocabulary

Before searching, write 6 to 10 ways to describe the idea: the builder's words, the words a user would type, the technical words for how it works, and the words of the neighbouring community that may have solved it first. Most "new" ideas are just named differently, so map each query to a different framing.

## 4. Search where builders publish

Start with about 12 queries across the framings. Keep going while new queries find new projects, and stop once two framings in a row add nothing. Run the whole check once; several agents searching at the same time use up the rate limit.

- Code: `gh search repos`, npm, PyPI, crates.io, the AUR.
- Marketplaces and listings for the platform: plugin marketplaces, skill and MCP registries. If a site renders in the browser, look for its data file and grep that. Omarchy's is `https://plugins.omarchy.org/catalog.json`, and it finds plugins that repo searches miss.
- Products and talk: Product Hunt, Show HN, forums, the platform's discussions.

`gh` details that cost time:

- `gh search` allows about 30 calls a minute. Leave about 2 seconds between calls, and rerun anything that hit the limit, because a failed search can look like an empty one.
- `gh search repos` needs `stargazersCount` in `--json`; `gh repo view` needs `stargazerCount`.
- `updatedAt` moves when someone stars a repo. Use `pushedAt` for the last code change.
- Search with plain keywords. Quoted phrases and `--sort stars` can come back empty where the same words without them find results.
- Use `--repo owner/name` carefully: a project may have moved, and search does not follow the redirect. Check the current owner with `gh repo view` first.

An empty result proves nothing until a differently worded query also comes back empty.

## 5. Check the platform's own plans

If the idea sits on a platform, the biggest risk is the platform shipping it. Check the source, not just the news:

- Open and recently closed PRs and issues: search several framings with `gh search prs --repo` and `gh search issues --repo`.
- Release candidates: read the notes with `gh release view`, and the code at the tag or main branch with `gh api repos/<owner>/<repo>/git/trees/<ref>?recursive=1`. Release notes leave things out.
- Branch names, discussions and roadmaps.

For each relevant PR, read its body and comments, and follow any "superseded by" or "see also" link, because the most important PR may not show up in a search. Say how far along it is: draft, open and quiet, reviewed, or merged. A closed PR often explains why the idea was rejected, which is worth more than the code.

## 6. Read the closest matches

Do not judge from a listing. For each direct match, read the README and check the last code change, the releases, and the stars. Check the claim that matters to this idea, not just the description: a one-line summary is often wider or narrower than the tool. Follow anything a match wraps or is built on, because the real incumbent is often one layer down. If a skill or tool would be installed, read its code first.

## 7. Report

Start with the verdict on the first line. Keep it to one screen.

```markdown
**Verdict: <Build it | Extend X | Contribute to Y | Use Z | Wait for Y | Investigate first>.** <One or two sentences, with the concrete next step.>

| Name | What it covers | State | Fit |
| --- | --- | --- | --- |

**On this machine:** <what is already installed or built, or "nothing found">
**Platform plans:** <PRs, issues and release candidates, each with its state>
**Still missing:** <what none of the above does, and which search failed to find it>
**Not checked:** <what you could not check, and what you only read a summary of>
```

Link every project and PR, and give dates. In the table, Fit is one of direct, adjacent, partial or abandoned, with at most six rows in all; name the rest in one line. Leave the list of queries out of the report unless asked, and keep each section to what changes the verdict.

Be honest about the gap. "Still missing" is a claim that a thing does not exist, so back it with the searches behind it, and call it "not found", not "does not exist". If the idea's only difference is a small one, say so. Never invent a competitor to fill the table, and never invent a gap to keep the idea alive.

## Credit

The vocabulary step, the verdicts and the idea of tracing one layer down come from [who-built-this-before-me](https://github.com/iagochavarry/who-built-this-before-me) (MIT, see `LICENSE-who-built-this-before-me`).
