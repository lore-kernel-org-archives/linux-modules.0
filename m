Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87571BD51F
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743577; cv=none; b=rKq3r5Sud5racsrqY5pgN7bIv+gFnlJRx9ZUCwJ2cKrrPfHGUFBilkEKUb70TmNlWy0ChNNqQicAmJ8b5ySRl2WHkMfxFh6KZapngSn6FU4b1wyrlfUHlolC5OuvTyQQd2c4N+Sf0lCGZpIkA+rfKlPSdwgoPlCSDHsfmUc39Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743577; c=relaxed/simple;
	bh=1jJqo9o9aQH+E0GjG/ROahqjvj9Bo5ZqYdph8BSQRt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hw9j2os+t/yjs3TB9i/c4m3zKQxS7vlitro8Bz0+iJfQsOAESWiS7F7bimj1q4nlFakfkmG9H8kwOaNCRwTnKP9sqxMujgmldu2S07T9FNpw5tE7WX0zlCdVrLaakKnGU/c1RDVU7y/wuXfLEaxb5vquoqrQxloBhpxbUS0lRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZaHQqBH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZaHQqBH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fd9a0efe4eso10132255ad.0
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743575; x=1724348375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtbsIaIfhBiE1DbP5u+JRQZBtsqBwwZART8vtMh98sw=;
        b=JZaHQqBHQ8g6oatqcBrmCMmZdtVOOa78cVVRTvXj52y+P42i/0rKH+On7UefoKYCh3
         AsTI/Av+lWN5icxUuFk392Ph+QbaasPydbuVRIL4SqklPXummpWmYdgvW89/l5QAE41M
         8um2uFJJD8EDdg5A945eiktS5+EkUSHDzAv6H1iXGNpnTcGH9+6s0jn7x/UHGdo3MizN
         3f+9ZwhwaqkqVGVs/dnj4U7XfBfyy5/lW/lTO5sEVraGmMkNfJN6k+T/V752xAgM5b+G
         Cz+s4CyIl2bAPBE73nZYl68U8aUWAj/NLemoD9cSEcG4HotoOBjDmsCfPIRLtSNSE/Uq
         tC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743575; x=1724348375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtbsIaIfhBiE1DbP5u+JRQZBtsqBwwZART8vtMh98sw=;
        b=hls2oSQTqjy30g7P0XqpuA0nFvChL1f+e903pLvXqoHU2CrwqMJsbAxVNuLVlO0dyu
         4pbq+geGy9ANFo4Nmx+UIcxQahiKS6fTeyc0OvGYcvtLiKzpUjBxZZfqdJc+tapzHU/F
         1T8vbhoP2FhGFoJzZ9LbvAISsmjsgZEQepqJNRYZgLlGrbWbjLVJGfFm5Fq1K7SARa0k
         V1xjF75HoZ//qYgJeyHsXZhOUW8y5M/cfI2GjTdBIh+U4R/9Ej61SwPtKMHfjHh0ISca
         Zm7Zv8Vno5Qpi0mlBCbMwSILKhWqTbWiy9pyC7XpNqOLHAH/kplzteT+MsMqu0yIQr2j
         02iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHWQ8QN7ao4Fn9OPxr33vBce9ZYVQYVe+EGZswGyTUfyVS5j/2ORycE1rIvZDy5X0ZnSofpndhz96FqlnXLE2Ih04X9MaqvwxUCVwgAg==
X-Gm-Message-State: AOJu0Yw4IW11hF1oHbehnNzSWa5YHG7ulDYm6hdim6KpjBc9xeNBZrKM
	EFTdu9r62PURaAjo04yS7I78vI2wLQDXQUeov/ugBdwTGqfrScltXX1RJpHgTXAVXkPqiItLvgF
	gTlm+8OQ4aA9c+0F6aKSyf77aPw==
X-Google-Smtp-Source: AGHT+IF2vutxQWYsriPKvF7iI6jHIZpZUjx/Iv3JjPdtDdO8O3OmwJ4gQIgzjZnRFjJRknlMxQakessYN+u5iq/0Q34=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:da8a:b0:1fb:8c26:4b17 with
 SMTP id d9443c01a7336-20203f31506mr8565ad.9.1723743574840; Thu, 15 Aug 2024
 10:39:34 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:39:16 +0000
