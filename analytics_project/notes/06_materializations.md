# Les matérialisations dbt

Une matérialisation détermine comment dbt crée un modèle dans le data warehouse.

| Matérialisation | Objet créé dans BigQuery | Quand l’utiliser | Limite principale |
|---|---|---|---|
| view | Vue | Modèles légers, staging et transformations simples | Requête recalculée à chaque consultation |
| table | Table physique | Marts et modèles fréquemment consultés | Table entièrement reconstruite |
| ephemeral | Aucun objet | Petit calcul intermédiaire utilisé par un autre modèle | Impossible à consulter directement dans BigQuery |
| incremental | Table alimentée progressivement | Très grandes tables contenant de nouvelles données | Configuration plus complexe et utilisation de MERGE |

## Configuration dans un modèle

```sql
{{ config(materialized='table') }}