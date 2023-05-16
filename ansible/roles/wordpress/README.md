# Wordpress Ansible role

This role installs and configures the latest version of Wordpress for Ubuntu. It also installs a set of PHP packages that are required by the LEMP stack and Wordpress, from Ubuntu official repository.

## Requirements

This role requires Nginx web server and MySQL database to be pre-installed for correct operation of Wordpress.

## Role Variables

- `wp_site` - web address of the Wordpress site. Used to name the virtual host folder in /var/www.
- `recreate_wp_config` (bool) - replace existing `wp-config.php` file with a new one generated from the template. Default is `false`.

  **WARNING: Setting this variable to `true` will irreversibly change Wordpress secrets and salts, forcing all users to log in again.**

- `db_host` - hostname of the database server.
- `db_name` - name of the database for Wordpress.
- `db_user` - database username.
- `db_password` - database password.

## Dependencies

None.

## Example Playbook

```yaml
- hosts: nodes_app
  roles:
    - role: wordpress
      wp_host: site.example.com
      db_host: wordpress-db.example.com
      db_name: wordpress
      db_user: wp-user
      db_password: secret
```

## License

MIT / BSD.

## Author Information

This role was created in 2023 by laslopaul.
