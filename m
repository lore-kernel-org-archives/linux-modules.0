Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32130F815
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927519; cv=none; b=dwYBgdtMBtQ7t8pCXV9qHb5No/3s9Foy1849lRgRAS0u2nuwFU/ROxpwXMJQqeE3pNjpM/q4T7GFF1Ymt0yXjsPMri0W+3+PqGzcqxvWm7+F1j0zbJqzIhhPKgefQOM9oF06RDBpToe8bN4v1ML/MMH96VG85eWv+V2Bf6yjL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927519; c=relaxed/simple;
	bh=j5GAqgH1tDYgb6kzTcUFN1yLPWoPsRlOPzCxW4/MNeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIKgxzDBa/4YC2/iUooAAwcuFjXQn1PcoDELSisl9qDzFhUl5CdYs7ZFNQwVBBSIhuEkjYTfjBUT/p1ggHua7KR4lEvUwkFiinTdx8Ea3eRFGJQYIjJiGzpoGsIRgPUyH7LlAeEgLEalZOLvNrR07Cj5wh7OpGBBU+Waj9KryPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK1JaAOi; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK1JaAOi"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67e09232daeso3016109eaf.2
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927517; x=1778532317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96+CnjisvPUb0CWRbReGwZxDAY9Evf8qYjQBtyb4fJA=;
        b=mK1JaAOiU0MxiV25TY/KRw94MLAuyKqhzAZdISaXe+7cuGgQLiSJ8bQ6RhwS0UUg4P
         UtLN22u0FvCWbPrd79BtrI9oSob296I08tj/SbWlMUR+1fFH8++UBclG7vez2+e8h44H
         x5y57abi9R1CIZr6izzrqLAIwy+zWMJwqOWA7RpRBJCUoQqICC1jyoGId6AYl1uxoZj0
         CIF69B7XaXotLp3GI1EKY2CXe+nV/7ole/usj6jWyrPEO5qMA3n9fpaizAY01tOLjNGb
         Ry+KXjGUGHKF9kNhrvPkw65tUhm+eGDEVtS9dTgdgwGXw+h/xF1wqb8wC93AAq2qqEi5
         CLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927517; x=1778532317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=96+CnjisvPUb0CWRbReGwZxDAY9Evf8qYjQBtyb4fJA=;
        b=J7yp5BqwFDOSy5JnEtafhu2ClGoNG6mrDUhatL5XKxHd9LNZEFMqHEuQkcvX61z0To
         uodI+Dvg9vLjhBwnR+dAzRmkiesLr1eJhHPKuiKFLeXYWs4K3PYnhkueiVGjSU682u2R
         xYoEpM04T7DP6maTuhfOXKdKFAynN/HsbAT+q+PLWsE6waD/Zq4l1/rSuAf8Fwfbd3ZK
         2fYXeLH+5u6Jt7qEXMxX2CFvFqXcT3uftudIA3xsftrNxaUfXFjTT4NI+GEBpy6UEn/u
         QRVqw0acuGXYgHVufGx2YqoSqITuFSq7wOEvil/necbPELXuZxxKeQFrYvDVFhRKpn/a
         z0Kw==
X-Forwarded-Encrypted: i=1; AFNElJ9sGk8fxpY7WngsWtAO6YzLjIM8Lkgd5KNir/lIull56ESrULfaUricMIpj8DkLIKKMQl3B7SJG8xCSMj9h@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxRvm7ZQwbkWmbn3Hnzl3E38pSKLQWX8y2W+hsZH4SKuKPTVE
	87pj4IvFHjcd1WYXCFjznnznf+xs5GBbPOEg8oQVC9D7RmfdgdGUcrR1
X-Gm-Gg: AeBDieskyjYzm7HvhFu7CqVaP6jIkvzHe7BoGCdAtMbVqJDyYTmM8FpYdW/5SLqDjLF
	uTlaXmhrIdETtqVWz+7KGZj3zrCSDkh4mABQy+UWldBzTLbss0yXGM6peZpY6UsYOwPsWB7QoJM
	2xhpTCRhJ8WQavg3/zgXr2OjuNmQiJ4wnqPpo+l2QTmGuzSsnINWoUdJsIJXubbL8TVgZzsBOCU
	Ymrvgsr7D+7Yoy3taVt4GG1DD5ubJCl86A1Xyh3JqMk2LGf7Y08hlUNlF0XU90uwpixnmy75ndq
	YT5DX6HWY3YUOguJb0ECHwosyNl2Fh/RcKNOvKzgPV42QKZfoLFsluUVne1WAHbZKcmbTS1nhBt
	2szS/GHsDlt344TEfb8pZQSJfxI5drZWJogZHP/sCFafb3yoxrkgAevYUFB3a4+lR0UHcsTk/L0
	+8TC9up+SyF9makLCkXNBYQ7SXKq6Ymhbxk1V5fXvG+1C7htqGnQM9hh+KlsUhDLN86D0adKvP
X-Received: by 2002:a05:6820:2109:b0:696:25d4:1e62 with SMTP id 006d021491bc7-696979cc0eamr5130131eaf.2.1777927516839;
        Mon, 04 May 2026 13:45:16 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:07 -0600
Subject: [PATCH 01/17] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-1-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=4346;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=j5GAqgH1tDYgb6kzTcUFN1yLPWoPsRlOPzCxW4/MNeE=;
 b=TnKzQJCtvtPa2kyeezQXWnc8ZQbBfl1uUt7zNXn5K9tUjUSqOj0Wvdj5kmmpddLZTQIFEXCl7
 iAV5ZJDwtMCAdTNqcnRnZqjq9kw9lSXIsIJAcZsj1AREKUQ/Bw/NuGf
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
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

