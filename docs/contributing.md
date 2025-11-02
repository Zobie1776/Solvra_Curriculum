# Contributing to Solvra Curriculum

---

## Welcome!

Thank you for contributing to the **Solvra_Curriculum**! This document explains how to add new lessons, maintain code quality, and follow our documentation standards.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Adding New Lessons](#adding-new-lessons)
3. [Naming Conventions](#naming-conventions)
4. [Zobie.format Specification](#zobieformat-specification)
5. [Testing Requirements](#testing-requirements)
6. [Submission Process](#submission-process)

---

## Quick Start

### Prerequisites

- Familiarity with SolvraScript syntax
- Understanding of the curriculum tier structure (see [roadmap.md](roadmap.md))
- Git and GitHub basics

### Development Setup

```bash
# 1. Clone the repository
git clone https://github.com/YourOrg/Solvra_Curriculum.git
cd Solvra_Curriculum

# 2. Initialize the solvra_script submodule
git submodule update --init --recursive

# 3. Build the SolvraScript VM (if not already available)
cd ../SolvraOS
cargo build -p solvrascript

# 4. Test your setup
cd ../Solvra_Curriculum
./scripts/learn.sh
```

---

## Adding New Lessons

### 1. Choose the Appropriate Tier

Refer to [roadmap.md](roadmap.md) to determine which tier your lesson belongs to:

- **Tier 1:** Language fundamentals (variables, functions, loops)
- **Tier 2:** Runtime concepts (async, memory, compilation)
- **Tier 3:** Advanced applications (modules, classes, concurrency)
- **Tier 4:** Expert systems (internals, bytecode, AI integration)

### 2. Create the Lesson File

**File naming pattern:**
```
lessons/tier<N>_<name>/<category>/<NN>_<topic>.svs
```

**Examples:**
```
lessons/tier1_foundations/examples/07_arrays.svs
lessons/tier2_intermediate/exercises/03_async_challenge.svs
lessons/tier3_advanced/tests/test_modules.svs
```

### 3. Follow the Lesson Template

Every lesson must:
- Use **Zobie.format** headers (see below)
- Include a clear **Goal** and **Objective**
- Provide **Try-It** prompts for learner exploration
- Include a **self-check** that validates core concepts
- End with an **@ZNOTE** relating the lesson to SolvraCore

**Minimal lesson template:**

```solvra
//==================================================
// File: <filename>.svs
//==================================================
// Author: ZobieLabs
// License: Duality Public License (DPL v1.0)
// Goal: <What this lesson teaches>
// Objective: <Specific learning outcome>
//==================================================

//==================================================
// Section 1.0 - Lesson Objective
//==================================================

// Detailed description of what the learner will do
// Run with: ./scripts/build.sh lessons/tier<N>_<name>/<category>/<filename>.svs
// Try-It: <Suggestion for learner experimentation>

//==================================================
// Section 2.0 - Example Execution
//==================================================

fn main() {
    println("Hello, learner!");
}

//--------------------------------------------------
// End comments: <Brief summary of what this lesson teaches>
// @ZNOTE: <How this relates to SolvraCore concepts>
//--------------------------------------------------

//==================================================
// End of file
//==================================================
```

---

## Naming Conventions

### Lesson Files

**Format:** `<number>_<descriptive_name>.svs`

**Examples:**
- ✅ `01_hello_world.svs`
- ✅ `05_async_timeout.svs`
- ✅ `test_foundations.svs`
- ❌ `HelloWorld.svs` (no PascalCase)
- ❌ `async.svs` (too vague)

### Directory Structure

- **examples/**: Introductory lessons with full explanations
- **exercises/**: Practice challenges for self-directed learning
- **tests/**: Validation tests for automated checking

### Variables and Functions

Follow SolvraScript conventions:
- `snake_case` for variables and functions
- `SCREAMING_SNAKE_CASE` for constants
- Descriptive names over abbreviations

---

## Zobie.format Specification

All `.svs`, `.svc`, and `.sh` files **must** follow Zobie.format.

### Required Header Fields

Every file must include:

```
// File: <filename>
// Author: ZobieLabs
// License: Duality Public License (DPL v1.0)
// Goal: <Short description>
// Objective: <Specific learning outcome>
```

### Section Structure

Use titled section headers for organization:

```
//==================================================
// Section X.X - <Section Title>
//==================================================
```

**Standard sections for lessons:**
1. **Section 1.0 - Lesson Objective** (lesson description, run instructions)
2. **Section 2.0 - Example Execution** (main code body)

**Standard sections for scripts:**
1. **Section 1.0 - Variables & Paths**
2. **Section 2.0 - <Main Logic>**
3. **Section 3.0 - <Secondary Logic>**
4. **Section 4.0 - <Execution/Output>**

### End Comments

Every file must include:

```
//--------------------------------------------------
// End comments: <Summary of what this file does>
// @ZNOTE: <Connection to SolvraCore or related concepts>
//--------------------------------------------------

//==================================================
// End of file
//==================================================
```

### Validation

Run the validation tool to check compliance:

```bash
./scripts/validate_format.sh
```

Fix any reported issues before submitting.

---

## Testing Requirements

### 1. Manual Testing

Before submitting, ensure your lesson:
- Runs without errors: `./scripts/build.sh <your_lesson>.svs`
- Produces expected output
- Includes helpful error messages if applicable

### 2. Self-Checks

Every lesson should include a **self-check** that validates core concepts:

```solvra
// Quick self-check: verify the result
if score == expected {
    println("[Self Check] PASS");
} else {
    println("[Self Check] FAIL: expected ", expected, ", got ", score);
}
```

### 3. Automated Tests

For new tiers or major features, add a test file:

**Location:** `lessons/tier<N>_<name>/tests/test_<feature>.svs`

**Example:**
```solvra
//==================================================
// File: test_arrays.svs
//==================================================
// Author: ZobieLabs
// License: Duality Public License (DPL v1.0)
// Goal: Validate array manipulation functions
// Objective: Test push, pop, and indexing operations
//==================================================

fn main() {
    let mut arr = [1, 2, 3];
    arr = push(arr, 4);

    if len(arr) == 4 {
        println("[TEST] Array push: PASS");
    } else {
        println("[TEST] Array push: FAIL");
    }
}

//--------------------------------------------------
// End comments: Validates array operations
// @ZNOTE: Ensures runtime array handling is correct
//--------------------------------------------------

//==================================================
// End of file
//==================================================
```

### 4. Running Tests

```bash
# Run all tests
./scripts/test.sh all

# Run specific tier tests
./scripts/test.sh tier1
```

---

## Submission Process

### 1. Fork and Branch

```bash
git checkout -b feature/tier2-network-lesson
```

### 2. Create Your Lesson

Follow all guidelines above.

### 3. Validate Format

```bash
./scripts/validate_format.sh
```

Fix any errors before proceeding.

### 4. Test Functionality

```bash
./scripts/build.sh lessons/tier2_intermediate/<your_lesson>.svs
./scripts/test.sh tier2
```

### 5. Commit with Clear Messages

```bash
git add lessons/tier2_intermediate/<your_lesson>.svs
git commit -m "Add Tier 2 lesson: Network programming basics"
```

### 6. Push and Create Pull Request

```bash
git push origin feature/tier2-network-lesson
```

Open a PR on GitHub with:
- **Title:** Clear, descriptive summary (e.g., "Add Tier 2 lesson: Network programming")
- **Description:**
  - What the lesson teaches
  - Which tier it belongs to
  - Any dependencies or prerequisites
  - Testing performed

### 7. Review Process

Maintainers will review for:
- Zobie.format compliance
- Code correctness
- Pedagogical clarity
- Tier appropriateness
- Test coverage

---

## Style Guide

### Code Comments

- Use `//` for single-line comments (SolvraScript convention)
- Use section headers for organization
- Avoid redundant comments (code should be self-documenting where possible)

### Output Messages

- Use clear, concise language
- Prefix self-checks with `[Self Check]`
- Prefix test output with `[TEST]`
- Use color-coded output in scripts (GREEN, RED, YELLOW, BLUE)

### Try-It Prompts

Every lesson should include a **Try-It** suggestion:

```solvra
println("Try-It Yourself: Change the timeout value and observe behavior.");
```

These prompts encourage active learning and experimentation.

---

## Advanced Topics

### Creating Bytecode Lessons

For `.svc` (compiled bytecode) lessons:

1. Write the `.svs` source
2. Compile using SolvraScript compiler
3. Include both `.svs` and `.svc` in the lesson directory
4. Document the compilation process in the lesson objective

### Multi-File Lessons

For lessons requiring multiple files (e.g., module imports):

```
lessons/tier3_advanced/modules_demo/
├── main.svs
├── helper_module.svs
└── README.md
```

Include a README explaining the file structure and how to run the lesson.

---

## Questions or Issues?

- **Documentation:** See [overview.md](overview.md) and [roadmap.md](roadmap.md)
- **Bugs:** Open an issue on GitHub
- **Discussions:** Use GitHub Discussions for lesson ideas or questions

---

**Thank you for contributing to Solvra_Curriculum!** 🚀

---

**Last Updated:** 2025-11-02
**Maintained by:** ZobieLabs
