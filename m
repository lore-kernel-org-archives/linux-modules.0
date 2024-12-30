Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD819DF9A
	for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735597837; cv=none; b=uu2DDdhvvQDBPkmrr7WEIWJu+5BUnoQ5aH6wZpMMgoOxRk1jkB+FZGCJPL8Tha3NrLySfw4wJFq3glYLYgoJ8x6BM3jnFya3fXBtBJyXOvEh+DurdprmTDVDOZ35k9y9lQrhEc72ri9b7g7nhLnP0yAHe+BVBnq2Jenz7a81D1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735597837; c=relaxed/simple;
	bh=HpSfhEQsmJDhbi0WozEpulnow31LpruRGqzOvEDchYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i4JTLpotjJWRusAEIZNoNbk3DczSy1rvvPqDtvGRfcFZWwXywhMPJxDlWa6iesrgfxJ3MF+nTKRj7EZ6m0gHyllZObwGeG8FpJM054+ToMGaplp/VO7uJcMwf8A0vqej1X3weIeAy0w+1Ihgwqd8x9FjBQurIyJ+MQzXewjo52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeXOIlsI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeXOIlsI"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso13222084a91.1
        for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 14:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735597835; x=1736202635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SdIG/Q/6InqG6fGpzelEgOUniqS646q8n2Ou3Fvqw0=;
        b=GeXOIlsI9IdwG3WnzVPw9DzPnMpdLAWf9PYU0upKNG8tI2DYiPjdPduFs/nE+mDrTF
         4vK+AkkxZ0wfDVfcSeeREbi8K6DqKKfN9iGPlR7Y62DZjvWBuwYk8G60TCmqPPCSApJa
         ByHc1/Lnei/gtTBmxIi1oYiqFEzAH7X5K663Zs4B+AwyNr8f0wfnIYOb4ZqilBshC/9+
         mEpoyV4jwOGXuMfitD5UDy6xb/3tobhT49Gh+QPUSxslbQkEFdfBbkMjAHqI8EvRh6ux
         ywdqJZu5iELO1Y4h90MlHnKLh0gdN35F42qHgNWO0HHwwlN34hedLsbrhQeAZL0ImtO/
         4cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735597835; x=1736202635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SdIG/Q/6InqG6fGpzelEgOUniqS646q8n2Ou3Fvqw0=;
        b=kMtdnCR4UbbcT5FzM4FTkr1cm4dhGROibvW8LJg3RJgqIswHcbqKxj1nWLD747mFGs
         /7OgV/dn1toj+Y6o6644hTaqfh1DrHINz0n+i+SpkyqWYZnnsUe1EG6l2ETj97liDdEt
         tILtGR2vo7bXPmWIf08hb8So1yE+ExQCMAQd3oh6DCoT6l6T0UMPxmLUxkIotvvlVjQU
         6dQW5Gtjn4NR73vdL48qKOOo14lrb2NoXS0VkmtDjLz89sLAEXkL01XJcJIRzb5FgS5u
         JMNZaTLusgrqEAAt5B06p5rZicnnGOpGMFAhQHzEqzEhKQ23S9tnx5Nx1uk58zXlT0e5
         vV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWqEXdyZEixaara+fvJ0+qJIHGxhU+nyaW+H5WcvZC4VEEJ8MX3nb5vYgcbQ5+ILShgCPVFsgUO7HRWk8W@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZTm8Ax9J3mlxaSmYo0nBcbuVPDe4oTDH102JWE7Yla2lRLlf
	QmEBJ7RAme8QSol0y975UP3vTL17+GBUu/u+aqLib4g8gSz0w03joDZXLUiGoTnmZ5915A/2BGj
	gTdQIWw==
X-Google-Smtp-Source: AGHT+IGi4L0DnioU3ViuOPQ9hdTSLKvrZaDYmzr68pUHr1qyZseGS+I94UFypBkIbr0Xh4WiRy55BOIz2PpM
X-Received: from pjbsq3.prod.google.com ([2002:a17:90b:5303:b0:2ea:6aa8:c4ad])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfc7:b0:2ee:b6c5:1def
 with SMTP id 98e67ed59e1d1-2f452def71bmr63227916a91.8.1735597835253; Mon, 30
 Dec 2024 14:30:35 -0800 (PST)
Date: Mon, 30 Dec 2024 22:30:30 +0000
In-Reply-To: <20241230-extended-modversions-v12-0-296a6a0f5151@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241230-extended-modversions-v12-0-296a6a0f5151@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241230-extended-modversions-v12-3-296a6a0f5151@google.com>
Subject: [PATCH v12 3/5] modules: Allow extended modversions without basic MODVERSIONS
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

If you know that your kernel modules will only ever be loaded by a newer
kernel, you can disable BASIC_MODVERSIONS to save space. This also
allows easy creation of test modules to see how tooling will respond to
modules that only have the new format.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/Kconfig    | 15 +++++++++++++++
 scripts/Makefile.modpost |  1 +
 scripts/mod/modpost.c    |  9 +++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 9568b629a03ce8289d3f3597eefc66fc96445720..4538f3af63e1ca531d0f74ef45a6f5268e505aec 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -217,6 +217,21 @@ config EXTENDED_MODVERSIONS
 	  The most likely reason you would enable this is to enable Rust
 	  support. If unsure, say N.
 
+config BASIC_MODVERSIONS
+	bool "Basic Module Versioning Support"
+	depends on MODVERSIONS
+	default y
+	help
+	  This enables basic MODVERSIONS support, allowing older tools or
+	  kernels to potentially load modules.
+
+	  Disabling this may cause older `modprobe` or `kmod` to be unable
+	  to read MODVERSIONS information from built modules. With this
+	  disabled, older kernels may treat this module as unversioned.
+
+	  This is enabled by default when MODVERSIONS are enabled.
+	  If unsure, say Y.
+
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
 	help
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 40426fc6350985780c0092beb49c6cc29b9eff62..d7d45067d08b94a82451d66a64eae29b6826e139 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -43,6 +43,7 @@ MODPOST = $(objtree)/scripts/mod/modpost
 modpost-args =										\
 	$(if $(CONFIG_MODULES),-M)							\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
+	$(if $(CONFIG_BASIC_MODVERSIONS),-b)						\
 	$(if $(CONFIG_EXTENDED_MODVERSIONS),-x)						\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6324b30f6b97ac24dc517b9229f227c6c369f7d5..3784f1e08104dc2ca1da10d45ed92bb8adf4826a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -33,6 +33,8 @@ static bool module_enabled;
 static bool modversions;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static bool all_versions;
+/* Is CONFIG_BASIC_MODVERSIONS set? */
+static bool basic_modversions;
 /* Is CONFIG_EXTENDED_MODVERSIONS set? */
 static bool extended_modversions;
 /* If we are modposting external module set to 1 */
@@ -1856,7 +1858,7 @@ static void add_versions(struct buffer *b, struct module *mod)
 {
 	struct symbol *s;
 
-	if (!modversions)
+	if (!basic_modversions)
 		return;
 
 	buf_printf(b, "\n");
@@ -2176,7 +2178,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:x")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:xb")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2225,6 +2227,9 @@ int main(int argc, char **argv)
 		case 'd':
 			missing_namespace_deps = optarg;
 			break;
+		case 'b':
+			basic_modversions = true;
+			break;
 		case 'x':
 			extended_modversions = true;
 			break;

-- 
2.47.1.613.gc27f4b7a9f-goog

