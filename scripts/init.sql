CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

CREATE TABLE "Addresses" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Label" text NULL,
    "IsConfirmed" boolean NOT NULL,
    CONSTRAINT "PK_Addresses" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoles" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Name" character varying(256) NULL,
    "NormalizedName" character varying(256) NULL,
    "ConcurrencyStamp" text NULL,
    CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetUsers" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "UserName" character varying(256) NULL,
    "NormalizedUserName" character varying(256) NULL,
    "Email" character varying(256) NULL,
    "NormalizedEmail" character varying(256) NULL,
    "EmailConfirmed" boolean NOT NULL,
    "PasswordHash" text NULL,
    "SecurityStamp" text NULL,
    "ConcurrencyStamp" text NULL,
    "PhoneNumber" text NULL,
    "PhoneNumberConfirmed" boolean NOT NULL,
    "TwoFactorEnabled" boolean NOT NULL,
    "LockoutEnd" timestamp with time zone NULL,
    "LockoutEnabled" boolean NOT NULL,
    "AccessFailedCount" integer NOT NULL,
    "Created" timestamp without time zone NOT NULL,
    "LastActive" timestamp without time zone NOT NULL,
    "IsActive" boolean NOT NULL,
    CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
);

CREATE TABLE "Categories" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Name" text NULL,
    "Icon" text NULL,
    CONSTRAINT "PK_Categories" PRIMARY KEY ("Id")
);

CREATE TABLE "FileDatas" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Name" text NULL,
    "Extension" text NULL,
    "Content" bytea NULL,
    CONSTRAINT "PK_FileDatas" PRIMARY KEY ("Id")
);

CREATE TABLE "Kinds" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Name" text NULL,
    "Icon" text NULL,
    CONSTRAINT "PK_Kinds" PRIMARY KEY ("Id")
);

CREATE TABLE "Registrations" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "MacAddressId" integer NOT NULL,
    "BleAddressId" integer NOT NULL,
    "Rssi" integer NOT NULL,
    CONSTRAINT "PK_Registrations" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Registrations_Addresses_BleAddressId" FOREIGN KEY ("BleAddressId") REFERENCES "Addresses" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Registrations_Addresses_MacAddressId" FOREIGN KEY ("MacAddressId") REFERENCES "Addresses" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "RoleId" integer NOT NULL,
    "ClaimType" text NULL,
    "ClaimValue" text NULL,
    CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "UserId" integer NOT NULL,
    "ClaimType" text NULL,
    "ClaimValue" text NULL,
    CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text NULL,
    "UserId" integer NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" integer NOT NULL,
    "RoleId" integer NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" integer NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text NULL,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Components" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Name" text NULL,
    "Icon" text NULL,
    "CategoryId" integer NULL,
    CONSTRAINT "PK_Components" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Components_Categories_CategoryId" FOREIGN KEY ("CategoryId") REFERENCES "Categories" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "Versions" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Name" text NULL,
    "Major" smallint NOT NULL,
    "Minor" smallint NOT NULL,
    "Patch" smallint NOT NULL,
    "ComponentId" integer NULL,
    "KindId" integer NULL,
    "FileDataId" integer NOT NULL,
    CONSTRAINT "PK_Versions" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Versions_Components_ComponentId" FOREIGN KEY ("ComponentId") REFERENCES "Components" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Versions_FileDatas_FileDataId" FOREIGN KEY ("FileDataId") REFERENCES "FileDatas" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Versions_Kinds_KindId" FOREIGN KEY ("KindId") REFERENCES "Kinds" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "Devices" (
    "Id" integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Created" timestamp without time zone NOT NULL,
    "Modified" timestamp without time zone NULL,
    "Name" text NULL,
    "Icon" text NULL,
    "AddressId" integer NOT NULL,
    "KindId" integer NULL,
    "CategoryId" integer NULL,
    "ComponentId" integer NULL,
    "VersionId" integer NULL,
    "Updated" timestamp without time zone NULL,
    "IsUpdated" boolean NULL,
    "IsAutoUpdate" boolean NULL,
    CONSTRAINT "PK_Devices" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Devices_Addresses_AddressId" FOREIGN KEY ("AddressId") REFERENCES "Addresses" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Devices_Categories_CategoryId" FOREIGN KEY ("CategoryId") REFERENCES "Categories" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Devices_Components_ComponentId" FOREIGN KEY ("ComponentId") REFERENCES "Components" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Devices_Kinds_KindId" FOREIGN KEY ("KindId") REFERENCES "Kinds" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Devices_Versions_VersionId" FOREIGN KEY ("VersionId") REFERENCES "Versions" ("Id") ON DELETE RESTRICT
);

