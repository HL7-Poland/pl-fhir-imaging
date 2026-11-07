# REVERSE ENGINEERING REPORT — HL7-Poland/pl-fhir-imaging

## Repositório original
- Nome: pl-fhir-imaging
- URL: https://github.com/HL7-Poland/pl-fhir-imaging
- Tipo: Implementation Guide FHIR R5 via SUSHI
- Branch: main

## Data da auditoria
2026-11-07

## Ferramentas utilizadas
- Git v2.49.0
- PowerShell 5.1
- webfetch (GitHub web/issues inspection)
- Kilo Code (análise estática de arquivos FSH/YAML)

## Arquitetura identificada
Implementation Guide FHIR para o domínio de diagnóstico imagem (radiologia) na Polônia. Gerado por SUSHI a partir de definições FSH em `input/fsh/`. Contém perfis de procedimento, ordem de serviço, DeviceDefinition (MRI), e base perfis (PLBasePatient, PLBaseEncounter, etc.). FHIR R5. Licença CC0-1.0.

## Tecnologias e dependências
- SUSHI (FSH → FHIR)
- FHIR R5 (5.0.0)
- Dependência ativa: hl7.fhir.eu.extensions: 0.1.0
- Dependência comentada (ativada na correção): hl7.fhir.pl.base.r5: 0.1.0

## Estado de manutenção
- 0 Issues GitHub (abertas e fechadas)
- 0 PRs GitHub
- ~18 commits
- Nenhum teste automatizado configurado
- README.md ausente (corrigido)

## Limitações da investigação
- Sem token GitHub válido para acessar API de Issues/PRs
- Sem ambiente SUSHI instalado para executar build e validar correções

---

## Problemas encontrados (pl-fhir-imaging)

| ID | Severidade | Status | Localização | Problema | Correção aplicada |
|---|---|---|---|---|---|
| REA-009 | P2 | CONFIRMADO | input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh:25,29 | Entrada duplicada "RTG biodra prawego 2 lub 3 projekcje" (LOINC 103234-1 e 103238-2) | Removida entrada duplicada LOINC 103238-2 |
| REA-010 | P2 | CONFIRMADO | input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh:57,58 | Entrada duplicada "RTG biodra obustronnie 3 lub 4 projekcje" (LOINC 103266-3 e 103267-1) | Removida entrada duplicada LOINC 103267-1 |
| REA-011 | P3 | CONFIRMADO | input/fsh/aliases.fsh:56 | Comentário placeholder `// Remove this comment` deixado no código | Removido |
| REA-012 | P2 | CONFIRMADO | sushi-config.yaml:29 | Dependência `hl7.fhir.pl.base.r5` comentada, mas perfis referenciam `PLBase*` | Ativada dependência |
| REA-013 | P3 | CONFIRMADO | Raiz do repositório | README.md ausente | Criado README.md com descrição do IG |

## Arquivos modificados
- input/fsh/aliases.fsh
- input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh
- sushi-config.yaml
- README.md (novo)

## Commits criados
- b9e8cfb (main): REA: fix ValueSet duplicates, placeholder comment, base dependency, add README

## Problemas não corrigidos
Nenhum — todos os 5 problemas identificados foram corrigidos.

## Testes executados
Nenhum — ambiente SUSHI não disponível para validar build.

## URL do fork publicado
Pendente — requer token GitHub válido para criar fork no admeduardovieira e fazer push.

## Riscos remanescentes
- Dependência `hl7.fhir.pl.base.r5` é externa; se não estiver publicada, o build falhará
- Sem build de validação (SUSHI não instalado), não é possível confirmar que as correções resolvem todos os erros de geração

## Recomendações para auditorias futuras
- Instalar SUSHI e executar `sushi` para validar build após correções
- Configurar testes automatizados (tests.csv) no repositório
- Publicar Issues para acompanhamento de problemas conhecidos
