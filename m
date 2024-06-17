Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BF198E90
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647120; cv=none; b=bC7JpfPSBgeeNkIl5AoG79bBglqt37g0IeJAx6xnVowroISBEw9bdWWfRTOT2G6N7DRQaiMVP3+GOFlFVSocQ3XjFMHrSPTB+ITSZj0/VNSyqA8fhFFhCtZScgBpsJRRYQMy6NCuswkGoW2/2cwjfqGIxdDH0Z1fDHkIleqppXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647120; c=relaxed/simple;
	bh=kOMHom4gVs6RWKcDfBpdNRS2iu22iu6ooQQly4TUfUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rK4515sscapiZc1rNMv2SC9ecG8Xy5GJaprn/ZsZIDo4FCNWC1YGSwzFnAgQXJDT4CyU3iMCHJ/oRS3fyyIqXp7ZBf9pqGJDeKBrtubxRswUqRPpao8Q3zA8I4pb6td8JomJPNjaDsra0iyqwtokmPVBQEj82SiWnqSBporDyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xspmofmy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xspmofmy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-704d99cb97aso2299775a12.0
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647118; x=1719251918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixi9Tabuy3CnXqRjT8zQOnb7QNjznqM/C/Fa/bP10ZY=;
        b=xspmofmyeDGriIAwGWcwVkqw6RgdBV/qF5v7/ZtkdtI4fE1x0LBchGLfRVFWdY79Ad
         wuHog5giJVrYIeAua/bMxckf5wTPh4X+iTMhPn+mz8tz/Hgmb82kfJ7JP2M4cDPJS/+O
         S52BbZrIIa7m2R2UdqxomhjH8UOTvhwEwU7fUzgrmrhJgKzJyvueqJ4Nn53gRtr0CsiF
         3p06fOkUFLN21a1wCB2VI44++RLOgek26jIm4/zOUEtQH8mcrDFMjGJaitO/k+9NLLBr
         7DzTsasqyrNnY5/9J+wN+nV+C/aoOLWEwEi6vrE0j6KzeBH1i96raq+dWCfXL+BgWUTr
         uymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647118; x=1719251918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixi9Tabuy3CnXqRjT8zQOnb7QNjznqM/C/Fa/bP10ZY=;
        b=LNcuiXzbHVgsEEowfW2n1bppxyWqEGu8DWsyN2mJmmtrRQiCsV5i9b4HDh6zCcN81j
         IEiTxRAskImMSOMNwlxDxa8hPfGMQiOjnuQVhFgo1ygxt9xMW/b9PPz7hflzNm4Wdc+u
         C62UQOUKdvZ+yuL4e4nPTa94L1utqpep9X1x6kQIqajUCxr3UabRypFr/huKTVtEEiQk
         jDAu/gMJAt4PwkgmYj/t3Q7Ju/J+uB1YdzLYSyryUYoZh2+n3kwMw3YX85BQbxUH3WsN
         5Rzeod1hT79ALAdviprSu0VUPdN4blHIcfIeFpNSDxuU9f7o3y8w67pnFoLBbjTJLGKi
         RWPw==
X-Forwarded-Encrypted: i=1; AJvYcCULl3AZNob/n8J0RiMpFwKsmsKX6JhvI5X5rXMtm8DHVE6gYmnldil0vbg2TXymbRrYFXNQ03FUnBCP2rd0goxkogo1mohUuF3+UcKxJA==
X-Gm-Message-State: AOJu0YxGv230S6ewxLVXvCNgX58FNOBvt5M5aSXyUsifpJ5oR/WxV4db
	BeTgN31TqWV80mAxBIJiiegK0TMf9ju6boLXcHppU0JzC2tnKjRzP3EXZ1aB/2pK6uD+SsRZ1JS
	coKIiKpZM8A+1hwcWzUBekqYx5A==
