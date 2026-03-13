# Growth Plan Generator

Generate a customized Maven learning growth plan as a deployable HTML page for a given topic + role combination.

## Inputs

The user provides:
- **Topic**: e.g., "vibe coding", "ai marketing", "claude code"
- **Role**: e.g., "product manager", "marketer", "designer"

## Output format

Each plan is a **single self-contained HTML file** saved to `plans/{topic-slug}-{role-slug}.html`. Use `plans/vibe-coding-product-manager.html` as the reference template for structure, styling, and layout.

## Step-by-step process

### Step 1: Content inventory

Search the local data files (NOT Metabase live -- use cached data in `data/` directory) for content matching the topic.

**Lightning Lessons** (`data/lightning_lessons.json`):
- Filter by keyword match across SECTION_TITLE, TOPIC_DESCRIPTION, LEARNING_OBJECTIVES
- Only include LLs that feel recent (check if the content references current tools/trends)
- Extract: title, slug (for URL: `https://maven.com/p/{slug}`), instructor name, instructor image URL (INSTRUCTOR_IMG_URL), school_id, brand_label, learning objectives, description
- Identify upcoming vs. on-demand LLs

**Courses** (`data/course_syllabus_5k.json` for courses over $5K earnings):
- Filter by keyword match across COURSE_NAME, TOPICS, ITEM_TITLE
- Deduplicate by COURSE_ID (many rows per course)
- Extract: course_name, course_url, course_id, school_slug, topics, cohort info, start dates
- Has GMV_LAST_12_MONTHS field for prioritization

**Course landing pages** (`data/course_landing_pages.json`):
- Use to enrich course descriptions and extract "Key skills to master" content
- Parse Sections JSON for outcomes, skills, testimonials, and learning objectives
- Cross-reference with course_syllabus_5k for the same courses

**GMV ranking** (`data/gmv_by_course.json`):
- Cross-reference course IDs to rank by `Sum of Gross Amount After Discount ($)`
- Higher GMV = more proven demand. Prioritize these.

**Signups** (`data/ll_signups_by_school.json`):
- Cross-reference school_id to get signup counts per instructor
- Use format "X+ students" in instructor cards

**Lead magnets** (`data/lead_magnets_recent.json` — only resources updated in past year):
- Check if any relevant lead magnets exist for the topic
- Include in the "Free Resources" carousel at EVERY level (Foundation, Application, Production)
- At least 1 free resource per section
- Parse Sections JSON for title (from "main" section_type) and URL (from "Content Pages Lead Magnets → Link URL")

### Step 2: Identify expert instructors

- Rank instructors by: (1) GMV of their courses, (2) number of LL signups, (3) number of relevant LLs
- Select 8-10 instructors for the "Experts in {Topic}" section
- **Ensure gender diversity** -- actively include women instructors
- Get their photo URL from INSTRUCTOR_IMG_URL field in lightning_lessons.json
- Get their full bio from the LL data (INSTRUCTOR_BIO field, strip HTML tags)

### Step 3: Map resources to three tiers

**Foundation** (free, low commitment):
- Lightning Lessons that cover basics, introductions, getting started
- Lead magnets / free downloads if available
- Beginner-friendly courses and bootcamps
- Goal: someone can start today in 30 minutes

**Application** (intermediate LLs + courses):
- LLs that cover intermediate skills, team adoption, specific workflows
- Courses that go deeper on practical application
- Goal: someone can apply this at work within a week

**Production** (advanced courses + technical depth):
- LLs that cover production, advanced techniques, architecture
- Advanced/longer courses
- Goal: someone becomes the go-to person on their team

### Step 4: Write role-specific framing

The resources are largely the same across roles. What changes:
- **"Why this matters" section**: frame urgency in terms of their role
- **"Key skills to master" bullets**: role-specific skills at each level, pulled from real LL learning objectives and course landing page content — practical, not salesy
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
- Place quotes in Expert Tips carousels within the relevant level

