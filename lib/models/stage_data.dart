class FocusOption {
  final String title;
  final String? subtitle;
  final List<String> suggestedGoals;

  const FocusOption({
    required this.title,
    this.subtitle,
    required this.suggestedGoals,
  });
}

class StageOption {
  final String title;
  final String question;
  final List<FocusOption> focusOptions;

  const StageOption({
    required this.title,
    required this.question,
    required this.focusOptions,
  });
}

class StageDataRepository {
  static const List<StageOption> stages = [
    StageOption(
      title: 'High School',
      question: 'Where are you leaning?',
      focusOptions: [
        FocusOption(
          title: 'University',
          suggestedGoals: [
            'Ace high school final exams',
            'Prepare college application essays',
            'Research top university programs',
            'Score high on standardized tests (SAT/ACT)',
            'Apply for academic scholarships',
          ],
        ),
        FocusOption(
          title: 'Start Working',
          suggestedGoals: [
            'Build a beginner-friendly resume',
            'Learn entry-level job skills',
            'Apply for part-time / entry-level positions',
            'Practice interview questions',
            'Build practical workplace confidence',
          ],
        ),
        FocusOption(
          title: 'Start a Business',
          suggestedGoals: [
            'Validate a business idea with 10 people',
            'Create a basic business plan',
            'Launch a simple social media page',
            'Make the first \$100 in revenue',
            'Learn digital marketing fundamentals',
          ],
        ),
        FocusOption(
          title: 'Learn a Skill',
          suggestedGoals: [
            'Complete an online course or bootcamp',
            'Dedicate 1 hour daily to practice',
            'Build 2 practical practice projects',
            'Get an industry certification',
            'Share project progress online',
          ],
        ),
        FocusOption(
          title: 'Still Figuring It Out',
          suggestedGoals: [
            'Explore 3 different career paths',
            'Talk to 2 professionals or mentors',
            'Take a career personality assessment',
            'Read 2 self-development books',
            'List out personal strengths and passions',
          ],
        ),
      ],
    ),
    StageOption(
      title: 'University Student',
      question: 'What are you working toward?',
      focusOptions: [
        FocusOption(
          title: 'Get a Job',
          suggestedGoals: [
            'Polish LinkedIn and build a standout resume',
            'Build 3 showcase portfolio projects',
            'Apply to 20 relevant job/internship openings',
            'Network with 5 industry professionals',
            'Prepare for technical and behavioral interviews',
          ],
        ),
        FocusOption(
          title: 'Higher Studies',
          suggestedGoals: [
            'Maintain a target GPA / academic record',
            'Shortlist 5 target graduate programs',
            'Prepare for GRE / GMAT / IELTS exams',
            'Reach out to potential research professors',
            'Draft Statement of Purpose (SOP)',
          ],
        ),
        FocusOption(
          title: 'Build a Startup',
          suggestedGoals: [
            'Develop a working MVP (Minimum Viable Product)',
            'Conduct 15 customer problem interviews',
            'Find a passionate co-founder or team',
            'Launch beta version to 50 active users',
            'Pitch to startup incubators / student grants',
          ],
        ),
        FocusOption(
          title: 'Research',
          suggestedGoals: [
            'Read 10 relevant peer-reviewed papers',
            'Collaborate on a research paper with faculty',
            'Submit findings to an academic journal/conference',
            'Master specialized research methodologies',
            'Present research poster at university symposium',
          ],
        ),
        FocusOption(
          title: 'Freelancing Thing',
          suggestedGoals: [
            'Set up profiles on Upwork / Fiverr / Contra',
            'Create a client-ready portfolio website',
            'Land first 3 paying clients',
            'Earn first \$500 freelancing',
            'Collect 5-star testimonials from clients',
          ],
        ),
        FocusOption(
          title: 'Still Exploring',
          suggestedGoals: [
            'Join 2 active university clubs/societies',
            'Experiment with 2 different tech/business skills',
            'Shadow a working professional for a day',
            'Attend 3 networking webinars or meetups',
            'Define top 3 interests for the next semester',
          ],
        ),
      ],
    ),
    StageOption(
      title: 'Just Graduated',
      question: 'What is your next plan?',
      focusOptions: [
        FocusOption(
          title: 'Find a Job',
          suggestedGoals: [
            'Tailor resume for targeted job roles',
            'Apply to 5 jobs daily with customized cover letters',
            'Practice mock interviews weekly',
            'Optimize LinkedIn profile for recruiters',
            'Secure a full-time offer within budget',
          ],
        ),
        FocusOption(
          title: 'Higher Studies',
          suggestedGoals: [
            'Finalize graduate school applications',
            'Secure 3 strong recommendation letters',
            'Apply for assistantships / funding',
            'Complete all application deadlines',
            'Prepare visa and relocation arrangements',
          ],
        ),
        FocusOption(
          title: 'Freelance',
          suggestedGoals: [
            'Define clear service packages and pricing',
            'Cold pitch 10 prospective businesses weekly',
            'Build a strong personal brand on LinkedIn/X',
            'Achieve consistent monthly recurring revenue',
            'Set up structured accounting and invoicing',
          ],
        ),
        FocusOption(
          title: 'Travel',
          suggestedGoals: [
            'Plan budget and itinerary for the trip',
            'Save target travel fund',
            'Document experiences and learnings',
            'Explore remote work opportunities while traveling',
            'Expand personal horizons and network abroad',
          ],
        ),
        FocusOption(
          title: 'Still Exploring',
          suggestedGoals: [
            'Take a 30-day skill sprint',
            'Do informational interviews with alumni',
            'Volunteer for a high-impact initiative',
            'Identify core non-negotiables for career',
            'Set a 90-day direction milestone',
          ],
        ),
      ],
    ),
    StageOption(
      title: 'Working',
      question: 'What is your next plan?',
      focusOptions: [
        FocusOption(
          title: 'Grow in My Career',
          suggestedGoals: [
            'Take on a high-visibility leadership project',
            'Earn an advanced professional certification',
            'Negotiate for a promotion / senior title',
            'Mentor a junior team member',
            'Present at an internal or external tech talk',
          ],
        ),
        FocusOption(
          title: 'Change Careers',
          suggestedGoals: [
            'Identify transferable skills for target industry',
            'Build 2 bridge projects showcasing new skillset',
            'Connect with 10 professionals in target field',
            'Complete targeted transition coursework',
            'Land first interview in the new domain',
          ],
        ),
        FocusOption(
          title: 'Higher Salary',
          suggestedGoals: [
            'Research market compensation benchmarks',
            'Document measurable ROI and achievements',
            'Prepare and conduct salary review meeting',
            'Apply to higher-paying market opportunities',
            'Develop high-leverage specialized skills',
          ],
        ),
        FocusOption(
          title: 'Start a Business',
          suggestedGoals: [
            'Build side-hustle revenue while working',
            'Validate customer demand for product/service',
            'Build an initial audience / waitlist',
            'Create runway savings for full-time transition',
            'Incorporate legal entity and launch',
          ],
        ),
        FocusOption(
          title: 'Work Abroad',
          suggestedGoals: [
            'Research work visa eligibility in target countries',
            'Apply to international / remote-first companies',
            'Get language certification if required',
            'Connect with expat professionals in target city',
            'Prepare global resume format',
          ],
        ),
        FocusOption(
          title: 'Better Work-Life Balance',
          suggestedGoals: [
            'Set strict work hours and boundary guidelines',
            'Establish a consistent morning / evening routine',
            'Automate and delegate repetitive tasks',
            'Dedicate dedicated time for fitness / mental health',
            'Take regular disconnected weekends',
          ],
        ),
      ],
    ),
    StageOption(
      title: 'Changing Careers',
      question: 'What are you working toward?',
      focusOptions: [
        FocusOption(
          title: 'Switch Industry',
          suggestedGoals: [
            'Map current experience to the new industry',
            'Conduct 5 informational coffee chats with insiders',
            'Complete foundational industry certification',
            'Revamp resume tailored for the new sector',
            'Attend relevant industry conferences/webinars',
          ],
        ),
        FocusOption(
          title: 'Learn New Skills',
          suggestedGoals: [
            'Enroll in a structured learning curriculum',
            'Spend 10 hours/week coding or practicing',
            'Build a portfolio of 3 real-world projects',
            'Get feedback from experienced mentors',
            'Master core tools and frameworks',
          ],
        ),
        FocusOption(
          title: 'Go Back to University',
          suggestedGoals: [
            'Research postgraduate / conversion degree programs',
            'Prepare application package and transcripts',
            'Calculate tuition, living expenses and funding',
            'Submit applications before priority deadlines',
            'Refresh prerequisite coursework',
          ],
        ),
        FocusOption(
          title: 'Start Freelancing',
          suggestedGoals: [
            'Package skills into clear freelance offerings',
            'Build a 1-page conversion-focused portfolio',
            'Acquire first 2 clients through direct outreach',
            'Set up efficient client onboarding systems',
            'Hit target monthly freelance revenue',
          ],
        ),
        FocusOption(
          title: 'Start a Business',
          suggestedGoals: [
            'Leverage previous domain knowledge for a startup',
            'Build prototype to solve a real industry pain point',
            'Acquire 5 pilot trial customers',
            'Refine product based on active feedback',
            'Achieve product-market fit metrics',
          ],
        ),
        FocusOption(
          title: 'Not Sure Yet',
          suggestedGoals: [
            'Take a structured career transition workshop',
            'Run 3 small 2-week mini-experiments',
            'Create a list of energizing vs draining tasks',
            'Consult with a certified career coach',
            'Choose a single direction by next month',
          ],
        ),
      ],
    ),
    StageOption(
      title: 'Building My Own Thing',
      question: 'What are you working toward?',
      focusOptions: [
        FocusOption(
          title: 'Startup',
          suggestedGoals: [
            'Build and deploy MVP in 30 days',
            'Get first 100 organic signups',
            'Implement analytics and user tracking',
            'Interview 20 active users for feedback',
            'Achieve 10% week-over-week user growth',
          ],
        ),
        FocusOption(
          title: 'Freelance',
          suggestedGoals: [
            'Define niche and high-ticket service offering',
            'Outreach to 15 qualified leads weekly',
            'Automate contract and payment collection',
            'Scale hourly or retainer rates by 30%',
            'Build a steady client referral pipeline',
          ],
        ),
        FocusOption(
          title: 'Small Business',
          suggestedGoals: [
            'Set up local/online storefront operations',
            'Establish reliable vendor & supplier channels',
            'Run localized marketing / advertising campaign',
            'Reach break-even monthly operating cashflow',
            'Implement customer loyalty program',
          ],
        ),
        FocusOption(
          title: 'Personal Brand',
          suggestedGoals: [
            'Publish 3 high-value content pieces weekly',
            'Grow newsletter to 500 engaged subscribers',
            'Collaborate with 3 creators in the niche',
            'Launch first digital product / guide',
            'Engage 30 minutes daily with target community',
          ],
        ),
        FocusOption(
          title: 'Creative Project',
          suggestedGoals: [
            'Complete initial draft / prototype / demo',
            'Gather critique from peer creators',
            'Host a public showcase or launch event',
            'Submit to film festivals / galleries / platforms',
            'Build a dedicated supporter community',
          ],
        ),
        FocusOption(
          title: 'Side Hustle',
          suggestedGoals: [
            'Dedicate 8 focused hours every weekend',
            'Launch product or service landing page',
            'Generate first \$250 in profit',
            'Systematize workflow for 100% time efficiency',
            'Scale revenue to cover a major monthly expense',
          ],
        ),
      ],
    ),
    StageOption(
      title: 'Entrepreneur',
      question: 'What are you working toward?',
      focusOptions: [
        FocusOption(
          title: 'Grow My Business',
          suggestedGoals: [
            'Increase quarterly revenue by 25%',
            'Optimize conversion funnel and retention rate',
            'Expand into 1 new marketing channel',
            'Reduce customer acquisition cost (CAC) by 15%',
            'Automate 3 core operational workflows',
          ],
        ),
        FocusOption(
          title: 'Find Investors',
          suggestedGoals: [
            'Finalize 10-slide pitch deck & financial model',
            'Build target investor pipeline of 30 angels/VCs',
            'Conduct 10 investor pitch meetings',
            'Secure term sheet for funding round',
            'Complete legal due diligence and close round',
          ],
        ),
        FocusOption(
          title: 'Build a Team',
          suggestedGoals: [
            'Write clear role scorecards and job descriptions',
            'Hire key lead engineer / growth marketer',
            'Establish company culture & onboarding playbook',
            'Set up weekly team OKR and sprint cadence',
            'Implement team performance review system',
          ],
        ),
        FocusOption(
          title: 'Launch a Product',
          suggestedGoals: [
            'Run successful Product Hunt / public launch',
            'Drive 1,000+ launch-day visitors',
            'Collect and prioritize post-launch bug fixes',
            'Convert 5% of trial users to paid plans',
            'Secure press/media coverage in niche publications',
          ],
        ),
        FocusOption(
          title: 'Start Something New',
          suggestedGoals: [
            'Brainstorm and evaluate 5 new market opportunities',
            'Run rapid smoke-test landing page validation',
            'Secure 50 pre-orders or letters of intent (LOI)',
            'Formulate go-to-market strategy',
            'Build minimal prototype for early adopters',
          ],
        ),
        FocusOption(
          title: 'Sell',
          suggestedGoals: [
            'Clean up accounting books and financial statements',
            'Calculate valuation based on EBITDA/revenue multiples',
            'List business on acquisition marketplace or with broker',
            'Negotiate letter of intent with prospective buyers',
            'Successfully transition operations and close deal',
          ],
        ),
      ],
    ),
  ];

  static StageOption? getStageByTitle(String title) {
    try {
      return stages.firstWhere((stage) => stage.title == title);
    } catch (_) {
      return null;
    }
  }
}
