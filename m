Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A6C2E0
	for <linux-modules@vger.kernel.org>; Sat, 23 Nov 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732321164; cv=none; b=tcyk5KCAgg4iaP6WuWyt61Y5H3z+3q6P9yEX5Ncqzb2RKf4m2dJc0fLL96Knp7TRqv5TmF/VVH/DGfIN81BlDy47JjWIumce4DA+JEPweA9n0he2dOJYZkRNDme8W0zoZuRvlvShsNRXz1SDZj8r9k2KyhVJf7VnTNgl5eqRi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732321164; c=relaxed/simple;
	bh=0yX0O56Cy9DjD1BN27Ou2NLL8xBazcNKqhkhwB+1Elo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IG+PjGmQjLtb3ff9wBQOWEOPR8Tr0h7GNhPcyVAQ9r3cYb9YVtvP6D6BvA+FdZkjig4wm/AZ9elsFOCex47gLf1iutuBAX9BelZazEj5UFd/UrjMl4dakfaMsrxnXei9U8DNVgHnzIXmLJt9z7CW8IV0ZS+t/iA+TnOQWFdIEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGoyDx/p; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGoyDx/p"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3884e5e828so4796347276.3
        for <linux-modules@vger.kernel.org>; Fri, 22 Nov 2024 16:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732321161; x=1732925961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp/DQHT9ajDejoGv2qWHIWzSG+xRkTc6NeDxcpejopM=;
        b=PGoyDx/prd8NN8YvB7C93jZI/uGmAr2uN7UYF4lyoAFGr0MrPDFqE0749j3H/jaybt
         bitvIfEEO0DyEnIbldcYvn7xbXvMe4aaMyvfzWegiu4YKI8Se+HoZPku0Gg1Afx2x1KQ
         +aVWBi5lteBRQbC72nOzxuIdnnNNRgByxUZwwE7EV+yLSQkk04oOPVAh4CqKBsJLsU9q
         pqY34SbKJsgjlRWFCEF8yh0UP2csLpwuD20mx7vmQ3dUfYsGg5s4W5fSEnruCcYI330c
         kV22JTj4571aj5+OgiQkS0Ex629DpHNclERthCsaZJxlc+ec7g6G3zAOl7CKMH4XYYey
         HPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732321161; x=1732925961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp/DQHT9ajDejoGv2qWHIWzSG+xRkTc6NeDxcpejopM=;
        b=OwIKvlIjoUvoWWGCeuF0GLi7ygTwXo0rb7NKyRZh92VT7l/TdXhFe/q9DaLNOdRofx
         HplA+mwOBDKN4mrL1Xx9+kvghQwIZMN4sZikBo/EXONDT6Ucf+AUBDYm2c99ZGfc4LZ3
         C4Iwlg5oWJNEzycz1oRYun2TQf4wVTfY2RwHalap1CchAGWUfZVq1H+CVyd0MYfLmmpy
         WZqZjYk50t9q5MgVROfGhHXgy+ppcKz7YXt02+1cH8ojWeUa2s/lLMnV5ttY8FsYyig5
         y874P1El6xPJ5qkKOLGSbt7cIItzi/EB+AqTBJWqZlKmIMLxvYf0f7xeHR/9kS3keDBm
         e0zw==
X-Forwarded-Encrypted: i=1; AJvYcCWai+J121FmcWrlboR9pl31/qLI+mjhnKhtQhOmbh0Gla83KD2Na2dYyXaVkAiPub2CZwXf82lztV2acCCh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8rwC4Rzd1QY0ysXKJLataWyk5SzaJorPEMejhYNDqDFnsuGB
	972zetsbdVfYDbjPrX1ywtv/pTcHR44s9S9XscRjrIQMwTk+aG+rE7k+vxoE1X7EYQ9vaZ/Mnh6
	unu8HsA==
X-Google-Smtp-Source: AGHT+IFuSLZGc60ostLOU1k2OiwHArN8p4rGSAZKGq+sEAZLzYGueiQ4iVD6+faW9zxR2K/RMUCSN+U/O/4d
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:d651:0:b0:e2e:3328:7a00 with SMTP id
 3f1490d57ef6-e38fb5b40f4mr6735276.3.1732321161087; Fri, 22 Nov 2024 16:19:21
 -0800 (PST)
Date: Sat, 23 Nov 2024 00:18:59 +0000
In-Reply-To: <20241123-extended-modversions-v9-0-bc0403f054bf@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241123-extended-modversions-v9-0-bc0403f054bf@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241123-extended-modversions-v9-2-bc0403f054bf@google.com>
Subject: [PATCH v9 2/5] modpost: Produce extended MODVERSIONS information
From: Matthew Maurer <mmaurer@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Generate both the existing modversions format and the new extended one
when running modpost. Presence of this metadata in the final .ko is
guarded by CONFIG_EXTENDED_MODVERSIONS.

