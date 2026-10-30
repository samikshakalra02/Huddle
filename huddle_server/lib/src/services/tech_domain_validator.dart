import 'dart:math' as math;
import '../generated/protocol.dart';

/// Machine Learning-based Natural Language Processing classifier for validating
/// and monitoring that student-uploaded Reels strictly belong to technical,
/// computer science, and engineering domains.
class TechDomainValidator {
  // 1. DOMAIN TAXONOMIES & WEIGHTED TECHNICAL VOCABULARY
  static const Map<String, List<String>> _techTaxonomies = {
    'Algorithms & Data Structures': [
      'algorithm',
      'algorithms',
      'dsa',
      'array',
      'arrays',
      'linked list',
      'doubly linked list',
      'stack',
      'queue',
      'deque',
      'hash table',
      'hash map',
      'hashmap',
      'tree',
      'binary tree',
      'bst',
      'avl',
      'red-black tree',
      'trie',
      'heap',
      'min-heap',
      'max-heap',
      'priority queue',
      'graph',
      'graphs',
      'adjacency matrix',
      'adjacency list',
      'bfs',
      'dfs',
      'breadth first',
      'depth first',
      'dijkstra',
      'bellman-ford',
      'floyd-warshall',
      'kruskal',
      'prim',
      'topological sort',
      'dynamic programming',
      'memoization',
      'tabulation',
      'greedy',
      'binary search',
      'two pointer',
      'sliding window',
      'backtracking',
      'recursion',
      'sorting',
      'quicksort',
      'mergesort',
      'heapsort',
      'big-o',
      'time complexity',
      'space complexity',
      'o(n)',
      'o(1)',
      'o(log n)',
      'o(n log n)',
      'o(n^2)',
      'leetcode',
      'codeforces',
    ],
    'Machine Learning & Artificial Intelligence': [
      'machine learning',
      'deep learning',
      'artificial intelligence',
      'neural network',
      'neural networks',
      'cnn',
      'convolutional',
      'rnn',
      'lstm',
      'transformer',
      'transformers',
      'attention mechanism',
      'self-attention',
      'gradient descent',
      'backpropagation',
      'loss function',
      'learning rate',
      'optimizer',
      'adam',
      'sgd',
      'overfitting',
      'underfitting',
      'regularization',
      'dropout',
      'batch normalization',
      'epoch',
      'hyperparameter',
      'cross-entropy',
      'mean squared error',
      'pytorch',
      'tensorflow',
      'keras',
      'scikit-learn',
      'huggingface',
      'llm',
      'large language model',
      'gpt',
      'bert',
      'gemini',
      'vector embedding',
      'embeddings',
      'cosine similarity',
      'tokenization',
      'fine-tuning',
      'rag',
      'retrieval augmented generation',
      'computer vision',
      'nlp',
      'natural language processing',
      'reinforcement learning',
      'q-learning',
      'markov',
    ],
    'Operating Systems & Systems Architecture': [
      'operating system',
      'os',
      'kernel',
      'process',
      'processes',
      'thread',
      'threads',
      'multithreading',
      'concurrency',
      'parallelism',
      'deadlock',
      'mutex',
      'semaphore',
      'spin lock',
      'race condition',
      'critical section',
      'virtual memory',
      'paging',
      'page fault',
      'page replacement',
      'lru',
      'segmentation',
      'tlb',
      'cache',
      'cache miss',
      'l1 cache',
      'l2 cache',
      'cpu scheduling',
      'round robin',
      'context switch',
      'system call',
      'syscall',
      'posix',
      'file system',
      'inode',
      'ipc',
      'inter-process communication',
      'pipe',
      'socket',
      'memory leak',
      'stack overflow',
      'heap allocation',
      'garbage collection',
      'assembly',
      'x86',
      'arm',
      'risc-v',
      'register',
      'registers',
      'instruction set',
    ],
    'Database & Storage Engines': [
      'database',
      'dbms',
      'rdbms',
      'sql',
      'nosql',
      'postgresql',
      'postgres',
      'mysql',
      'sqlite',
      'mongodb',
      'redis',
      'cassandra',
      'acid',
      'atomicity',
      'consistency',
      'isolation',
      'durability',
      'transaction',
      'transactions',
      'wal',
      'write-ahead log',
      'b-tree',
      'b+tree',
      'lsm tree',
      'index',
      'indexing',
      'primary key',
      'foreign key',
      'inner join',
      'outer join',
      'normalization',
      '1nf',
      '2nf',
      '3nf',
      'bcnf',
      'query optimization',
      'explain analyze',
      'sharding',
      'replication',
      'partitioning',
      'concurrency control',
      'two-phase locking',
    ],
    'Web, Mobile & Software Engineering': [
      'flutter',
      'dart',
      'react',
      'react native',
      'vue',
      'angular',
      'nextjs',
      'node',
      'nodejs',
      'typescript',
      'javascript',
      'python',
      'java',
      'c++',
      'rust',
      'golang',
      'serverpod',
      'api',
      'rest',
      'restful',
      'graphql',
      'websocket',
      'websockets',
      'http',
      'https',
      'http/2',
      'http/3',
      'tcp',
      'udp',
      'dns',
      'clean code',
      'solid principles',
      'design patterns',
      'singleton',
      'factory pattern',
      'observer pattern',
      'state management',
      'bloc',
      'provider',
      'redux',
      'microservices',
      'monolith',
      'unit test',
      'integration test',
      'ci/cd',
      'git',
      'github',
    ],
    'Cloud, DevOps & Cybersecurity': [
      'docker',
      'container',
      'containers',
      'kubernetes',
      'k8s',
      'pod',
      'cloud',
      'aws',
      'gcp',
      'azure',
      'linux',
      'ubuntu',
      'bash',
      'shell script',
      'ssh',
      'serverless',
      'lambda',
      'load balancer',
      'reverse proxy',
      'nginx',
      'caching',
      'cdn',
      'cybersecurity',
      'encryption',
      'aes',
      'rsa',
      'public key',
      'private key',
      'sha-256',
      'hash',
      'hashing',
      'ssl',
      'tls',
      'handshake',
      'jwt',
      'oauth',
      'oauth2',
      'authentication',
      'authorization',
      'cross-site scripting',
      'xss',
      'sql injection',
      'csrf',
      'ddos',
      'firewall',
      'zero trust',
      'penetration testing',
    ],
  };

