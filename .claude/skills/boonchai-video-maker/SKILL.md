---
name: boonchai-video-maker
description: Making and editing 25-30s Thai vertical ad clips for บุญชัยฮาร์ดแวร์ (Boonchai Hardware / BCH) with the video-maker workspace - the brand.json → promptkit → Google Flow → harvest → buildad → pro-pass pipeline. Use whenever the task is a new BCH clip, editing an existing give-<name> clip, writing Thai VO lines, or checking shots against the client's rules.
---

# Boonchai Hardware video maker

Not an app. A Claude Code workspace of Python scripts plus rule files. Claude does
the thinking, Google Flow generates the shots, ffmpeg assembles them.

Source: the `video-maker` folder (shipped as `video-maker-part01..04` RAR/zip on
the Desktop, also on USB drive E:\video maker). Part01 alone is incomplete.

## Pipeline

```
brand.json          <- the rulebook (character, outfit, style, client's rules)
  v promptkit.py
prompt1..6.txt      <- 6 English prompts, one per 8s shot, + lines.txt (Thai VO)
  v send_all.py     <- fires all 6 into Google Flow, project MAIN (e8f77fc9)
  v harvest2.py     <- ~10 min later, downloads them (must pick 720p Original)
  v sort_harvest.py <- matches files to shots by transcribing audio (>=0.6)
shots/shot1..6.mp4
  v buildad.py <folder>  <- trims silence, concats, burns Thai .ass subs
out/final.mp4
  v pro pass (pro_all.py) <- 1.18x zoom-in, whoosh 0.4, music 0.12, BCH logo
out/final-pro.mp4   <- the one you send
```

Scripts that live in parts 02-04, not part01: `promptkit.py`, `send_all.py`,
`harvest2.py`, `sort_harvest.py`, `flowsite.py`, `pro_all.py`, the `music/`
folder, `give-share/`, and most `shots/*.mp4`.

**Every script hardcodes `C:\Users\Computer\Downloads\cluade code\...`.**
Nothing runs from another location until those paths are fixed or the folder is
put back there.

## The format (locked by the client, the user's dad)

- **6 shots x 4-5s = 25-30s, vertical.**
- **Shot 6 is always the share ask:** "ถ้าคลิปนี้มีประโยชน์ ช่วยกดแชร์ให้ด้วยนะครับ"
- **Structure:** hook question → "most people get this wrong" → prove it →
  explain → correct way → share.
- **GIVE content only for the first 3 months.** Teach, don't sell. Shop name only
  at the close.
- **เฮียวัฒน์** = Flow saved character `hia-bch` only. 3D Pixar-style cartoon,
  grey glasses, navy/red BCH jacket, no apron.
- **No Thai text on products.** AI spells it as nonsense; order blank packaging
  instead.
- **No burned-in subs from Flow.** Subs are added in the edit.

## Making a new clip

1. **Pick a topic.** Must be something most people don't know. `STATUS.md` says
   the topic stock is empty, so propose new ones first.
2. **Write 6 lines of Thai VO**, one sentence per 8s shot →
   `give-<name>/lines.txt`.
3. **Generate the 6 prompts with `promptkit.py`.** It stamps in every hard-won
   rule: Omni 1.1 Flash model, one continuous locked-off take, BCH badge spelled
   right, cartoon-not-photoreal, no text in frame. Don't hand-write prompts. Copy
   the structure from `give-nail/prompt1.txt` if you must.
4. **Send to Flow:** `python send_all.py give-<name> 1 2 3 4 5`. Shot 6 reuses
   the share shot and saves credits. Verify the **"Ingredient image"** chip
   appears before sending. If it says "Video ingredient image", the face comes
   out as a different guy.
5. **Wait ~10 min**, then `python harvest2.py e8f77fc9 give-<name> 6` →
   `python sort_harvest.py`.
6. **Check every shot** against the 6-point list in `STATUS.md`: BCH not RCM,
   glasses on, torso visible in hand shots, no fake Thai on products, no Flow
   subs, no repeated lines.
7. **Assemble:** add a `PLANS["give-<name>"]` entry in `buildad.py`, six tuples of
   `(file, speech_start, speech_end, subtitle, style, tail)`. Timings must come
   from actually transcribing each shot, not guessing. Then
   `python buildad.py give-<name>`.
8. **Pro pass** → `out/final-pro.mp4` → review before showing him.

## Editing an existing clip

Everything lives in `buildad.PLANS`. Change the in/out seconds or the subtitle
text and re-run `python buildad.py give-<name>`. It rebuilds `out/final.mp4` in
seconds with no Flow credits spent. Only re-generate a shot in Flow when the
*picture* is wrong.

## Where it was left off (10 ก.ย. 2569)

- 18-19 clips done, none posted yet. He hasn't said to post.
- 3 new topics in progress: `give-nail` (built, `out/final-v3.mp4` exists but
  shots 3-6 aren't in part01), `give-anchor`, `give-tap`.
- Waiting on him: the 12 borderline shots in `audit/AUDIT.md`, and whether he
  liked the storytelling version (`give-drillbattery`).

## Related skills

- `video-editing` for the local video-editor connector (captions, loudness,
  grading) when finishing a cut outside this pipeline.
- `ad-performance` for logging views and watch-through once clips are posted.