CREATE UNIQUE INDEX "IX_Addresses_Label" ON "Addresses" ("Label");

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

CREATE INDEX "IX_Components_CategoryId" ON "Components" ("CategoryId");

CREATE UNIQUE INDEX "IX_Devices_AddressId" ON "Devices" ("AddressId");

CREATE INDEX "IX_Devices_CategoryId" ON "Devices" ("CategoryId");

CREATE INDEX "IX_Devices_ComponentId" ON "Devices" ("ComponentId");

CREATE INDEX "IX_Devices_KindId" ON "Devices" ("KindId");

CREATE INDEX "IX_Devices_VersionId" ON "Devices" ("VersionId");

CREATE INDEX "IX_Registrations_BleAddressId" ON "Registrations" ("BleAddressId");

CREATE INDEX "IX_Registrations_MacAddressId" ON "Registrations" ("MacAddressId");

CREATE INDEX "IX_Versions_ComponentId" ON "Versions" ("ComponentId");

CREATE INDEX "IX_Versions_FileDataId" ON "Versions" ("FileDataId");

CREATE INDEX "IX_Versions_KindId" ON "Versions" ("KindId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20201027190741_IdentityAdded', '3.1.9');

INSERT INTO public."AspNetUsers" ("UserName", "NormalizedUserName", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "ConcurrencyStamp", "PhoneNumber", "PhoneNumberConfirmed", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount", "Created", "LastActive", "IsActive") VALUES ('admin', 'ADMIN', 'admin@admin', 'ADMIN@ADMIN', false, 'AQAAAAEAACcQAAAAEP+ft9Im54ZEwoYJWOHajxKiEcX2WfhayD8gV2QZF8l4S26YDhmBXPiykvF2h0q4Iw==', 'PL7ZGOCNQMRLZ3YFBETJPD2NQ4PZDOVI', '26ca969e-7623-4a55-9896-d145900d60c0', NULL, false, false, NULL, true, 0, '2020-10-31 12:55:11.893999', '0001-01-01 00:00:00', true);
INSERT INTO public."AspNetUsers" ("UserName", "NormalizedUserName", "Email", "NormalizedEmail", "EmailConfirmed", "PasswordHash", "SecurityStamp", "ConcurrencyStamp", "PhoneNumber", "PhoneNumberConfirmed", "TwoFactorEnabled", "LockoutEnd", "LockoutEnabled", "AccessFailedCount", "Created", "LastActive", "IsActive") VALUES ('test', 'TEST', 'test@test', 'TEST@TEST', false, 'AQAAAAEAACcQAAAAEKkWj0YPNCdlAOX0srMpY3BumZX2HRMtxs5zzRyfVFLzYzfLYj+d48LKapwI0I5cqw==', 'STZSEMF4XBIJQTUJZTGE3HGXDRM63LJO', 'daa1f935-31e9-4344-b236-cfbd8bbe3146', NULL, false, false, NULL, true, 0, '2020-10-31 12:55:03.241054', '0001-01-01 00:00:00', true);

INSERT INTO public."AspNetRoles" ("Name", "NormalizedName", "ConcurrencyStamp") VALUES ('Admin','ADMIN','f97edd36-8db1-43c0-bd5c-248fd74eb551');
INSERT INTO public."AspNetRoles" ("Name", "NormalizedName", "ConcurrencyStamp") VALUES ('Member','MEMBER','45d1f146-192b-482b-9241-e0b23faa7aa4');

INSERT INTO public."AspNetUserRoles" VALUES (1,1);
INSERT INTO public."AspNetUserRoles" VALUES (1,2);
INSERT INTO public."AspNetUserRoles" VALUES (2,2);