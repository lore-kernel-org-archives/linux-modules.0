Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0708197A95
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647115; cv=none; b=dd4khXZUhmvI9d6J5siqNgf27LKWDD8cxd0z7LbVMWI279caUFd+oTW4c2/y287qpxkqm8D13ai+ycXD04AzfBjGfCtxVoQXsGxFNAEEuQYmXit+yWYcYlMRZPur/9TNqDzO/IM1K33icUyxzxEeaGWnX75ONGAivBA4RkbkxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647115; c=relaxed/simple;
	bh=n0WO328t/R/22oR4dAFfOzsZotv9Vy1BGsad/Gul6sE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T62TWhCsyJhaLhJE87eBTWPFDRMN2pFHfo/XFLxN3xOKMfn7sJcsTtOxyflheUhoU0qi2arIdjDUO6qxV5AqTYoPNqO2GtSY+tXTBD3gh+LUa3Wzeyjs0OK8vC1xaZ1CfXMSg2upcuMilxJ9Uh6+M0fTWOx9e8mgTOGsKYUISZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dB5/dc7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dB5/dc7"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfdfe3d9fc8so9507832276.3
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647113; x=1719251913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=76YAbYQsN4iBlLO/AdhdCy35iLXKLbSen1j9CZMms3w=;
        b=0dB5/dc7o7DUJLLo+CLU3qpr9i8DmqWFxFlI5ebrPhKx/m2yQ8Fq1stTxykAID4Bt8
         oz2qhuP7HbrVD5GNhdj7XELiSakDyTqdi008sDaPkUFmCWYosHPj9WvDov0ZMJT67/hN
         Zz5piK3RoVIJJPMRfQmB/ZDXeRfmi1yOUfSalXN2DLzSRggyKR2t483fCMYGd3ObRF1j
         MPbXpw4iEnYqDTzfyvURH6F9U3tEy3IzEyAIJaCoQ9nXI+0Y8SJPH1g/lWbYi+JsO9PU
         fi5+hVTpqHmh6lr8JNwYlelaNOz+gGUA3KuB0Dso/oM7pWTvWQxLIuhbd3PeaIJQDUux
         AGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647113; x=1719251913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76YAbYQsN4iBlLO/AdhdCy35iLXKLbSen1j9CZMms3w=;
        b=E+T/V1LZtMA0b9VHmUyAERYef4gbcxB8mbckODKQde6+Zfc0+pd05i1ebAANjINfIR
         orl6o0TyMEEIY5Jma4oQwY9MNug0xSeEmOOEqCPENwwlz/70zLCb7IbOk81GTgNw4RZ3
         HDFxs47rEaPQcDA6muLsmKx4tcz2+vNuSS3rnx6vTVnb1aNnfJYTWoVoDT00dtcfX0eR
         hs7U4pQVPoLX3HLzvEqB+VR4QnGQ3exW0cjN9J2Y8QJ7NfzzgQdIel+uP8rd6q5Q8l6+
         jzJo3i8qWPjtXPXTv9B8UoAGuk5MBdh4gSAwe9simi+4Z72/TikdLf6jHwtAsGqG5BG6
         K/uA==
X-Forwarded-Encrypted: i=1; AJvYcCWdqvKfLqzcM0uN753+EV82GqNMUlRRuxkFa6V7wKPIeT8FRmorMLuP1v+jRLv52WdhUjzy2OKbyS9gURTmx9vKOo6402+xsEco9esspg==
X-Gm-Message-State: AOJu0YxHSiaz0u6jnihQ+2+uKvc0PWips+1JXq0GJiTH0ZaeQNrZuizg
	CvLhALg8m/AdKMy1mvp81CpemOWq+/8huSXUZGhHuBYXln6INybweAks9507NGZKIgGsPBzkXiS
	XW8VG4cTpqGDehTRgUwsdf7dLcw==
X-Google-Smtp-Source: AGHT+IEFlFDxRrubSZKRKq19ggp4bGgoj3XoC6AvOCv9XxrI5awLRpUMpL3IaZAxaZPpwk4phGXhW1ExNLzu5coj+zU=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:2984:b0:dfb:fb2:ebe with
 SMTP id 3f1490d57ef6-dff15480784mr1072302276.13.1718647112827; Mon, 17 Jun
 2024 10:58:32 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:23 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=4723; i=samitolvanen@google.com;
 h=from:subject; bh=n0WO328t/R/22oR4dAFfOzsZotv9Vy1BGsad/Gul6sE=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk7VghQRt6tJGo+Lh47/+dL7GF5TrJggVB/Z
 YqQXn8U8gKJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5OwAKCRBMtfaEi7xW
 7hifC/0SP1IKS7zZIqmmeCgMSQNkuUFdCo1FdX/QfJw4dcz1EktOSWQ87V9jK4Z7eVazfE0Bcvk
 2GIYZlmIJjtM/xn/dZfozLVtys9cuUc8GHBd+DJooXharA1ZHjTiuuvzDz+rKCM8nTZfcSAZgKX
 6uoXbqjJ5zsaC+O+uKvWLN3mxxL95amU9m/f4w8PZlyuLVjnGlNYse/oMdMvcvmke5ECMiqnKnz
 Lvb2dslKCjnk3EDIfPMQkZ8JUJiGhw9JebdVbViOQaKdQIhfh93Yl7H+glQHGocNJlpcgTKaFj7
 OdUDNqe/ZWSIY6WTUM0qQRb7gn6yJem92yyYyRo4FcT67l75b87WWcslEEihf8BDKvUfhMZdcko
 uq2WFTu8rnd2Pgr4k0goi7QLCfiURuYmCjBAf6ByvrlxG3r0sRURFcnsV+hL/eoTObhFxvpkqwS /qGAgUM2pso52796WF2ZgB/+Cl42HAU7Zd6OoLdhboYfUGRS3yS/BasH4cZo4Dr9C8S5U=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-21-samitolvanen@google.com>
