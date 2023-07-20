# SOPS

[SOPS](https://github.com/getsops/sops) is a secrets management utility originally made by mozilla. It enables secrets to be encrypted and stored somewhere with public access and only decrypted when and where they are needed. [SOPS-nix](https://github.com/Mic92/sops-nix) is the nix implementation.

## `.sops.yaml`

- lives in the root
- defines where the secrets will be stored and which users should be able to access said secrets
- formatted in yaml like below where:
  - keys are a list of the different server/admin public keys
  - creation rules determines which user/systems will have access to which secrets file

```yaml
keys:
  - &admin_alice 2504791468b153b8a3963cc97ba53d1919c5dfd4
  - &admin_bob age12zlz6lvcdk6eqaewfylg35w0syh58sm7gh53q5vvn7hd7c6nngyseftjxl
  - &server_azmidi 0fd60c8c3b664aceb1796ce02b318df330331003
  - &server_nosaxa age1rgffpespcyjn0d8jglk7km9kfrfhdyev6camd3rck6pn8y47ze4sug23v3
creation_rules:
  - path_regex: secrets/[^/]+\.(yaml|json|env|ini)$
    key_groups:
    - pgp:
      - *admin_alice
      - *server_azmidi
      age:
      - *admin_bob
      - *server_nosaxa
  - path_regex: secrets/azmidi/[^/]+\.(yaml|json|env|ini)$
    key_groups:
    - pgp:
      - *admin_alice
      - *server_azmidi
      age:
      - *admin_bob
```

## `secrets.yaml`

- where secrets are stored
- do NOT manually modify

- to create or modify secrets file:
  - move into root (with .sops.yaml) `cd soxyn`
  - run `sops secrets/secrets.yaml`
  - will be booted in an editor where you can edit the secrets
  - when finished save and close editor as usual
