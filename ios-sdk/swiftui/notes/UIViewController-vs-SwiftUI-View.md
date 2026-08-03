# UIViewController (class) vs SwiftUI View (struct)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `504764` |
| Related | [SwiftUI README](../README.md) · [UIKit](../../uikit/README.md) |
| URL | https://www.linkedin.com/posts/sachin-rasane-a69ab3b8_ios-iosdevelopment-swift-share-7480908621803839488-ZzEC/ |

---

## Digest

🚨 𝗢𝗻𝗲 𝗼𝗳 𝘁𝗵𝗲 𝗠𝗼𝘀𝘁 𝗖𝗼𝗺𝗺𝗼𝗻 #𝗶𝗢𝗦 𝗜𝗻𝘁𝗲𝗿𝘃𝗶𝗲𝘄 𝗧𝗿𝗮𝗽𝘀

"Swift loves "struct"s. Then why is "UIViewController" a "class"? And why is SwiftUI's "View" a "struct"?"

This question tests whether you truly understand Swift—not just syntax.

📌 𝐖𝐡𝐲 "𝐔𝐈𝐕𝐢𝐞𝐰𝐂𝐨𝐧𝐭𝐫𝐨𝐥𝐥𝐞𝐫" 𝐢𝐬 𝐚 "𝐜𝐥𝐚𝐬𝐬"

"UIViewController" manages identity and lifecycle.

𝐀 𝐯𝐢𝐞𝐰 𝐜𝐨𝐧𝐭𝐫𝐨𝐥𝐥𝐞𝐫:

- Maintains mutable state.
- Responds to lifecycle events ("viewDidLoad", "viewWillAppear", etc.).
- Is shared across multiple parts of UIKit.
- Inherits from "NSObject" and works with Objective-C runtime features like delegation, KVO, and target-action.

Since it represents a single, long-lived object, reference semantics ("class") are the right choice.

---

📌 𝗪𝗵𝘆 𝗦𝘄𝗶𝗳𝘁𝗨𝗜 "𝗩𝗶𝗲𝘄" 𝗶𝘀 𝗮 "𝘀𝘁𝗿𝘂𝗰𝘁"

A SwiftUI "View" is simply a description of the UI, not the UI itself.

Every time state changes:

- SwiftUI creates a new value.
- Compares it with the previous one.
- Updates only the parts that changed.

Using "struct" provides:
✅ Value semantics
✅ Better performance
✅ Thread safety
✅ Easy diffing for UI updates

The actual UI objects are managed internally by SwiftUI.

---

🎯 𝗜𝗻𝘁𝗲𝗿𝘃𝗶𝗲𝘄 𝗔𝗻𝘀𝘄𝗲𝗿 𝗶𝗻 𝗢𝗻𝗲 𝗟𝗶𝗻𝗲

«UIKit uses classes because UI components have identity and lifecycle. SwiftUI uses structs because views are immutable value descriptions that SwiftUI recreates and diffs efficiently.»

Understanding identity vs value semantics is what interviewers are really looking for.

💬 If this question came up in your interview, how would you explain it?

#iosdevelopment #Swift #SwiftUI #UIKit #MobileDevelopment #SoftwareEngineering #iOSInterview #code #SwiftProgramming #AppleDeveloper #TechnicalInterview #iosjobs #iosdev

## One-liner

UIKit classes = identity + lifecycle; SwiftUI structs = disposable value descriptions that the framework diffs.