If no transcripts exist for an instructor:
- Query Metabase for their school using the transcript dataset query (ID 10189)
- Filter by school slug using field 13355 in the query filter
- Save result to `data/transcripts_{instructor_name}.json`

### Step 6: Assemble the HTML page

Use `plans/vibe-coding-product-manager.html` as the reference template. The page structure is:

#### Above the fold (preview/gate area)
1. **Nav** -- Maven logo (SVG from CDN) + nav links
2. **Hero** -- Badge (`{Topic} × {Role}`), h1 title, subtitle
3. **Preview stats** -- 4 stat cards (e.g., "15 Free Lightning Lessons", "5 Free Resources", "12 Courses", "10 Expert Instructors")
4. **Your learning path** -- 3-step roadmap (Foundation, Application, Production) with descriptions
5. **Email capture gate** -- Dark box with email input (white) and highlight-colored CTA button

#### Below the gate (main content)
6. **Why this matters for {Role}s** -- 1 paragraph, role-specific framing. Weave in a short expert quote inline with attribution (not as a standalone blockquote).
7. **Experts in {Topic}** -- 2-column grid of instructor cards, each with:
   - Circular headshot photo (from INSTRUCTOR_IMG_URL)
   - Name, title, student count
   - Subscribe button
8. **Level 1: Foundation** section containing:
   - Key skills to master (bullet list pulled from real LL LEARNING_OBJECTIVES and course landing page content)
   - Lightning Lessons carousel (upcoming with date badges, on-demand)
   - Free Resources carousel (from lead_magnets_recent.json — at least 1 per section)
   - Courses section
9. **Level 2: Application** -- same structure as Level 1
10. **Level 3: Production** -- same structure as Level 1

#### Design system (from skills/frontend-design.md)
- **Fonts**: Bureau Serif (headings), Bureau Sans (body) -- local woff2 files in `plans/`
- **Colors**: `--accent: #1C368D`, `--highlight: #CDFF92`, `--text: #080C28`
- **Logo**: `https://cdn.brandfetch.io/idIp45c7Hp/theme/dark/logo.svg?c=1bxid64Mup7aczewSAYMX&t=1772482451686`
- **No unnecessary color highlights** on quotes, courses, or LL cards -- keep it clean
- Blockquotes: subtle 2px grey left border, no background color
- Upcoming cards: no green/accent background, just neutral styling
- Course cards: no colored left border for upcoming

### Step 7: Humanize

Run /humanizer on all text content to remove AI writing patterns:
- Em dash overuse (keep to 2-3 max in the whole doc)
- Rule of three (break up triads)
- Promotional language ("flagship", "groundbreaking", "superpower")
- Copula avoidance ("serves as" -> "is")
- Sycophantic framing
- Keep sentences varied in length

### Step 8: Save and update checklist

Save the plan to `plans/{topic-slug}-{role-slug}.html`
Update the build list checklist in CLAUDE.md, marking the plan as done with the file path.

## Quality checklist

Before marking a plan as done:
- [ ] Only LLs from past 6-12 months
- [ ] Instructors prioritized by GMV
- [ ] Instructor photos included (from INSTRUCTOR_IMG_URL)
- [ ] Subscribe button on each instructor card
- [ ] Gender diversity in expert instructors
- [ ] Student counts included where available
- [ ] No earnings/GMV numbers in the plan (student-facing)
- [ ] Real quotes from real transcripts (not fabricated)
- [ ] Role-specific framing at each level
- [ ] Foundation level is 100% free content
- [ ] Preview stats are accurate counts
- [ ] Email gate with white input + highlight CTA button
- [ ] Uses Maven brand system (Bureau fonts, Lapis blue, lime highlight)
- [ ] No unnecessary color highlights on quotes/cards
- [ ] Humanizer pass completed
- [ ] Saved to plans/ directory as .html
- [ ] CLAUDE.md checklist updated
