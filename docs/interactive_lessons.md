# Interactive Lessons — Guided Tutorial Format

---

## Overview

The Solvra_Curriculum features **guided, interactive tutorials** that teach SolvraScript through narrated, step-by-step walkthroughs. Each lesson uses `inp()` for user interaction, provides real-time feedback, and offers progression controls.

This document explains the guided tutorial format, how lessons work, and best practices for creating engaging educational content.

---

## 🎓 New: Guided Tutorial Format

All lessons now follow a structured, interactive tutorial format that includes:

1. **Opening Banner** - Visual welcome with lesson title
2. **Learning Objectives** - Clear list of what you'll learn
3. **Concept Sections** - Step-by-step explanations with examples
4. **Try-It-Yourself Challenges** - Interactive quizzes with feedback
5. **Lesson Summary** - Recap of key takeaways
6. **Next Steps** - Options to repeat, continue, or exit

**Example Lesson Flow:**
```
╔════════════════════════════════════════╗
║  Welcome to SolvraScript — Lesson 1   ║
╚════════════════════════════════════════╝

📚 What you'll learn:
  • Concept A
  • Concept B

─────────────────────────────────────────
📖 Concept 1: Introduction
─────────────────────────────────────────
Explanation here...
Press Enter to continue...

✍️  Try-It-Yourself Challenge
Question: What is...?
Your answer: _
✓ Correct! / ✗ Not quite...

📋 Lesson Summary
Today you learned:
  ✓ Item 1
  ✓ Item 2

What would you like to do?
  [1] View lesson again
  [2] Continue to next lesson
  [3] Exit
```

---

## 1.0 How `inp()` Works in SolvraScript

### 1.1 Basic Usage

`inp()` is a built-in SolvraScript function that reads user input from the terminal:

```svs
let name = inp("What's your name? ");
println("Hello, " + name + "!");
```

**Key Features:**
- **Blocking I/O**: Waits for user to press Enter
- **String Return**: Always returns a string value
- **Empty Handling**: Returns empty string `""` if no input provided
- **Non-Interactive Safe**: In piped/automated environments, returns empty string immediately

### 1.2 Type Conversion

For numeric input, use type conversion:

```svs
let count_str = inp("Enter count: ");
let count = parse_int(count_str);

if count < 0 {
    count = 5; // fallback default
}
```

### 1.3 Default Value Pattern

Always provide defaults for robust lessons:

```svs
let timeout_input = inp("Enter timeout (or press Enter for 150ms): ");
let timeout = 150;

if len(timeout_input) > 0 {
    timeout = parse_int(timeout_input);
    if timeout < 0 {
        timeout = 150;
    }
}
```

---

## 2.0 Guided Tutorial Structure

### 2.1 Lesson Components

Every guided tutorial includes these sections:

**1. Welcome Banner**
```svs
println("╔════════════════════════════════════════╗");
println("║  Welcome to SolvraScript — Lesson 1   ║");
println("╚════════════════════════════════════════╝");
```

**2. Learning Objectives**
```svs
println("📚 What you'll learn:");
println("  • How to print text with println()");
println("  • How to create variables with let");
println("  • How to get user input with inp()");
```

**3. Concept Sections**
```svs
println("─────────────────────────────────────────");
println("📖 Concept 1: Printing Text");
println("─────────────────────────────────────────");
println();
println("In SolvraScript, we use println() to display text...");
println();
let continue1 = inp("Press Enter to continue...");
```

**4. Try-It-Yourself Challenge**
```svs
println("═════════════════════════════════════════");
println("✍️  Try-It-Yourself Challenge");
println("═════════════════════════════════════════");
println();
println("Question: What function prints text in SolvraScript?");
println("  a) print()");
println("  b) println()");
println("  c) echo()");
let answer = inp("Your answer (a/b/c): ");

if answer == "b" || answer == "B" {
    println("✓ Correct! println() prints with a newline.");
} else {
    println("✗ Not quite. The correct answer is 'b'.");
}
```

**5. Lesson Summary**
```svs
println("═════════════════════════════════════════");
println("📋 Lesson Summary");
println("═════════════════════════════════════════");
println();
println("Today you learned:");
println("  ✓ How to print text with println()");
println("  ✓ How to create variables with let");
println("  ✓ How to get user input with inp()");
```

**6. Next Steps**
```svs
println("What would you like to do?");
println("  [1] View lesson again");
println("  [2] Continue to next lesson");
println("  [3] Exit");
let choice = inp("Your choice (1/2/3): ");

if choice == "1" {
    run_tutorial(); // Restart lesson
} else if choice == "2" {
    println("Continue to next lesson with ./scripts/learn.sh");
} else {
    println("Thanks for learning!");
}
```

---

## 3.0 Interactive Patterns by Tier

### Tier 1 — Foundations

**Focus**: Basic input/output and user interaction with step-by-step guidance

