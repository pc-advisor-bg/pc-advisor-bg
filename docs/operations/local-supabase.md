# Local Supabase runtime

The Local Supabase stack is development-only and must bind only to loopback.
Run it through the dedicated Docker network:

```powershell
docker network inspect pc-advisor-local-loopback *> $null
if ($LASTEXITCODE -ne 0) {
  docker network create -o com.docker.network.bridge.host_binding_ipv4=127.0.0.1 pc-advisor-local-loopback
}
pnpm dlx supabase start --network-id pc-advisor-local-loopback
```

Do not use plain `supabase start`: it can publish development services to the
LAN. The tracked configuration enables only the Local API, Postgres, and Auth
path required before product coding; Realtime, Storage, Studio, Mailpit, Edge
Runtime, Vector, and analytics remain disabled until separately approved.