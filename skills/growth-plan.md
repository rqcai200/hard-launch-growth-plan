# Growth Plan Generator

Generate a customized Maven learning growth plan for a given topic + role combination.

## Inputs

The user provides:
- **Topic**: e.g., "vibe coding", "ai marketing", "claude code"
- **Role**: e.g., "product manager", "marketer", "designer"

## Step-by-step process

### Step 1: Content inventory

Search the local data files (NOT Metabase live -- use cached data in `data/` directory) for content matching the topic.

**Lightning Lessons** (`data/lightning_lessons.json`):
- Filter by keyword match across SECTION_TITLE, TOPIC_DESCRIPTION, LEARNING_OBJECTIVES
- Only include LLs that feel recent (check if the content references current tools/trends)
- Extract: title, slug (for URL: `https://maven.com/p/{slug}`), instructor name, instructor bio, school_id, brand_label, learning objectives, description

**Courses** (`data/course_syllabus.json`):
- Filter by keyword match across COURSE_NAME, TOPICS, ITEM_TITLE
- Deduplicate by COURSE_ID (many rows per course)
- Extract: course_name, course_url, course_id, school_slug, topics

**GMV ranking** (`data/gmv_by_course.json`):
- Cross-reference course IDs to rank by `Sum of Gross Amount After Discount ($)`
- Higher GMV = more proven demand. Prioritize these.

**Signups** (`data/ll_signups_by_school.json`):
- Cross-reference school_id to get signup counts per instructor
- Use format "X+ students on Maven" in the plan

**Lead magnets** (`data/lead_magnets.json`):
- Check if any relevant lead magnets exist for the topic
- If so, note them for potential inclusion at the Foundation level

### Step 2: Identify anchor instructor(s)

- Rank instructors by: (1) GMV of their courses, (2) number of LL signups, (3) number of relevant LLs
- The top 1-2 instructors become the "featured guide(s)" in the plan
- Get their full bio from the LL data (INSTRUCTOR_BIO field, strip HTML tags)

### Step 3: Map resources to three tiers

**Foundation** (free, low commitment):
- Lightning Lessons that cover basics, introductions, getting started
- Lead magnets / free downloads if available
- Goal: someone can start today in 30 minutes

**Application** (free LLs + paid workshops/courses):
- LLs that cover intermediate skills, team adoption, specific workflows
- Entry-level courses and workshops
- Goal: someone can apply this at work within a week

**Leverage** (advanced courses + technical depth):
- LLs that cover production, advanced techniques, architecture
- Advanced/longer courses
- Free LLs at this level too (e.g., "learn to read code" for non-technical roles)
- Goal: someone becomes the go-to person on their team

### Step 4: Write role-specific framing

The resources are largely the same across roles. What changes:
- **"Why now" section**: frame urgency in terms of their role (PM interviews, marketer competitive edge, designer prototyping, etc.)
- **"What you'll be able to do" bullets**: role-specific outcomes at each level
- **Which LLs to highlight first**: if a LL is role-specific, lead with it

Role framing guidelines:
- **Product Manager**: prototype to validate, PM interviews, stakeholder demos, build-vs-buy decisions
- **Marketer**: build landing pages, automate workflows, create tools without waiting on dev
- **Designer**: interactive prototypes beyond Figma, design-to-code, test real interactions
- **Engineer**: agent architecture, production workflows, AI-native development patterns
- **Founder**: MVP speed, solo building, SaaS side projects, fundraising demos
- **Executive/Leader**: understand what's possible, evaluate AI tools, lead AI adoption

### Step 5: Pull expert quotes from transcripts

Check if transcript data exists in `data/transcripts_*.json` for anchor instructors.

If transcripts exist:
- Parse the Metabase dataset response: `data.rows[]` with column mapping from `data.cols[]`
- Key columns: TITLE, TRANSCRIPT_URL, EVENT_TYPE, DURATION_MIN, DESCRIPTION
- Prioritize workshop sessions and main course sessions (skip office hours, Q&A, kick-offs)
- Download 2-3 VTT transcript files from the URLs
- Extract 2-3 quotable moments per instructor (specific, practical, surprising)
- Place quotes next to the relevant LL or course in the plan

If no transcripts exist for an instructor:
- Query Metabase for their school using the transcript dataset query (ID 10189)
- Filter by school slug using field 13355 in the query filter
- Save result to `data/transcripts_{instructor_name}.json`

### Step 6: Assemble the plan

Use this template structure:

```markdown
# Your {Topic} Growth Plan
**For {Role}s**

---

## Why {topic}, why now
[2-3 sentences, role-specific urgency]

---

## Meet your guide
**{Instructor Name}** -- {title}
[Bio paragraph with credibility signals, student count]

---

## Your progression path

### Level 1: Foundation -- "{outcome quote}"
What you'll be able to do:
- [role-specific outcome]
- [role-specific outcome]
- [role-specific outcome]

Start here (free Lightning Lessons):

**[LL Title](url)** -- Instructor | student count
[1-2 sentence description]

> "quote from transcript" -- Instructor Name

[repeat for 3-4 LLs]

---

### Level 2: Application -- "{outcome quote}"
[same pattern, LLs + courses]

---

### Level 3: Leverage -- "{outcome quote}"
[same pattern, LLs + advanced courses]

---

## Your first step
**Watch [LL Title](url) by Instructor.** Free, about X minutes. [concrete outcome].

---
```

### Step 7: Humanize

Run /humanizer on the completed plan to remove AI writing patterns. Key things to watch for:
- Em dash overuse (keep to 2-3 max in the whole doc)
- Rule of three (break up triads)
- Promotional language ("flagship", "groundbreaking", "superpower")
- Copula avoidance ("serves as" -> "is")
- Sycophantic framing
- Keep sentences varied in length
- Use "is/are/has" where appropriate instead of fancy substitutes

### Step 8: Save

Save the plan to `plans/{topic-slug}-{role-slug}.md`
Update the "Completed plans" checklist in CLAUDE.md

## Quality checklist

Before marking a plan as done:
- [ ] Only LLs from past 6-12 months
- [ ] Instructors prioritized by GMV
- [ ] Student counts included where available
- [ ] No earnings/GMV numbers in the plan (student-facing)
- [ ] Real quotes from real transcripts (not fabricated)
- [ ] Instructor bios included with credibility signals
- [ ] Role-specific framing at each level
- [ ] Foundation level is 100% free content
- [ ] Clear single first step at the bottom
- [ ] Humanizer pass completed
- [ ] Saved to plans/ directory
- [ ] CLAUDE.md checklist updated
