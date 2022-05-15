# Ansible role: nginx

## Introdução
Essa role instala e configura o nginx web server. O usuário pode especificar
qualquer parâmetro de configuração `http` que ele deseja aplicar ao seu site.
Pode ser adicionado a quantidade de sites desejada com as configurações de sua prefêrencia.

## Requisitos
- Ansible **2.9**

## Configuração
### nginx.conf

Customizações de campos específicos devem utilizar como referência as variáveis
presentes em [defaults/main.yml](defaults/main.yml).

### VirtualHost padrão
Configuração do virtualhost padrão:

```yaml
nginx_default_sites:
  default:
    - listen 80 default_server
    - server_name ""
    - root "/var/www/01-default/www"
    - location / { index index.html; }
  default_ips:
    - listen 80
    - server_name {{ ansible_all_ipv4_addresses | join(" ") }}
    - root "/var/www/01-default/www"
    - location / { index index.html; }
```

### Configuração de Virtualhosts
Os virtualhosts devem ser configurados conforme exemplo abaixo:

```yaml
---
nginx_sites:
  exemplo.com:
    - listen 80
    - server_name exemplo.com
    - root "/var/www/exemplo.com/www"
    - location / {
          return 301 https://$server_name$request_uri;
      }
    - location ~ ^/(dashboard|tv)\/?(.*) {
          try_files  $uri $uri/ /index.php$is_args$args;
          include        fastcgi_params;
          fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
          fastcgi_pass   unix:/var/run/exemplo.com.sock;
      }
    - error_log   /var/log/nginx/exemplo-com.error.log   notice
    - access_log  /var/log/nginx/exemplo-com.access.log  main
```

Playbook:

```yaml
- hosts: all
  roles:
    - nginx
```

## Autor
Mantido por [Lucas Freitas](https://github.com/mrlucasfreitas).

## Licença
Apache 2 Licensed.