We no longer generate an error on long symbols in modpost if
CONFIG_EXTENDED_MODVERSIONS is set, as they can now be appropriately
encoded in the extended section. These symbols will be skipped in the
previous encoding. An error will still be generated if
CONFIG_EXTENDED_MODVERSIONS is not set.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/Kconfig    | 10 ++++++++
 scripts/Makefile.modpost |  1 +
 scripts/mod/modpost.c    | 65 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index e6b2427e5c190aacf7b9c5c1bb57fca39d311564..a31c617cd67d3d66b24d2fba34cbd5cc9c53ab78 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -208,6 +208,16 @@ config ASM_MODVERSIONS
 	  assembly. This can be enabled only when the target architecture
 	  supports it.
 
+config EXTENDED_MODVERSIONS
+	bool "Extended Module Versioning Support"
+	depends on MODVERSIONS
+	help
+	  This enables extended MODVERSIONs support, allowing long symbol
+	  names to be versioned.
+
+	  The most likely reason you would enable this is to enable Rust
+	  support. If unsure, say N.
+
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
 	help
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index ab0e94ea62496e11dbaa3ffc289ce546862795ca..40426fc6350985780c0092beb49c6cc29b9eff62 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -43,6 +43,7 @@ MODPOST = $(objtree)/scripts/mod/modpost
 modpost-args =										\
 	$(if $(CONFIG_MODULES),-M)							\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
+	$(if $(CONFIG_EXTENDED_MODVERSIONS),-x)						\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
 	$(if $(KBUILD_MODPOST_WARN),-w)							\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 107393a8c48a5993dbe456702fec0652a967ee86..bd38f33fd41fbd98bce34f8924b2fb0ac04297ee 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -32,6 +32,8 @@ static bool module_enabled;
 static bool modversions;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static bool all_versions;
+/* Is CONFIG_EXTENDED_MODVERSIONS set? */
+static bool extended_modversions;
 /* If we are modposting external module set to 1 */
 static bool external_module;
 /* Only warn about unresolved symbols */
@@ -1817,6 +1819,52 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 	}
 }
 
+/**
+ * Record CRCs for unresolved symbols, supporting long names
+ */
+static void add_extended_versions(struct buffer *b, struct module *mod)
+{
+	struct symbol *s;
+
+	if (!extended_modversions)
+		return;
+
+	buf_printf(b, "\n");
+	buf_printf(b, "static const s32 ____version_ext_crcs[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_crcs\") = {\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			/*
+			 * We already warned on this when producing the legacy
+			 * modversions table.
+			 */
+			continue;
+		}
+		buf_printf(b, "\t%#8x,\n", s->crc);
+	}
+	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const char ____version_ext_names[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_names\") =\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			/*
+			 * We already warned on this when producing the legacy
+			 * modversions table.
+			 * We need to skip its name too, as the indexes in
+			 * both tables need to align.
+			 */
+			continue;
+		}
+		buf_printf(b, "\t\"%s\\0\"\n", s->name);
+	}
+	buf_printf(b, ";\n");
+}
+
 /**
  * Record CRCs for unresolved symbols
  **/
@@ -1840,9 +1888,14 @@ static void add_versions(struct buffer *b, struct module *mod)
 			continue;
 		}
 		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			error("too long symbol \"%s\" [%s.ko]\n",
-			      s->name, mod->name);
-			break;
+			if (extended_modversions)
+				/* this symbol will only be in the extended info */
+				continue;
+			else {
+				error("too long symbol \"%s\" [%s.ko]\n",
+				      s->name, mod->name);
+				break;
+			}
 		}
 		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
 			   s->crc, s->name);
@@ -1972,6 +2025,7 @@ static void write_mod_c_file(struct module *mod)
 	add_header(&buf, mod);
 	add_exported_symbols(&buf, mod);
 	add_versions(&buf, mod);
+	add_extended_versions(&buf, mod);
 	add_depends(&buf, mod);
 	add_moddevtable(&buf, mod);
 	add_srcversion(&buf, mod);
@@ -2130,7 +2184,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:x")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2179,6 +2233,9 @@ int main(int argc, char **argv)
 		case 'd':
 			missing_namespace_deps = optarg;
 			break;
+		case 'x':
+			extended_modversions = true;
+			break;
 		default:
 			exit(1);
 		}

-- 
2.47.0.371.ga323438b13-goog

