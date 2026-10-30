BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "campus_event" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "organizer" text NOT NULL,
    "venue" text NOT NULL,
    "eventTime" timestamp without time zone NOT NULL,
    "description" text NOT NULL,
    "tag" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reel" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "creatorName" text NOT NULL,
    "subject" text NOT NULL,
    "videoUrl" text NOT NULL,
    "durationSeconds" bigint NOT NULL DEFAULT 45,
    "suggestedSquadTopic" text NOT NULL,
    "quizQuestions" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "squad" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "topic" text NOT NULL,
    "targetExam" text NOT NULL,
    "timeSlot" text NOT NULL,
    "streak" bigint NOT NULL DEFAULT 1,
    "goal" text NOT NULL DEFAULT '40 problems'::text,
    "currentGoalCount" bigint NOT NULL DEFAULT 28,
    "maxMembers" bigint NOT NULL DEFAULT 6,
    "timerStartedAt" timestamp without time zone,
    "timerDurationSeconds" bigint NOT NULL DEFAULT 1500,
    "isFocusing" boolean NOT NULL DEFAULT false
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "squad_member" (
    "id" bigserial PRIMARY KEY,
    "squadId" bigint NOT NULL,
    "userName" text NOT NULL,
    "avatarUrl" text,
    "isFocusing" boolean NOT NULL DEFAULT true,
    "karma" double precision NOT NULL DEFAULT 4.8,
    "joinedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR huddle
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('huddle', '20261029095400451', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261029095400451', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
