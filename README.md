# Demo site

A three-page static site for trying the Code console with a real GitHub repository. CI (`.github/workflows/ci.yml`) runs `tests/smoke.sh` on every push.

Ways to make CI fail on purpose (each is a normal developer mistake):
- add a link to a page that does not exist, for example `<a href="pricing.html">` in `index.html`;
- delete the `<title>` of a page;
- type `BREAK-CI` anywhere in a page (a quick switch).
Fix it in a following commit and CI passes again.

Run the check by hand: `bash tests/smoke.sh` from this folder.
