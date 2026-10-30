import 'package:flutter_test/flutter_test.dart';
import 'package:huddle_flutter/services/tech_domain_validator.dart';

void main() {
  group('TechDomainValidator ML Pipeline Tests', () {
    test('Approves Algorithm & DSA technical content with high confidence', () {
      final result = TechDomainValidator.validateContent(
        title: 'LRU Cache implementation with Doubly Linked List',
        subject: 'DSA',
        content:
            'Using a hash map for O(1) lookup combined with a doubly linked list '
            'allows O(1) eviction of the tail and moving accessed nodes to the head. '
            'Time complexity: O(1) for both get and put operations.',
      );

      expect(result.isValid, isTrue);
      expect(result.isTechDomain, isTrue);
      expect(result.confidenceScore, greaterThanOrEqualTo(0.80));
      expect(result.detectedDomain, 'Algorithms & Data Structures');
      expect(result.technicalKeywords, contains('doubly linked list'));
      expect(result.technicalKeywords, contains('hash map'));
    });

    test('Approves Machine Learning & Deep Learning technical content', () {
      final result = TechDomainValidator.validateContent(
        title: 'Backpropagation & Gradient Descent in Neural Networks',
        subject: 'Machine Learning',
        content:
            'Gradient descent optimizes neural network weights by minimizing the loss function. '
            'We compute partial derivatives via backpropagation and update parameters in PyTorch.',
      );

      expect(result.isValid, isTrue);
      expect(result.isTechDomain, isTrue);
      expect(result.confidenceScore, greaterThanOrEqualTo(0.85));
      expect(
        result.detectedDomain,
        'Machine Learning & Artificial Intelligence',
      );
      expect(result.technicalKeywords, contains('gradient descent'));
      expect(result.technicalKeywords, contains('backpropagation'));
    });

    test('Rejects non-tech lifestyle and daily vlogging content', () {
      final result = TechDomainValidator.validateContent(
        title: 'My college morning routine and outfit of the day',
        subject: 'General',
        content:
            'Get ready with me for college! Sharing my daily morning routine, aesthetic room decor, '
            'skincare products, and outfit haul before heading out.',
      );

      expect(result.isValid, isFalse);
      expect(result.isTechDomain, isFalse);
      expect(result.confidenceScore, lessThan(0.50));
      expect(result.detectedDomain, contains('Lifestyle'));
      expect(result.reason, contains('Rejection'));
      expect(result.suggestion, isNotNull);
    });

    test('Rejects casual gaming gameplay streams (non-engineering)', () {
      final result = TechDomainValidator.validateContent(
        title: 'Insane 1v5 clutch gameplay montage in BGMI',
        subject: 'Gaming',
        content:
            'Watch this crazy battle royale gameplay! Headshot montage, squad wipe clutch, '
            'and winning the chicken dinner in ranked lobby with high killstreak.',
      );

      expect(result.isValid, isFalse);
      expect(result.isTechDomain, isFalse);
      expect(result.confidenceScore, lessThan(0.50));
      expect(result.detectedDomain, contains('Gaming'));
      expect(result.suggestion, contains('game engineering'));
    });

    test('Rejects vague content with insufficient technical depth', () {
      final result = TechDomainValidator.validateContent(
        title: 'Study tips for students',
        subject: 'Study',
        content: 'Wake up early, drink plenty of water, and stay motivated every single day.',
      );

      expect(result.isValid, isFalse);
      expect(result.isTechDomain, isFalse);
      expect(result.reason, contains('threshold'));
    });
  });
}
