# Metamodel — Knowledge Graph

Source of design: Charter. GitHub markdown is the store; Pages is the first UI.

## Node types

| Type | Meaning |
|------|---------|
| Problem | Pain that demanded a solution |
| Concept | Idea / model |
| Technology | Language, framework, protocol family |
| API | Concrete Apple/Swift surface |
| Topic | Multi-layer learning unit (onion) |
| HistoryEvent | Dated step that explains a technology |
| Person | Trace on the graph (Jobs, Torvalds, Liskov…) — not celebrity bios |
| WWDC | Conference release node |
| Evolution | Swift Evolution proposal |
| Doc | Official documentation / sample |
| Lab | Experiment artifact |
| Example | Code sample linked to Core World / Sandbox |
| Exercise | Practice mission |
| Question | Open question (answered in chat / interview, not always in page) |
| GlossaryTerm | Shared vocabulary |
| WorldEntity | Character/thing in a Reference World |

## Edge types (minimum)

`depends_on` · `required_for` · `solves` · `superseded_by` · `replaced_by` · `inspired_by` · `introduced_at` · `proposed_in` · `documented_in` · `invented_by` · `used_by` · `practiced_in` · `related_to`

## Topic passport (every Topic node)

1. What is it?  
2. What problem does it solve?  
3. Why did that problem appear?  
4. What came before?  
5. Why was that not enough?  
6. Modern recommendation  
7. Where is the industry going (evidence-based)?  
8. Where used  
9. Practice / lab  
10. Interview / English for Interview  
11. Graph links (prerequisites, used-in, WWDC, docs)

## Onion layers

See Charter. Spec template: [TOPIC_TEMPLATE.md](TOPIC_TEMPLATE.md).

## Progress dimension

Separate from content depth — see [PROGRESS.md](PROGRESS.md).

## Implementation note

Phase now: passport + links in markdown. Later: generated graph UI. Do not block learning on custom graph software.
