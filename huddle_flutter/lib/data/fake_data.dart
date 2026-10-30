import 'package:huddle_client/huddle_client.dart';

class FakeData {
  static final List<Reel> reels = [
    Reel(
      id: 1,
      title: 'Dijkstra shortest path in 45s',
      creatorName: 'Ayaan · Final Year',
      subject: 'DSA',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      durationSeconds: 45,
      suggestedSquadTopic: 'LeetCode Sprint',
      quizQuestions: [
        QuizQuestion(
          question: 'What data structure gives Dijkstra O((V + E) log V)?',
          options: [
            'Min-Heap / Priority Queue',
            'FIFO Stack',
            'Adjacency Matrix',
            'Linked List',
          ],
          correctOptionIndex: 0,
          explanation:
              'Binary Min-Heap extracts the closest unvisited node in log V time.',
        ),
        QuizQuestion(
          question: 'When does Dijkstra algorithm break completely?',
          options: [
            'Dense graph',
            'Negative edge weights',
            'Cycles with positive weights',
            'Undirected paths',
          ],
          correctOptionIndex: 1,
          explanation:
              'Negative edges violate greedy assumptions. Run Bellman-Ford instead.',
        ),
        QuizQuestion(
          question: 'What is faster than Dijkstra for unweighted graphs?',
          options: [
            'Depth First Search',
            'Breadth First Search',
            'Floyd-Warshall',
            'Kruskal Algorithm',
          ],
          correctOptionIndex: 1,
          explanation:
              'BFS discovers shortest paths in O(V + E) without heap overhead.',
        ),
      ],
    ),
    Reel(
      id: 2,
      title: 'Deadlock: the 4 conditions',
      creatorName: 'Kabir · Systems TA',
      subject: 'Operating Systems',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      durationSeconds: 40,
      suggestedSquadTopic: 'OS Deep Work',
      quizQuestions: [
        QuizQuestion(
          question: 'Which is NOT one of the 4 Coffman conditions?',
          options: [
            'Mutual Exclusion',
            'Preemption Allowed',
            'Hold and Wait',
            'Circular Wait',
          ],
          correctOptionIndex: 1,
          explanation:
              'NO Preemption is required for deadlock; preemption prevents it.',
        ),
        QuizQuestion(
          question: 'How do you mathematically eliminate circular wait?',
          options: [
            'Linear resource ordering',
            'Infinite mutex locks',
            'Spinlock polling',
            'Thread sleeping',
          ],
          correctOptionIndex: 0,
          explanation:
              'Requesting resources in strict ascending order breaks cycles.',
        ),
        QuizQuestion(
          question:
              'What algorithm performs multi-resource deadlock avoidance?',
          options: [
            'Round Robin',
            'Banker Algorithm',
            'QuickSelect',
            'LRU Eviction',
          ],
          correctOptionIndex: 1,
          explanation:
              'Dijkstra Banker Algorithm ensures the system stays in a safe state.',
        ),
      ],
    ),
    Reel(
      id: 3,
      title: 'SQL joins without the confusion',
      creatorName: 'Sneha · Database Lead',
      subject: 'DBMS',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      durationSeconds: 50,
      suggestedSquadTopic: 'Midterm Prep',
      quizQuestions: [
        QuizQuestion(
          question: 'Which join keeps all rows from the left table?',
          options: [
            'LEFT JOIN',
            'INNER JOIN',
            'CROSS JOIN',
            'RIGHT JOIN',
          ],
          correctOptionIndex: 0,
          explanation:
              'LEFT JOIN preserves left rows with nulls for missing right matches.',
        ),
        QuizQuestion(
          question:
              'What is the output row count of CROSS JOIN between 4 and 6 rows?',
          options: ['10', '24', '4', '0'],
          correctOptionIndex: 1,
          explanation: 'Cartesian product multiplies table sizes: 4 * 6 = 24.',
        ),
        QuizQuestion(
          question: 'Which clause filters aggregated group results?',
          options: ['HAVING', 'WHERE', 'LIMIT', 'OFFSET'],
          correctOptionIndex: 0,
          explanation:
              'HAVING filters post-aggregation groups; WHERE filters raw rows.',
        ),
      ],
    ),
    Reel(
      id: 4,
      title: 'Attention mechanism in 55s',
      creatorName: 'Aris · AI Lab',
      subject: 'ML Lab',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyBlazes.mp4',
      durationSeconds: 55,
      suggestedSquadTopic: 'Transformer Lab',
      quizQuestions: [
        QuizQuestion(
          question:
              'What three vectors are calculated for each token in self-attention?',
          options: [
            'Query, Key, Value',
            'Hidden, Cell, State',
            'Weight, Bias, Loss',
            'Input, Filter, Stride',
          ],
          correctOptionIndex: 0,
          explanation:
              'Self-attention calculates Q (Query), K (Key), and V (Value) projections.',
        ),
        QuizQuestion(
          question: 'Why do Transformers need positional encodings?',
          options: [
            'Self-attention has no innate sense of word order',
            'To prevent vanishing gradients',
            'To reduce matrix size',
            'Required by softmax',
          ],
          correctOptionIndex: 0,
          explanation:
              'Self-attention is permutation-invariant without positional vectors.',
        ),
        QuizQuestion(
          question:
              'What is the standard time complexity over sequence length N?',
          options: ['O(N^2)', 'O(N)', 'O(log N)', 'O(1)'],
          correctOptionIndex: 0,
          explanation:
              'Pairwise dot-product between every query and every key scales as O(N^2).',
        ),
      ],
    ),
    Reel(
      id: 5,
      title: 'LRU Cache: Doubly Linked List in 50s',
      creatorName: 'Rohan · FAANG Intern',
      subject: 'DSA',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      durationSeconds: 50,
      suggestedSquadTopic: 'LeetCode Sprint',
      quizQuestions: [
        QuizQuestion(
          question: 'Why pair a HashMap with Doubly Linked List for LRU Cache?',
          options: [
            'O(1) lookup, O(1) removal, and O(1) insertion at head',
            'Saves memory compared to arrays',
            'Sorts keys alphabetically automatically',
            'Prevents hash collisions in all scenarios',
          ],
          correctOptionIndex: 0,
          explanation:
              'HashMap gives O(1) key access; DLL allows O(1) node detachment and head placement.',
        ),
        QuizQuestion(
          question: 'When cache reaches capacity, which node is evicted?',
          options: [
            'Tail node (Least Recently Used)',
            'Head node (Most Recently Used)',
            'Middle node',
            'Random node',
          ],
          correctOptionIndex: 0,
          explanation:
              'The tail node has not been accessed for the longest time and gets pruned.',
        ),
        QuizQuestion(
          question: 'What is the time complexity of get(key) in optimal LRU?',
          options: ['O(1)', 'O(log N)', 'O(N)', 'O(N log N)'],
          correctOptionIndex: 0,
          explanation:
              'Constant time: hash map lookup followed by pointer reassignment.',
        ),
      ],
    ),
    Reel(
      id: 6,
      title: 'B+ Trees vs Hash Index in DBMS',
      creatorName: 'Sneha · Database Lead',
      subject: 'DBMS',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      durationSeconds: 48,
      suggestedSquadTopic: 'DBMS Revision',
      quizQuestions: [
        QuizQuestion(
          question: 'Why do relational databases prefer B+ Trees over Hash indexes?',
          options: [
            'B+ Trees efficiently support range queries (<, >, BETWEEN)',
            'Hash indexes use more disk space',
            'B+ Trees have O(1) lookups',
            'Hash tables cannot handle integers',
          ],
          correctOptionIndex: 0,
          explanation:
              'Linked leaf nodes in B+ Trees enable sequential scanning for range queries.',
        ),
        QuizQuestion(
          question: 'Where are the actual record pointers stored in a B+ Tree?',
          options: [
            'Exclusively in leaf nodes',
            'In the root node only',
            'Evenly across internal nodes',
            'In external bitmap files',
          ],
          correctOptionIndex: 0,
          explanation:
              'Internal nodes only store routing keys; leaf nodes hold data pointers.',
        ),
        QuizQuestion(
          question: 'What is the primary advantage of high fan-out in B+ Trees?',
          options: [
            'Low tree height minimizing disk I/O seek operations',
            'Faster string concatenation',
            'Eliminates lock contention',
            'Automatic compression of tuples',
          ],
          correctOptionIndex: 0,
          explanation:
              'A fan-out of 100+ keeps depth at 3-4 levels for billions of records.',
        ),
      ],
    ),
    Reel(
      id: 7,
      title: 'Virtual Memory & TLB Misses in 45s',
      creatorName: 'Kabir · Systems TA',
      subject: 'OS Systems',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      durationSeconds: 45,
      suggestedSquadTopic: 'OS Deep Work',
      quizQuestions: [
        QuizQuestion(
          question: 'What is the Translation Lookaside Buffer (TLB)?',
          options: [
            'A high-speed hardware cache for virtual-to-physical address translations',
            'A kernel log buffer for disk failures',
            'A software queue for CPU threads',
            'A network packet cache',
          ],
          correctOptionIndex: 0,
          explanation:
              'TLB caches recent page table lookups directly inside the CPU memory management unit.',
        ),
        QuizQuestion(
          question: 'What happens when a CPU experiences a Page Fault?',
          options: [
            'OS traps to kernel mode to fetch missing page from swap space into RAM',
            'Process is terminated immediately with SIGKILL',
            'Memory is completely cleared',
            'CPU frequency is lowered',
          ],
          correctOptionIndex: 0,
          explanation:
              'Hardware generates an interrupt; OS handles disk I/O and updates page tables.',
        ),
        QuizQuestion(
          question: 'Which page replacement policy is immune to Belady Anomaly?',
          options: [
            'LRU (Least Recently Used)',
            'FIFO (First In First Out)',
            'Random Eviction',
            'Second Chance FIFO',
          ],
          correctOptionIndex: 0,
          explanation:
              'Stack algorithms like LRU satisfy inclusion property, preventing Belady anomaly.',
        ),
      ],
    ),
    Reel(
      id: 8,
      title: 'Momentum vs Adam Optimizer in ML',
      creatorName: 'Aris · AI Lab',
      subject: 'ML Lab',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyBlazes.mp4',
      durationSeconds: 52,
      suggestedSquadTopic: 'Transformer Lab',
      quizQuestions: [
        QuizQuestion(
          question: 'What does the Adam optimizer combine?',
          options: [
            'Momentum (first moment) and RMSprop (second raw moment)',
            'SGD and Simulated Annealing',
            'Genetic Algorithms and Backprop',
            'Linear Regression and K-Means',
          ],
          correctOptionIndex: 0,
          explanation:
              'Adam maintains exponentially decaying averages of past gradients and squared gradients.',
        ),
        QuizQuestion(
          question: 'What is the purpose of momentum in gradient descent?',
          options: [
            'Accelerates along persistent directions and dampens oscillations',
            'Guarantees finding global minimum in non-convex loss',
            'Multiplies learning rate by batch size',
            'Prevents overfitting on training set',
          ],
          correctOptionIndex: 0,
          explanation:
              'Momentum adds a fraction of past update vector, smoothing ravines and saddle points.',
        ),
        QuizQuestion(
          question: 'Why is an epsilon term (e.g. 1e-8) added in Adam denominator?',
          options: [
            'Numerical stability to prevent division by zero',
            'To set the minimum gradient threshold',
            'To induce weight sparsity',
            'To speed up GPU tensor cores',
          ],
          correctOptionIndex: 0,
          explanation:
              'Adding small epsilon ensures denominator never evaluates to zero when variance is near null.',
        ),
      ],
    ),
    Reel(
      id: 9,
      title: 'CAP Theorem & Consistent Hashing in 55s',
      creatorName: 'Aisha · Systems TA',
      subject: 'Interview',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      durationSeconds: 55,
      suggestedSquadTopic: 'FAANG System Design',
      quizQuestions: [
        QuizQuestion(
          question: 'According to CAP theorem, what trade-off must you make during network partition?',
          options: [
            'Choose between Consistency (CP) or Availability (AP)',
            'Choose between Speed or Security',
            'Choose between SQL or NoSQL',
            'Choose between CPU or RAM',
          ],
          correctOptionIndex: 0,
          explanation:
              'Network partitions (P) are unavoidable; systems must sacrifice C or A.',
        ),
        QuizQuestion(
          question: 'How does Consistent Hashing minimize key redistribution when adding a node?',
          options: [
            'Only keys assigned to adjacent range on the ring migrate: O(K/N)',
            'All keys are rehashed with modulo arithmetic',
            'Keys are duplicated to all nodes',
            'Random routing transfers half the database',
          ],
          correctOptionIndex: 0,
          explanation:
              'On average only K/N keys are moved when node count changes from N to N+1.',
        ),
        QuizQuestion(
          question: 'What solves hot spots in consistent hashing rings?',
          options: [
            'Virtual nodes (multiple points on ring per physical server)',
            'Larger primary key integers',
            'Single master database replica',
            'Blocking client requests',
          ],
          correctOptionIndex: 0,
          explanation:
              'Virtual nodes ensure uniform distribution across heterogeneous servers.',
        ),
      ],
    ),
    Reel(
      id: 10,
      title: 'Backtracking: N-Queens & Pruning in 48s',
      creatorName: 'Dev Patel · Competitive Programmer',
      subject: 'DSA',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      durationSeconds: 48,
      suggestedSquadTopic: 'LeetCode Sprint',
      quizQuestions: [
        QuizQuestion(
          question: 'How do you check diagonal queen conflicts in O(1)?',
          options: [
            'Hash sets storing (row - col) and (row + col)',
            'Scanning full 2D matrix',
            'Iterative breadth-first search',
            'Binary search on row indices',
          ],
          correctOptionIndex: 0,
          explanation:
              'Major and minor diagonals have constant row-col and row+col invariants.',
        ),
        QuizQuestion(
          question: 'What distinguishes Backtracking from Brute Force?',
          options: [
            'Backtracking prunes partial candidates as soon as constraints fail',
            'Backtracking uses parallel threads',
            'Brute force uses dynamic programming tables',
            'Backtracking is always linear time',
          ],
          correctOptionIndex: 0,
          explanation:
              'Pruning invalid sub-trees drastically cuts search space from O(N^N) to manageable depth.',
        ),
        QuizQuestion(
          question: 'What is the base case in standard N-Queens recursion?',
          options: [
            'Row index equals N (all N queens placed legally)',
            'Row index equals 0',
            'Column set is empty',
            'Matrix is filled with ones',
          ],
          correctOptionIndex: 0,
          explanation:
              'Reaching row N without conflicts confirms a valid board solution.',
        ),
      ],
    ),
    Reel(
      id: 11,
      title: 'ACID Properties & Two-Phase Commit (2PC)',
      creatorName: 'Priya · Stats & Data Lead',
      subject: 'DBMS',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      durationSeconds: 50,
      suggestedSquadTopic: 'DBMS Revision',
      quizQuestions: [
        QuizQuestion(
          question: 'Which SQL transaction isolation level prevents phantom reads?',
          options: [
            'SERIALIZABLE',
            'READ COMMITTED',
            'REPEATABLE READ',
            'READ UNCOMMITTED',
          ],
          correctOptionIndex: 0,
          explanation:
              'SERIALIZABLE employs range locks or predicate locks to prevent phantom insertions.',
        ),
        QuizQuestion(
          question: 'What are the two sequential phases of Two-Phase Commit?',
          options: [
            'Prepare (Vote) Phase and Commit/Abort Phase',
            'Lock Phase and Unlock Phase',
            'Read Phase and Write Phase',
            'Map Phase and Reduce Phase',
          ],
          correctOptionIndex: 0,
          explanation:
              'Coordinator asks nodes if ready; if all agree, commit message is broadcasted.',
        ),
        QuizQuestion(
          question: 'What is the primary drawback of Two-Phase Commit?',
          options: [
            'It is a blocking protocol if the coordinator crashes during commit',
            'High memory overhead on client',
            'Cannot work with relational databases',
            'Requires manual SQL execution',
          ],
          correctOptionIndex: 0,
          explanation:
              'Participants holding locks remain blocked waiting for coordinator recovery.',
        ),
      ],
    ),
    Reel(
      id: 12,
      title: 'STAR Method for Behavioral Tech Interviews',
      creatorName: 'Ananya · Placement Lead',
      subject: 'Interview',
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyBlazes.mp4',
      durationSeconds: 42,
      suggestedSquadTopic: 'FAANG System Design',
      quizQuestions: [
        QuizQuestion(
          question: 'What does the acronym STAR stand for?',
          options: [
            'Situation, Task, Action, Result',
            'System, Tech, Architecture, Reliability',
            'Strategy, Timeline, Assessment, Review',
            'Scope, Team, Analysis, Report',
          ],
          correctOptionIndex: 0,
          explanation:
              'STAR structures behavioral answers cleanly without rambling.',
        ),
        QuizQuestion(
          question: 'Which component of STAR should take ~60% of your interview speaking time?',
          options: [
            'Action: What YOU individually engineered and executed',
            'Situation: Context and company history',
            'Task: What managers told you to do',
            'Result: General statistics',
          ],
          correctOptionIndex: 0,
          explanation:
              'Interviewers want to evaluate your specific individual decisions and contributions.',
        ),
        QuizQuestion(
          question: 'What elevates a good Result into an exceptional engineering story?',
          options: [
            'Quantifiable business metrics and reflections on lessons learned',
            'Lengthy descriptions of meetings attended',
            'Claiming the entire project was built in one day',
            'Avoiding discussing bugs or obstacles',
          ],
          correctOptionIndex: 0,
          explanation:
              'Numbers (e.g. reduced p99 latency by 35%) paired with growth reflections show engineering maturity.',
        ),
      ],
    ),
  ];

