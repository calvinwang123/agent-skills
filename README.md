# Agent skills

Two skills for agent communication:

- [Caveman](skills/caveman/SKILL.md): terse conversation by default.
- [Unslop](skills/unslop/SKILL.md): clear, complete prose for writing other people will read.

The root [AGENTS.md](AGENTS.md) defines when to use each skill. After importing the skills into another harness, put its routing rules in that harness's persistent instructions. A skill folder alone may not establish an always-on default.

The Caveman skill comes from [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman). Unslop is adapted from [Cursor's pstack plugin](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop); the adaptation limits it to shared writing and adds fact preservation rules. Keep this repository private unless you verify the upstream redistribution terms.
