# Nginx Ansible role

This role installs and configures the latest version of the Nginx web server from the Ubuntu official repository. Depending on the value of `target` variable, Nginx can be configured to act as a reverse proxy (handling requests from the internet-facing load balancer to the internal load balancer in the three-tier web architecture) or a web server in the LEMP stack.

## Requirements

None.

## Role Variables

- `target` - configures Nginx as a reverse proxy or a LEMP web server (possible values: `rproxy` / `lemp`).
- `external_lb_endpoint` - endpoint of the internet-facing load balancer, from which Nginx reverse proxy will accept requests. When `target` is set to `lemp`, this variable defines the name of Nginx document root in `/var/www` directory.
- `internal_lb_endpoint` - endpoint of the internal load balancer, to which Nginx reverse proxy will redirect requests (required only when `target` is set to `rproxy`).

## Dependencies

None.

## Example Playbook

```yaml
- hosts: nodes_web
  roles:
    - role: nginx
        target: rproxy
        external_lb_endpoint: site.example.com
        internal_lb_endpoint: "10.0.0.10"
```

## License

MIT / BSD.

## Author Information

This role was created in 2023 by laslopaul.
