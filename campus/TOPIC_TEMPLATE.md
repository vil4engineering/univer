# Topic template (v2)

Stable id + passport. Storage path may be Library; shape is academic.

---

## Header

- **Topic id:**
- **Faculty:**
- **Path heat:**
- **Status:** `not_started` | `learning` | `practicing` | `interview_ready` | `mastered`
- **Confidence:** /5
- **Interview Heat:** ★…
- **Levels present:** 1 / 2 / 3

---

## Passport

1. What is it?  
2. Problem it solves  
3. Why the problem appeared  
4. What came before  
5. Why that was not enough  
6. Modern approach  
7. Where next (incl. AI when relevant)  
8. Where used  

History / lore only if it answers passport 3–5. North-star gate: *Does this help understand the engineering world?* Cut the rest.

---

## Evolution (then → now)

Short strip, not a legacy course. Show why the modern API looks the way it does.

Example shape: `NSURLConnection` → `URLSession` → `async/await` · or `UIButton` → `Configuration` → `SwiftUI Button`.

Link Sandbox / Evolution files if they exist outside the app target ([CODE_CONTRACT.md](CODE_CONTRACT.md)).

---

## Levels

### Level 1 — Student B
Intuition · life analogies · visuals · tiny practice. Prefer Reference World heroes over `Foo`/`Bar`.

### Level 2 — Engineer
Professional explanation · examples · default decisions.

### Level 3 — Deep Dive
Implementation · trade-offs · history · research / runtime (optional onion layers 3–5 inside this level only).

Default study obligation: Level 2 (+ Level 1 if teaching Student B). Level 3 when earned. Do not force full onion on every topic.

---

## Completeness

- [ ] Understand  
- [ ] Explain  
- [ ] Demonstrate  
- [ ] Practice  
- [ ] Reuse  
- [ ] Teach (when applicable)

---

## Visual & practice (Pages DoD)

Aim for these when marking a topic toward `interview_ready` / `mastered` (browser-first):

- [ ] Diagram or process scheme  
- [ ] Life analogy (required for Level 1)  
- [ ] Code (Reference World / lab / Sandbox cite)  
- [ ] Experiment (“what if…”) or intentional failure → fix  
- [ ] Self-check / quiz  
- [ ] Official links (Apple Docs · WWDC · Evolution as applicable)  

No topic is complete without practice.

---

## English for Interview (optional block)

Key terms: …  
Spoken answer sketch (EN): …

---

## Evidence

- [ ] Explained  
- [ ] Mock answers  
- [ ] Code / lab  
- [ ] Level 3 (if agreed)  
- [ ] Exercise  

## Skills used

(e.g. `wwdc-deepdive`, `architecture-review`)

## Open questions

Leave **unanswered** on the page. Forge answers in chat / mock interview, then write Evidence back ([OPERATING_MODES.md](OPERATING_MODES.md)).

## Next

Prerequisites · follow-ups · Lab ids · related Skills · related Engineering Patterns / symptoms (if any)
