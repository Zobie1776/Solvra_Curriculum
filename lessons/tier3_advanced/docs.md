# Tier 3 Overview

- Focus: modular design, async orchestration, and bytecode inspection.
- Suggested route: start with `modules_and_imports.svs`, then tackle `classes.svs`, follow with `async_scheduler.svs`, and finish by running `compile_pipeline.svc` through the build script.
- Highlights: observe how event handlers complement async/await, and notice how compiled `.svc` files log pipeline stages without re-parsing source.
- Stretch idea: compose a reusable module that returns both a script API and a compiled SolvraCore handle.
