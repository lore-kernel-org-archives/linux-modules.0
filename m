Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEF1993AE
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647130; cv=none; b=rjfYMGsb8eqzapHd5NNEr47f+eYulxnICpr7TNfF8QN6Q2KY1FD80r5ZPCj2ELQp1qva5X/7NKwdaoqzQPoscPrqZRON8k0FjhNKmCVUjxet2oGy8p3E37OyyWD1bOdxascb/a6pg2H9MgICeihMZrW/w7nv7x+U4k5PxZtaUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647130; c=relaxed/simple;
	bh=E8SnT3PVNgwvs9gIA8r8UmB9RILzIMEk5mxRikJC8gY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P74R/Sk8M8hqyeDo1hsLaBcn6Xe319jcVYBvvxWkwVyyQZs294f/PHuO9BI5AaOyWSKzoBSdRz/HNa/H/tW8Sq4sUT1K9CTXtz9g0bo7utc+xkc2M7Qzfoekt1jHdaQ3VHHvhOxMpTNgEFtCWBSZ7V2sOnMfVCISsiGQivCqWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fX/hZuTq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fX/hZuTq"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70419ef7f48so4339060b3a.1
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647127; x=1719251927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q78REyi52sqkWL03kuxiNz+yyQ9ejPgzHXaQsMRmJ8I=;
        b=fX/hZuTqdTeAAo+DEk3WrIyHJWpdonvIf+ID2BSTh4xCRom+PH6qNyDxtwDFBoZXRU
         oZNqogRuNmblU8ioPf6xerIHKwgHPk1rYGhHa9XahbpsEa3VY21rq92JU2Uap16YzUUo
         3cycS/qKR7M+UjPoEYsBiMjb2/2tgzVRejR0quU9dgh4Ym+HjdpfOiZHAQq+CFrfWEC2
         ff+IUyw2R7nRYPms+RcdX0ommm17Q8U357Vv4ihI7y0V7kSUNINkmg7iwgeVw0h4YAgU
         gaP9T7jU1B0Lh5FJHiUhWJtQpH66u8fsBRNsBMjR3FCqljOPZftdmKV9QGMJpOQVvW9U
         LbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647127; x=1719251927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q78REyi52sqkWL03kuxiNz+yyQ9ejPgzHXaQsMRmJ8I=;
        b=YvhUD2CUpU4+o4EDQQ01ctjTYVBfbnH06U55CSp9pKI6K4OJgosR2zcAUS94r5q9YY
         6NgQ8I8vIM3XyI9EI2p2UzgpOmXXIPx9gOYKeZIeHKpJoTPW5P7UmcW95J7t+tbi0lO7
         qKH3HdLdhc8OpDSsnoXorVtGo/AFWPqB920ypc0zHMUe7q7cLO6Pgrjf6tNJiaQsMKGI
         /Mm7mVuO4VDUuTQ9C+zblyLpWvZt/yz9LBbly38kCA1hLV+EitEI5DgyuLPIrF9sIrly
         21lMv8UXS6fsFHSxmAEob4fXDwVYl1ExpO4TSFreq0yut/N+uA+O+ggzzORHxg2rEWkD
         IvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXneBlEyrS2vtX5bqauz/zviCJdGOoavtAJsU+XK7Np0PfGwWZmUYIylsjx59qqWf7Ek5vRoLJNsK2gJpmiDvqmg9SbhDQDhefkW/RrLw==
X-Gm-Message-State: AOJu0YznV+NNWhEyetUT9xZWc0xMZqaD1hyrQsYHznEnCatFy/Sg5Y6K
	5Dm1rkDqEqbSLfBJ+w27KcTI8KOgto3z5d5ma4LzPkRBCKZy1PRMrqcfzxBsjBG/8Ql08ZvSBC1
	qkDm8PHTprDVHWZo4sFJhGWcWHw==
