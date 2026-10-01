# Anhängerverwaltung – Project Status

> Status: Initial Planning
>
> Last updated: October 2026

---

## 1. Project Overview

School project for an offline trailer rental administration system.

The project focuses primarily on the **administrator side** of the application.

The system must run completely offline and must not depend on a cloud backend or permanently available server.

---

## 2. Original Requirements

The initial requirements document defines two user roles:

- Administrator
- Customer

The current development focus is the **Administrator** side.

Main administrator functions:

- Trailer management
- Trailer status management
- Trailer location
- Damage history
- Trailer photos
- Dashboard
- Reports

The original requirements also define customer and rental-contract functionality for later development.

---

## 3. Technical Direction

### Application

Offline desktop application built with Flutter and Dart, using the `fluent_ui` package for a Windows look and feel. Target platform is Windows, development happens on macOS.

The original requirements document speaks of a "local web application". This was superseded by the technology decision, see `docs/decisions/ADR-001-technology-stack.md`.

### Offline Requirement

The complete application must work without an internet connection.

### Database

The database is local (SQLite).

The database model is designed first. The choice of the SQLite access technology (`drift` or `sqflite` with `sqflite_common_ffi`) is still open and has to be documented as its own decision.

### Backend

No cloud backend is required.

The application should be self-contained and locally runnable.

---

## 4. Project Management

GitHub is used as the central project-management and collaboration platform.

A GitHub Repository has already been created.

A GitHub Project has also been created using the **Team planning** template.

---

## 5. GitHub Project Status Workflow

The project uses the following workflow:

```text
Backlog
   ↓
Todo
   ↓
In Progress
   ↓
Review
   ↓
Done
```

- **Backlog**: Tasks that are known and planned but are not currently being worked on.
- **Todo**: Tasks that are ready to be worked on and have been assigned to a person.
- **In Progress**: The assigned person is actively working on the task.
- **Review**: The implementation/documentation is finished and needs review.
- **Done**: The work has been reviewed and accepted.

---

## 6. Current GitHub Project Fields

The Team Planning template currently provides:

- Status
- Sub-issues progress
- Priority
- Size
- Estimate
- Iteration
- Start date
- Target date

For the current school project, we are keeping the structure simple.

The most important fields are:

- Status
- Priority
- Assignee
- Iteration (if needed)

The remaining fields are kept available but do not need to be actively used yet.

---

## 7. Current Project Scope

The project will be developed in stages.

Planned major areas:

1. Project Foundation
2. Database
3. Scenario-based Wireframes
4. Design System
5. Development & AI Guidelines
6. Trailer Management
7. Damage Management
8. Customers & Contracts
9. Dashboard & Reports
10. Testing & Finalization

The project should remain lightweight because this is a school project.

We explicitly decided not to over-engineer the project management process.

---

## 8. Current Tasks

For the current phase, only four main tasks have been defined.

All four tasks initially belong in **Backlog**.

They move to Todo when the team decides that the task is ready to be worked on and assigns a responsible person.

### Task 1 — Database Design

**Title:** Design Database Model

**Description:** Define the database entities, fields, relationships, keys, constraints and status values based on the requirements document.

**Output:**

- Database schema
- Entity relationships
- ER diagram

**Priority:** High

### Task 2 — Scenario-Based Wireframes

**Title:** Design Scenario-Based Wireframes

**Description:** Define the main user scenarios and create wireframes based on the actual system workflows.

**Cover:**

- Admin login
- Dashboard
- Trailer management
- Trailer details
- Status management
- Location management
- Damage management
- Customer overview
- Rental contracts
- Reports

**Output:**

- User flows
- Scenario definitions
- Wireframes

**Priority:** High

The wireframes should be scenario-oriented, not just a collection of individual screens.

The goal is to understand what the complete system does and how the administrator moves through it.

### Task 3 — Design System

**Title:** Define Design System

**Description:** Define the visual and UI standards that must be used consistently throughout the application.

**Define:**

