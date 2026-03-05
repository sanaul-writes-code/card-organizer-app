# Card Organizer App

Welcome to the project! To maintain a stable `main` branch, we use a **branch-and-merge workflow**. Please follow the steps below for all changes.

---

# 🚀 Development Workflow

## 1. Sync with Main

Before starting any new work, ensure your local `main` branch has the latest updates.

```bash
git checkout main
git pull origin main
```

## 2. Create a Feature Branch

Do not push directly to main. Always create a new branch for your task.

```git checkout -b branch_name```

## 3. Commit and Push

Work on your changes, commit them, and push your branch to GitHub.

```
git add .
git commit -m "Description of your changes"
git push origin branch_name
```

## 4. Create a Pull Request (PR)

Go to the repository on GitHub.

Click the "Compare & pull request" button that appears.

Provide a clear title and description.

Self-Approval:
For now, you are permitted to approve and merge your own PRs to keep the workflow moving.

5. Cleanup

Once your PR is merged, delete your feature branch to keep the repository clean.

`git branch -d branch_name`

## 6. Workflow Rules

No Direct Pushes: The main branch is protected. All code must enter via a Pull Request.

Branch First: Always run git checkout -b before writing code.

Update Frequently: Always pull from main before starting a new branch to avoid merge conflicts.