Subject: [PATCH 04/15] gendwarfksyms: Expand base_type
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for expanding basic DWARF attributes and DW_TAG_base_type
types.

Example usage:

  $ nm -p --defined-only vmlinux.o | \
      awk '/ (T|R|D) / {printf "%s %s\n",$1, $3}' | \
      grep loops_per_jiffy | \
      ./tools/gendwarfksyms/gendwarfksyms --debug vmlinux.o

Output:

  gendwarfksyms: symbol_read_list: adding { 4b0, "loops_per_jiffy" }
  gendwarfksyms: process_modules: vmlinux.o
  gendwarfksyms: process_exported_symbols: loops_per_jiffy (@ 4b0)
  variable base_type unsigned long byte_size(8);
  #SYMVER loops_per_jiffy 0xc694aefc

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/gendwarfksyms/types.c | 109 +++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/gendwarfksyms/types.c b/tools/gendwarfksyms/types.c
index 47ae967d42ee..7508d0fb8b80 100644
--- a/tools/gendwarfksyms/types.c
+++ b/tools/gendwarfksyms/types.c
@@ -16,6 +16,7 @@
 	}
 
 DEFINE_GET_ATTR(addr, Dwarf_Addr)
+DEFINE_GET_ATTR(udata, Dwarf_Word)
 
 static bool get_ref_die_attr(Dwarf_Die *die, unsigned int id, Dwarf_Die *value)
 {
@@ -82,6 +83,73 @@ static int process(struct state *state, const char *s)
 	return 0;
 }
 
+#define MAX_FMT_BUFFER_SIZE 128
+
+static int process_fmt(struct state *state, const char *fmt, ...)
+{
+	char buf[MAX_FMT_BUFFER_SIZE];
+	va_list args;
+	int res;
+
+	va_start(args, fmt);
+
+	res = check(vsnprintf(buf, sizeof(buf), fmt, args));
+	if (res >= MAX_FMT_BUFFER_SIZE - 1) {
+		error("vsnprintf overflow: increase MAX_FMT_BUFFER_SIZE");
+		res = -1;
+	} else {
+		check(process(state, buf));
+	}
+
+	va_end(args);
+	return res;
+}
+
+/* Process a fully qualified name from DWARF scopes */
+static int process_fqn(struct state *state, Dwarf_Die *die)
+{
+	Dwarf_Die *scopes = NULL;
+	const char *name;
+	int res;
+	int i;
+
+	res = check(dwarf_getscopes_die(die, &scopes));
+	if (!res) {
+		name = get_name(die);
+		name = name ?: "<unnamed>";
+		return check(process(state, name));
+	}
+
+	for (i = res - 1; i >= 0; i--) {
+		if (dwarf_tag(&scopes[i]) == DW_TAG_compile_unit)
+			continue;
+
+		name = get_name(&scopes[i]);
+		name = name ?: "<unnamed>";
+		check(process(state, name));
+		if (i > 0)
+			check(process(state, "::"));
+	}
+
+	free(scopes);
+	return 0;
+}
+
+#define DEFINE_PROCESS_UDATA_ATTRIBUTE(attribute)                         \
+	static int process_##attribute##_attr(struct state *state,        \
+					      Dwarf_Die *die)             \
+	{                                                                 \
+		Dwarf_Word value;                                         \
+		if (get_udata_attr(die, DW_AT_##attribute, &value))       \
+			check(process_fmt(state,                          \
+					  " " #attribute "(%" PRIu64 ")", \
+					  value));                        \
+		return 0;                                                 \
+	}
+
+DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
+DEFINE_PROCESS_UDATA_ATTRIBUTE(byte_size)
+
 bool match_all(Dwarf_Die *die)
 {
 	return true;
@@ -103,11 +171,48 @@ int process_die_container(struct state *state, Dwarf_Die *die,
 	return 0;
 }
 
+static int process_type(struct state *state, Dwarf_Die *die);
+
+static int process_type_attr(struct state *state, Dwarf_Die *die)
+{
+	Dwarf_Die type;
+
+	if (get_ref_die_attr(die, DW_AT_type, &type))
+		return check(process_type(state, &type));
+
+	/* Compilers can omit DW_AT_type -- print out 'void' to clarify */
+	return check(process(state, "base_type void"));
+}
+
+static int process_base_type(struct state *state, Dwarf_Die *die)
+{
+	check(process(state, "base_type "));
+	check(process_fqn(state, die));
+	check(process_byte_size_attr(state, die));
+	return check(process_alignment_attr(state, die));
+}
+
 static void state_init(struct state *state)
 {
 	state->crc = 0xffffffff;
 }
 
+static int process_type(struct state *state, Dwarf_Die *die)
+{
+	int tag = dwarf_tag(die);
+
+	switch (tag) {
+	case DW_TAG_base_type:
+		check(process_base_type(state, die));
+		break;
+	default:
+		debug("unimplemented type: %x", tag);
+		break;
+	}
+
+	return 0;
+}
+
 /*
  * Exported symbol processing
  */
@@ -118,7 +223,9 @@ static int process_subprogram(struct state *state, Dwarf_Die *die)
 
 static int process_variable(struct state *state, Dwarf_Die *die)
 {
-	return check(process(state, "variable;\n"));
+	check(process(state, "variable "));
+	check(process_type_attr(state, die));
+	return check(process(state, ";\n"));
 }
 
 static int process_exported_symbols(struct state *state, Dwarf_Die *die)
-- 
2.45.2.627.g7a2c4fd464-goog

