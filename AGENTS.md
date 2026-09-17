# Skill bundle instructions

This repository holds reusable agent skills. When asked to import the bundle, inspect each `skills/*/SKILL.md` and install the requested skills in the target harness's supported location. Preserve the skill folders and their relative files.

After installation, inspect the skills for behavior that must apply across tasks or for rules that choose between skills. Put those short routing rules in the target harness's persistent user or project instructions. Skill descriptions alone are not a reliable way to establish an always-on default. Keep those instructions short, preserve explicit user preferences, and avoid copying full skill bodies into the instruction file.

For the Caveman and Unslop pair:

- Use Caveman full mode by default in ordinary conversation.
- For writing intended for other people, use normal grammatical prose and Unslop. This includes documentation, READMEs, reports, PRs, issues, emails, UI text, and code comments. Apply this rule to a shared document even when the document is drafted inside a chat reply.
- In a mixed reply, use Caveman for the surrounding conversation and normal prose with Unslop for the shared text. Resume Caveman afterward.
- Preserve facts, conditions, uncertainty, negation, code, and technical terms. Use full prose whenever compression would obscure meaning. Follow an explicit user style request over these defaults.

Use the target harness's own instruction file and skill paths. Do not assume this repository's `AGENTS.md` will be read automatically after the repository is copied elsewhere; install or reference the routing instructions in the target harness. Verify with one ordinary chat request and one request to draft shared documentation.