In-Reply-To: <20240815173903.4172139-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5220; i=samitolvanen@google.com;
 h=from:subject; bh=1jJqo9o9aQH+E0GjG/ROahqjvj9Bo5ZqYdph8BSQRt0=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmvj05p4mX3gDUPwZMYwEx1Enne0Ag7prR0Wlf9
 GzJChEBdZ6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZr49OQAKCRBMtfaEi7xW
 7s/sC/9MpvmBZcBA9Rv5mHdI+WO1ut2X7/+YdUhXZtWBz5unbj8Q0jRG1WT0/AAKbXHhGFhIEMC
 X48h5BwZq8SlLLyqhRsZjVyp1HsmW2h+tl+Q4fUPl1fF5p+jdUakcqxl6m3nZF4lsL+9NWu5JyZ
 s+ui6D+VRcrnaanyw68hKvjPehdgh16dBL4JBaEkHwFZcb6kUfewAwnLS73rV/+mpMEtt/eppVg
 tcYwIelS5xQcn7l/B47w0V3vpKEmoubCXJePF1QGoDIsei9LcUbRJdMpJhMXJ8Cl2FmxhVMXbrX
 dfWpegajVmmUL3KBFjw6ew3AbdEJ7YR/K7ZGcEgik61UJ4FATwBDbBpxNmn3WOVQfo+6u4iEgwc
 9sfUaIROxzykz0kzS8LTmURr4Rlboz2p+03LGzJRfTTfJC5Tfuxx/NXCRoO//+HDGfTJyhzUtM9 pIwZNM8rkonwJS7VzTs8pRDeL9rC5MF5DV664B/DXAxhOoyHXXefgyDXA8e87h3bmm6Hk=
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815173903.4172139-33-samitolvanen@google.com>
Subject: [PATCH v2 12/19] gendwarfksyms: Add die_map debugging
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Debugging the DWARF processing can be somewhat challenging, so add
more detailed debugging output for die_map operations. Move parsed
die_map output behind --dump-dies to clean up the --debug output, and
add a --dump-die-map flag, which adds highlighted tags to the output
about die_map operations.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/dwarf.c         | 19 +++++++++++++++++--
 scripts/gendwarfksyms/gendwarfksyms.c |  9 +++++++++
 scripts/gendwarfksyms/gendwarfksyms.h | 14 ++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 2f1601015c4e..9bca21a71639 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -84,15 +84,17 @@ static int process(struct state *state, struct die *cache, const char *s)
 {
 	s = s ?: "<null>";
 
-	if (debug && do_linebreak) {
+	if (dump_dies && do_linebreak) {
 		fputs("\n", stderr);
 		for (int i = 0; i < indentation_level; i++)
 			fputs("  ", stderr);
 		do_linebreak = false;
 	}
-	if (debug)
+	if (dump_dies)
 		fputs(s, stderr);
 
+	if (cache)
+		die_debug_r("cache %p string '%s'", cache, s);
 	return check(die_map_add_string(cache, s));
 }
 
@@ -510,6 +512,8 @@ static int process_cached(struct state *state, struct die *cache,
 	while (df) {
 		switch (df->type) {
 		case STRING:
+			die_debug_b("cache %p STRING '%s'", cache,
+				    df->data.str);
 			check(process(state, NULL, df->data.str));
 			break;
 		case LINEBREAK:
@@ -522,6 +526,8 @@ static int process_cached(struct state *state, struct die *cache,
 				error("dwarf_die_addr_die failed");
 				return -1;
 			}
+			die_debug_b("cache %p DIE addr %" PRIxPTR " tag %d",
+				    cache, df->data.addr, dwarf_tag(&child));
 			check(process_type(state, NULL, &child));
 			break;
 		default:
@@ -619,6 +625,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	check(die_map_get(die, want_state, &cache));
 
 	if (cache->state == want_state) {
+		die_debug_g("cached addr %p tag %d -- %s", die->addr, tag,
+			    die_state_name(cache->state));
+
 		if (want_state == COMPLETE && is_expanded_type(tag))
 			check(cache_mark_expanded(&state->expansion_cache,
 						  die->addr));
@@ -630,6 +639,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		return 0;
 	}
 
+	die_debug_g("addr %p tag %d -- INCOMPLETE -> %s", die->addr, tag,
+		    die_state_name(want_state));
+
 	switch (tag) {
 	/* Type modifiers */
 	PROCESS_TYPE(atomic)
@@ -665,6 +677,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		return -1;
 	}
 
+	die_debug_r("parent %p cache %p die addr %p tag %d", parent, cache,
+		    die->addr, tag);
+
 	/* Update cache state and append to the parent (if any) */
 	cache->tag = tag;
 	cache->state = want_state;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index 55a7fc902bf4..1349e592783b 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.c
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -16,6 +16,10 @@
 
 /* Print out debugging information to stderr */
 bool debug;
+/* Print out die_map contents */
+bool dump_dies;
+/* Print out inline debugging information about die_map changes */
+bool dump_die_map;
 
 static const struct {
 	const char *arg;
@@ -23,6 +27,8 @@ static const struct {
 	const char **param;
 } options[] = {
 	{ "--debug", &debug, NULL },
+	{ "--dump-dies", &dump_dies, NULL },
+	{ "--dump-die-map", &dump_die_map, NULL },
 };
 
 static int usage(void)
@@ -111,6 +117,9 @@ int main(int argc, const char **argv)
 	if (parse_options(argc, argv) < 0)
 		return usage();
 
+	if (dump_die_map)
+		dump_dies = true;
+
 	check(symbol_read_exports(stdin));
 
 	for (n = 0; n < object_count; n++) {
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 6482503e7d6e..7cd907e3d5e3 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -20,6 +20,8 @@
  * Options -- in gendwarfksyms.c
  */
 extern bool debug;
+extern bool dump_dies;
+extern bool dump_die_map;
 
 #define MAX_INPUT_FILES 128
 
@@ -40,6 +42,18 @@ extern bool debug;
 #define warn(format, ...) __println("warning: ", format, ##__VA_ARGS__)
 #define error(format, ...) __println("error: ", format, ##__VA_ARGS__)
 
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
2.46.0.184.g6999bdac58-goog

