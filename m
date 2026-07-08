Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE73B4EAD
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477119; cv=none; b=haAqJ+59nED3V5ds6i7p3fTsIFb68VxWDGUmbRY+ljFtg2PAj3nWjuI1dsbFKFaB+nii7QxCRm2p31SG1r/G47n+Mx0CZjNanQKtMQF9Bo321yqNRBOMDBzOonP4NP2MHfbF3mLNt7bYBsuewur67WSaSPrSrAF2nJjVNF+WMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477119; c=relaxed/simple;
	bh=c5WIgaUW86zxkVqcui5pvUWjMpEd0rPqQJs9nD03Rho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiUuFQ6W2/aNckplms/QG6ohh+yT90IoZFr455pLxYxe2Av2FB4NZzIPbgH7kZ3m8BQ5I6VqqFD88klLWFmvVjwX1o3HgKxbU9xm4DZJuulYov1iaCswAetRAY+UjXyDgQYZPfD5B/vRvoChzhDStCLYeKQkewMdJ3mjm4rZP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QumXT6Li; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QumXT6Li"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-49c86d1d21cso75741b6e.3
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477116; x=1784081916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
        b=QumXT6LiUj2wdjuxy7wrWIPaOJeTN/xDQayDH//bFAtJzLtjUKCEnkoAGn4CP30v34
         CMevnTeFnWOodgxrQv+AXfvuY63zDgXYkbEfnUy6mt94xUF3GPsLdVDZoD5xTd47ydsK
         p8i9b6I5I7PnwQ1Z56O7IpwSqgNJFVpwN3BK3Jnxatfieb2ZnnYKKuGLYg5+1MUPl6iX
         Gl2Ika8hy6qP2YT+5P7O8IRHCSWKEV+VLXK8NRSmtJkf0u/LsY0H+CfwVzwZcmi90IV2
         lfRe8YWzzts2/i5XXdUBDSrqXDSODosBTOwtQRQx/8s35Wos8bDx1Jb8r5oxXAgaucm1
         OxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477116; x=1784081916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
        b=l9Oivl6Fbt8s36RYi9x4U73Hsz9u7Y8qnL0ith/UDkXQutE0dNrt56D4F9ji5IFYJt
         zf6n/f8IBCBMWSeoBRTiF8do5J/krdhCSnaK70+g2Kqgv6izp4iiVKGCUw2vl6QbJrno
         ccPI8rrmVqZUaRE7paul7JVY3RLKSJ/Na/aUgwjz2cRJSUUo2WhpkMRBztDlYKH77k5Y
         dwgDwfKhVXLMoyBaGHya0nbrOmEDTWpgL5Ohx9b21SRujfxoU6QWS9dbTAYQXfSV12Ql
         AQynNFZ9EtteXXKPBp/Q9XEE7VPVQq14xEyCBFJP+UqzRalL+By0QPY5NTpFvNBgpC06
         KHDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8O8yGzzexd2jhXwdrdIQITnm3xnljfflubSyzms03ZgaCRGCmOT485jTD96bbXM1a4cVvVE/OVXnHEgz4e@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkDjU4K/AtQseJHVk3LkPfIni/ETHcY9UMjn+alOxFihRjAqk
	Ox3ieX8XWY/BfahQJ5YILfxdflqGTsf0Jl8GUsYLsyzjwHtqZ9D3P1qG
X-Gm-Gg: AfdE7clI0Mvw2idkKXQMQiku5v1jHaeGXAvhmMb61Kj1J8DULiYV3Slwb9rZWoaF+4i
	GqnUxXPlKXfvEHfF1h8LS7JNCM/Laxi/RJu7fLj3RhCzvxsNvxJPa4BOuctecXMP3RJXmXICmew
	1235XwUwFXny9CxA9ab5KSwbkX26MxD/diodTa6Xoowc91isAvlD1AcYnkzx/LG3TugcySGHjNI
	Y/D8tDxQCC6n8racNYBur73vEPUJQulVgF0MmPoWLq/hAvfxcZYzzYYyMo23Da136mjLqmIgC1D
	P/K4Z9VmKJ5u2cC5cKs8Ot/qmxopitcYOUnlTJuD7P0vfhc7kTsKLPJdFPW5ke/XX7cyQ5t3372
	3BGcH3yMfarW5YbUGHjsluNg0+qeDYoJ/8Vz9sXhHqGq2MUnSQRlNw53xFnhAlc7GGQ9t0tRki+
	3SU5f3Y1j/WsC1ZDlIv0cfnAxnDDlBEn19I5q7y/GmyKcwH7BUn9E=
X-Received: by 2002:a05:6808:1203:b0:496:fd2:94e8 with SMTP id 5614622812f47-4a20252b9f2mr325652b6e.12.1783477115870;
        Tue, 07 Jul 2026 19:18:35 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:35 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:06 -0600
Subject: [PATCH v6 06/24] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-6-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=4529;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=c5WIgaUW86zxkVqcui5pvUWjMpEd0rPqQJs9nD03Rho=;
 b=04RgXc/Apq9U8cVOxkk9yG7Al6ydGuc69Ip+3XA/yuC3YkRyQar6eVXBInEVdxoRCCuknZtdO
 +FNIb0eFwmIB3dOAaNrZUY01ELAnI3eh1V4e8zq/FpVXFi3JrNiRDWj
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
v5: check for null format in callsite. shouldnt happen, but pr_debug() isnt illegal
---
 lib/dynamic_debug.c | 87 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..577a07916072 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,56 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
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
+		if (!dp->format) {
+			pr_info("encountered a NULL format\n");
+			return false;
+		}
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
@@ -204,42 +254,7 @@ static int ddebug_change(const struct ddebug_query *query,
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
2.55.0