  static final List<CampusEvent> events = [
    CampusEvent(
      id: 1,
      title: 'Hack Night: Build with AI',
      organizer: 'ACM Student Crew',
      venue: 'Auditorium L2',
      eventTime: DateTime.now().add(const Duration(hours: 3)),
      description:
          'Build fullstack apps with Flutter. Pizza, stickers, and swag for everyone.',
      tag: 'HACKATHON',
    ),
    CampusEvent(
      id: 2,
      title: 'DBMS End-Sem Review',
      organizer: 'Senior TAs',
      venue: 'Lab 4B · Tech Wing',
      eventTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      description:
          'Live problem-solving on Normalization, B+ Trees, and ACID transactions.',
      tag: 'STUDY JAM',
    ),
    CampusEvent(
      id: 3,
      title: 'Cracking FAANG Interviews',
      organizer: 'Campus Alumni Guild',
      venue: 'Seminar Hall A',
      eventTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      description:
          'Seniors review mock interview rubrics, resume teardowns, and preparation plans.',
      tag: 'CAREER',
    ),
    CampusEvent(
      id: 4,
      title: 'System Design Marathon: Sharding & Caching',
      organizer: 'Distributed Systems Club',
      venue: 'Auditorium L1 · CS Wing',
      eventTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
      description:
          'Architect high-scale messaging backends with Redis, Kafka, and PostgreSQL sharding. Live whiteboard battles.',
      tag: 'SYSTEM DESIGN',
    ),
    CampusEvent(
      id: 5,
      title: 'ML Hackday: Fine-Tuning Open Source LLMs',
      organizer: 'Campus AI Collective',
      venue: 'Innovation Hub B3',
      eventTime: DateTime.now().add(const Duration(days: 4, hours: 5)),
      description:
          'Hands-on LoRA and QLoRA fine-tuning on consumer GPUs. Free compute credits and dinner vouchers provided.',
      tag: 'AI HACKDAY',
    ),
    CampusEvent(
      id: 6,
      title: 'Mock Technical Coding Interviews',
      organizer: 'Placement Cell & Alumni',
      venue: 'Career Centre Rooms 1-4',
      eventTime: DateTime.now().add(const Duration(days: 5, hours: 2)),
      description:
          '1-on-1 45-minute live coding interviews with alumni from Google, Microsoft, and Uber. Instant rubric feedback.',
      tag: 'MOCK INTERVIEW',
    ),
    CampusEvent(
      id: 7,
      title: 'Linux Kernel Bug Bash & Concurrency',
      organizer: 'Kernel & Open Source Guild',
      venue: 'Hardware Lab 2',
      eventTime: DateTime.now().add(const Duration(days: 6, hours: 3)),
      description:
          'Trace memory leaks, deadlock reproduction with eBPF, and submit upstream patches to open source repositories.',
      tag: 'OPEN SOURCE',
    ),
    CampusEvent(
      id: 8,
      title: 'Midnight LeetCode Hard Sprint',
      organizer: 'Algorithm Knights Squad',
      venue: 'North Library 24/7 Lounge',
      eventTime: DateTime.now().add(const Duration(days: 7, hours: 6)),
      description:
          'Solve 4 Hard DP & Tree problems under a 100-minute constraint. Energy drinks, ramen, and collaborative debrief.',
      tag: 'CODING SPRINT',
    ),
  ];

