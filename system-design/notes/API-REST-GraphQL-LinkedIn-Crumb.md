# API type choice — REST vs GraphQL crash story (LinkedIn)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `505054` |
| Related | system-design |
| URL | https://www.linkedin.com/posts/aryan-gupta-81887028a_api-softwareengineering-rest-share-7475982968360943617-_mUO/ |

---

## Digest

My API handled 10,000 requests flawlessly in testing.

Crashed in production within 2 hours.

The problem? I used the wrong API type.

🎁 Lately, I started learning Claude skills from this article: https://lnkd.in/eSgv9QP8

APIs aren't one-size-fits-all. Different problems need different types.

𝗢𝗣𝗘𝗡 𝗔𝗣𝗜
- Public access for anyone.
- Use for: Weather data, login systems, product catalogs
- Example: Stripe payments, Google Maps

𝗥𝗘𝗦𝗧 𝗔𝗣𝗜
- HTTP-based, simple, universal.
- Use for: 90% of modern web apps
- Example: Mobile app fetching user data

𝗦𝗢𝗔𝗣 𝗔𝗣𝗜
- XML-based, strict, formal.
- Use for: Banks, insurance, government
- Example: Processing insurance claims, wire transfers

𝗚𝗿𝗮𝗽𝗵𝗤𝗟 𝗔𝗣𝗜
- Query exactly what you need.
- Use for: Complex data with many relationships
- Example: Facebook feed (only fetch what's needed)

𝗕𝗔𝗖𝗞𝗘𝗡𝗗 𝗧𝗢 𝗕𝗔𝗖𝗞𝗘𝗡𝗗
- Internal microservices talking.
- Use for: Your own system architecture
- Example: Auth service → User service → Payment service

𝗙𝗥𝗢𝗡𝗧𝗘𝗡𝗗 𝗧𝗢 𝗕𝗔𝗖𝗞𝗘𝗡𝗗
- Your UI requesting server data.
- Use for: Every web/mobile app interaction
- Example: Login, search, profile updates

𝗦𝗘𝗥𝗩𝗜𝗖𝗘 𝗧𝗢 𝗗𝗔𝗧𝗔𝗕𝗔𝗦𝗘
- Backend querying databases.
- Use for: All data operations
- Example: Storing users, fetching orders
B2B INTEGRATION

𝗣𝗔𝗥𝗧𝗡𝗘𝗥 𝗔𝗣𝗜
- Controlled access for trusted partners.
- Use for: Affiliate programs, reseller systems
- Example: Amazon affiliate tracking

𝗗𝗔𝗧𝗔 𝗦𝗛𝗔𝗥𝗜𝗡𝗚 𝗔𝗣𝗜
- Secure exchange of sensitive data.
- Use for: Health records, financial data
- Example: Hospital systems sharing patient info

The pattern:
❌ Use REST for everything
✅ Match API type to problem

My decision framework:
Public access? → Open API or REST
Complex queries? → GraphQL
Enterprise/legacy? → SOAP
Internal services? → Backend to Backend
Business partners? → Partner API
Sensitive data? → Data Sharing API

Which API type saves you the most time?

🔁 Repost if this clears up API confusion

➕ Follow Aryan Gupta for more resources 

#API #SoftwareEngineering #REST #GraphQL #Backend #WebDev #TechArchitecture
 | 31 comments on LinkedIn

## Framing

SE crumb on picking API style for load — not Backend faculty depth. Useful as cautionary interview anecdote.
