import json
import csv
import random
import os

random.seed(42)

# --- Dimension Variations ---
STAGES_AND_DIRECTIONS = {
    "University Student": [
        ("Get a Job", ["Software Engineering", "Frontend Development", "Backend Development", "Data Analyst", "UI/UX Design", "Machine Learning Engineer", "Cybersecurity Analyst"]),
        ("Higher Studies", ["IELTS & GRE Prep", "Master's in Computer Science", "Research Fellowship Application", "Target GPA 3.8+"]),
        ("Build a Startup", ["Launch MVP on Campus", "Build SaaS Tool", "Apply to YC / Student Incubator"]),
        ("Freelance", ["Top Rated Freelancer on Upwork", "Build Client Portfolio", "Earn First $1k Freelancing"])
    ],
    "Just Graduated": [
        ("Find a Job", ["Entry Level Software Engineer", "Junior Product Manager", "Data Analyst", "QA Automation Engineer", "Digital Marketing Specialist"]),
        ("Higher Studies", ["Graduate School Applications", "Scholarship Hunt", "Statement of Purpose & Reference Letters"]),
        ("Freelance", ["Full-time Freelance Agency", "Content Creation & Personal Brand"])
    ],
    "High School": [
        ("University", ["Top Tier CS University Admissions", "SAT 1500+ / ACT 34+", "Scholarship Strategy"]),
        ("Learn a Skill", ["Full-Stack Web Basics", "Python for Data Analysis", "Mobile App Development"]),
        ("Start Working", ["Entry-level Internship", "Retail / Admin Experience", "Resume & Interview Readiness"])
    ],
    "Working": [
        ("Grow in My Career", ["Promotion to Senior Engineer", "Lead Cross-Functional Team", "Executive Presence & Tech Lead"]),
        ("Change Careers", ["Transition from Non-Tech to Tech", "Transition from QA to Dev", "Transition to Product Management"]),
        ("Higher Salary", ["Market Benchmark & Negotiation", "Target FAANG / Tier 1 Tech Offer"]),
        ("Better Work-Life Balance", ["Daily Routine Reset", "Deep Work Systems & Burnout Recovery"])
    ],
    "Changing Careers": [
        ("Switch Industry", ["Software Engineering Bootcamp to Job", "Product Management Transition", "Data Science Career Pivot"]),
        ("Learn New Skills", ["Machine Learning Fundamentals", "Cloud & DevOps (AWS/Docker)", "Modern Full-Stack Javascript/Python"])
    ],
    "Building My Own Thing": [
        ("Startup", ["B2B SaaS to First 10 Customers", "Mobile App with 10k Downloads", "AI Micro-SaaS Launch"]),
        ("Small Business", ["E-commerce Brand to $5k MRR", "Local Service Agency Launch"])
    ],
    "Entrepreneur": [
        ("Find Investors", ["Raise $250k Pre-Seed", "Create Investor Pitch Deck & Data Room"]),
        ("Grow My Business", ["Scale Revenue by 50%", "Hire First 3 Core Engineers", "Product Hunt Launch to #1 Product of Day"])
    ]
}

TIMELINES = ["1 Week", "1 Month", "3 Months", "6 Months"]

EXPERIENCE_LEVELS = [
    "Beginner (No prior background)",
    "Beginner (Basic theory / introductory coursework)",
    "Intermediate (Built 1-2 small projects / self-taught)",
    "Intermediate (1-2 years relevant experience)",
    "Advanced (3+ years experience, looking to level up)"
]

DIFFICULTIES = ["Easy", "Moderate", "Hard", "Intensive"]

ALL_DAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

DAYS_PATTERNS = [
    ["Mon", "Tue", "Wed", "Thu", "Fri"],
    ["Mon", "Wed", "Fri", "Sat"],
    ["Tue", "Thu", "Sat", "Sun"],
    ["Sat", "Sun"],
    ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
    ["Mon", "Wed", "Fri"],
]

PREVIOUS_GOALS_POOL = [
    "Completed introductory Python course",
    "Read clean code fundamentals",
    "Built simple portfolio website",
    "Passed college calculus and algebra",
    "Practiced basic LeetCode easy problems",
    "Interviewed 3 industry professionals",
    "Wrote initial product feature specification",
    "Maintained 3.5+ GPA in relevant subjects",
    "Set up basic GitHub account",
    "None"
]

