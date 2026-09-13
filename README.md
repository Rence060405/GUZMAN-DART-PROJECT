# Open Trivia Arena 🎯

A production-grade, multi-package Dart Command-Line Interface (CLI) application that fetches, formats, and displays randomized, categorized quiz questions using the Open Trivia Database API.

---

## 📖 Description

**Open Trivia Arena** is built as an interactive terminal tool designed with strict Object-Oriented Programming (OOP) principles and high architectural standards. Rather than relying on a single monolithic script, the project utilizes a Dart workspace architecture that isolates terminal styling, remote HTTP networking, and CLI user interaction into separate, loosely coupled packages.

---

## ✨ Features

* **Modular Multi-Package Workspace**: Separates visual terminal formatting, API data acquisition, and user interaction.
* **ANSI Terminal Styling**: Visual hierarchy featuring custom extensions for bold headers, emerald success states, amber warnings, and crimson error messages.
* **Asynchronous Networking**: Non-blocking HTTP communication with strict timeout constraints, custom client headers, and graceful lifecycle handling.
* **Defensive JSON Parsing**: Pattern matching and modern Dart switch expressions to validate dynamic API payloads safely under Sound Null Safety.
* **Hierarchical Telemetry Logging**: Centralized diagnostic logging powered by `package:logging` instead of unmanaged console print statements.
* **Polymorphic CLI Command Shell**: Extensible Command Pattern design for parsing and executing terminal user inputs.

---

## 🛠️ Technology Stack

* **Language**: [Dart SDK](https://dart.dev/) (v3.8.1 or later)
* **Architecture**: Dart Monorepo Pub Workspaces
* **Libraries & Packages**:
  * [`http`](https://pub.dev/packages/http) — Asynchronous remote data fetching
  * [`logging`](https://pub.dev/packages/logging) — Diagnostic telemetry logging
  * [`test`](https://pub.dev/packages/test) — Automated unit verification suites
  * [`lints`](https://pub.dev/packages/lints) — Static analysis and coding standards enforcement

---

## 📁 Project Structure

```text
trivia_workspace/
├── pubspec.yaml                 # Root workspace configuration
├── analysis_options.yaml        # Shared static analysis rules
│
├── terminal_colors/             # Package: ANSI Colorizer Utilities
│   ├── pubspec.yaml
│   ├── lib/
│   │   ├── terminal_colors.dart # Package entry export barrier
│   │   └── src/
│   │       └── ansi.dart        # TerminalColor enum & String extension
│   └── test/
│       └── terminal_colors_test.dart
│
├── trivia_api/                  # Package: Remote Data Access & Models
│   ├── pubspec.yaml
│   ├── lib/
│   │   ├── trivia_api.dart      # Package entry export barrier
│   │   └── src/
│   │       ├── client.dart      # TriviaApiClient network implementation
│   │       ├── exceptions.dart  # Custom TriviaException definitions
│   │       └── models.dart      # TriviaQuestion model & JSON deserializer
│   └── test/
│       └── api_test.dart        # Unit testing suite
│
└── trivia_cli/                  # Package: User Interactive CLI Runner
    ├── pubspec.yaml
    ├── bin/
    │   └── main.dart            # Interactive prompt loop entry point
    └── lib/
        └── src/
            ├── command_base.dart # Abstract CliCommand contract
            ├── commands.dart     # Concrete QueryCommand implementation
            └── logging_config.dart # Centralized telemetry setup