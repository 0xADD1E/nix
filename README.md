## Setup
- Set opnix token
    - https://my.1password.com/developer-tools/active/service-accounts
    - Create new opnix-host token (read permissions on opnix vault)
    - `[sudo] nix run github:brizzbuzz/opnix token set`
    - Possibly rebuild/switch twice (due to opnix seemingly running late in the activation order)
- On brand new devices, configure backups
    - Make sure Kopia has a scheduling policy for the device
    - Either allow the GUI to run the policy, or manually snapshot the relevent directories