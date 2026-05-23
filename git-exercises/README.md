# Git Exercises — Git Katas

![Git](https://img.shields.io/badge/Git-Katas-orange?style=flat-square&logo=git&logoColor=white)

This directory contains a collection of **Git katas** — hands-on exercises to practice and master various Git concepts. These exercises are sourced from the [git-katas](https://github.com/praqma-training/git-katas) open-source training repository.

Each kata is a self-contained exercise with its own **setup script** and **README** describing the scenario to solve.

---

## Exercises Covered

### 🔰 Basics
| Kata | What I Practiced |
|------|-----------------|
| `basic-commits` | Making and managing commits |
| `basic-staging` | Staging files, `git add` variants |
| `basic-branching` | Creating, switching, and managing branches |
| `basic-stashing` | Stashing work-in-progress changes |
| `basic-cleaning` | Cleaning untracked files with `git clean` |
| `basic-revert` | Reverting commits safely |
| `basic-cherry-pick` | Applying specific commits from one branch to another |

### 🔀 Merging & Branching
| Kata | What I Practiced |
|------|-----------------|
| `3-way-merge` | Three-way merge scenarios |
| `ff-merge` | Fast-forward merges |
| `merge-conflict` | Resolving merge conflicts manually |
| `merge-mergesort` | Complex merge with algorithmic code |
| `merge-driver` | Custom merge drivers |
| `master-based-workflow` | Team-based merge workflows with upstream pushes |

### 🔄 Rebasing
| Kata | What I Practiced |
|------|-----------------|
| `rebase-branch` | Rebasing feature branches onto main |
| `rebase-multiple-commits` | Rebasing multiple commits at once |
| `rebase-interactive-autosquash` | Interactive rebase with `--autosquash` and `fixup!` |
| `rebase-exec` | Rebasing with `--exec` to run tests on each commit |
| `advanced-rebase-interactive` | Advanced interactive rebase techniques |

### 🧹 History Manipulation
| Kata | What I Practiced |
|------|-----------------|
| `amend` | Amending the last commit |
| `squashing` | Squashing multiple commits into one |
| `reorder-the-history` | Reordering commits with interactive rebase |
| `reset` | Soft, mixed, and hard resets |
| `restore` | Using `git restore` to unstage/discard changes |
| `bad-commit` | Finding and fixing bad commits |
| `commit-on-wrong-branch` | Moving commits to the correct branch |
| `commit-on-wrong-branch-2` | Advanced wrong-branch recovery |
| `save-my-commit` | Recovering seemingly lost commits |

### 🔍 Investigation & Debugging
| Kata | What I Practiced |
|------|-----------------|
| `bisect` | Binary search to find the commit that introduced a bug |
| `investigation` | Using `git log`, `git blame`, `git diff` for investigation |
| `diff-advance` | Advanced diff techniques |
| `detached-head` | Working in detached HEAD state |
| `objects` | Git internals — blobs, trees, commits |

### 🏷️ Configuration & Collaboration
| Kata | What I Practiced |
|------|-----------------|
| `alias` | Creating Git aliases for frequently used commands |
| `configure-git` | Git configuration (global, local, system) |
| `git-tag` | Creating and managing tags |
| `ignore` | Using `.gitignore` effectively |
| `git-attributes` | Git attributes for file-specific behavior |
| `change-author` | Changing commit author information |
| `signed-commits` | GPG-signing commits |

### 🧩 Advanced
| Kata | What I Practiced |
|------|-----------------|
| `submodules` | Working with Git submodules |
| `subtree` | Git subtree for nested repositories |
| `lfs` | Git Large File Storage (LFS) |
| `pre-push` | Pre-push hooks |
| `reverted-merge` | Handling reverted merges |

---

## How to Use

```bash
# Navigate to any kata folder
cd git-exercises/git-katas/<kata-name>

# Run the setup script to initialize the exercise environment
# On Linux/Mac:
./setup.sh

# On Windows:
./setup.ps1

# Read the exercise README (if available) or the kata's README.md
# Solve the exercise & verify your work
```

---

## Skills Practiced

- ✅ Branch creation, switching, merging, and rebasing
- ✅ Conflict resolution strategies
- ✅ Interactive rebase for clean commit history
- ✅ Stashing and restoring work-in-progress
- ✅ Git bisect for debugging
- ✅ Cherry-picking specific commits
- ✅ Reset (soft, mixed, hard) and revert
- ✅ Tagging and aliases
- ✅ Submodules and subtrees
- ✅ Signed commits and LFS
- ✅ Recovering from mistakes (wrong branch, lost commits)
- ✅ Understanding Git internals (objects, HEAD, detached state)

---

*These exercises are from the [git-katas](https://github.com/praqma-training/git-katas) repository by Praqma Training, used for hands-on Git skill development.*
