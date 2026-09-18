<!-- nicolosi-deployment:start -->
## This deployment: https://artifacts.nicolosi.me

On this machine the deployment is already decided and configured. When asked to publish, share, or update an artifact, use this server directly — do not ask which server and do not default to the public demo.

- **Server:** `https://artifacts.nicolosi.me` (home LAN only; unreachable from the public internet).
- **Credentials:** `ARTIFACT_SITE_URL` and `ARTIFACT_SITE_TOKEN` are already set in the environment, with an on-disk fallback at `~/.config/artifact-site/tokens/artifacts.nicolosi.me` plus `~/.config/artifact-site/config.json` naming the default server. Do not ask the user for credentials; never print the token or send it anywhere except this server.
- **Operator-token mode, no accounts:** this deployment has no OIDC and no user accounts by design. Do NOT run device authorization (`artifact-site login`) — it is disabled here and will dead-end. `GET /api/auth/me` returns `200 {"user":null}` for the operator token; that is the expected success response, not a missing-credential signal. Only a 401 indicates a credential problem.
- **Public visibility is deliberate:** new sites are viewable and searchable by anyone on the LAN. Full-text search only indexes public sites, which is why the default is public.
- **Publishing conventions (always apply):** title as `<project>: <short description>`, and embed `<meta name="description" content="artifacts: project=<repo> session=<id> sources=<files> agent=<tool>">` in the HTML head. Search only indexes title, meta description, and visible body text — HTML comments are stripped and NOT searchable.
- **Updates:** per-site journals live in `~/.config/artifact-site/published/*.json` (slug, versionId, editToken). Prefer the CLI (`artifact-site find` / `update <slug> <path>`) over re-deriving endpoints.
- **Tooling:** the `artifact-site` CLI is installed on this machine (Node from pacman). On machines without it, use plain HTTP per the server guide.
<!-- nicolosi-deployment:end -->
