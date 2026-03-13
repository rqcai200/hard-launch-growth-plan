# Hard Launch Growth Plan

Generate customized learning growth plans for Maven's landing page hero. Each plan is a topic + role combination (e.g., "Vibe Coding x Product Manager").

## Project structure

```
data/                          # Raw Metabase exports (refresh periodically)
  lightning_lessons.json       # LL page content (Metabase #6859)
  course_syllabus.json         # Course syllabus + taxonomy (Metabase #15271)
  course_syllabus_5k.json     # Course syllabus for courses >$5K earnings (Metabase #15970)
  course_landing_pages.json   # Course landing page content (Metabase #15965)
  gmv_by_course.json           # GMV by course (Metabase #3887)
  ll_signups_by_school.json    # LL signups by school (Metabase #4081)
  lead_magnets.json            # Lead magnet page content - all (Metabase #15864)
  lead_magnets_recent.json    # Lead magnets updated in past year (Metabase #15971)
  transcripts_*.json           # Transcript query results per instructor
plans/                         # Completed growth plans (topic-role.md)
skills/                        # Skill definition for generating plans
```

## Data sources (Metabase)

| What | Query ID | URL | Refresh frequency |
|------|----------|-----|-------------------|
| Lightning Lesson page content | 6859 | https://maven.metabaseapp.com/question/6859 | Weekly |
| Course syllabus + taxonomy | 15271 | https://maven.metabaseapp.com/question/15271 | Weekly |
| Course syllabus (>$5K earnings) | 15970 | https://maven.metabaseapp.com/question/15970 | Weekly |
| Course landing pages (published) | 15965 | https://maven.metabaseapp.com/question/15965 | Weekly |
| GMV by course | 3887 | https://maven.metabaseapp.com/question/3887 | Weekly |
| LL signups by school | 4081 | https://maven.metabaseapp.com/question/4081 | Weekly |
| Lead magnet page content (all) | 15864 | https://maven.metabaseapp.com/question/15864 | Weekly |
| Lead magnets (recent, past year) | 15971 | https://maven.metabaseapp.com/question/15971 | Weekly |
| Course video transcripts | 10189 | https://maven.metabaseapp.com/question/10189 | Per-instructor (filter by school slug) |

## API access

- Metabase API token: see ~/.claude/CLAUDE.md
- Metabase base URL: https://maven.metabaseapp.com
- Query pattern: `POST /api/card/{id}/query/json` with header `x-api-key`
- Transcript query: `POST /api/dataset` with custom filter on school slug (field 13355)

## How to refresh data

```bash
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/6859/query/json" -X POST > data/lightning_lessons.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/15271/query/json" -X POST > data/course_syllabus.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/15970/query/json" -X POST > data/course_syllabus_5k.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/15965/query/json" -X POST > data/course_landing_pages.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/3887/query/json" -X POST > data/gmv_by_course.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/4081/query/json" -X POST > data/ll_signups_by_school.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/15864/query/json" -X POST > data/lead_magnets.json
curl -s -H "x-api-key: $MB_TOKEN" "https://maven.metabaseapp.com/api/card/15971/query/json" -X POST > data/lead_magnets_recent.json
```

## Key rules

- Only include Lightning Lessons from the past 6-12 months (AI moves fast)
- Prioritize instructors by GMV (earnings signal quality and demand)
- Include instructor bios and student counts for credibility
- NEVER include course earnings or GMV in the plan (student-facing content)
- Colin Matthews (School ID 3009, school slug "tech-for-product") is a top instructor -- feature him prominently for vibe coding / prototyping topics
- Pull real quotes from transcripts, not made-up ones
- Run /humanizer on every completed plan before finalizing
- Differentiate by role at the framing/use-case level, not at the resource level (same LLs, different "why this matters to you")

## Topics