def generate_pathway(goal, timeline, experience, difficulty, days):
    is_beginner = "Beginner" in experience
    is_advanced = "Advanced" in experience
    
    if timeline == "1 Week":
        return {
            "pathway_type": "Rapid Sprint & Habit Kickoff",
            "total_duration": "7 Days",
            "phases": [
                {
                    "phase_name": "Days 1 - 2: Setup & Foundations",
                    "timeline_range": "Days 1 - 2",
                    "focus": "Environment Setup & Baseline Audit",
                    "steps": [
                        f"Audit current knowledge gaps for {goal}",
                        "Set up development tools, accounts, and daily schedule",
                        "Complete 2 foundational learning modules"
                    ]
                },
                {
                    "phase_name": "Days 3 - 5: Focused Execution",
                    "timeline_range": "Days 3 - 5",
                    "focus": "Hands-on Sprint",
                    "steps": [
                        f"Build minimal working demo or core submission for {goal}",
                        "Practice 5 targeted core exercises",
                        "Review errors and optimize daily routine"
                    ]
                },
                {
                    "phase_name": "Days 6 - 7: Review & Finalization",
                    "timeline_range": "Days 6 - 7",
                    "focus": "Output & Retrospective",
                    "steps": [
                        "Complete end-to-end review and polish deliverable",
                        "Share project / progress with a peer or mentor for feedback",
                        "Lock in weekly habit system for continuous growth"
                    ]
                }
            ]
        }
    elif timeline == "1 Month":
        w1_focus = "Syntax & Foundations" if is_beginner else "Advanced System Architecture"
        return {
            "pathway_type": "30-Day Milestone Accelerator",
            "total_duration": "4 Weeks",
            "phases": [
                {
                    "phase_name": "Week 1: Core Fundamentals & Environment",
                    "timeline_range": "Week 1",
                    "focus": w1_focus,
                    "steps": [
                        f"Master foundational concepts and tools required for {goal}",
                        "Set up version control, linters, and structured note-taking system",
                        f"Dedicate {len(days)} days this week to deliberate practice"
                    ]
                },
                {
                    "phase_name": "Week 2: Practical Project Build",
                    "timeline_range": "Week 2",
                    "focus": "Hands-on Implementation",
                    "steps": [
                        f"Build an end-to-end practical project solving a real problem in {goal}",
                        "Implement best practices, modular code structure, and error handling",
                        "Write clear documentation and architectural overview"
                    ]
                },
                {
                    "phase_name": "Week 3: Polish & Portfolio Integration",
                    "timeline_range": "Week 3",
                    "focus": "Asset Polish & Review",
                    "steps": [
                        "Revamp resume and online profile to showcase new project and metrics",
                        "Practice 15 domain-specific interview / problem-solving questions",
                        "Conduct peer code review or get expert feedback"
                    ]
                },
                {
                    "phase_name": "Week 4: Outreach, Applications & Next Steps",
                    "timeline_range": "Week 4",
                    "focus": "Outcomes & Pipeline",
                    "steps": [
                        f"Apply to 20+ targeted opportunities or launch project in {goal}",
                        "Reach out to 10 professionals/mentors in the domain",
                        "Conduct mock interview / evaluate final milestone metrics"
                    ]
                }
            ]
        }
    elif timeline == "3 Months":
        return {
            "pathway_type": "Quarterly Transformation Roadmap",
            "total_duration": "12 Weeks",
            "phases": [
                {
                    "phase_name": "Phase 1: Deep Fundamentals & Tooling",
                    "timeline_range": "Weeks 1 - 3",
                    "focus": "Core Knowledge Acquisition",
                    "steps": [
                        f"Complete structured curriculum / readings on {goal}",
                        "Build 3 mini-exercises cementing foundational concepts",
                        "Establish active study/work rhythm across scheduled days"
                    ]
                },
                {
                    "phase_name": "Phase 2: Flagship Portfolio & Execution",
                    "timeline_range": "Weeks 4 - 7",
                    "focus": "Production-Grade Capstone Project",
                    "steps": [
                        f"Architect and develop a flagship capstone project for {goal}",
                        "Integrate full-stack features, third-party APIs, and automated tests",
                        "Deploy live version with comprehensive documentation and video demo"
                    ]
                },
                {
                    "phase_name": "Phase 3: Interview / Examination Mastery",
                    "timeline_range": "Weeks 8 - 10",
                    "focus": "Technical Screening & Problem Solving",
                    "steps": [
                        "Solve 50+ domain problem sets / case studies under timed conditions",
                        "Optimize LinkedIn, GitHub, and 1-page ATS-ready resume",
                        "Conduct 3 rigorous mock interviews with feedback notes"
                    ]
                },
                {
                    "phase_name": "Phase 4: Sourcing, Outreach & Offer Closing",
                    "timeline_range": "Weeks 11 - 12",
                    "focus": "Outcomes & Placement",
                    "steps": [
                        "Submit 50+ targeted applications with tailored cover notes",
                        "Network with 20 industry insiders for warm referrals",
                        "Negotiate offers / celebrate milestone achievement"
                    ]
                }
            ]
        }
    else: # 6 Months
        return {
            "pathway_type": "Comprehensive Mastery & Career Pivot",
            "total_duration": "24 Weeks",
            "phases": [
                {
                    "phase_name": "Phase 1: Immersion & Theory Foundations",
                    "timeline_range": "Months 1 - 2",
                    "focus": "Complete Deep Fundamentals",
                    "steps": [
                        f"Master theoretical concepts, math/science, and architecture of {goal}",
                        "Build 5 progressive practice projects with clean documentation",
                        "Engage with online communities and technical discussion groups"
                    ]
                },
                {
                    "phase_name": "Phase 2: Advanced Projects & Systems",
                    "timeline_range": "Months 3 - 4",
                    "focus": "Enterprise/Production Level Building",
                    "steps": [
                        f"Build 2 large-scale production projects showcasing {goal} mastery",
                        "Implement CI/CD, cloud deployments, and performance optimizations",
                        "Contribute to an open-source repository or publish a technical article"
                    ]
                },
                {
                    "phase_name": "Phase 3: Profile Optimization & Mock Sprints",
                    "timeline_range": "Month 5",
                    "focus": "Evaluation Readiness",
                    "steps": [
                        "Complete 100+ domain practice challenges under strict time constraints",
                        "Revamp brand portfolio, resume, and LinkedIn with quantifiable results",
                        "Execute 5 comprehensive mock technical and behavioral interviews"
                    ]
                },
                {
                    "phase_name": "Phase 4: Intensive Application & Final Breakthrough",
                    "timeline_range": "Month 6",
                    "focus": "Career Landing / Goal Completion",
                    "steps": [
                        "Submit 80+ strategic applications and leverage alumni/referral networks",
                        "Conduct interviews, onsite rounds, and case presentations",
                        "Finalize offers, career transition, or major milestone launch"
                    ]
                }
            ]
        }

