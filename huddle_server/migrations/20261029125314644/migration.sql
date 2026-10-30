BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "squad_chat_message" (
    "id" bigserial PRIMARY KEY,
    "squadId" bigint NOT NULL,
    "userName" text NOT NULL,
    "message" text NOT NULL,
    "sentAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR huddle
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('huddle', '20261029125314644', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261029125314644', "timestamp" = now();

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
