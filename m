Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5B1FC104
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925831; cv=none; b=f5C0fZmIVtXrM7yUb+eQHTAf0VZKuIAtGrHysiRNpN0Nn0Yd/WUyDb4jxzN40zZncdiKg5x4JfYLPUrfo3gYKEXpW/dHbJh94O1HRTdZ09q+qH+3mGUHXwcPCStjLbaT8u6jy/v8jOpVW1RlmkMTcZ6xo21LRFLBcW+MiHrWpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925831; c=relaxed/simple;
	bh=LzZzjYtMrjAIOilGNqPDi1aMo2B8A5UAsk+7N50tLOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E3nUQ6cAla0ryANUYl6m//Mk5AeQUTJRrtM4qlOrZktMPTVSnf09DOLtU3lPnQz01cDYzyUfVOihv3R9RVCvzRNLX7vYDH57baE+adyBtR3e/lzndeac5w9AL/OGxEJseat7H65DrEhAxDOmJ2M2FWMqfgl7lPZKneebGW8cScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhEiy7Ci; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhEiy7Ci"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2162f80040aso158394275ad.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735925828; x=1736530628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIRcbYHGQmiiiWpSG/HYzoKu7yqD3/iQMyIqYWEujyM=;
        b=PhEiy7CiPxeCTyEIOr2WTfU6MWf74k5mIOa18OFnu08JZ8ONfiB/Uihmx6P2MZukuO
         7UvnLQ+bMpLK9G6cs2Mb2CHYNgqs7ni/pb8d8eDAilznGthOcb9lcx4BRg1ZTFdTxng5
         9XiRhnD/SCouPohw6LwOkC2bV/tzl4N12xr2HDY4V9FleT8uIV6/gg7DMoUwnS4QCbos
         1NTbwtbWmqHbGxO41q4u5G32C8cdxR5HjMHtkt/bu8+/8P6ICwdXzXsJ3QXJKXNBOeis
         gWtA0mJj/mhUwG4gG8ezuNUcBu1Z5wqjhFxPASzDPz3wI1r4qy9hSYnYcHv6kJicCyRe
         mtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735925828; x=1736530628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIRcbYHGQmiiiWpSG/HYzoKu7yqD3/iQMyIqYWEujyM=;
        b=de12HKkV3jbe7ZFutABZ2MvfLo4J2gTcJysu2spfw5VauRPdo8Mrimrhiuu+K0rltg
         AxO4oXE8i9IfkvRD+N0QsD6ZVAG0mFtv6/SLfJ7wwaCvFYWuq8WZe5HT2fQJM9wBL12y
         WuMzES+si2mahQREWaj928cpEk+7Iar3jMtCrmoJ9msgdhA61B12NY+eYQ/fl5hRmUgF
         60lmGmf3GTBnFyOTCte3VNM0lWX+VwLWsks5MTEp/2UpbY+WncCbRkKLjx79IiO5oV+m
         XR08PsyF2WeFqQDZYgWVIBGKxgfSJ7PXQ6T0TPiAfHpBVk9lfLR39IZ2ZzQk/h5IE7Yb
         gYaA==
X-Forwarded-Encrypted: i=1; AJvYcCVk4hbAgp+JY3NS4MLf1TUiPUdM3VcStMoF9fXIoPTFO+a6/cCUUKs9SRqEHuUG5t7hU9gPIbJvoM62NXvT@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQa0y/9qjFqYMj3EqB/mFTDs+P/8q7hXJBaE1Egb8sxCI1arE
	cUDCFWsnknblxhiFP+0wyYxXMACXyfERVOlemhmNdAO04kLhSae04RbBEgM1NhrwmZHKT24VYKx
	WzmEztg==
X-Google-Smtp-Source: AGHT+IGN8rfvyM0kzqkaoKk2IRtLNpQCxGFK/t3b2wn9lw4sVagsSV0vesavi1D1bZqcCHgcyY5k+8G0ghYs
X-Received: from pfba3.prod.google.com ([2002:a05:6a00:ac03:b0:725:ceac:b481])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:841e:b0:1e1:9f57:eacb
 with SMTP id adf61e73a8af0-1e5e0470415mr82396811637.14.1735925828172; Fri, 03
 Jan 2025 09:37:08 -0800 (PST)
Date: Fri, 03 Jan 2025 17:37:02 +0000
In-Reply-To: <20250103-extended-modversions-v13-0-35d87c65ee04@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250103-extended-modversions-v13-0-35d87c65ee04@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250103-extended-modversions-v13-2-35d87c65ee04@google.com>
Subject: [PATCH v13 2/5] modpost: Produce extended MODVERSIONS information
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
 scripts/mod/modpost.c    | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index d443fc504ffca0d1001f880ec496ab1f21fe979e..9568b629a03ce8289d3f3597eefc66fc96445720 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -207,6 +207,16 @@ config ASM_MODVERSIONS
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
index e489983bb8b2850c0f95bcbdfd82f684d4e7f0c3..6324b30f6b97ac24dc517b9229f227c6c369f7d5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -33,6 +33,8 @@ static bool module_enabled;
 static bool modversions;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static bool all_versions;
+/* Is CONFIG_EXTENDED_MODVERSIONS set? */
+static bool extended_modversions;
 /* If we are modposting external module set to 1 */
 static bool external_module;
 /* Only warn about unresolved symbols */
@@ -1804,6 +1806,49 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
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
+	buf_printf(b, "static const u32 ____version_ext_crcs[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_crcs\") = {\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			warn("\"%s\" [%s.ko] has no CRC!\n",
+				s->name, mod->name);
+			continue;
+		}
+		buf_printf(b, "\t0x%08x,\n", s->crc);
+	}
+	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const char ____version_ext_names[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_names\") =\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid)
+			/*
+			 * We already warned on this when producing the crc
+			 * table.
+			 * We need to skip its name too, as the indexes in
+			 * both tables need to align.
+			 */
+			continue;
+		buf_printf(b, "\t\"%s\\0\"\n", s->name);
+	}
+	buf_printf(b, ";\n");
+}
+
 /**
  * Record CRCs for unresolved symbols
  **/
@@ -1827,9 +1872,14 @@ static void add_versions(struct buffer *b, struct module *mod)
 			continue;
 		}
 		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			error("too long symbol \"%s\" [%s.ko]\n",
-			      s->name, mod->name);
-			break;
+			if (extended_modversions) {
+				/* this symbol will only be in the extended info */
+				continue;
+			} else {
+				error("too long symbol \"%s\" [%s.ko]\n",
+				      s->name, mod->name);
+				break;
+			}
 		}
 		buf_printf(b, "\t{ 0x%08x, \"%s\" },\n",
 			   s->crc, s->name);
@@ -1960,6 +2010,7 @@ static void write_mod_c_file(struct module *mod)
 	add_header(&buf, mod);
 	add_exported_symbols(&buf, mod);
 	add_versions(&buf, mod);
+	add_extended_versions(&buf, mod);
 	add_depends(&buf, mod);
 
 	buf_printf(&buf, "\n");
@@ -2125,7 +2176,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:x")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2174,6 +2225,9 @@ int main(int argc, char **argv)
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
2.47.1.613.gc27f4b7a9f-goog

