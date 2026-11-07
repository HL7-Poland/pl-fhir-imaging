# HL7 Poland Imaging IG

HL7 FHIR Implementation Guide para o domínio de diagnóstico imagem na Polônia.

Este IG especifica perfis, extensões e valores para troca de dados de exames de imagem (radiologia) baseado no padrão FHIR R5.

## Estrutura

- `input/fsh/` — Definições FSH (perfis, extensões, terminologia)
- `input/pagecontent/` — Conteúdo das páginas (index.md, model.md)
- `sushi-config.yaml` — Configuração do SUSHI

## Build

Requer SUSHI e IG Publisher instalados.

```bash
sushi
./_genonce.sh
```
