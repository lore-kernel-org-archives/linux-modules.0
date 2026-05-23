Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0733F5AE
	for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520513; cv=none; b=W2z+cyg+vtnNg7sc0WFjK9Nnoqpxja5bX7yKBqG/ZPIl+lmiNxoEo49iJhskDjVTg6h0BaWvadSzDZMu7LsD2tvXkzVKDwi0x6LFty0ByX8kMjjxLYaelc+YuwQzKts4R4I4SYQC5kx7PTc0Q8hzpy4WlzrT8jILp8PWYhCziuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520513; c=relaxed/simple;
	bh=ytc0P/UZw6i8hpySK2Au28vrT+KoK4/4tvvmOq28NjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjH/Ftg25z77nZPt7hysrKoXouzBzZTmQaAYnr+U0n30wZHzrMxqK94jWB4IpsUk3nFFOAocNqVRCzkJ8BJRQV4MNv7w90T7EB1A8KRULXSzQELMcUnUklqLT9FykAH9It46pJ5hgrJMbwlNAWnfe10xZljXrvv7s54ohymKPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOHk0v/Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOHk0v/Y"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44a5174670eso4707953f8f.1
        for <linux-modules@vger.kernel.org>; Sat, 23 May 2026 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520505; x=1780125305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdDKIkZQT8kN6q6EUNEFoTcvXlPCpXkuxCaw1ETC1j0=;
        b=KOHk0v/Y4BkDZjDkXwM5TOzSZqZvmt0+9xV2btspHIs4du5ytuXuYMsD9nVpRMd/Qz
         c3oydRjROCKmlz3tJmR4okd0XcQ4h/lICfDAzDy0GXUMkHL40u9J+8T02Mt4DSTn8im2
         ZUQAmqXO2u0qzC0AZ7iEyxXUAqMtqdyhT9okDiVZoUFYnCwtv8hPOZsTNSreNp1E973c
         Y08eNIvVX1UZejXQUIOMNL9exAWtBVZJ0V7oArty5/yZ/MVcPG2QE9jnx+UCP/lIRVMO
         pzez8YShVoFIQbvNSBQxj+jBvc2LqKeQ2zzPvcV0YtZ4+lXN2kR/cEpDy83mPCoBVq1x
         Zzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520505; x=1780125305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdDKIkZQT8kN6q6EUNEFoTcvXlPCpXkuxCaw1ETC1j0=;
        b=dkBPpbaZrr4UcB2/qUgVsnuhxGxPPKyhL30hMwZnLWPXSt/K2h9LHD2+YXsCD14WSa
         M6BLaCEiPCn1TdelO5agK/x0k+4EgTYAlyHgV9vJ4slWF8yXbOshonc3jvZw1kFxLL2U
         IprPYwFeMNrFavBAptrjFiH0HCdGQ/j7WsR2KILY9LF5vo7NhwG/7cCYbTjrWOQ5QAfr
         6UfO1UNnJ1lkfj6WQw6jNIO+YI/aPln3VMdy4fsIgR3XDhoi79S9mzGu5pGrXoFF/NjB
         l1QbCpR5VF5k7wWP0xF7ODa4Y2JODyIIneIScQtVPTOzoMBQXYPW8Z5wyeS0YNN4BgfO
         c/oA==
X-Forwarded-Encrypted: i=1; AFNElJ97r2xTSwsKj4887zzz66IzuPMgV4YO/wPdpdL4JadYVEdGA89RyAcpLiB0QYM9FbIOL52uHQjJZ2Cflmd8@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqbPfCRvacpuSH2FZFphwtkRRqSK3+87h9dfbLr9RPIKz5xyK
	YCiAES2hVHXQ43gugbwfKoZZHNiv8zT+QsUyKINwMcwUZblkXRDDh26WhWFlLIoCNro=
X-Gm-Gg: Acq92OGzCBw4/Wl6ogxVo9w2K8ni+vG2FDZARdTT8tisFNMpCqe92ataUuBo85TaTJM
	9czbuT2PpN3Ypw1LJL883dhr5MMLjpgL/747kx5X0c19S5bH9kUC8BCQoz4c0VqVp8PXLxo+Ssp
	//zGowVmILTKTQqGjwqatVcFj63NlPAmRnDyF3+ag+iK4k/WgHUZe1HenJ9guToMB7WI7HTFfjP
	LE3xUZHiTiYkxYWCFBEjxFetowOXpzj0HwzPzQtk7muQ548S0qXWZBOQOMdo3liwwx4UPUdk1Mu
	cYx7uIqK/ib9y/qdZNnSyoSZTUqtXlCklGRs5e6zMkmKyjyrkwYLrxjSuRPW+vEjpAinoqb9Gk+
	ONm5Cs0PkP6219cRou7pmsy51ttOHl8HeZ0XnWXvjauSU3XkhHCuMFFccOSfFwBk9w8r70ctCPQ
	Hk5j2zd83CFuhqd3zAA5eNXc9i/Y/g
X-Received: by 2002:a05:6000:41ee:b0:43f:e94a:e773 with SMTP id ffacd0b85a97d-45eb36b0818mr10298365f8f.27.1779520503105;
        Sat, 23 May 2026 00:15:03 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:41 -0600
Subject: [PATCH v2 08/24] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-8-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=4346;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ytc0P/UZw6i8hpySK2Au28vrT+KoK4/4tvvmOq28NjE=;
 b=0FjUNJKqj7zcKpWVRK2n6ovvyNH2+oda32OW1WLwtDuWRnsuT5scN/UPpoLhYifa4yWRrthJy
 aTwPMijUnb1DvrrA+go89tdgBJwSTv77BQa50TUt4C4cH9JveciLEG8
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ddebug_change() is a big (~100 lines) function with a nested for loop.

The outer loop walks the per-module ddebug_tables list, and does
module stuff: it filters on a query's "module FOO*" and "class BAR",
failures here skip the entire inner loop.

The inner loop (60 lines) scans a module's descriptors.  It starts
with a long block of filters on function, line, format, and the
validated "BAR" class (or the legacy/_DPRINTK_CLASS_DFLT).

These filters "continue" past pr_debugs that don't match the query
criteria, before it falls through the code below that counts matches,
then adjusts the flags and static-keys.  This is unnecessarily hard to
think about.

So move the per-descriptor filter-block into a boolean function:
ddebug_match_desc(desc), and change each "continue" to "return false".
This puts a clear interface in place, so any future changes are either
inside, outside, or across this interface.

also fix checkpatch complaints about spaces and braces.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 83 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..6b1e983cfedc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * callsites, normally the same as number of changes.  If verbose,
  * logs the changes.  Takes ddebug_lock.
  */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dp->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dp->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dp->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dp->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format + 1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format)) {
+			return false;
+		}
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
 {
@@ -204,42 +250,7 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
 
 			nfound++;

-- 
2.54.0

