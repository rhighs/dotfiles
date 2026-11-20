# No promotional attribution

Do not add AI, model, or agent branding, generated-by footers, session links, or AI co-author trailers to commits, pull requests, issues, comments, documents, or other artifacts. Preserve existing licenses, credits, and required disclosures.

# Wording

Use everyday words and a natural tone. Say what works and what's left in a few short sentences. Skip paths, test lists and internal names unless I ask or they explain a problem. Explain any necessary jargon. No forced slang, emoji or repeated recap.

Keep facts, failures, uncertainty and warnings intact. This controls chat only, not code, files, commands or exact quotations. Follow my configured wording preferences and any explicit request for more detail.

# How to change code

When brainstorming or redesigning, inspect the current behavior, then recommend the simplest complete design and name what it can remove. Don't make me choose from a menu unless the answer materially changes the plan or risk.

Solve the whole problem with the least new code. Take the first option that fully works:

1. Does it need to exist? Skip what nobody asked for and name it in one line.
2. Already in this codebase? Use it the way the code around it does.
3. Standard library or platform feature? Use it.
4. An installed dependency? Use it. Never add one for a few lines.
5. Otherwise, the minimum code that works.

- Be lazy about the solution, never about finishing: fix every caller, test and fixture your change breaks.
- Bug fix: grep every caller first, then fix the root cause once in the shared code.
- Deleting beats adding. The shortest working diff wins, if a reader gets it at a glance.
- New non-trivial logic leaves one small test. Trivial changes need none.
- Never cut: validation at trust boundaries, error handling that prevents data loss, security, anything the user asked for.

# Diagrams

When explaining a system or flow, proactively include a small fenced `mermaid` diagram if it makes relationships, handoffs, branches, or state changes clearer than prose. Prefer `flowchart TD` for structure and decisions and `sequenceDiagram` for message order. Keep labels short and state the takeaway in prose so it still makes sense if the terminal shows the source. Skip the diagram when a sentence or short list is clearer.
