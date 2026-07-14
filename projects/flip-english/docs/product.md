# Product specification

Native iOS/macOS app **FlipEnglish** — learn English through AI-generated **phrase** flashcards.

## Philosophy

Do not teach isolated words. Teach complete phrases and sentence patterns.

| Bad | Good |
|-----|------|
| confident | I feel confident during interviews. |
| architecture | The architecture is highly scalable. |

Always prioritize useful real-world phrases.

## Scope (2026)

| Now | Later (TBD) |
|-----|-------------|
| Personal use — author learning B1→B2 English daily | Elementary / kids decks (family) |
| Tech English, interviews, everyday phrases | Additional languages |
| AI learning lab — see [strategy.md](strategy.md) | App Store, audio, conversation agent, monetization |

Ship for yourself first. Business model and kid mode — decide after daily-use data, not before MVP.

## Learning loop

1. **Front:** image, English definition, example sentence → user recalls the phrase.
2. **Tap** → card flips.
3. **Back:** phrase, pronunciation, phrase type, additional examples.
4. **Swipe right** = remembered · **Swipe left** = forgot → spaced repetition updates schedule.

Optimized for speaking practice, job interviews, communication with American clients, and professional vocabulary.

## Main user flow

Launch → Today → Start Learning → Review cards → Swipe → Progress saved.

## Screens

### Today

- Cards due today, new cards available, streak, total learned
- Primary CTA: **Start Learning**

### Learning

**Front:** image, English definition, example sentence.

**Back:** phrase, pronunciation, phrase type, additional examples.

**Actions:** swipe right = know, swipe left = don't know.

### Import

| Source | Input | Output |
|--------|-------|--------|
| Text | Paste paragraph or interview answer | Generated cards |
| Phrase list | One phrase per line | Generated cards |
| Share Extension | Selected text from Safari, Notes, Mail, chat | Generated cards *(deferred v1)* |

### Statistics

Track total cards, mastered cards, current streak, reviews today, retention rate, success rate.

## Card model

| Field | Purpose |
|-------|---------|
| `id` | Identity |
| `phrase` | Target phrase |
| `definition` | English definition (front) |
| `example` | Example sentence |
| `pronunciation` | How to say it |
| `phraseType` | Category |
| `difficulty` | Level |
| `imagePrompt` | AI image prompt |
| `imageLocalPath` | Stored image |
| `source` | Import origin |
| `createdAt` | Creation time |
| `nextReviewDate` | SRS schedule |
| `repetitionLevel` | SRS level |
| `reviewCount` | Times reviewed |
| `successCount` | Successful recalls |

### Phrase types

Everyday · Business · Interview · Technical · Travel · Custom

### Generation rules

Every card must include English definition, at least one example, phrase, pronunciation, and AI image prompt.

**Never generate translations. English only.**

### Images

Generate a supportive image for every card (deferred for v1 implementation — Image Playground).

Example: phrase *"I feel confident during interviews."* → prompt *Professional job interview candidate sitting confidently in a modern office.*

Images appear on the **front** side to support recall.

## Collections

**Default:** Everyday English, Business English, iOS Development, Job Interviews, Travel.

Users can create custom collections.

## Spaced repetition

**States:** New → Learning → Review → Mastered

**Intervals (days):** 1, 3, 7, 14, 30, 90

- Swipe right → increase interval
- Swipe left → reduce interval

## Interview mode

User imports interview answers. AI extracts reusable phrases, professional vocabulary, and strong sentence patterns.

**Input:** *"My last project stood out to me because I worked on AI agents for Apple Watch."*

**Example cards:** stood out to me · worked on AI agents · Apple Watch application · battery life requirements · privacy considerations

## AI responsibilities

Using Foundation Models:

1. Extract useful phrases
2. Generate definitions, examples, pronunciation
3. Generate image prompts
4. Assign difficulty and phrase type
5. Suggest related phrases

## UI principles

Minimal · fast · one-handed · no complex navigation.

Primary interaction is swiping. Feel similar to Tinder + Anki. Focus on learning speed and daily habit formation.

## Success criteria

The user can:

1. Import phrases from any source
2. Generate flashcards in seconds
3. Review cards using swipes
4. Sync progress through iCloud
5. Improve spoken English through repeated exposure to useful real-world phrases

Phrase acquisition over vocabulary memorization.

## Future features (Phase 2)

Apple Watch companion · widgets · lock screen cards · pronunciation scoring · AI-generated stories using learned phrases · speaking practice mode
