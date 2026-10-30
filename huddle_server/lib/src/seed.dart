import 'package:serverpod/serverpod.dart';
import 'generated/protocol.dart';

class Seed {
  static Future<void> seedIfNeeded(Session session) async {
    final existingReelsCount = await Reel.db.count(session);
    if (existingReelsCount >= 8) return;

    session.log('Checking and seeding Huddle database with demo data...');

    // 1. Seed Reels with 3-question "Try it" Quizzes
    final reels = [
      Reel(
        title: 'SQL Joins in 45 Seconds',
        creatorName: 'Ayaan (Final Year)',
        subject: 'DBMS',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        durationSeconds: 45,
        suggestedSquadTopic: 'DBMS Revision',
        quizQuestions: [
          QuizQuestion(
            question:
                'Which JOIN keeps all unmatched rows from the left table?',
            options: ['INNER JOIN', 'LEFT JOIN', 'FULL JOIN', 'CROSS JOIN'],
            correctOptionIndex: 1,
            explanation:
                'LEFT JOIN preserves all rows from the left table regardless of a match.',
          ),
          QuizQuestion(
            question:
                'What is the result size of a CROSS JOIN between 4 and 5 rows?',
            options: ['9 rows', '20 rows', '1 row', 'Error'],
            correctOptionIndex: 1,
            explanation:
                'Cartesian product multiplies table sizes: 4 * 5 = 20 rows.',
          ),
          QuizQuestion(
            question:
                'Which clause filters aggregate functions like COUNT or AVG?',
            options: ['WHERE', 'HAVING', 'GROUP BY', 'ORDER BY'],
            correctOptionIndex: 1,
            explanation:
                'HAVING filters groups post-aggregation; WHERE filters pre-aggregation rows.',
          ),
        ],
      ),
      Reel(
        title: 'Binary Search Edge Cases',
        creatorName: 'Priya (Senior TA)',
        subject: 'DSA',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        durationSeconds: 50,
        suggestedSquadTopic: 'DSA Sprint',
        quizQuestions: [
          QuizQuestion(
            question:
                'Why write low + (high - low) / 2 instead of (low + high) / 2?',
            options: [
              'Faster bit shift',
              'Prevents integer overflow',
              'Compiler requirement',
              'Better cache locality',
            ],
            correctOptionIndex: 1,
            explanation:
                'Prevents 32-bit signed integer overflow when low + high > 2^31 - 1.',
          ),
          QuizQuestion(
            question:
                'What is the worst-case time complexity of Binary Search?',
            options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
            correctOptionIndex: 1,
            explanation:
                'Halving the search space each step yields logarithmic time O(log n).',
          ),
          QuizQuestion(
            question:
                'When the element is not found, what does the low pointer indicate?',
            options: [
              '-1',
              'Insertion point for the target',
              'End of array index',
              'Previous smaller element index',
            ],
            correctOptionIndex: 1,
            explanation:
                'When low > high, low points to the exact insertion index maintaining sorted order.',
          ),
        ],
      ),
      Reel(
        title: 'Virtual Memory & Page Faults',
        creatorName: 'Kabir S. (Dept Rank 1)',
        subject: 'Operating Systems',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        durationSeconds: 40,
        suggestedSquadTopic: 'OS & Systems Architecture',
        quizQuestions: [
          QuizQuestion(
            question:
                'Which hardware unit translates virtual to physical addresses?',
            options: ['ALU', 'MMU', 'Control Unit', 'BIOS'],
            correctOptionIndex: 1,
            explanation:
                'Memory Management Unit (MMU) performs hardware translation using page tables.',
          ),
          QuizQuestion(
            question: 'When is a page fault trap generated?',
            options: [
              'Divide by zero',
              'Referenced page is not in physical RAM',
              'Out of CPU cache',
              'Disk read failure',
            ],
            correctOptionIndex: 1,
            explanation:
                'A page fault occurs when the present bit in page table entry is 0.',
          ),
          QuizQuestion(
            question:
                'Which page replacement algorithm suffers from Belady\'s Anomaly?',
            options: ['LRU', 'FIFO', 'Optimal', 'LFU'],
            correctOptionIndex: 1,
            explanation:
                'FIFO can exhibit more page faults when allocated more page frames (Belady\'s Anomaly).',
          ),
        ],
      ),
      Reel(
        title: 'Dijkstra Shortest Path in 50s',
        creatorName: 'Rohan M. (LeetCode Knight)',
        subject: 'DSA',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyBlazes.mp4',
        durationSeconds: 50,
        suggestedSquadTopic: 'DSA Sprint',
        quizQuestions: [
          QuizQuestion(
            question:
                'What data structure optimizes Dijkstra to O((V + E) log V)?',
            options: [
              'Binary Min-Heap / Priority Queue',
              'Stack',
              'Linked List',
              'Hash Table',
            ],
            correctOptionIndex: 0,
            explanation:
                'A Min-Heap extracts the nearest unvisited node in O(log V) time.',
          ),
          QuizQuestion(
            question:
                'What condition causes Dijkstra to fail or give incorrect paths?',
            options: [
              'Cycle in graph',
              'Negative edge weights',
              'Dense graph',
              'Disconnected vertices',
            ],
            correctOptionIndex: 1,
            explanation:
                'Negative edges break Dijkstra greedy assumption. Use Bellman-Ford instead.',
          ),
          QuizQuestion(
            question:
                'In an unweighted graph, which algorithm finds the shortest path faster?',
            options: ['Dijkstra', 'Breadth-First Search (BFS)', 'DFS', 'A*'],
            correctOptionIndex: 1,
            explanation:
                'BFS finds shortest paths in O(V + E) for unweighted graphs without heap overhead.',
          ),
        ],
      ),
      Reel(
        title: 'Deadlock: The 4 Coffman Conditions',
        creatorName: 'Kabir S. (Dept Rank 1)',
        subject: 'Operating Systems',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
        durationSeconds: 38,
        suggestedSquadTopic: 'OS & Systems Architecture',
        quizQuestions: [
          QuizQuestion(
            question:
                'Which of the following is NOT one of the 4 Coffman conditions?',
            options: [
              'Mutual Exclusion',
              'Preemption Allowed',
              'Hold and Wait',
              'Circular Wait',
            ],
            correctOptionIndex: 1,
            explanation:
                'NO Preemption is required for deadlock; allowing preemption prevents it.',
          ),
          QuizQuestion(
            question:
                'How can circular wait be mathematically eliminated in OS?',
            options: [
              'Allow infinite threads',
              'Impose linear resource ordering',
              'Use spinlocks',
              'Disable interrupts',
            ],
            correctOptionIndex: 1,
            explanation:
                'Numbering resources and requiring monotonic request ordering breaks circular wait.',
          ),
          QuizQuestion(
            question:
                'Which algorithm is used for multi-instance deadlock avoidance?',
            options: [
              'Round Robin',
              'Banker\'s Algorithm',
              'QuickSelect',
              'Peterson\'s Algorithm',
            ],
            correctOptionIndex: 1,
            explanation:
                'Dijkstra\'s Banker\'s Algorithm tests resource requests for safe state transitions.',
          ),
        ],
      ),
      Reel(
        title: 'ACID Properties & Transactions',
        creatorName: 'Sneha K. (Database Lead)',
        subject: 'DBMS',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        durationSeconds: 42,
        suggestedSquadTopic: 'DBMS Revision',
        quizQuestions: [
          QuizQuestion(
            question:
                'Which ACID property guarantees all changes succeed or none do?',
            options: ['Atomicity', 'Consistency', 'Isolation', 'Durability'],
            correctOptionIndex: 0,
            explanation:
                'Atomicity is the all-or-nothing guarantee backed by commit and rollback.',
          ),
          QuizQuestion(
            question:
                'Which mechanism ensures Durability surviving sudden power loss?',
            options: [
              'RAM Caching',
              'Write-Ahead Logging (WAL)',
              'B-Tree Indexes',
              'Foreign Keys',
            ],
            correctOptionIndex: 1,
            explanation:
                'WAL writes log records to non-volatile disk before committing transactions.',
          ),
          QuizQuestion(
            question:
                'Reading uncommitted data from another transaction is known as?',
            options: [
              'Phantom Read',
              'Dirty Read',
              'Non-repeatable Read',
              'Deadlock',
            ],
            correctOptionIndex: 1,
            explanation:
                'A Dirty Read occurs when Transaction A reads modifications made by uncommitted B.',
          ),
        ],
      ),
      Reel(
        title: 'Attention Mechanism & Transformers',
        creatorName: 'Dr. Aris (AI Lab)',
        subject: 'AI / ML',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackSeeTheWorld.mp4',
        durationSeconds: 55,
        suggestedSquadTopic: 'AI & Machine Learning Crew',
        quizQuestions: [
          QuizQuestion(
            question:
                'What three vectors are calculated for tokens in Self-Attention?',
            options: [
              'Query, Key, Value',
              'Input, Hidden, Output',
              'Loss, Weight, Bias',
              'Source, Target, Mask',
            ],
            correctOptionIndex: 0,
            explanation:
                'Self-Attention computes Q (Query), K (Key), and V (Value) projections.',
          ),
          QuizQuestion(
            question:
                'Why are Positional Encodings required in Transformer architectures?',
            options: [
              'To normalize gradients',
              'Self-Attention is permutation-invariant',
              'To reduce memory footprint',
              'To replace activation functions',
            ],
            correctOptionIndex: 1,
            explanation:
                'Without positional encodings, transformers treat tokens as an unordered set.',
          ),
          QuizQuestion(
            question:
                'What is the computational complexity of standard self-attention over sequence length N?',
            options: ['O(1)', 'O(N)', 'O(N^2)', 'O(2^N)'],
            correctOptionIndex: 2,
            explanation:
                'Pairwise dot product of all N tokens with all N keys results in O(N^2) complexity.',
          ),
        ],
      ),
      Reel(
        title: 'TCP 3-Way Handshake in 40s',
        creatorName: 'Aisha R. (Network TA)',
        subject: 'Networks',
        videoUrl:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
        durationSeconds: 40,
        suggestedSquadTopic: 'Computer Networks Hub',
        quizQuestions: [
          QuizQuestion(
            question:
                'What is the exact sequence of flags in a TCP 3-way handshake?',
            options: [
              'SYN -> SYN-ACK -> ACK',
              'ACK -> SYN -> ACK',
              'SYN -> ACK -> DATA',
              'RST -> SYN -> FIN',
            ],
            correctOptionIndex: 0,
            explanation:
                'Client sends SYN, server responds SYN-ACK, and client acknowledges with ACK.',
          ),
          QuizQuestion(
            question:
                'Which TCP header flag is sent to gracefully initiate termination?',
            options: ['RST', 'FIN', 'URG', 'PSH'],
            correctOptionIndex: 1,
            explanation:
                'The FIN (Finish) flag requests graceful connection teardown.',
          ),
          QuizQuestion(
            question:
                'What key mechanism ensures in-order delivery and packet deduplication?',
            options: [
              'Sequence Numbers',
              'Port Numbers',
              'TTL Field',
              'Checksum only',
            ],
            correctOptionIndex: 0,
            explanation:
                'Sequence numbers allow TCP receiver to order packets and detect duplicates.',
          ),
        ],
      ),
    ];

    for (final reel in reels) {
      final exists = await Reel.db.findFirstRow(
        session,
        where: (t) => t.title.equals(reel.title),
      );
      if (exists == null) {
        await Reel.db.insertRow(session, reel);
      }
    }

    // 2. Seed Campus Events
    final events = [
      CampusEvent(
        title: 'Hack Night: Build with AI',
        organizer: 'ACM Club',
        venue: 'Auditorium L2',
        eventTime: DateTime.now().toUtc().add(
          const Duration(days: 1, hours: 4),
        ),
        description:
            'Build fullstack AI apps with Flutter & Serverpod. Pizza and prizes included!',
        tag: 'Hackathon',
      ),
      CampusEvent(
        title: 'DBMS End-Sem Review Session',
        organizer: 'CSI Student Chapter',
        venue: 'Lab 4B',
        eventTime: DateTime.now().toUtc().add(
          const Duration(days: 2, hours: 2),
        ),
        description:
            'Live problem-solving on Normalization, B+ Trees, and ACID transactions.',
        tag: 'Study Jam',
      ),
      CampusEvent(
        title: 'Placement AMA: Cracking FAANG',
        organizer: 'Placement Cell',
        venue: 'Seminar Hall A',
        eventTime: DateTime.now().toUtc().add(
          const Duration(days: 3, hours: 5),
        ),
        description:
            'Seniors reveal mock interview rubrics, resume teardowns, and preparation checklists.',
        tag: 'Career',
      ),
      CampusEvent(
        title: 'Cloud Native & Kubernetes Jam',
        organizer: 'DevOps Campus Guild',
        venue: 'Tech Park B3',
        eventTime: DateTime.now().toUtc().add(
          const Duration(days: 4, hours: 3),
        ),
        description:
            'Hands-on cluster spinning, container orchestration, and real-time metrics monitoring.',
        tag: 'Workshops',
      ),
      CampusEvent(
        title: 'Google Summer of Code Info AMA',
        organizer: 'Open Source Club',
        venue: 'Virtual Room 1',
        eventTime: DateTime.now().toUtc().add(
          const Duration(days: 5, hours: 6),
        ),
        description:
            'Past GSoC scholars share proposal drafting secrets, maintainer outreach tips, and project templates.',
        tag: 'Career',
      ),
    ];

    for (final event in events) {
      final exists = await CampusEvent.db.findFirstRow(
        session,
        where: (t) => t.title.equals(event.title),
      );
      if (exists == null) {
        await CampusEvent.db.insertRow(session, event);
      }
    }

    // 3. Seed Squads with Members
    final squadsToSeed = [
      Squad(
        name: 'DSA Sprint',
        topic: 'DSA Sprint',
        targetExam: 'Placements',
        timeSlot: 'Evenings (6-8 PM)',
        streak: 14,
        goal: '50 problems',
        currentGoalCount: 38,
        maxMembers: 6,
        timerStartedAt: null,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      Squad(
        name: 'DBMS Revision Crew',
        topic: 'DBMS Revision',
        targetExam: 'Midterms',
        timeSlot: '4:00 PM - 6:00 PM',
        streak: 7,
        goal: 'All SQL & Normal Forms',
        currentGoalCount: 18,
        maxMembers: 6,
        timerStartedAt: null,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      Squad(
        name: 'OS & Systems Architecture',
        topic: 'OS & Systems Architecture',
        targetExam: 'End-Sem',
        timeSlot: 'Late Night (9-11 PM)',
        streak: 9,
        goal: 'Lab Files & CPU Scheduling',
        currentGoalCount: 22,
        maxMembers: 8,
        timerStartedAt: null,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      Squad(
        name: 'Midnight Leetcode Grinders',
        topic: 'DSA Sprint',
        targetExam: 'Placements',
        timeSlot: 'Late Night (11 PM - 1 AM)',
        streak: 21,
        goal: 'Hard DP & Graph Theory',
        currentGoalCount: 45,
        maxMembers: 6,
        timerStartedAt: null,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      Squad(
        name: 'AI & Machine Learning Crew',
        topic: 'AI & Machine Learning Crew',
        targetExam: 'Research & Labs',
        timeSlot: 'Afternoon (2-4 PM)',
        streak: 6,
        goal: 'Transformer Architecture & Fine-tuning',
        currentGoalCount: 12,
        maxMembers: 6,
        timerStartedAt: null,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      Squad(
        name: 'GATE 2026 CS Rankers',
        topic: 'Engineering Core',
        targetExam: 'GATE 2026',
        timeSlot: 'Mornings (7-9 AM)',
        streak: 28,
        goal: 'PYQs & Discrete Math',
        currentGoalCount: 84,
        maxMembers: 8,
        timerStartedAt: null,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
    ];

    for (final squadData in squadsToSeed) {
      final existingSquad = await Squad.db.findFirstRow(
        session,
        where: (t) => t.name.equals(squadData.name),
      );
      if (existingSquad == null) {
        final insertedSquad = await Squad.db.insertRow(session, squadData);
        // Seed default active members
        await SquadMember.db.insertRow(
          session,
          SquadMember(
            squadId: insertedSquad.id!,
            userName: 'Ayaan',
            avatarUrl: null,
            isFocusing: true,
            karma: 4.9,
            joinedAt: DateTime.now().toUtc().subtract(const Duration(days: 8)),
          ),
        );
        await SquadMember.db.insertRow(
          session,
          SquadMember(
            squadId: insertedSquad.id!,
            userName: 'Priya',
            avatarUrl: null,
            isFocusing: true,
            karma: 4.8,
            joinedAt: DateTime.now().toUtc().subtract(const Duration(days: 5)),
          ),
        );
      }
    }

    session.log('Seeding completed successfully.');
  }
}
