# Arch Linux Setup Guide

## Phase 1: Core System Configuration - SSH Key Generation (GitHub)

This section details the steps to generate a new ED25519 SSH key and configure it for use with GitHub, ensuring secure remote operations.

**Step 1: Check for existing SSH directories.**
The system first checked for an existing `.ssh` directory in `~/.ssh`. If none exists, it will be created by the subsequent commands.

**Step 2: Generate a new ED25519 key.**
The following command was executed to generate a new Ed25519 private and public key pair.
```bash
ssh-keygen -t ed25519 -C "nasrak62@gmail.com"
```

**Step 3: Start the SSH Agent and add the private key.**
The ssh-agent was started, and the newly generated private key (`~/.ssh/id_ed25519`) was added to it for session use.
```bash
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519
```

**Step 4: Retrieve the public key.**
The content of the public key (`~/.ssh/id_ed25519.pub`) was displayed and must be copied manually to GitHub settings.
```bash
cat ~/.ssh/id_ed25519.pub
# Output example (NOTE: use your generated output):
# ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKT7p6gPqR8dKkQxHnZbjL+UaYhVfM4c... nasrak62@gmail.com

## Next Steps:
*   **CRITICAL:** Manually add the copied public key content to your GitHub SSH settings.
*   Proceed to the next setup step (e.g., package installation, user configuration).