**Patterns:**
- Narrated concept introductions
- Simple text input (names, labels)
- Interactive quizzes with feedback
- Progress pacing with "Press Enter to continue..."

**Example: Hello World (01_hello_world.svs)**
```svs
println("📖 Concept 3: Getting User Input");
println("We can ask users for input with inp():");
println("  let name = inp(\"What's your name? \");");
println();
println("Now it's your turn!");
let learner_name = inp("What's your name? ");
println("Hello, " + learner_name + "!");
```

---

### Tier 2 — Intermediate

**Focus**: Configuration and experimentation

**Patterns:**
- Timeout/delay configuration
- Optional feature toggles (y/n)
- Data structure size selection

**Example: Async Programming (async_programming.svs)**
```svs
let delay_input = inp("Enter task delay in ms (or press Enter for 150): ");
let TASK_DELAY_MS = 150;
if len(delay_input) > 0 {
    TASK_DELAY_MS = parse_int(delay_input);
}
```

---

### Tier 3 — Advanced

**Focus**: Multi-step configuration and dynamic workflows

**Patterns:**
- Multiple related prompts
- Optional task spawning
- Custom data injection

**Example: Async Scheduler (async_scheduler.svs)**
```svs
let delay_alpha = inp("Enter alpha delay: ");
let delay_beta = inp("Enter beta delay: ");
let spawn_gamma = inp("Spawn gamma task? (y/n): ");

if spawn_gamma == "y" {
    // spawn third task
}
```

---

### Tier 4 — Expert

**Focus**: Advanced system configuration and debugging

**Patterns:**
- File path input
- Memory tracking toggles
- Execution iteration counts

**Example: AI Module Integration (ai_module_integration.svs)**
```svs
let show_tracking = inp("Enable memory tracking? (y/n, or Enter for yes): ");
let run_count = inp("Run count (or Enter for 1): ");

let execution_count = 1;
if len(run_count) > 0 {
    execution_count = parse_int(run_count);
}
```

---

## 3.0 Logging User Progress

### 3.1 Session Logs

The curriculum automatically logs all lesson activity:

**Location:** `logs/learn_session.log`

**Format:**
```
[2025-11-02T15:30:00Z] session_start
[2025-11-02T15:30:15Z] launch lessons/tier1_foundations/examples/01_hello_world.svs
[2025-11-02T15:31:45Z] complete lessons/tier1_foundations/examples/01_hello_world.svs
[2025-11-02T15:32:00Z] session_end
```

### 3.2 Progress Tracking

Progress is tracked in `logs/progress.csv`:

**Format:**
```csv
timestamp,lesson_path,status
2025-11-02T15:31:45Z,lessons/tier1_foundations/examples/01_hello_world.svs,completed
2025-11-02T15:35:22Z,lessons/tier1_foundations/examples/02_variables.svs,completed
```

**View Progress:**
```bash
./scripts/progress_tracker.sh
```

**Output:**
```
========================================
📊 Progress Summary
========================================
✓ Unique lessons completed: 5
Total completions (including repeats): 7

Recent completions:
  ✓ lessons/tier1_foundations/examples/01_hello_world.svs - 2025-11-02T15:31:45Z
  ✓ lessons/tier1_foundations/examples/02_variables.svs - 2025-11-02T15:35:22Z
```

### 3.3 Input Logging (Future Enhancement)

**Planned Feature:** `logs/lesson_inputs.jsonl`

Future versions will log user inputs for replay and analysis:

```jsonl
{"timestamp":"2025-11-02T15:31:00Z","lesson":"01_hello_world.svs","prompt":"What's your name?","response":"Alex"}
{"timestamp":"2025-11-02T15:32:00Z","lesson":"02_variables.svs","prompt":"Enter starting count:","response":"10"}
```

This will enable:
- Session replay for debugging
- Learning pattern analysis
- Automated grading systems

---

## 4.0 Testing Interactive Lessons

### 4.1 Manual Testing

Run any lesson directly:

```bash
./scripts/build.sh lessons/tier1_foundations/examples/01_hello_world.svs
```

Interact with prompts and verify output.

### 4.2 Automated Testing (Non-Interactive Mode)

Use piped input for CI/CD:

```bash
echo -e "\n\n\n" | ./scripts/build.sh lessons/tier1_foundations/examples/01_hello_world.svs
```

**Expected Behavior:**
- `inp()` returns empty strings
- Lesson uses default values
- No hanging or timeout

### 4.3 Regression Tests

**Test 1: Non-Blocking Execution**
```bash
echo "" | ./scripts/build.sh lessons/tier1_foundations/tests/test_inp_nonblocking.svs
```

Validates that `inp()` doesn't hang when no input is available.

**Test 2: Async Compatibility**
```bash
echo "" | ./scripts/build.sh lessons/tier2_intermediate/tests/test_inp_async_safe.svs
```

