# Solvra Curriculum — Roadmap

---

## Overview

This roadmap details the **four curriculum tiers** that guide learners from SolvraScript basics to expert-level systems programming. Each tier builds on the previous one, introducing progressively more advanced concepts and practical applications.

---

## Tier 1: Language Foundations

**Goal:** Master fundamental SolvraScript syntax and core language features.

**Topics Covered:**
- Variables and type annotations (`let`, `let mut`, `const`)
- Functions and parameters
- Conditionals and branching (`if/else`)
- Loops and iteration (`for`, `while`)
- Basic I/O and string manipulation
- Simple data structures (arrays)

**Lessons:**
1. `01_hello_world.svs` — Display "Hello World" and verify VM execution
2. `02_variables.svs` — Variables, mutability, and type safety
3. `03_functions.svs` — Function definition, parameters, and return values
4. `04_conditionals.svs` — If/else branching and boolean logic
5. `05_loops.svs` — While and for loop patterns
6. `06_basic_math.svs` — Arithmetic operations and numeric types

**Exercises:**
- Quiz-style validation of core concepts
- Math challenges requiring function composition
- Self-directed exploration with Try-It prompts

**Prerequisites:** None. Start here if you're new to SolvraScript.

**Outcome:** Learners will be comfortable writing simple SolvraScript programs, understanding basic control flow, and working with the REPL or build scripts.

---

## Tier 2: Runtime Concepts

**Goal:** Understand how SolvraScript interacts with the runtime and manages execution.

**Topics Covered:**
- Async programming fundamentals
- Cooperative scheduling with `async`/`await`
- Memory management basics
- Compilation workflows (`.svs` → `.svc`)
- Runtime error handling

**Lessons:**
1. `async_programming.svs` — Async/await, cooperative scheduling, and timeouts
2. `memory_basics.svs` — Stack vs heap, ownership patterns
3. `compile_and_run.svs` — Understanding the compilation pipeline

**Prerequisites:** Tier 1 completion (or equivalent SolvraScript familiarity)

**Outcome:** Learners will understand asynchronous execution models, how SolvraScript manages memory, and how to compile and execute bytecode.

---

## Tier 3: Advanced Applications

**Goal:** Build complex applications using modules, classes, and advanced concurrency patterns.

**Topics Covered:**
- Module system and imports
- Object-oriented programming with classes
- Advanced async patterns (schedulers, task management)
- Bytecode compilation and inspection
- Error recovery and debugging strategies

**Lessons:**
1. `modules_and_imports.svs` — Import system, standard library modules
2. `classes.svs` — OOP patterns, methods, and encapsulation
3. `async_scheduler.svs` — Custom task schedulers and priority queues
4. `compile_pipeline.svc` — Inspecting compiled bytecode

**Prerequisites:** Tier 2 completion

**Outcome:** Learners will be able to architect modular applications, leverage OOP patterns, and understand advanced async workflows suitable for SolvraOS integration.

---

## Tier 4: Expert Systems

**Goal:** Explore runtime internals, build developer tools, and integrate with AI/ML modules.

**Topics Covered:**
- SolvraScript runtime internals
- Bytecode visualization and analysis
- AI module integration
- Performance optimization techniques
- Capstone project: End-to-end system design

**Lessons:**
1. `solvra_runtime_internals.svc` — Deep dive into VM architecture
2. `bytecode_visualizer.svs` — Tool for inspecting bytecode execution
3. `ai_module_integration.svs` — Integrating ML models with SolvraScript
4. `final_project.md` — Capstone project guidelines

**Prerequisites:** Tier 3 completion + familiarity with systems programming concepts

**Outcome:** Learners will have expert-level understanding of SolvraScript internals, be able to contribute to the runtime, and build sophisticated applications that integrate with SolvraOS components.

---

## Learning Path Summary

```
┌─────────────────────────────────────────────┐
│ Tier 1: Language Foundations                │
│ ├─ Variables, functions, loops              │
│ └─ Basic I/O and control flow               │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Tier 2: Runtime Concepts                    │
│ ├─ Async/await and scheduling               │
│ └─ Memory management and compilation        │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Tier 3: Advanced Applications               │
│ ├─ Modules, classes, OOP                    │
│ └─ Advanced async patterns                  │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Tier 4: Expert Systems                      │
│ ├─ Runtime internals and bytecode           │
│ ├─ AI/ML integration                        │
│ └─ Capstone project                         │
└─────────────────────────────────────────────┘
```

---

## Estimated Time Commitment

| Tier | Lessons | Estimated Time |
|------|---------|----------------|
| **Tier 1** | 6 examples + 2 exercises | 4-6 hours |
| **Tier 2** | 3 lessons + tests | 3-4 hours |
| **Tier 3** | 4 lessons + advanced exercises | 5-7 hours |
| **Tier 4** | 3 lessons + capstone project | 8-12 hours |
| **Total** | ~20 lessons + projects | **20-30 hours** |

*Times are estimates for learners with basic programming experience.*

---

## Future Additions

### Planned Tier Expansions

**Tier 1 Additions:**
- Array manipulation patterns
- String processing exercises
- Error handling basics

**Tier 2 Additions:**
- Advanced memory patterns (reference counting, arenas)
- Profiling and performance measurement
- FFI (Foreign Function Interface) basics

**Tier 3 Additions:**
- Network programming with async I/O
- Custom module authoring
- Advanced OOP patterns (inheritance, traits)

**Tier 4 Additions:**
- JIT compilation concepts
- WASM integration
- SolvraOS kernel module development

### Planned Tools

- **Interactive REPL lessons**: In-browser or CLI-based interactive exercises
- **Automated grading**: Self-assessment quizzes with instant feedback
- **Video walkthroughs**: Supplementary video content for complex topics
- **Community challenges**: Collaborative problem-solving exercises

---

## Contributing New Tiers

See [docs/contributing.md](contributing.md) for guidelines on:
- Proposing new lesson topics
- Tier placement criteria
- Lesson structure requirements
- Review and approval process

---

## References

- [Curriculum Overview](overview.md)
- [Contributing Guidelines](contributing.md)
- [SolvraScript Documentation](../solvra_script/docs/language_reference.md)

---

**Last Updated:** 2025-11-02
**Maintained by:** ZobieLabs
