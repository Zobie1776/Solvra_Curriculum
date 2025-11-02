# Tier 2 Overview

- Focus: async execution, runtime memory accounting, and compiled module handoff.
- Flow suggestion: start with `async_programming.svs`, then `memory_basics.svs`, finish with `compile_and_run.svs`.
- Reflection prompts: note when to call `core_module_release` and how allocator stats respond to your experiments.
- Build hint: use `./scripts/build.sh <lesson>` to run a single file or `./scripts/test.sh tier2` (added later) for bundle checks.