def generate_dataset(num_samples=1000):
    dataset = []
    
    # 1. Ensure the user's specific test case is #1
    specific_case = {
        "id": "RIPPLE_0001",
        "user_stage": "University Student",
        "direction": "Get a Job",
        "goal": "Software Engineering",
        "timeline": "1 Month",
        "experience": "Beginner",
        "available_days": ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
        "difficulty": "Moderate",
        "previous_goals": ["Completed CS101", "Learned basic syntax"],
        "completed_goals": ["Completed CS101"],
        "chosen_pathway": generate_pathway("Software Engineering", "1 Month", "Beginner", "Moderate", ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"])
    }
    dataset.append(specific_case)
    
    # 2. Generate varied examples
    for i in range(2, num_samples + 1):
        stage = random.choice(list(STAGES_AND_DIRECTIONS.keys()))
        direction_tuple = random.choice(STAGES_AND_DIRECTIONS[stage])
        direction = direction_tuple[0]
        goal = random.choice(direction_tuple[1])
        timeline = random.choice(TIMELINES)
        experience = random.choice(EXPERIENCE_LEVELS)
        difficulty = random.choice(DIFFICULTIES)
        days = random.choice(DAYS_PATTERNS)
        
        # Sample previous / completed goals
        num_prev = random.randint(0, 3)
        if num_prev > 0:
            prev_goals = random.sample(PREVIOUS_GOALS_POOL, num_prev)
            if "None" in prev_goals:
                prev_goals = []
                comp_goals = []
            else:
                comp_goals = random.sample(prev_goals, random.randint(0, len(prev_goals)))
        else:
            prev_goals = []
            comp_goals = []
            
        pathway = generate_pathway(goal, timeline, experience, difficulty, days)
        
        sample = {
            "id": f"RIPPLE_{i:04d}",
            "user_stage": stage,
            "direction": direction,
            "goal": goal,
            "timeline": timeline,
            "experience": experience,
            "available_days": days,
            "difficulty": difficulty,
            "previous_goals": prev_goals,
            "completed_goals": comp_goals,
            "chosen_pathway": pathway
        }
        dataset.append(sample)
        
    return dataset

if __name__ == "__main__":
    data_dir = "data"
    os.makedirs(data_dir, exist_ok=True)
    
    dataset = generate_dataset(1000)
    
    # Save as JSON
    json_path = os.path.join(data_dir, "ripple_synthetic_dataset_1000.json")
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(dataset, f, indent=2)
    print(f"Saved {len(dataset)} examples to {json_path}")
    
    # Save as JSONL
    jsonl_path = os.path.join(data_dir, "ripple_synthetic_dataset_1000.jsonl")
    with open(jsonl_path, "w", encoding="utf-8") as f:
        for item in dataset:
            f.write(json.dumps(item) + "\n")
    print(f"Saved {len(dataset)} examples to {jsonl_path}")
    
    # Save as CSV (flattened for tabular / tree ML models)
    csv_path = os.path.join(data_dir, "ripple_synthetic_dataset_1000.csv")
    with open(csv_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f)
        writer.writerow([
            "id", "user_stage", "direction", "goal", "timeline", "experience",
            "available_days", "difficulty", "previous_goals_count", "completed_goals_count",
            "pathway_type", "total_duration", "num_phases", "total_steps"
        ])
        for d in dataset:
            p = d["chosen_pathway"]
            total_steps = sum(len(phase["steps"]) for phase in p["phases"])
            writer.writerow([
                d["id"], d["user_stage"], d["direction"], d["goal"], d["timeline"], d["experience"],
                ";".join(d["available_days"]), d["difficulty"], len(d["previous_goals"]), len(d["completed_goals"]),
                p["pathway_type"], p["total_duration"], len(p["phases"]), total_steps
            ])
    print(f"Saved tabular CSV summary to {csv_path}")
