# Infrastructure as Code kandiprojekti

Tämä repositorio on osa kandidaatintutkielmaani.
Koodi on kirjoitettu niin, että se toimii ja on ajettavissa, mutta tämän repon todellinen tarkoitus on toimia käytännön esimerkkinä: miten provisiointi ja konfiguraationhallinta eroavat toisistaan, miten ne linkittyvät (`.tfvars` -> `inventory.ini`).

## Työkalut ja versiot

| Komponentti | Versio |
|---|---|
| Proxmox Virtual Environment | 9.2 |
| Terraform | 1.15.6 |
| Ansible | 2.21.1 |
| Ubuntu Server | 26.04 LTS |
| Docker Engine | 29.1.3 |
| Nginx | 1.30.3 |

Testattu vain näillä versioilla. GitHub Actions -workflow tarkistaa syntaksin (`terraform fmt/validate`, `ansible-lint`).

## Tietoturva

`terraform.auto.tfvars` sisältää Proxmox API -tokenin, ssh-avaimen, yms. eikä sitä viedä versionhallintaan.