X-Google-Smtp-Source: AGHT+IG7Ue5DJDS1N7DP4tCk4vCEgaA5IoS5ykSNmz1WLMo+HqkFJZ34S73K58/Xvvf2E+rzd0MQkiPOgpUx01THRW4=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:1d9a:b0:705:d750:83dd with
 SMTP id d2e1a72fcca58-7061a9cd714mr1634b3a.0.1718647126976; Mon, 17 Jun 2024
 10:58:46 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:31 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5421; i=samitolvanen@google.com;
 h=from:subject; bh=E8SnT3PVNgwvs9gIA8r8UmB9RILzIMEk5mxRikJC8gY=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk8Bb1DCi99v6wb89Vda/7vwSnIbRDTw0ABB
 IYi86zqYneJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5PAAKCRBMtfaEi7xW
 7nsZC/0fY4b4nIhSqSmetH7M+TuHCSDRTPXYnz6APqYIR82AgLo3SR3Ca+zpPFziHT1Rvik7uWJ
 zbbTbE32fF7R6lopcUh6k6qh+cctPuAvDyN8CkOqnb/8lMAbFPb0xZNnZmHyEjgeccTLmusU9yX
 VqNaEs5SIhiDoST8A4iAJMwnAOzKKXMm7X4nfZ7cL+RsMBIGAf4C0WnoszRDD6GbfLh1gMumKVa
 KQ0XD7c9cne4LvKv8m8s/9Hp0SJnsVYdXWB86YueROeGhYVSflI5wsXS5UvNa3XoZO9JFhXUJTS
 8YlBnQpE/+EWz8rZXdKYdz3Q4SIk9ZiRVwpqA8Cj1uZm2toAw2ht99lvfXleE4nwg3xo3QWft/R
 J5ca6acXIjNTxb2jWVqlWkNSbF+OZZ58Q55ETL83qi2OALARh0OSMBx0XhNS6zAd/gwFgyR2TZK mD/JQPyoZ0uxXu2y905BawVVBWgkgJ5zuEvfYGUg9b7LdKl6n7oFmM+LHBAOeTGft9HD8=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-29-samitolvanen@google.com>
Subject: [PATCH 12/15] gendwarfksyms: Add inline debugging
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Understanding the operation and caching of the tool can be somewhat
challenging without a debugger. Add inline debugging information with
the --inline-debug command, which adds highlighted tags to the --debug
output with information about cache states etc.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/gendwarfksyms/gendwarfksyms.c |  3 +++
 tools/gendwarfksyms/gendwarfksyms.h | 29 +++++++++++++++++++++++++++++
 tools/gendwarfksyms/types.c         | 14 ++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/tools/gendwarfksyms/gendwarfksyms.c b/tools/gendwarfksyms/gendwarfksyms.c
index 7095f0ecccab..acf4b44238e2 100644
--- a/tools/gendwarfksyms/gendwarfksyms.c
+++ b/tools/gendwarfksyms/gendwarfksyms.c
@@ -15,6 +15,8 @@
 
 /* Print type descriptions and debugging output to stderr */
 bool debug;
+/* Print inline debugging information to stderr (with --debug) */
+bool inline_debug;
 /* Don't use caching */
 bool no_cache;
 /* Don't pretty-print (with --debug) */
@@ -25,6 +27,7 @@ static const struct {
 	bool *flag;
 } options[] = {
 	{ "--debug", &debug },
+	{ "--inline-debug", &inline_debug },
 	{ "--no-cache", &no_cache },
 	{ "--no-pretty-print", &no_pretty_print },
 };
diff --git a/tools/gendwarfksyms/gendwarfksyms.h b/tools/gendwarfksyms/gendwarfksyms.h
index 568f3727017e..34d1be3cfb7f 100644
--- a/tools/gendwarfksyms/gendwarfksyms.h
+++ b/tools/gendwarfksyms/gendwarfksyms.h
@@ -18,6 +18,7 @@
  * Options -- in gendwarfksyms.c
  */
 extern bool debug;
+extern bool inline_debug;
 extern bool no_cache;
 extern bool no_pretty_print;
 
@@ -38,6 +39,18 @@ extern bool no_pretty_print;
 #define warn(format, ...) __println("warning: ", format, ##__VA_ARGS__)
 #define error(format, ...) __println("error: ", format, ##__VA_ARGS__)
 