X-Google-Smtp-Source: AGHT+IHCicmwZJWS4aDIb3BbC3DAPBGOj6Uu7pMNETbNCKIL0/2phEEyDM9aUx9nahpwEuqkTnqYVTgXJDHFS5dGtRE=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:3805:b0:2c2:e31f:4993 with
 SMTP id 98e67ed59e1d1-2c4db1290e1mr93429a91.1.1718647118108; Mon, 17 Jun 2024
 10:58:38 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:26 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4937; i=samitolvanen@google.com;
 h=from:subject; bh=kOMHom4gVs6RWKcDfBpdNRS2iu22iu6ooQQly4TUfUg=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk7Ef8A7+1CNTp+xTArVDN7sEYreWBUSNkp9
 TVNkF3AYoCJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5OwAKCRBMtfaEi7xW
 7tNsC/98cAuLslmd+4Vd5IBw4994Ko9bAeysBor5ueyKAcXwQpGYIqjZj0NvnZLLCZg/oL3Xosc
 uoUipBkaRPOKghNoyqI7XdVu6APJ67S31vUAwF4hZcRgokl0OL/yJKGUPwR7h53D8W95x5mI/Vf
 m69dnikfR+AtcGLWxc3KhwXDyGMdVNljI8wyBN1gVqNjv8kzbfchz6hN3FpMcRMaj7765Em0YDS
 JUSrEtfHjbl7H/5Y+hA6X4zq+vp1E3eMbmoFsVHWOwh4VciTS0/pr2mYff1clG+BkKDnnANvONd
 xIej9xyI/krErEkjZ0eLzdPQGl57LOfArJAEvq2Zq1C3NZYOKPc19Vd6RfGcQJ18Nv61MmyM3ap
 3HA0Lbi0VxYosETLOKMlLe/tmfaHrPOYgGglhWHH1Pc+IEaF3PHk7nWZMyVEJBc1BTe5kJmAXA/ 4DftpiisZcdK5MX40dWQDJvyfSjze/FkW3F27y0MpgDzmn6jsJg2MJtBOpGENqZIhu2CI=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-24-samitolvanen@google.com>
Subject: [PATCH 07/15] gendwarfksyms: Add pretty-printing
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add linebreaks and indentation to --debug output. This will be
particularly useful for more complex structures.

Example output with --debug:

  variable pointer_type <unnamed> {
    base_type char byte_size(1)
  };

And the same with --debug --no-pretty-print:

  variable pointer_type <unnamed> {base_type char byte_size(1)};

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/gendwarfksyms/cache.c         | 13 +++++++++++++
 tools/gendwarfksyms/gendwarfksyms.c |  3 +++
 tools/gendwarfksyms/gendwarfksyms.h |  5 ++++-
 tools/gendwarfksyms/types.c         | 22 ++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/gendwarfksyms/cache.c b/tools/gendwarfksyms/cache.c
index 9adda113e0b6..85a2adeb649d 100644
--- a/tools/gendwarfksyms/cache.c
+++ b/tools/gendwarfksyms/cache.c
@@ -133,6 +133,19 @@ int cache_add_string(struct cached_die *cd, const char *str)
 	return 0;
 }
 