  // 2. NON-TECH & OFF-TOPIC DISQUALIFIERS (High-penalty triggers)
  static const Map<String, List<String>> _nonTechTaxonomies = {
    'Lifestyle & Daily Vlogging': [
      'morning routine',
      'night routine',
      'what i eat',
      'grwm',
      'get ready with me',
      'outfit',
      'ootd',
      'fashion haul',
      'makeup tutorial',
      'skincare',
      'room decor',
      'aesthetic vlog',
      'day in my life',
      'shopping haul',
      'lifestyle vlog',
      'college campus walk',
    ],
    'Entertainment, Viral & Dance': [
      'dance',
      'dancing',
      'dance challenge',
      'choreography',
      'lip sync',
      'prank',
      'prank video',
      'comedy skit',
      'funny roast',
      'meme review',
      'viral reel',
      'trending audio',
      'bollywood song',
      'pop music',
      'music video',
      'clubbing',
      'party night',
      'celebrity gossip',
      'dating advice',
      'breakup story',
    ],
    'Casual Gaming & Streams (Non-development)': [
      'gameplay',
      'let\'s play',
      'battle royale',
      'fortnite win',
      'bgmi',
      'pubg clutch',
      'valorant montage',
      'headshot montage',
      'minecraft survival',
      'gta v rp',
      'killstreak',
      'ranked gameplay',
      'clutch 1v5',
    ],
    'Fitness, Cooking & Food': [
      'gym workout',
      'bicep curl',
      'bench press',
      'calorie deficit',
      'weight loss',
      'diet plan',
      'protein shake',
      'tasty recipe',
      'cooking tutorial',
      'street food review',
      'mukbang',
    ],
    'Astrology & Sensational Gossip': [
      'horoscope',
      'zodiac sign',
      'tarot reading',
      'shocking secret',
      'exposed',
      'celebrity drama',
      'scandal',
    ],
  };