- Colors
- Typography
- Spacing
- Icons
- Buttons
- Inputs
- Tables
- Cards
- Dialogs
- Status badges
- Navigation
- Empty / Loading / Error states

**Output:**

- Design System documentation
- Reusable UI component specifications

**Priority:** High

A shared Design System that ensures all team members and AI-generated UI have a consistent visual appearance.

### Task 4 — Development & AI Guidelines

**Title:** Define Development and AI Guidelines

**Description:** Define the common rules that all team members and AI assistants must follow when developing the project.

**Define:**

- Project structure
- Naming conventions
- Coding standards
- Architecture rules
- UI rules
- Database rules
- Git and branch rules
- Commit rules
- Pull Request rules
- Testing rules
- Dependency rules
- AI coding rules
- Standard AI prompt

**Output:**

- AGENTS.md
- DEVELOPMENT_GUIDELINES.md
- Standard AI prompt

**Priority:** High

---

## 9. Collaboration Rules

The project is being developed by multiple classmates.

AI will be used by team members for design and coding.

Therefore, consistency is a major project requirement.

The goal is:

```text
Same requirements
       ↓
Same documentation
       ↓
Same design system
       ↓
Same development rules
       ↓
Same AI guidelines
       ↓
Consistent final application
```

Each task should have a clear owner.

However, the four initial foundation tasks are shared project standards and should be reviewed by the whole team.

---

## 10. Git Strategy

Git workflow has been discussed but feature branches should not be created yet.

For the initial documentation/design phase, branches can be used for the four foundation tasks.

Suggested branch names:

```text
docs/database-design
docs/wireframes
docs/design-system
docs/development-guidelines
```

After the foundation phase, feature development will use branches such as:

```text
feature/trailer-management
feature/damage-management
feature/customers
feature/contracts
feature/dashboard
```

Bug fixes:

```text
fix/<short-description>
```

---

## 11. Development Workflow

The planned development workflow is:

```text
GitHub Issue
     ↓
Todo
     ↓
Create Branch
     ↓
Development
     ↓
Pull Request
     ↓
Review
     ↓
Merge into main
     ↓
Done
```

The exact Git workflow will be documented in the Development & AI Guidelines task.

---

## 12. AI Development Principle

AI is treated as a development assistant, not as the source of project decisions.

Before implementing a feature, the AI should follow the project's shared documentation.

Expected future documentation:

```text
AGENTS.md
DEVELOPMENT_GUIDELINES.md
DATABASE_MODEL.md
DESIGN_SYSTEM.md
ARCHITECTURE.md
```

AI-generated code must follow the project's existing:

- Architecture
- Database model
- Design system
- Coding conventions
- Git workflow
- Offline requirement

AI should not independently introduce new architecture, UI patterns, dependencies, or database structures without following the project's documented rules.

---

## 13. Current Development Rule

At this stage: **do not start feature implementation yet.**

First complete the four foundation tasks:

1. Database Design
2. Scenario-Based Wireframes
3. Design System
4. Development & AI Guidelines

After these are reviewed and accepted, begin application implementation.

---

## 14. Current Priority

The immediate project priority is:

```text
Database
    ↓
User Scenarios & Wireframes
    ↓
Design System
    ↓
Development & AI Guidelines
    ↓
Application Development
```

---

## 15. Important Project Constraints

The following constraints are currently established:

- The application must work completely offline.
- The database must be local.
- No cloud backend is required.
- The UI language is German.
- The application is primarily optimized for desktop.
- Tablet support is desirable.
- The application should be consistent across all team members.
- AI-generated work must follow shared project guidelines.
- The project should remain appropriately simple for a school project.
- Avoid unnecessary complexity and over-engineering.

---

## 16. Next Step

Complete the four current GitHub tasks.

After they are completed:

1. Review the database model.
2. Review the system scenarios and wireframes.
3. Review and finalize the Design System.
4. Finalize the Development & AI Guidelines.
5. Establish the final project structure.
6. Begin application implementation.
