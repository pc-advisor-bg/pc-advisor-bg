# Local Supabase runtime

The Local Supabase stack is development-only and must be isolated from the
LAN. The Docker network bind option alone is insufficient on this Windows
Docker host; the Windows inbound firewall rule is a required precondition.

In an **elevated PowerShell**, establish the rule once:

```powershell
New-NetFirewallRule -DisplayName 'PC Advisor BG Local Supabase loopback isolation' -Direction Inbound -Action Block -Protocol TCP -LocalPort 54321,54322 -RemoteAddress Any -Profile Any
```

Then start through the dedicated Docker network:

```powershell
docker network inspect pc-advisor-local-loopback *> $null
if ($LASTEXITCODE -ne 0) {
  docker network create -o com.docker.network.bridge.host_binding_ipv4=127.0.0.1 pc-advisor-local-loopback
}
pnpm dlx supabase start --network-id pc-advisor-local-loopback
```

Before treating the runtime as safe, prove API and database loopback access,
then prove a separate container cannot reach the host LAN API or database port.
Do not use plain `supabase start`: it can publish development services to the
LAN. The tracked configuration enables only the Local API, Postgres, and Auth
path required before product coding; Realtime, Storage, Studio, Mailpit, Edge
Runtime, Vector, and analytics remain disabled until separately approved.