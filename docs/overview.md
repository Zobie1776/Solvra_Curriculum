# Solvra Curriculum — Overview

---

## 1.0 Purpose

The **Solvra_Curriculum** repository is an interactive learning environment for mastering **SolvraScript** and **SolvraCore** concepts. It provides a structured, hands-on approach to understanding the SolvraScript language through four progressive tiers of lessons.

This curriculum is designed to:
- Teach SolvraScript syntax and runtime interaction
- Build practical skills with async programming, modules, and bytecode
- Prepare developers for advanced SolvraOS integration
- Provide a native runtime learning environment that works seamlessly with the SolvraScript VM

---

## 2.0 Architecture

### 2.1 Directory Structure

```
Solvra_Curriculum/
├── lessons/              # tier1-tier4 lesson folders
│   ├── tier1_foundations/
│   │   ├── examples/     # Introductory lessons
│   │   ├── exercises/    # Practice challenges
│   │   └── tests/        # Validation tests
│   ├── tier2_intermediate/
│   ├── tier3_advanced/
│   └── tier4_expert/
├── scripts/              # build.sh, learn.sh, progress_tracker.sh
├── solvra_script/        # submodule or linked runtime engine
├── logs/                 # runtime + learning logs
├── build/                # compiled bytecode output
└── docs/                 # this file + roadmap + contributing
```

### 2.2 Lesson Tiers

1. **Tier 1: Language Foundations**
   - Variables, functions, conditionals, loops
   - Basic I/O and type system
   - Hello World to foundation mastery

2. **Tier 2: Runtime Concepts**
   - Async programming and cooperative scheduling
   - Memory management basics
   - Compile and run workflows

3. **Tier 3: Advanced Applications**
   - Module system and imports
   - Classes and object-oriented patterns
   - Async schedulers and advanced concurrency

4. **Tier 4: Expert Systems**
   - Runtime internals exploration
   - Bytecode visualization
   - AI module integration
   - Final capstone projects

---

## 3.0 Lesson Flow

### 3.1 How Lessons Run

Each lesson is a `.svs` (SolvraScript source) or `.svc` (compiled bytecode) file that is executed by the SolvraScript VM.

**Execution Path:**
1. User launches `./scripts/learn.sh`
2. Interactive menu displays available lessons organized by tier
3. User selects a lesson
4. `build.sh` locates the SolvraScript runtime (either from `solvra_script/bin/solvrascript` or `../SolvraOS/target/debug/solvrascript`)
5. The lesson executes and output is logged to `logs/`
6. Progress is tracked in `logs/learn_session.log`

### 3.2 Runtime Detection

`build.sh` dynamically searches for the SolvraScript VM in these locations:
- `solvra_script/bin/solvrascript` (submodule binary)
- `../SolvraOS/target/debug/solvrascript` (sibling SolvraOS build)

This ensures the curriculum works whether you're using a standalone SolvraScript binary or developing alongside SolvraOS.

### 3.3 Logging

- **build.log**: Execution output for individual lessons
- **learn_session.log**: Session activity and lesson completions
- **progress.csv**: Structured progress tracking with timestamps

---

## 4.0 Runtime Execution

### 4.1 How `build.sh` Calls SolvraScript

The `build.sh` script:
1. Validates the lesson path argument
2. Locates the SolvraScript VM binary
3. Executes: `$SOLVRA_SCRIPT_BIN "$ROOT/$LESSON_PATH"`
4. Logs output to `logs/build.log`

### 4.2 How the Environment Connects to SolvraCore

SolvraScript lessons interact with SolvraCore through:
- **Built-in functions**: `println()`, `len()`, `push()`, etc.
- **Standard library**: `<string>`, `<io>`, `<vector>` modules
- **Runtime primitives**: async/await, module imports, type annotations
- **VM execution**: All `.svs` files are interpreted or compiled to `.svc` bytecode

The curriculum is **runtime-agnostic**: `.svs` files execute identically whether the VM binary is sourced from the `solvra_script` submodule or from a developer's compiled SolvraOS build.

---

## 5.0 Notes & @ZNOTE Tags

### What are @ZNOTE tags?

Every lesson file includes a `@ZNOTE` comment in the end section that explains:
- What the lesson teaches
- How it relates to SolvraCore concepts
- What to explore next

**Example:**
```
//--------------------------------------------------
// End comments: Demonstrates async/await cooperative scheduling
// @ZNOTE: Foundation for understanding SolvraOS task management
//--------------------------------------------------
```

These notes help learners connect individual lessons to the broader SolvraOS ecosystem and identify prerequisite knowledge for advanced topics.

---

## 6.0 Quick Start

### Running Your First Lesson

```bash
# 1. Launch the interactive menu
./scripts/learn.sh

# 2. Select a lesson (e.g., option 1 for Hello World)

# 3. View logs
tail logs/learn_session.log
```

### Running a Specific Lesson

```bash
./scripts/build.sh lessons/tier1_foundations/examples/01_hello_world.svs
```

### Checking Progress

```bash
./scripts/progress_tracker.sh
```

### Running Tests

```bash
# Run all tier tests
./scripts/test.sh all

# Run specific tier
./scripts/test.sh tier1
```

---

## 7.0 Contributing

See [docs/contributing.md](contributing.md) for guidelines on:
- Adding new lessons
- Naming conventions
- Zobie.format compliance
- Testing requirements

---

## 8.0 References

- [SolvraScript Language Reference](../solvra_script/docs/language_reference.md)
- [Curriculum Roadmap](roadmap.md)
- [Zobie.format Specification](contributing.md#zobie-format)

---

**Last Updated:** 2025-11-02
**Maintained by:** ZobieLabs
