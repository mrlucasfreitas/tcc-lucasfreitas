# Ansible Stack
Está Stack é destinada a execução das roles do Ansible para a instalação ou configuração de serviços/aplicativos no servidores listados no [hosts.ini](./environments/aws/hosts.ini)

## Exemplo
As roles que devem ser executadas estão definidas na pasta de [playbooks](./plays/nginx.yml).

As configurações que a instância irá receber estão listadas no [group_vars](environments/aws/group_vars) e/ou [host_vars](environments/aws/host_vars).