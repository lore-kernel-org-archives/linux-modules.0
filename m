Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEA1DE889
	for <linux-modules@vger.kernel.org>; Thu, 21 Nov 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221776; cv=none; b=VC+6hEwYYf7OdUAS+mGJGiZuLC3zDwswjdnqsWFzePqmkzqESAnvK89uqsA4Ladg3ua+O8/d7DCW5wGuIyexEj/nVxXVTMpGmcLybDwxhmWp3dKcRzah1FoeIKdN7OFalEIWyOO6qdC83O5w1PsM1/JbEy8cqTVUVGc4A2HAT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221776; c=relaxed/simple;
	bh=ZtfhRREvYeeJIRTnypn2kVeALnWdluQMXmr8x8azY3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P26ouG1UdCl2xPh/0Dcz7SDgKm8dnD62Ze3BI/HRC6nznPuQxbURyHA5tTmcqDEftNo+q+vn9NYj8suwVXvw6fG72Z94de8iTa6oG6ORQGaxcqhLYJrw75Vn6ZO3SfVH3Z0t7UERRStomILZgIkjuO5tpluYVu+nTVwyrz5KEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lasm8BwA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lasm8BwA"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e388f173db4so2543034276.3
        for <linux-modules@vger.kernel.org>; Thu, 21 Nov 2024 12:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732221773; x=1732826573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wO2hIdiG7CrcRjoffVNYAvcAwiMWtXmgICIm5eEBWSg=;
        b=Lasm8BwA2daDeeKXB/tNlZKoSwjc+Ey/TosZTho/SYTUPlfVt1Jcf/kURVZM2LyP3y
         hUjUKo4Fu5GVcC/37xobiWik5CZyX+tuuS8+3QSbzxjoBTeTuUlap/C+UU/pVRIWcqcJ
         SJuytnz0E7RoQyRJpzOW0v4uxcg5BJmEMAIIXb1uohv7o7MMyQ3XuLdkEhoJuZBHMJBS
         R7koDXxBDQoaSIZx6u/IcknTzVDl3FlueT2oriHaG14gaIogcuDLboO6TJEy144kSmuj
         StF5iJKSCsvjPaU+/uCGKHIEGxODM7uuFnWirYiaOjA9w/IRiMSUa51ryNhOJXacFjsi
         Ju7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221773; x=1732826573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wO2hIdiG7CrcRjoffVNYAvcAwiMWtXmgICIm5eEBWSg=;
        b=miKKjp6Vm5EcJp9xJTnffyfm4+BYoYnueMKiZ0IX22Ng4rvTAF5ia+JvWtaQv8QHJg
         a2OP7WiP0cqn6QNJ0dfJ6fOlhbaT4yMcyDU1AgYM3n/xglUnec7644pmxX9lGcI85nIK
         vTDfLqvRvC4bSa+puqklrKXKZH+pZScYYrqUoA7I4PG4vmHUS5ou8SDHBxED+WPWviXv
         fY8FwmCqxpApg7fJsGusTswJsZ+8CElWKUR9rPEnUq1VQ8iB4HyOT++d3pstGQH7lFFM
         rWiba1lH80zC3MeRd+jyBaQ0ELGjFq6fjbzlcrTXqVNLc4TSeKnsUmWrR87JX7FWTHOG
         UWDw==
X-Forwarded-Encrypted: i=1; AJvYcCX4QkMo2grWLn7Z9jcssgAkBmRihStyM3IyiNe/ftSatK0Yjsss3uk5MEMUaSejajZ95av5fVkrEzFu1c7j@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0S63AP/IHxQAHKRbtdv21/2GdN/W3B2agZhZOb2iLqTI7Q6h
	/nFFUc2W3JUdOHA5k6o5wiXgWXwLj3F+i/ijC0dsmSPhpcQUgSXfoI0Hc6hLho2cmYJJ76l/gAd
	y4dmc/Nxz5Q9SmN5y72cXpMAafQ==
