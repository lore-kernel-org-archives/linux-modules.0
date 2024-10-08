Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D0218D69
	for <linux-modules@vger.kernel.org>; Tue,  8 Oct 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412738; cv=none; b=qREDJaFnRt3IY4UIwNKbAa2GoajMpgwqRE7ZlAQGXEDuum8EwAKTBIUh47tp9EZtEuTZp+VN5b2O4JAr05Eko1TcF0/nyHZiSXKrG3XJJc2yxY+jJrPJqb2eygPmpSZLnZU5i+76oTQmIj+EecmR4bPiUlzXNqjweIuPGRuCm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412738; c=relaxed/simple;
	bh=5W4NnaWBh21tEB8jC/516T8HqqLQetbKzxXxh7N0Wcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lrxHnH/cSq8VuKzjTYs4WXvzdO6XiFqt2ZYfCMcTA2YSOGQ0m7SLmIzIt8+YZOFKF6VJIAF8daEpuRsfXCYBZtrwfl40OZlJHxFKvuOmyfuhF31SgtcyDeeHveFyuUdkuL7HOvqBgVXIaO1IvtpcG/aJ7ZxDuhKarYFtqu7RSOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6jBdezt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6jBdezt"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71dfd9fc0e5so2445020b3a.2
        for <linux-modules@vger.kernel.org>; Tue, 08 Oct 2024 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728412737; x=1729017537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GC9IxdNYQ5s89h9KldC7D7ygNlj7/6kTvjxiY5iu2+k=;
        b=a6jBdezt+DeVXi4+xF7mLDuCh96hDFA4K4s1ZWMV5JLKJtNsKT2+lXcz9wOmq9BFz4
         AO6U+TwynFAyXVUzp/91ihr4TeYDOLQqRDLG6stwJvEdnLCgyBoD33/J+BBq2QunIRGo
         +l5b+PJHYScKIgxzK6nInk2HFUbBg3vAcKgyYY+H3RzriKRZjLo5sw/UguRZP6nEk5tY
         cdgUoh8ZB/UFwJI/N+42mmZgRkGm3Rs37QmsSWYWthhnUHjP5S9K+rtW2M3dsdNzk3Uo
         N8miAVxi/B4It2LMJyMSUteukJGIZYxqKytIIJbAdyRmhmCgFJDpooj/UERKgE8NKMPc
         nQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412737; x=1729017537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GC9IxdNYQ5s89h9KldC7D7ygNlj7/6kTvjxiY5iu2+k=;
        b=Qr5InNKgritCzk663s9IcGDpTcI8r2rwajPCM6n4yYBMJvvXRHCHq7RHr38zE4SXyx
         da6Kc2PbtsiyrKObYdwseO0CG5PCDxVZW4JCoT1owqKJ3oOWS4bQgBHi6bfiremL4R+I
         lFZz+KWWnpm4Om2FaLSuorWqxKI4tvouoxn3cPanppGBQ0eWy+2y/1KvLTTMlFoPn2pj
         DUsnskc/0DiLSl/xXtfyYA3C2SzsUyF/+jlB6oRi5tzxIxxHJbrmHn5cMWQV5uNKJ/bb
         ukGRxyCXD/pM7wYR8JoW6ahz6eCLVCdDsEEuLrnzuAurp3rGRyNUG1i3lSRyl7I4wbTR
         viNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX15yABcGtEpm2tWpKdDnpmFBu3jVXVn/H5/T7vwEOvqwE81vOOo2Sh3Mww6/qUoHgt4lC74HyD/UZ6gGGD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7S4twSSTkn0gFJmulnaTGfN6x37RXWCowdSODShmiPu4qzJgA
	DyMA575sVM40IZYHU1WNmQ3FVTYcSE1PjHCSBzEh7970zZtHhUtbbj3HE8sOTFQuSqXripGwtWO
	socXpBBRUPWJ429as5yrI+ZciIw==
X-Google-Smtp-Source: AGHT+IEZ7EStY5c6my6qpz+1/bN8XdjA2O/ROJGFeFD06XOmiiKtukLKzGwRHycXHMhZArMgvL1TdNWRER0WY9E7H1s=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:318f:b0:71d:f1f9:b979 with
 SMTP id d2e1a72fcca58-71df1f9ba82mr20092b3a.3.1728412736553; Tue, 08 Oct 2024
 11:38:56 -0700 (PDT)
