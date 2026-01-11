import shutil
from pathlib import Path
import subprocess

# List of dotfiles to back up
# expanduser() is REQUIRED so "~" resolves to the home directory
files = [
    Path("~/.zshrc").expanduser(),
    Path("~/.config/nvim/init.vim").expanduser(),
    Path("~/.tmux.conf").expanduser(),
    Path("~/.gitconfig").expanduser(),
]

# Destination directory for backups
# This will resolve to: ~/Documents/backup
destination_folder = Path("~/Documents/dot_files").expanduser()

# Create the destination directory if it does not exist
# parents=True  -> create intermediate directories (Documents/)
# exist_ok=True -> do nothing if the folder already exists
destination_folder.mkdir(parents=True, exist_ok=True)

def copy_files(files):
    # Copy each file
    for src in files:
        # Skip missing files instead of crashing
        if not src.exists():
            print(f"{'NOT FOUND':<8} | {str(src):<40} | -")
            continue

        # Destination path (file name only, no directory structure)
        dest = destination_folder / src.name

        # copy2 preserves metadata (timestamps, permissions)
        shutil.copy2(src, dest)
        print(f"{'SUCCESS':<8} | {str(src):<40} | {dest}")

    print("Copy files done")

def git(cmd):
    """Run a git command inside the destination folder"""
    subprocess.run(
        ["git"] + cmd,
        cwd=destination_folder,
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

def commit():
    # Initialize git repo if it doesn't exist
    if not (destination_folder / ".git").exists():
        git(["init"])
        print("Git folder added")

    # Stage everything
    git(["add", "."])

    # Check if anything actually changed
    status = subprocess.run(
        ["git", "status", "--porcelain"],
        cwd=destination_folder,
        capture_output=True,
        text=True,
    )

    if status.stdout.strip():
        git(["commit", "-m", "Update dotfiles"])
        print("Git commit created.")
        return True
    else:
        print("No commit")
        return False

def push():
    # assumes remote 'origin' is already configured
    remotes = subprocess.run(["git", "remote"], cwd=destination_folder, capture_output=True, text=True)
    if "origin" in remotes.stdout:
        git(["push", "-u", "origin", "master"])
        print("Pushed to GitHub")
    else:
        print("Remote repo not added")


if __name__ == '__main__':
    copy_files(files)
    did_commit = commit()
    if did_commit:
        push()
    else:
        print("No push")