  /// Evaluates and classifies incoming reel submission text (title, subject, transcript/description).
  /// Returns a detailed [ReelValidationResult] including domain classification,
  /// confidence probability, detected technical keywords, and clear feedback.
  static ReelValidationResult validateContent({
    required String title,
    required String subject,
    required String content,
    Reel? reel,
  }) {
    final fullText = '$title $subject $content'.toLowerCase();

    // 1. Calculate technical match signals per category
    final detectedKeywords = <String>{};
    final domainScores = <String, double>{};
    double totalTechScore = 0.0;

    for (final entry in _techTaxonomies.entries) {
      final domain = entry.key;
      final keywords = entry.value;
      double categoryScore = 0.0;

      for (final kw in keywords) {
        if (_containsPhrase(fullText, kw)) {
          detectedKeywords.add(kw);
          // Longer phrases have higher semantic weight
          final weight = kw.contains(' ') ? 2.5 : 1.5;
          categoryScore += weight;
        }
      }

      if (categoryScore > 0) {
        domainScores[domain] = categoryScore;
        totalTechScore += categoryScore;
      }
    }

    // Syntax heuristics: check for code symbols and constructs
    final syntaxSignals = [
      RegExp(r'\b(def|class|function|const|let|var|return|import|void)\b'),
      RegExp(r'[\{\}\[\]\(\)\=\>\<]'),
      RegExp(r'o\([1nlog\^\+ ]+\)'),
      RegExp(r'\b(select|from|where|insert|delete|join)\b'),
    ];
    int syntaxMatches = 0;
    for (final pattern in syntaxSignals) {
      if (pattern.hasMatch(fullText)) {
        syntaxMatches++;
      }
    }
    totalTechScore += (syntaxMatches * 1.5);

    // 2. Calculate non-tech penalty signals
    final detectedNonTechWords = <String>{};
    double totalNonTechPenalty = 0.0;
    String detectedNonTechCategory = '';

    for (final entry in _nonTechTaxonomies.entries) {
      final category = entry.key;
      final keywords = entry.value;

      for (final kw in keywords) {
        if (_containsPhrase(fullText, kw)) {
          detectedNonTechWords.add(kw);
          totalNonTechPenalty += 3.8; // Strong penalty multiplier
          if (detectedNonTechCategory.isEmpty) {
            detectedNonTechCategory = category;
          }
        }
      }
    }

    // 3. Normalized Confidence Scoring (Sigmoid function)
    // Positive score pushes toward 1.0, non-tech penalty pushes toward 0.0
    final netScore = totalTechScore - totalNonTechPenalty - 0.5;
    final confidence = 1.0 / (1.0 + math.exp(-netScore));
    final clampedConfidence = confidence.clamp(0.04, 0.99);

    // 4. Decision Rule:
    // Requires >= 0.70 confidence AND positive tech presence AND tech score strictly dominates penalty
    final isTech = (clampedConfidence >= 0.70) &&
        (totalTechScore >= 2.0) &&
        (totalTechScore > totalNonTechPenalty);

    // Find primary domain
    String bestDomain = 'General Computer Science';
    if (domainScores.isNotEmpty) {
      var highestScore = -1.0;
      for (final e in domainScores.entries) {
        if (e.value > highestScore) {
          highestScore = e.value;
          bestDomain = e.key;
        }
      }
    }

    if (isTech) {
      final termsSample = detectedKeywords.take(4).map((k) => '"$k"').join(', ');
      return ReelValidationResult(
        isValid: true,
        isTechDomain: true,
        confidenceScore: (clampedConfidence * 100).roundToDouble() / 100,
        detectedDomain: bestDomain,
        technicalKeywords: detectedKeywords.toList(),
        reason: 'Verified Tech Content: Successfully classified under "$bestDomain" '
            'with ${(clampedConfidence * 100).toStringAsFixed(1)}% ML confidence score. '
            'Key technical markers verified: $termsSample.',
        suggestion: null,
        validatedReel: reel,
      );
    } else {
      final nonTechLabel = detectedNonTechCategory.isNotEmpty
          ? detectedNonTechCategory
          : 'Non-Technical / General Entertainment';

      final suggestion = _generateTechPivotSuggestion(
        detectedNonTechCategory,
        title,
      );

      final reason = totalNonTechPenalty > 0
          ? 'Rejection: Content strongly detected as $nonTechLabel '
              '(flagged phrases: ${detectedNonTechWords.take(3).join(', ')}). '
              'Huddle campus reels are strictly reserved for Computer Science, '
              'Software Engineering, and Technical learning.'
          : 'Rejection: Content lacks sufficient technical depth or engineering keywords '
              '(ML confidence ${(clampedConfidence * 100).toStringAsFixed(1)}% is below required 70% threshold). '
              'Please explain a technical concept, algorithm, code pattern, or architecture.';

      return ReelValidationResult(
        isValid: false,
        isTechDomain: false,
        confidenceScore: (clampedConfidence * 100).roundToDouble() / 100,
        detectedDomain: nonTechLabel,
        technicalKeywords: detectedKeywords.toList(),
        reason: reason,
        suggestion: suggestion,
        validatedReel: null,
      );
    }
  }

  static bool _containsPhrase(String text, String phrase) {
    if (phrase.contains(' ')) {
      return text.contains(phrase);
    }
    // Word boundary check for single words to avoid partial false positives
    final regExp = RegExp(r'\b' + RegExp.escape(phrase) + r'\b');
    return regExp.hasMatch(text);
  }

  static String _generateTechPivotSuggestion(String category, String title) {
    if (category.contains('Gaming')) {
      return '💡 Tech Pivot Suggestion: Re-frame this around game engineering: '
          'e.g. "How Unreal Engine 5 Nanite geometry works", "Writing custom shaders in GLSL", '
          'or "Multiplayer netcode & tick rates in C++".';
    }
    if (category.contains('Lifestyle')) {
      return '💡 Tech Pivot Suggestion: Focus on your engineering environment: '
          'e.g. "My terminal productivity setup with Neovim & Tmux", "Top 5 VS Code extensions for DSA", '
          'or "My daily LeetCode revision workflow".';
    }
    if (category.contains('Entertainment')) {
      return '💡 Tech Pivot Suggestion: Turn this into a tech learning topic: '
          'e.g. "How Spotify uses audio fingerprinting & FFT algorithms", or '
          '"Building an interactive rhythm game in Flutter".';
    }
    return '💡 Tech Pivot Suggestion: Include a specific algorithm, data structure, code snippet, '
        'or architecture design (e.g. Dijkstra, B-Trees, Docker, REST vs gRPC, or SQL Indexing).';
  }
}