  static final List<SquadSuggestion> squadSuggestions = [
    SquadSuggestion(
      squad: Squad(
        id: 1,
        name: 'LeetCode Sprint',
        topic: 'DSA Sprint',
        targetExam: 'Placements',
        timeSlot: '6:00 - 8:00 PM',
        streak: 14,
        goal: '50 problems',
        currentGoalCount: 38,
        maxMembers: 6,
        timerDurationSeconds: 1500,
        isFocusing: true,
      ),
      matchScore: 98,
      matchReason: 'Both prep for Placements · Active now',
      memberCount: 3,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 2,
        name: 'DBMS Revision Crew',
        topic: 'DBMS Revision',
        targetExam: 'Midterms',
        timeSlot: '4:00 - 6:00 PM',
        streak: 7,
        goal: 'All SQL & Normal Forms',
        currentGoalCount: 18,
        maxMembers: 6,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      matchScore: 92,
      matchReason: 'Midterm focus · 7-day streak',
      memberCount: 4,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 3,
        name: 'OS Deep Work',
        topic: 'Operating Systems',
        targetExam: 'End-Sem',
        timeSlot: '9:00 - 11:00 PM',
        streak: 9,
        goal: 'Lab Files & CPU Scheduling',
        currentGoalCount: 22,
        maxMembers: 8,
        timerDurationSeconds: 1500,
        isFocusing: true,
      ),
      matchScore: 88,
      matchReason: 'Late night lock-in · 9d streak',
      memberCount: 5,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 4,
        name: 'Transformer & Diffusion Lab',
        topic: 'ML Lab',
        targetExam: 'Research Prep',
        timeSlot: '5:00 - 7:00 PM',
        streak: 11,
        goal: 'Attention Paper Implementations',
        currentGoalCount: 38,
        maxMembers: 6,
        timerDurationSeconds: 1500,
        isFocusing: true,
      ),
      matchScore: 95,
      matchReason: 'Active AI research · PyTorch code review',
      memberCount: 4,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 5,
        name: 'Concurrency & Kernel Hackers',
        topic: 'OS Systems',
        targetExam: 'End-Sem',
        timeSlot: '8:00 - 10:00 PM',
        streak: 16,
        goal: 'xv6 OS Project Submissions',
        currentGoalCount: 28,
        maxMembers: 6,
        timerDurationSeconds: 1500,
        isFocusing: true,
      ),
      matchScore: 91,
      matchReason: 'Kernel locks & semaphore experts',
      memberCount: 5,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 6,
        name: 'FAANG System Design Sprint',
        topic: 'Interview',
        targetExam: 'Placements',
        timeSlot: '7:00 - 9:00 PM',
        streak: 21,
        goal: '20 Architecture Blueprints',
        currentGoalCount: 17,
        maxMembers: 6,
        timerDurationSeconds: 1500,
        isFocusing: false,
      ),
      matchScore: 96,
      matchReason: 'Top 1% placement prep · Mock interviews',
      memberCount: 5,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 7,
        name: 'Distributed Database Lab',
        topic: 'DBMS',
        targetExam: 'Midterms',
        timeSlot: '3:00 - 5:00 PM',
        streak: 8,
        goal: 'ACID & Index Optimization Sets',
        currentGoalCount: 42,
        maxMembers: 6,
        timerDurationSeconds: 1500,
        isFocusing: true,
      ),
      matchScore: 89,
      matchReason: 'Indexing & Sharding practice crew',
      memberCount: 4,
    ),
    SquadSuggestion(
      squad: Squad(
        id: 8,
        name: 'Graph Algorithms & DP Grind',
        topic: 'DSA',
        targetExam: 'Placements',
        timeSlot: '9:30 - 11:30 PM',
        streak: 19,
        goal: '100 LeetCode Medium/Hard',
        currentGoalCount: 74,
        maxMembers: 8,
        timerDurationSeconds: 1500,
        isFocusing: true,
      ),
      matchScore: 97,
      matchReason: 'Hard problem solvers · High karma squad',
      memberCount: 6,
    ),
  ];

  static final List<SquadMember> roomMembers = [
    SquadMember(
      squadId: 1,
      userName: 'Ayaan',
      isFocusing: true,
      karma: 4.95,
      joinedAt: DateTime.now().subtract(const Duration(days: 14)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Priya',
      isFocusing: true,
      karma: 4.88,
      joinedAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Aisha R.',
      isFocusing: true,
      karma: 4.92,
      joinedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Kabir S.',
      isFocusing: false,
      karma: 4.78,
      joinedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Dev Patel',
      isFocusing: true,
      karma: 4.91,
      joinedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Sneha',
      isFocusing: true,
      karma: 4.85,
      joinedAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Marcus T.',
      isFocusing: false,
      karma: 4.70,
      joinedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    SquadMember(
      squadId: 1,
      userName: 'Ananya',
      isFocusing: true,
      karma: 4.89,
      joinedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  static final List<SquadChatMessage> roomMessages = [
    SquadChatMessage(
      id: 1,
      squadId: 1,
      userName: 'Ayaan',
      message: 'Locked in on graph algorithms and Bellman-Ford tonight. [LOCKED IN]',
      sentAt: DateTime.now().subtract(const Duration(minutes: 24)),
    ),
    SquadChatMessage(
      id: 2,
      squadId: 1,
      userName: 'Priya',
      message: 'Timer running! 25 min deep work cycle, zero notifications. [FIRE]',
      sentAt: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    SquadChatMessage(
      id: 3,
      squadId: 1,
      userName: 'Aisha R.',
      message: 'Dijkstra quiz was crystal clear! The min-heap trick saved 20 lines of code.',
      sentAt: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    SquadChatMessage(
      id: 4,
      squadId: 1,
      userName: 'Dev Patel',
      message: 'Just solved LeetCode 743 Network Delay Time using priority queue. 100% test cases passed! 🚀',
      sentAt: DateTime.now().subtract(const Duration(minutes: 11)),
    ),
    SquadChatMessage(
      id: 5,
      squadId: 1,
      userName: 'Sneha',
      message: 'Reviewing SQL index optimizations alongside. Remember: composite indexes require leftmost prefix! [COFFEE]',
      sentAt: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    SquadChatMessage(
      id: 6,
      squadId: 1,
      userName: 'Ananya',
      message: '9 minutes left on the synchronized Pomodoro ring. Everyone stay locked in! [100]',
      sentAt: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    SquadChatMessage(
      id: 7,
      squadId: 1,
      userName: 'Ayaan',
      message: 'Great pace crew. Taking a 5-min tea break after this bell then running round 2.',
      sentAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  static final List<String> tickerItems = [
    '🔥 14-DAY STREAK ON LEETCODE SPRINT',
    '⚡ 6 OF 8 FOCUSING IN SQUAD ROOM',
    '🍕 HACK NIGHT: BUILD WITH AI STARTS IN 3 HOURS',
    '🧠 42 STUDENTS ACED OS DEADLOCK & TLB QUIZZES',
    '🎬 12 NEW PEER REELS LIVE ON CAMPUS FEED',
    '💎 PRIYA EARNED TOP 3% STATS RISING STAR KARMA',
    '🚀 SERVERPOD REAL-TIME WEBSOCKET ROOM SYNCHRONIZED',
    '🏆 380 SQUADS ACTIVE ACROSS CAMPUS QUADS',
  ];

  static final List<StudentPersona> personas = [

    StudentPersona(
      name: 'Aisha Rahman',
      handle: '@aisha.cs',
      major: 'Computer Science (Systems & AI)',
      year: 'Year 3 · Junior',
      campus: 'North Campus Tech Hub',
      bio:
          'Distributed systems nerd & CS 201 TA. Building a mini Raft consensus engine. Do not talk to me before 2 Pomodoro rounds.',
      studyVibe: 'Silent Pomodoro · Lofi Synthwave · Double Espresso',
      currentGoal:
          'Implement Raft cluster heartbeat & score 95%+ on DistSys finals',
      karmaScore: 4.92,
      karmaRank: 'TOP 1% CAMPUS ANCHOR',
      streakDays: 18,
      focusHours: 38.5,
      quizzesAced: 24,
      squadsJoined: 4,
      peerEndorsementsCount: 58,
      activeSquadName: 'Algorithm Knights',
      badges: [
        StudentBadge(
          title: 'POMODORO MASTER',
          description: 'Completed 25+ certified focus hours',
          category: 'Focus',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 24',
        ),
        StudentBadge(
          title: 'SPEED SOLVER',
          description: 'Aced 5 consecutive active recall quizzes',
          category: 'Quiz',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 27',
        ),
        StudentBadge(
          title: 'MIDNIGHT DEBUGGER',
          description: 'Studied past 1:00 AM with squad members',
          category: 'Grind',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 28',
        ),
        StudentBadge(
          title: 'CAMPUS ANCHOR',
          description: 'Maintained 4.9+ Karma for 30 consecutive days',
          category: 'Prestige',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 15',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: 'Hosted 50m Pomodoro Session',
          detail: '4 peers locked in together in Algorithm Knights',
          karmaDelta: 0.05,
          timeAgo: '2h ago',
          iconName: 'timer',
        ),
        KarmaActivity(
          title: 'Aced Try-It Quiz: Mutex vs Semaphore',
          detail: 'Scored 3/3 on first attempt in 28 seconds',
          karmaDelta: 0.03,
          timeAgo: '5h ago',
          iconName: 'quiz',
        ),
        KarmaActivity(
          title: 'Peer Endorsement Received',
          detail: 'Endorsed for "Clarity under pressure" by Dev P.',
          karmaDelta: 0.04,
          timeAgo: 'Yesterday',
          iconName: 'star',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Dev Patel',
          authorMajor: 'CS Year 4',
          tag: 'SYSTEMS GENIUS',
          quote:
              'Carried our Distributed Systems sprint at 2 AM without losing patience. Explains concensus like second nature.',
          timeAgo: '1d ago',
        ),
        PeerEndorsement(
          authorName: 'Marcus Turner',
          authorMajor: 'CS Year 2',
          tag: 'BEST EXPLAINER',
          quote:
              'Her 45s reel on Mutex vs Semaphore literally saved my midterm score. Clear, direct, zero fluff.',
          timeAgo: '3d ago',
        ),
        PeerEndorsement(
          authorName: 'Sarah Kim',
          authorMajor: 'EE Year 3',
          tag: 'SQUAD ANCHOR',
          quote:
              'Always keeps the squad locked in when everyone else is drifting off. 25m Pomodoro queen.',
          timeAgo: '5d ago',
        ),
      ],
    ),
    StudentPersona(
      name: 'Kabir Sharma',
      handle: '@kabir.cad',
      major: 'Mechanical Engineering (Solid Mechanics)',
      year: 'Year 4 · Senior',
      campus: 'South Engineering Machine Labs',
      bio:
          'Formula Student chassis lead. Spending 14 hours a day in the shop. Grinding FE Mechanical exam & Finite Element Analysis.',
      studyVibe: 'Whiteboard Problem Solving · MathCAD · Matcha Latte',
      currentGoal: 'Master FE Exam Thermo & Fluid Dynamics question banks',
      karmaScore: 4.78,
      karmaRank: 'TOP 5% SQUAD ANCHOR',
      streakDays: 9,
      focusHours: 44.0,
      quizzesAced: 16,
      squadsJoined: 3,
      peerEndorsementsCount: 42,
      activeSquadName: 'Late Night Mechanics',
      badges: [
        StudentBadge(
          title: 'MARATHON SESSION',
          description: 'Logged 4+ hour single squad focus session',
          category: 'Focus',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 26',
        ),
        StudentBadge(
          title: 'HARDWARE HUSTLE',
          description: 'Completed 10 mechanical design review sessions',
          category: 'Specialty',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 20',
        ),
        StudentBadge(
          title: 'NIGHT OWL',
          description: 'Studied past 11 PM with squad',
          category: 'Grind',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 25',
        ),
        StudentBadge(
          title: 'WORKSHOP LEAD',
          description: 'Conducted CAD speedrun workshop on campus',
          category: 'Leadership',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 18',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: 'Completed Thermo Problem Set #7',
          detail: '4 hours focus streak logged with 3 squad members',
          karmaDelta: 0.04,
          timeAgo: '3h ago',
          iconName: 'timer',
        ),
        KarmaActivity(
          title: 'FE Exam Diagnostic Test Passed',
          detail: 'Scored 88% on Fluid Mechanics module',
          karmaDelta: 0.03,
          timeAgo: 'Yesterday',
          iconName: 'quiz',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Ananya Verma',
          authorMajor: 'Mech Year 2',
          tag: 'WHITEBOARD WIZARD',
          quote:
              'Explains Mohr circle and stress tensors 10x better than our textbook. Saved our lab report.',
          timeAgo: '2d ago',
        ),
        PeerEndorsement(
          authorName: 'Rohan Mehta',
          authorMajor: 'Mech Year 4',
          tag: 'CHASSIS BEAST',
          quote:
              'Hosted a 4-hour mock FE session in the squad room. Relentless work ethic, total MVP.',
          timeAgo: '4d ago',
        ),
      ],
    ),
    StudentPersona(
      name: 'Priya Menon',
      handle: '@priya.data',
      major: 'Economics & Data Science',
      year: 'Year 2 · Sophomore',
      campus: 'West Stats & Social Sciences Quad',
      bio:
          'Econometrics researcher & stats tutor. Passionate about causal inference, R regressions, and behavioral economics. Ping me for clean ggplot2 charts.',
      studyVibe:
          'Noise-Cancelling Over-Ears · Classical Piano · Iced Americano',
      currentGoal:
          'Draft empirical thesis proposal on local rental price dynamics',
      karmaScore: 4.85,
      karmaRank: 'TOP 3% RISING STAR',
      streakDays: 14,
      focusHours: 29.0,
      quizzesAced: 22,
      squadsJoined: 5,
      peerEndorsementsCount: 39,
      activeSquadName: 'Stochastic Squad',
      badges: [
        StudentBadge(
          title: 'SPEED SOLVER',
          description: 'Aced 5 consecutive active recall quizzes',
          category: 'Quiz',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 25',
        ),
        StudentBadge(
          title: 'REEL MAESTRO',
          description: 'Author of 3 high-impact campus micro-lessons',
          category: 'Creator',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 22',
        ),
        StudentBadge(
          title: 'CONSISTENT GRIND',
          description: '14-day unbroken daily focus room check-in',
          category: 'Streak',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 28',
        ),
        StudentBadge(
          title: 'STATS VIRTUOSO',
          description: '100% on every econometric method test',
          category: 'Specialty',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 19',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: 'Published Peer Reel: OLS Assumptions',
          detail: 'Bite-sized breakdown watched by 160 students',
          karmaDelta: 0.06,
          timeAgo: '4h ago',
          iconName: 'movie',
        ),
        KarmaActivity(
          title: '14-Day Streak Milestone Reached',
          detail: 'Consistent daily Pomodoro presence on campus',
          karmaDelta: 0.05,
          timeAgo: '1d ago',
          iconName: 'fire',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Jason Liu',
          authorMajor: 'Econ Year 3',
          tag: 'STATS SAVIOR',
          quote:
              'Her intuition on Heteroskedasticity and p-values is crystal clear. Makes econometrics actually fun.',
          timeAgo: '1d ago',
        ),
        PeerEndorsement(
          authorName: 'Maya Sen',
          authorMajor: 'Stats Year 1',
          tag: 'NOTION GENIUS',
          quote:
              'Always shares structured Notion summary notes after every focus round. Invaluable study partner.',
          timeAgo: '3d ago',
        ),
      ],
    ),
    StudentPersona(
      name: 'Ayaan Khan',
      handle: '@ayaan.arch',
      major: 'Architecture & Spatial Design',
      year: 'Year 3 · Junior',
      campus: 'East Studio Lofts',
      bio:
          'Studio dweller building physical models & Rhino 3D parametric rigs. Living off oat milk and laser cutter queues. Seeking quiet late-night drawing crews.',
      studyVibe: 'Ambient Lo-Fi · Wacom Drawing Tablet · Continuous Green Tea',
      currentGoal: 'Finish final scale model for urban transit hub critique',
      karmaScore: 4.65,
      karmaRank: 'TOP 8% VISUAL THINKER',
      streakDays: 7,
      focusHours: 22.5,
      quizzesAced: 11,
      squadsJoined: 2,
      peerEndorsementsCount: 27,
      activeSquadName: 'Studio All-Nighters',
      badges: [
        StudentBadge(
          title: 'STUDIO ANCHOR',
          description: 'Host of East Loft all-night focus sessions',
          category: 'Host',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 23',
        ),
        StudentBadge(
          title: 'FEEDBACK HERO',
          description: 'Given 20+ peer critique reactions in chat',
          category: 'Community',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 21',
        ),
        StudentBadge(
          title: 'NIGHT OWL',
          description: 'Studied past 11 PM with squad',
          category: 'Grind',
          isVolt: true,
          isUnlocked: true,
          unlockedDate: 'Oct 27',
        ),
        StudentBadge(
          title: 'CREATIVE FLOW',
          description: 'Maintained 3 consecutive 50m study blocks',
          category: 'Focus',
          isVolt: false,
          isUnlocked: true,
          unlockedDate: 'Oct 17',
        ),
      ],
      recentActivity: [
        KarmaActivity(
          title: '3D Rhino Model Section Crit',
          detail: 'Shared structural renders with studio peer crew',
          karmaDelta: 0.03,
          timeAgo: '6h ago',
          iconName: 'draw',
        ),
        KarmaActivity(
          title: 'Laser Cutter Workshop Completed',
          detail: 'Assisted 3 first-year students with acrylic cuts',
          karmaDelta: 0.04,
          timeAgo: '2d ago',
          iconName: 'hand',
        ),
      ],
      endorsements: [
        PeerEndorsement(
          authorName: 'Fatima Baig',
          authorMajor: 'Arch Year 3',
          tag: 'LIFESAVER',
          quote:
              'Saved my section drawings from crashing 20 mins before critique! The most generous designer on campus.',
          timeAgo: '2d ago',
        ),
        PeerEndorsement(
          authorName: 'Tyler Nguyen',
          authorMajor: 'Design Year 4',
          tag: 'LOFI VIBES',
          quote:
              'Creates the best calm studio focus room atmosphere on campus. Zero ego, pure craft.',
          timeAgo: '5d ago',
        ),
      ],
    ),
  ];
}
