# 🎓 Huddle — Campus Study Crews & Peer Learning

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Serverpod](https://img.shields.io/badge/Serverpod-Backend-6C4DFF?logo=dart&logoColor=white)](https://serverpod.dev)
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![Serverpod Cloud](https://img.shields.io/badge/Deployed-Serverpod_Cloud-00F0FF)](https://huddle-campus.serverpod.space)

> **Huddle** is a campus peer learning app built with **Flutter** (frontend) and **Serverpod** (backend), designed for high-focus students, study squads, and collaborative exam preparation.

---

## 🌐 Live Cloud Demo

- 🚀 **Live Production App:** [https://huddle-campus.serverpod.space](https://huddle-campus.serverpod.space)
- 📊 **Serverpod Cloud API:** [https://huddle-campus.api.serverpod.space](https://huddle-campus.api.serverpod.space)
- 📈 **Serverpod Insights:** [https://huddle-campus.insights.serverpod.space](https://huddle-campus.insights.serverpod.space)

---

## ✨ Key Features

### 1. 🎬 Peer Reels & Instant Try-It Quizzes
- 30-60 second bite-sized campus micro-lessons across **DSA**, **ML Lab**, **DBMS**, **OS Systems**, and **Interview Prep**.
- Integrated **3-question quiz sheet** with instant answer feedback and score breakdown.
- One-tap **"Study this together"** CTA directly launching squad matching.

### 2. ⚡ Smart Squad Matching & Study Radar
- Algorithm that matches peers by subject, schedule, and exam milestones (Placements, Midterms, End-Sem).
- Transparent **"Why you matched"** explanations with compatibility scores.
- Interactive swipe deck with Study Radar filters.

### 3. ⏱️ Live Squad Focus Rooms
- Synchronized **25-minute Pomodoro timer rings** owned and coordinated by the Serverpod backend.
- Member rosters with live animated focus rings ("X of Y focusing").
- Real-time **WebSocket chat** with sticker reactions (`[LOCKED IN]`, `[FIRE]`, `[COFFEE]`, `[100]`).
- Squad streak counters and active sprint goals.

### 4. 📅 Campus Events & Workshops
- Live campus events for hackathons, guest lectures, and placement marathons.
- Instant RSVP toggle, attendee counters, and speaker avatar stacks.

### 5. 🎨 Procedural Neon Avatar Studio & Karma Profile
- Deterministic, procedurally generated cartoon anime avatars drawn in real time via Flutter's `CustomPainter` (no network image dependencies).
- 8 character vibes (Lo-Fi Coder, Star Scholar, Neon Neko, Cyber Visor, etc.) and custom neon aura glows.
- Verified **Campus Karma** score (out of 5.00), daily study streak flames, and unlocked achievement badges.

---

## 🛠️ Architecture & Tech Stack

```
huddle/
├── huddle_flutter/    # Flutter multiplatform client (Web, Android, iOS, Desktop)
├── huddle_server/     # Serverpod backend server & WebSocket streaming endpoints
└── huddle_client/     # Automatically generated, strongly-typed Dart client SDK
```

| Layer | Technology | Details |
|---|---|---|
| **Frontend** | Flutter (Dart 3.x) | Responsive multi-column layout, `go_router`, `google_fonts`, `CustomPainter` |
| **Backend** | Serverpod | Typed RPC endpoints, Relic web server, live WebSocket streaming |
| **Database** | PostgreSQL | Serverpod ORM, declarative `.spy.yaml` models, automated SQL migrations |
| **Hosting** | Serverpod Cloud | Google Cloud containerized podlets with HTTP/3 & automated TLS |

---

## 🚀 Getting Started Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.22+)
- [Dart SDK](https://dart.dev/get-started/sdk) (v3.x+)
- [Serverpod CLI](https://docs.serverpod.dev) (`dart pub global activate serverpod_cli`)

### 1. Clone the repository
```bash
git clone https://github.com/samikshakalra02/huddle.git
cd huddle
```

### 2. Install dependencies
```bash
dart pub get
cd huddle_flutter && flutter pub get && cd ..
cd huddle_server && dart pub get && cd ..
```

### 3. Start the Serverpod Backend & Web Client
```bash
cd huddle_server
serverpod start
```

### 4. Run the Flutter Frontend
```bash
cd huddle_flutter
flutter run -d chrome
```

---

## 🧪 Testing

Run the test suite with 33 responsive tests and zero RenderFlex overflows:
```bash
cd huddle_flutter
flutter test
```

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).