+int cache_add_linebreak(struct cached_die *cd, int linebreak)
+{
+	struct cached_item *ci;
+
+	if (!cd)
+		return 0;
+
+	check(append_item(cd, &ci));
+	ci->data.linebreak = linebreak;
+	ci->type = LINEBREAK;
+	return 0;
+}
+
 int cache_add_die(struct cached_die *cd, Dwarf_Die *die)
 {
 	struct cached_item *ci;
diff --git a/tools/gendwarfksyms/gendwarfksyms.c b/tools/gendwarfksyms/gendwarfksyms.c
index 38ccaeb72426..7095f0ecccab 100644
--- a/tools/gendwarfksyms/gendwarfksyms.c
+++ b/tools/gendwarfksyms/gendwarfksyms.c
@@ -17,6 +17,8 @@
 bool debug;
 /* Don't use caching */
 bool no_cache;
+/* Don't pretty-print (with --debug) */
+bool no_pretty_print;
 
 static const struct {
 	const char *arg;
@@ -24,6 +26,7 @@ static const struct {
 } options[] = {
 	{ "--debug", &debug },
 	{ "--no-cache", &no_cache },
+	{ "--no-pretty-print", &no_pretty_print },
 };
 
 static int usage(void)
diff --git a/tools/gendwarfksyms/gendwarfksyms.h b/tools/gendwarfksyms/gendwarfksyms.h
index d5ebfe405445..43eff91e2f2f 100644
--- a/tools/gendwarfksyms/gendwarfksyms.h
+++ b/tools/gendwarfksyms/gendwarfksyms.h
@@ -19,6 +19,7 @@
  */
 extern bool debug;
 extern bool no_cache;
+extern bool no_pretty_print;
 
 /*
  * Output helpers
@@ -76,12 +77,13 @@ extern void symbol_print_versions(void);
 /*
  * cache.c
  */
-enum cached_item_type { EMPTY, STRING, DIE };
+enum cached_item_type { EMPTY, STRING, LINEBREAK, DIE };
 
 struct cached_item {
 	enum cached_item_type type;
 	union {
 		char *str;
+		int linebreak;
 		uintptr_t addr;
 	} data;
 	struct cached_item *next;
@@ -99,6 +101,7 @@ struct cached_die {
 extern int cache_get(Dwarf_Die *die, enum cached_die_state state,
 		     struct cached_die **res);
 extern int cache_add_string(struct cached_die *pd, const char *str);
+extern int cache_add_linebreak(struct cached_die *pd, int linebreak);
 extern int cache_add_die(struct cached_die *pd, Dwarf_Die *die);
 extern void cache_free(void);
 
diff --git a/tools/gendwarfksyms/types.c b/tools/gendwarfksyms/types.c
index 27169c77937f..74b3755c3e16 100644
--- a/tools/gendwarfksyms/types.c
+++ b/tools/gendwarfksyms/types.c
@@ -6,6 +6,17 @@
 #include "gendwarfksyms.h"
 #include "crc32.h"
 
+static bool do_linebreak;
+static int indentation_level;
+
+/* Line breaks and indentation for pretty-printing */
+static int process_linebreak(struct cached_die *cache, int n)
+{
+	indentation_level += n;
+	do_linebreak = true;
+	return check(cache_add_linebreak(cache, n));
+}
+
 #define DEFINE_GET_ATTR(attr, type)                                    \
 	static bool get_##attr##_attr(Dwarf_Die *die, unsigned int id, \
 				      type *value)                     \
@@ -76,6 +87,12 @@ static int process(struct state *state, struct cached_die *cache, const char *s)
 {
 	s = s ?: "<null>";
 
+	if (debug && !no_pretty_print && do_linebreak) {
+		fputs("\n", stderr);
+		for (int i = 0; i < indentation_level; i++)
+			fputs("  ", stderr);
+		do_linebreak = false;
+	}
 	if (debug)
 		fputs(s, stderr);
 
@@ -196,7 +213,9 @@ static int __process_type(struct state *state, struct cached_die *cache,
 	check(process(state, cache, type));
 	check(process_fqn(state, cache, die));
 	check(process(state, cache, " {"));
+	check(process_linebreak(cache, 1));
 	check(process_type_attr(state, cache, die));
+	check(process_linebreak(cache, -1));
 	check(process(state, cache, "}"));
 	check(process_byte_size_attr(state, cache, die));
 	return check(process_alignment_attr(state, cache, die));
@@ -241,6 +260,9 @@ static int process_cached(struct state *state, struct cached_die *cache,
 		case STRING:
 			check(process(state, NULL, ci->data.str));
 			break;
+		case LINEBREAK:
+			check(process_linebreak(NULL, ci->data.linebreak));
+			break;
 		case DIE:
 			if (!dwarf_die_addr_die(state->dbg,
 						(void *)ci->data.addr,
-- 
2.45.2.627.g7a2c4fd464-goog