+#define __inline_debug(color, format, ...)                              \
+	do {                                                            \
+		if (debug && inline_debug)                              \
+			fprintf(stderr,                                 \
+				"\033[" #color "m<" format ">\033[39m", \
+				__VA_ARGS__);                           \
+	} while (0)
+
+#define inline_debug_r(format, ...) __inline_debug(91, format, __VA_ARGS__)
+#define inline_debug_g(format, ...) __inline_debug(92, format, __VA_ARGS__)
+#define inline_debug_b(format, ...) __inline_debug(94, format, __VA_ARGS__)
+
 /*
  * Error handling helpers
  */
@@ -51,6 +64,9 @@ extern bool no_pretty_print;
 		__res;                                          \
 	})
 
+/*
+ * DWARF helpers
+ */
 /* Consistent aliases (DW_TAG_<type>_type) for DWARF tags */
 #define DW_TAG_enumerator_type DW_TAG_enumerator
 #define DW_TAG_formal_parameter_type DW_TAG_formal_parameter
@@ -97,6 +113,19 @@ struct cached_item {
 
 enum cached_die_state { INCOMPLETE, UNEXPANDED, COMPLETE };
 
+static inline const char *cache_state_name(enum cached_die_state state)
+{
+	switch (state) {
+	default:
+	case INCOMPLETE:
+		return "INCOMPLETE";
+	case UNEXPANDED:
+		return "UNEXPANDED";
+	case COMPLETE:
+		return "COMPLETE";
+	}
+}
+
 struct cached_die {
 	enum cached_die_state state;
 	uintptr_t addr;
diff --git a/tools/gendwarfksyms/types.c b/tools/gendwarfksyms/types.c
index da3aa2ad9f57..694b33cdd606 100644
--- a/tools/gendwarfksyms/types.c
+++ b/tools/gendwarfksyms/types.c
@@ -97,6 +97,7 @@ static int process(struct state *state, struct cached_die *cache, const char *s)
 		fputs(s, stderr);
 
 	state->crc = partial_crc32(s, state->crc);
+	inline_debug_r("cache %p string '%s'", cache, s);
 	return cache_add_string(cache, s);
 }
 
@@ -456,6 +457,8 @@ static int process_cached(struct state *state, struct cached_die *cache,
 	while (ci) {
 		switch (ci->type) {
 		case STRING:
+			inline_debug_b("cache %p STRING '%s'", cache,
+				       ci->data.str);
 			check(process(state, NULL, ci->data.str));
 			break;
 		case LINEBREAK:
@@ -468,6 +471,8 @@ static int process_cached(struct state *state, struct cached_die *cache,
 				error("dwarf_die_addr_die failed");
 				return -1;
 			}
+			inline_debug_b("cache %p DIE addr %lx tag %d", cache,
+				       ci->data.addr, dwarf_tag(&child));
 			check(process_type(state, NULL, &child));
 			break;
 		default:
@@ -561,6 +566,9 @@ static int process_type(struct state *state, struct cached_die *parent,
 		check(cache_get(die, want_state, &cache));
 
 		if (cache->state == want_state) {
+			inline_debug_g("cached addr %p tag %d -- %s", die->addr,
+				       tag, cache_state_name(cache->state));
+
 			if (want_state == COMPLETE && is_expanded_type(tag))
 				check(cache_mark_expanded(die));
 
@@ -572,6 +580,9 @@ static int process_type(struct state *state, struct cached_die *parent,
 		}
 	}
 
+	inline_debug_g("addr %p tag %d -- INCOMPLETE -> %s", die->addr, tag,
+		       cache_state_name(want_state));
+
 	switch (tag) {
 	/* Type modifiers */
 	PROCESS_TYPE(atomic)
@@ -608,6 +619,9 @@ static int process_type(struct state *state, struct cached_die *parent,
 	}
 
 	if (!no_cache) {
+		inline_debug_r("parent %p cache %p die addr %p tag %d", parent,
+			       cache, die->addr, tag);
+
 		/* Update cache state and append to the parent (if any) */
 		cache->state = want_state;
 		check(cache_add_die(parent, die));
-- 
2.45.2.627.g7a2c4fd464-goog