Date: Tue,  8 Oct 2024 18:38:35 +0000
In-Reply-To: <20241008183823.36676-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5132; i=samitolvanen@google.com;
 h=from:subject; bh=5W4NnaWBh21tEB8jC/516T8HqqLQetbKzxXxh7N0Wcc=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOmsNaob3u/aK5s4gWfLNos9ky8VnFticU58fdA0of0Wk
 3RNL0pv6ihlYRDjYJAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATMfnFyDDPnjvsjp5s2ss7
 P1OiXZ8abiws1T2nN6v6TvTp9/6PJX4yMnQvYl7If+10SVim0XLXn54LXxk79Z1lLJzUl/mwWaB Ojw8A
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008183823.36676-32-samitolvanen@google.com>
Subject: [PATCH v4 11/19] gendwarfksyms: Add die_map debugging
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Debugging the DWARF processing can be somewhat challenging, so add
more detailed debugging output for die_map operations. Add the
--dump-die-map flag, which adds color coded tags to the output for
die_map changes.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Neal Gompa <neal@gompa.dev>
---
 scripts/gendwarfksyms/dwarf.c         | 15 +++++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.c |  7 +++++++
 scripts/gendwarfksyms/gendwarfksyms.h | 13 +++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 51dd8e82f9e7..d67cac16f8fb 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -103,6 +103,8 @@ static void process(struct die *cache, const char *s)
 	if (dump_dies)
 		fputs(s, stderr);
 
+	if (cache)
+		die_debug_r("cache %p string '%s'", cache, s);
 	die_map_add_string(cache, s);
 }
 
@@ -552,6 +554,8 @@ static void process_cached(struct state *state, struct die *cache,
 	list_for_each_entry(df, &cache->fragments, list) {
 		switch (df->type) {
 		case FRAGMENT_STRING:
+			die_debug_b("cache %p STRING '%s'", cache,
+				    df->data.str);
 			process(NULL, df->data.str);
 			break;
 		case FRAGMENT_LINEBREAK:
@@ -561,6 +565,8 @@ static void process_cached(struct state *state, struct die *cache,
 			if (!dwarf_die_addr_die(dwarf_cu_getdwarf(die->cu),
 						(void *)df->data.addr, &child))
 				error("dwarf_die_addr_die failed");
+			die_debug_b("cache %p DIE addr %" PRIxPTR " tag %x",
+				    cache, df->data.addr, dwarf_tag(&child));
 			check(process_type(state, NULL, &child));
 			break;
 		default:
@@ -651,6 +657,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	cache = die_map_get(die, want_state);
 
 	if (cache->state == want_state) {
+		die_debug_g("cached addr %p tag %x -- %s", die->addr, tag,
+			    die_state_name(cache->state));
+
 		if (want_state == DIE_COMPLETE && is_expanded_type(tag))
 			cache_mark_expanded(&state->expansion_cache, die->addr);
 
@@ -661,6 +670,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		return 0;
 	}
 
+	die_debug_g("addr %p tag %x -- %s -> %s", die->addr, tag,
+		    die_state_name(cache->state), die_state_name(want_state));
+
 	switch (tag) {
 	/* Type modifiers */
 	PROCESS_TYPE(atomic)
@@ -696,6 +708,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		error("unexpected type: %x", tag);
 	}
 
+	die_debug_r("parent %p cache %p die addr %p tag %x", parent, cache,
+		    die->addr, tag);
+
 	/* Update cache state and append to the parent (if any) */
 	cache->tag = tag;
 	cache->state = want_state;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index 310cc9257d6e..d40692a703bb 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.c
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -19,6 +19,8 @@
 int debug;
 /* Dump DIE contents */
 int dump_dies;
+/* Print debugging information about die_map changes */
+int dump_die_map;
 
 static void usage(void)
 {
@@ -26,6 +28,7 @@ static void usage(void)
 	      "Options:\n"
 	      "  -d, --debug          Print debugging information\n"
 	      "      --dump-dies      Dump DWARF DIE contents\n"
+	      "      --dump-die-map   Print debugging information about die_map changes\n"
 	      "  -h, --help           Print this message\n"
 	      "\n",
 	      stderr);
@@ -74,6 +77,7 @@ int main(int argc, char **argv)
 
 	struct option opts[] = { { "debug", 0, NULL, 'd' },
 				 { "dump-dies", 0, &dump_dies, 1 },
+				 { "dump-die-map", 0, &dump_die_map, 1 },
 				 { "help", 0, NULL, 'h' },
 				 { 0, 0, NULL, 0 } };
 
@@ -93,6 +97,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (dump_die_map)
+		dump_dies = 1;
+
 	if (optind >= argc) {
 		usage();
 		error("no input files?");
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 6147859ae2af..126916e85ee0 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -24,6 +24,7 @@
  */
 extern int debug;
 extern int dump_dies;
+extern int dump_die_map;
 
 /*
  * Output helpers
@@ -46,6 +47,18 @@ extern int dump_dies;
 		exit(1);                                     \
 	} while (0)
 
+#define __die_debug(color, format, ...)                                 \
+	do {                                                            \
+		if (dump_dies && dump_die_map)                          \
+			fprintf(stderr,                                 \
+				"\033[" #color "m<" format ">\033[39m", \
+				__VA_ARGS__);                           \
+	} while (0)
+
+#define die_debug_r(format, ...) __die_debug(91, format, __VA_ARGS__)
+#define die_debug_g(format, ...) __die_debug(92, format, __VA_ARGS__)
+#define die_debug_b(format, ...) __die_debug(94, format, __VA_ARGS__)
+
 /*
  * Error handling helpers
  */
-- 
2.47.0.rc0.187.ge670bccf7e-goog

