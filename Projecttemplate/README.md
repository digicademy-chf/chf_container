# \<project_name\>

The files in this folder are project-specific content for use with
[CHF Container](https://github.com/digicademy-chf/chf_container), a standard
container set-up for the Cultural Heritage Framework (CHF). To set up a
development or production environment of this project, simply drop these files
into the set-up's `project` folder as per the installation instructions in the
documentation.

## Additional setup info

- None

## Sensitive files

**Some project-specific files are stored securely at \<location\>.**

Make sure that the following files do not get pushed into a public or
semi-public repository as they may contain user data, passwords, and other
secret credentials:

- `settings.php` (except for a version with dummy password hashes)
- `.env` or `.env.production` (`.env.development` is likely safe)
- `database.sql` (except for a subset without user tables)
- `cert.crt`
- `cert.key`

Check the CHF Container documentation for more information about these files.