| Topic | Anchor instructors | GMV signal |
|-------|-------------------|------------|
| Vibe Coding | Colin Matthews ($923K), Harold Dijkstra, Aman Khan, Shaw Talebi | $923K+ |
| Claude Code | James Gray, Aman Khan, Colin Matthews | Adjacent to vibe coding pool |
| AI Agents | Aishwarya Reganti ($2.2M), Mahesh Yadav ($1.7M), Amir Feizpour, Hamza Farooq | $7.8M total |
| AI Evals | Hamel Husain / parlance-labs ($6.2M), Bryan Bischof, Shreya Shankar | $6.2M (#2 course on Maven) |
| AI Product | Marily Nika ($3M), Product Faculty ($5.4M), Mahesh Yadav, Aman Khan | $5.4M+ |
| RAG & LLM Apps | Applied LLMs, Jason Liu (25K signups), Hamza Farooq | $810K |
| AI for Sales | Everett Berry (Clay), outbound automation instructors | Clay + GTM overlap |
| GTM Engineering | Everett Berry (Clay), Noah Adelstein, Patrick Spychalski | Clay is hot |
| AI Marketing | Elena Luneva, LinkedIn Accelerator ($321K) | $321K, 287 LLs |
| AI Analysis | Caitlin Sullivan (21K signups), Bryan Bischof, Kohavi ($402K) | $402K |
| AI Productivity | Superlinear ($421K), Hilary Gridley (11K signups) | $421K |
| AI x Leaders | Agentic AI for Leaders ($361K), Dave Kline ($549K) | $549K+ |
| Product Sense | Shreyas Doshi ($8M), Ben Erez, Pawel Huryn | $8M (#1 course on Maven) |
| Decision Making | Annie Duke ($358K), Shreyas Doshi, Kohavi | $358K+ |
| Management & Leadership | Dave Kline ($549K), Ethan Evans ($1.6M), Wes Kao ($1.4M), Hilary Gridley | $3M+ combined |
| Executive Influence | Ethan Evans (59K signups), Wes Kao, Dave Kline, Jess Goldberg | $3M combined |
| Personal Branding | LinkedIn Accelerator ($321K), Ethan Evans, Jess Goldberg | $321K |
| UX Design | Xinran Ma (17K signups), John Whalen, Vitaly Friedman, Caitlin Sullivan | $303K + $556K |
| AI Design | Xinran Ma, Rupa Chaturvedi, Junaid Dodhia | Generative AI for visual work |
| Figma & Design Systems | Baseline Design ($556K), Vitaly Friedman | $556K |
| Career Planning & Interviewing | Ben Erez (35K signups), Ethan Evans, Marily Nika | $396K + $1M |

## Roles

- Product Manager
- Marketer
- Designer
- Engineer
- Founder
- Executive/Leader

## Build list (44 plans)

### Vibe Coding
- [x] Vibe Coding x PM → plans/vibe-coding-product-manager.html
- [ ] Vibe Coding x Marketer
- [ ] Vibe Coding x Designer
- [ ] Vibe Coding x Founder
- [ ] Vibe Coding x Engineer

### Claude Code
- [ ] Claude Code x Engineer
- [ ] Claude Code x PM
- [ ] Claude Code x Founder

### AI Agents
- [ ] AI Agents x Engineer
- [ ] AI Agents x PM
- [ ] AI Agents x Executive

### AI Evals
- [ ] AI Evals x Engineer
- [ ] AI Evals x PM

### AI Product
- [ ] AI Product x PM
- [ ] AI Product x Engineer

### RAG & LLM Apps
- [ ] RAG & LLM Apps x Engineer

### AI for Sales
- [ ] AI for Sales x Marketer
- [ ] AI for Sales x Founder

### GTM Engineering
- [ ] GTM Engineering x Marketer
- [ ] GTM Engineering x Founder

### AI Marketing
- [ ] AI Marketing x Marketer
- [ ] AI Marketing x Founder

### AI Analysis
- [ ] AI Analysis x PM
- [ ] AI Analysis x Executive

### AI Productivity
- [ ] AI Productivity x PM
- [ ] AI Productivity x Marketer
- [ ] AI Productivity x Executive

### AI x Leaders
- [ ] AI x Leaders x Executive

### Product Sense
- [ ] Product Sense x PM
- [ ] Product Sense x Founder

### Decision Making
- [ ] Decision Making x Executive
- [ ] Decision Making x PM

### Management & Leadership
- [ ] Management & Leadership x Executive
- [ ] Management & Leadership x PM

### Executive Influence
- [ ] Executive Influence x Executive
- [ ] Executive Influence x Founder

### Personal Branding
- [ ] Personal Branding x Marketer
- [ ] Personal Branding x Founder
- [ ] Personal Branding x Executive

### UX Design
- [ ] UX Design x Designer

### AI Design
- [ ] AI Design x Designer

### Figma & Design Systems
- [ ] Figma & Design Systems x Designer

### Career Planning & Interviewing
- [ ] Career Planning & Interviewing x PM
- [ ] Career Planning & Interviewing x Engineer
- [ ] Career Planning & Interviewing x Designer