X-Google-Smtp-Source: AGHT+IGsvhnsnrZz7y6skRItADeCqn8aWPQ51xtGa1NURNHB9v1UiuF4WhjQJfrq8s7XEv92esfmgAi1sMsb7EbrY8A=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:9a43:0:b0:e38:164f:5bf2 with SMTP
 id 3f1490d57ef6-e38f8bffec0mr123276.9.1732221772935; Thu, 21 Nov 2024
 12:42:52 -0800 (PST)
Date: Thu, 21 Nov 2024 20:42:31 +0000
In-Reply-To: <20241121204220.2378181-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5088; i=samitolvanen@google.com;
 h=from:subject; bh=ZtfhRREvYeeJIRTnypn2kVeALnWdluQMXmr8x8azY3w=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOn2s42iDr5bcna6UMhtz/d1vz0EFWw31nZeKz9+w7Td+
 fnVqreTO0pZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEFq9mZLhUXOVTfsaB82X1
 PA/2x6LfVh2N8vjcLdgjzXHt8ROFyicM/zSN1+99Kqzcuuxl92+vXz3B7G93+D8TFvi6+qiNmYM ELzcA
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121204220.2378181-30-samitolvanen@google.com>
Subject: [PATCH v6 10/18] gendwarfksyms: Add die_map debugging
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
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c         | 15 +++++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.c |  7 +++++++
 scripts/gendwarfksyms/gendwarfksyms.h | 13 +++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 3ea7583e6c3f..cf6d2c2844dc 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -145,6 +145,8 @@ static void process(struct die *cache, const char *s)
 	if (dump_dies)
 		fputs(s, stderr);
 
+	if (cache)
+		die_debug_r("cache %p string '%s'", cache, s);
 	die_map_add_string(cache, s);
 }
 
@@ -593,6 +595,8 @@ static void process_cached(struct state *state, struct die *cache,
 	list_for_each_entry(df, &cache->fragments, list) {
 		switch (df->type) {
 		case FRAGMENT_STRING:
+			die_debug_b("cache %p STRING '%s'", cache,
+				    df->data.str);
 			process(NULL, df->data.str);
 			break;
 		case FRAGMENT_LINEBREAK:
@@ -602,6 +606,8 @@ static void process_cached(struct state *state, struct die *cache,
 			if (!dwarf_die_addr_die(dwarf_cu_getdwarf(die->cu),
 						(void *)df->data.addr, &child))
 				error("dwarf_die_addr_die failed");
+			die_debug_b("cache %p DIE addr %" PRIxPTR " tag %x",
+				    cache, df->data.addr, dwarf_tag(&child));
 			check(process_type(state, NULL, &child));
 			break;
 		default:
@@ -670,6 +676,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	cache = die_map_get(die, want_state);
 
 	if (cache->state == want_state) {
+		die_debug_g("cached addr %p tag %x -- %s", die->addr, tag,
+			    die_state_name(cache->state));
+
 		process_cached(state, cache, die);
 		die_map_add_die(parent, cache);
 
@@ -677,6 +686,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		return 0;
 	}
 
+	die_debug_g("addr %p tag %x -- %s -> %s", die->addr, tag,
+		    die_state_name(cache->state), die_state_name(want_state));
+
 	switch (tag) {
 	/* Type modifiers */
 	PROCESS_TYPE(atomic)
@@ -712,6 +724,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 		error("unexpected type: %x", tag);
 	}
 
+	die_debug_r("parent %p cache %p die addr %p tag %x", parent, cache,
+		    die->addr, tag);
+
 	/* Update cache state and append to the parent (if any) */
 	cache->tag = tag;
 	cache->state = want_state;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index 7552fde495ef..ed6d8c585268 100644
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
index 7b29d8f07aa0..10fb476a7b76 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -26,6 +26,7 @@
  */
 extern int debug;
 extern int dump_dies;
+extern int dump_die_map;
 
 /*
  * Output helpers
@@ -48,6 +49,18 @@ extern int dump_dies;
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
2.47.0.371.ga323438b13-goog

