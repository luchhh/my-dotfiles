---
name: slack-summary
description: What's up on slack 
argument-hint: filter date, defaults to last workable day
---

Interpret $ARGUMENTS to get a filter date, if no arguments is passed, assumed the filter date is the last workable day

- Use /slack:channel-digest #dev-general, #dev-based, #renesas, #ext-chiplab-dev to get last messages from each channel
- Filter messages only equal or later than filter date
- Make a summary of each channel. No need to include personal messages like sick days, or missed daily