Ensures `inp()` works correctly with async/await patterns.

---

## 5.0 Creating Interactive Lessons

### 5.1 Design Guidelines

1. **Always Provide Defaults**: Never require input for a lesson to run
2. **Clear Prompts**: Explain what the input does and what format is expected
3. **Validate Input**: Check bounds, types, and handle errors gracefully
4. **Document Try-Its**: Include comments showing what happens with different inputs
5. **Test Non-Interactive**: Ensure lesson works with empty inputs (CI/CD compatibility)

### 5.2 Template Pattern

```svs
//==================================================
// File: my_lesson.svs
//==================================================
// Author: ZobieLabs
// License: Duality Public License (DPL v1.0)
// Goal: <Lesson objective>
// Objective: Demonstrate interactive <feature>
//==================================================

//==================================================
// Section 1.0 - Lesson Objective
//==================================================

// <Description>
// Run with: ./scripts/build.sh lessons/tier<N>_<name>/my_lesson.svs
// Try-It: <Suggestion for experimentation>

//==================================================
// Section 2.0 - Example Execution
//==================================================

fn run_demo() {
    let user_input = inp("Enter value (or press Enter for default): ");
    let value = 10; // default

    if len(user_input) > 0 {
        value = parse_int(user_input);
        if value < 0 {
            value = 10; // validation fallback
        }
    }

    println("Using value: ", value);

    // ... lesson logic ...

    // Self-check
    println("[Self Check] ✓ Correct! or ✗ Try again.");
}

fn main() {
    run_demo();
}

//--------------------------------------------------
// End comments: <What this teaches>
// @ZNOTE: <How it relates to SolvraCore concepts>
//--------------------------------------------------

//==================================================
// End of file
//==================================================
```

### 5.3 Input Types

**Text Input:**
```svs
let name = inp("Enter name: ");
```

**Numeric Input:**
```svs
let count = parse_int(inp("Enter count: "));
```

**Boolean (y/n) Input:**
```svs
let enable = inp("Enable feature? (y/n): ");
if enable == "y" || enable == "Y" {
    // enable feature
}
```

**Optional Input with Default:**
```svs
let input = inp("Enter value (or press Enter for 100): ");
let value = 100;
if len(input) > 0 {
    value = parse_int(input);
}
```

---

## 6.0 Example Lesson Flow

### Interactive Session Example

```
$ ./scripts/learn.sh

========================================
📚 SolvraScript Curriculum
========================================

Tier1 foundations:
  1) Introduce SolvraScript syntax and runtime basics
  2) Master variables and type annotations in SolvraScript
  ...

Select an option: 1

▶ Launching: lessons/tier1_foundations/examples/01_hello_world.svs

[INFO] Running lesson: lessons/tier1_foundations/examples/01_hello_world.svs

Welcome to SolvraScript!
What's your name? Alice
Hello, Alice!
Now you're officially part of the Solvra ecosystem.

[Self Check] Greeting for Tester ->
Hello, Tester!

Try-It Yourself: change learner_name prompt and rerun.

[INFO] Lesson completed successfully.

✓ Lesson complete. Check logs for details.
```

---

## 7.0 Troubleshooting

### Problem: Lesson Hangs on `inp()` Call

**Cause**: Running in fully automated environment without stdin

**Solution:** Pipe empty input or newlines:
```bash
echo -e "\n\n\n" | ./scripts/build.sh <lesson_path>
```

### Problem: Input Not Validated

**Cause**: Lesson expects specific format but user enters invalid data

**Solution:** Always validate and provide fallbacks:
```svs
let value = parse_int(user_input);
if value < 0 || value > 100 {
    value = 50; // safe default
}
```

### Problem: Lesson Fails in CI/CD

**Cause**: CI environments have no stdin

**Solution:** Add regression tests that simulate empty input:
```bash
# In test script
echo "" | ./scripts/build.sh lessons/tier1_foundations/examples/01_hello_world.svs
```

---

## 8.0 Future Enhancements

### Planned Features

1. **Input Replay System**
   - Record user inputs during interactive sessions
   - Replay inputs for debugging or demonstration
   - Format: `logs/lesson_inputs.jsonl`

2. **Automated Grading**
   - Compare user inputs against expected patterns
   - Provide instant feedback on correctness
   - Generate completion certificates

3. **Interactive Hints**
   - Contextual help during lessons
   - Adaptive difficulty based on user responses
   - Progressive disclosure of advanced concepts

4. **Session Analytics**
   - Time spent per lesson
   - Common input patterns
   - Difficulty assessment

---

## 9.0 References

- [Curriculum Overview](overview.md)
- [Contributing Guidelines](contributing.md)
- [SolvraScript Language Reference](../solvra_script/docs/language_reference.md)

---

**Last Updated:** 2025-11-02
**Maintained by:** ZobieLabs
