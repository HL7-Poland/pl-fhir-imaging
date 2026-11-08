# CORRECTIONS.md — pl-fhir-imaging

## Correções aplicadas

### REA-009: Remove duplicate ValueSet entry
**Arquivo:** input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh  
**Problema:** Entrada duplicada no ValueSet: "RTG biodra prawego 2 lub 3 projekcje" aparecia com LOINC 103234-1 (linha 25) e LOINC 103238-2 (linha 29) — mesmo display, códigos diferentes.  
**Correção:** Removida a entrada duplicada LOINC 103238-2.  
**Evidência:** `Select-String` encontrou 2 ocorrências de "RTG biodra prawego 2 lub 3 projekcje" antes da correção.

### REA-010: Remove duplicate ValueSet entry
**Arquivo:** input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh  
**Problema:** Entrada duplicada: "RTG biodra obustronnie 3 lub 4 projekcje" aparecia com LOINC 103266-3 (linha 57) e LOINC 103267-1 (linha 58) — mesmo display, códigos diferentes.  
**Correção:** Removida a entrada duplicada LOINC 103267-1.  
**Evidência:** `Select-String` encontrou 2 ocorrências consecutivas de "RTG biodra obustronnie 3 lub 4 projekcje" antes da correção.

### REA-011: Remove placeholder comment
**Arquivo:** input/fsh/aliases.fsh  
**Problema:** Comentário `// Remove this comment` deixado no final do arquivo.  
**Correção:** Removido o comentário placeholder.  
**Evidência:** Linha 56 do aliases.fsh tinha `// Remove this comment`.

### REA-012: Activate hl7.fhir.pl.base.r5 dependency
**Arquivo:** sushi-config.yaml  
**Problema:** Dependência `hl7.fhir.pl.base.r5` estava comentada, mas perfis do Imaging referenciam tipos `PLBase*` (PLBasePatient, PLBaseEncounter, PLBaseServiceRequester, etc.) que só existem nessa dependência.  
**Correção:** Descomentada a dependência.  
**Evidência:** sushi-config.yaml:29 tinha `# hl7.fhir.pl.base.r5: 0.1.0`.

### REA-013: Add missing README.md
**Arquivo:** README.md (novo)  
**Problema:** Repositório não tinha README.md (apenas pl-fhir-lab tinha).  
**Correção:** Criado README.md com descrição do IG, estrutura e instruções de build.  
**Evidência:** `Get-ChildItem` não encontrou README.md no repositório antes da correção.

## Problemas não corrigidos
Nenhum.

## Riscos remanescentes
- Dependência externa `hl7.fhir.pl.base.r5` deve estar disponível para build bem-sucedido
- Build não validado (SUSHI não instalado no ambiente)
