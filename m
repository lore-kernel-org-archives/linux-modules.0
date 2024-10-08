Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC903213EF7
	for <linux-modules@vger.kernel.org>; Tue,  8 Oct 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412726; cv=none; b=FjVM1VWx4Uqkrz2vak6HDXCISoSZMDSygqCCnfRe8zTXP4A19xoLTKbyG4+uuZx5IsN1cnMRKIjh7vNzlVdaZcYHDOexn2o8IgahQvmHAnAg4QrKY4Q1GBvwiJGNiTzc6RvLeVXcFuB9VG+I2h2KW1M4VGIjnIsyPW9JHqAEjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412726; c=relaxed/simple;
	bh=L8gZOiNafqMVcV01G0lHB854teeObYaONcRZ1bZVn3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLh3nAePugogJYnwysvNV+3/aZF38TAkH0FxERq68C+vhpaBsbC+nIc4kTymn+zuIxCbqpM5AHJ37/DkS4i8FCfq6Jl5b9urceV79Hm/wibJF8orMWIZFz3m6yShawh4VzxV3I9QKNqvkfVaO0sydzm8rZaC3UbED29NdrD8lOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uXWk762Y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uXWk762Y"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20bb491189aso77152225ad.3
        for <linux-modules@vger.kernel.org>; Tue, 08 Oct 2024 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728412724; x=1729017524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkH5Ih0xNj3RgiCeSysh2t3eMUNLsppdxz7owK02bHI=;
        b=uXWk762YSg4lcvdVkuzlgrGPC5GlWv8rBj4h77aGjQ0q+v+Q3Xnhu6aSQu5P5covQ9
         Gs7aBvo42FE5AdlzwfahL+SKvNhy4iKccBdDpq8K8Uos5DqbytuGc9SGSXHgvIgfmJzf
         M5520n1VR28Q9amiMPEV+JyadIDuqmjoXbEi3SqmjgNr7cnpP/IgkY0V4kNMFXlbITRR
         HQvG3+E6mZlrPR5NbKih6aEDcz/eT2zrNOa1zYSlOFOuV4VKwzu0Fg8ymOO7QAORX/vw
         LNKu4lo2pNW0KHLkM8gY+CRMa/BIq1rQKq94eFPQHiprNd8GTpz6xjT3GhZ1LkX+aVzE
         +tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412724; x=1729017524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkH5Ih0xNj3RgiCeSysh2t3eMUNLsppdxz7owK02bHI=;
        b=A4oqh6sk6AMVSPl2VID+Fnn4PY49E8iYCCBO4yaGr4U2kDv/vbxFTo6f+9NgLZcEkl
         9jIkCrLbdKKG+TCTJR0x0p+K8X6KXqHMecuX7aepqE21gxEshGvbvhL0zOcMyEvOQsIi
         +Ih+93fBRVMls7i8+prP4sU56QDtEi5bLpWD+B3Edtdqjops3f5FPEd7f9s9STornmK9
         wGDKW4N2jnBis2hTe+fc72O32wE8aIQxIzhx7IvB7LnY6/ZE7pFtiamz+iY6VfMipbot
         GkFOk44VtNA8GRRGev39rcEyVUsVFhw25LAnd+G1J7p3qkpnKOD7K5aYx/S5l3dqHL4Z
         E30w==
X-Forwarded-Encrypted: i=1; AJvYcCUo9ovBF9YyvYv6uP+05eB0xzvtitw3nwUXZ7kIWSvq3XTtel3BhR+4MLwlqs3sfi4mrVLdrJdNAALttBhB@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkxyhKwmpwkcA950LzW64T+kCstfvMCqGlxVjYImu9gC8qJ1n
	j/2lp2Ag0mz/fAoWpbTPAFsotDwtczFwJNJhJjLysDBbSO/h5xQPsL8AntH8g07yAANgs1CXk/Q
	mhiRebka2EKI1T28J06kgqM1L6w==
X-Google-Smtp-Source: AGHT+IFmEULt/jO3vqjILkmVX45b4prHh+Y47lGGy6+F3tp14h2lmNPgyIt35LgeXNCkncMExOSiIlEpJkHiZLFfzWc=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:c404:b0:20b:b7b2:b6ef with
 SMTP id d9443c01a7336-20bfe0628c0mr4719855ad.4.1728412724086; Tue, 08 Oct
 2024 11:38:44 -0700 (PDT)
Date: Tue,  8 Oct 2024 18:38:28 +0000
In-Reply-To: <20241008183823.36676-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5424; i=samitolvanen@google.com;
 h=from:subject; bh=L8gZOiNafqMVcV01G0lHB854teeObYaONcRZ1bZVn3Y=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOmsNUprA7ZfPDfpwdpNx/Mfb/FK6tu1cJ+r7LQ5lt2HY
 h/fO1ad21HKwiDGwSArpsjS8nX11t3fnVJffS6SgJnDygQyhIGLUwAm0vOO4Z/x1+Z1mozzFI9G
 c/IVlXFm31H9zN7MPeNG+q3H5pn7Fm1kZLj64GhzhfvR7mQFIxbuoL/6Hh+3VfxN/XJh88WuZ3P tmVkA
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008183823.36676-25-samitolvanen@google.com>
Subject: [PATCH v4 04/19] gendwarfksyms: Expand base_type
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

Start making gendwarfksyms more useful by adding support for
expanding DW_TAG_base_type types and basic DWARF attributes.

Example:

  $ echo loops_per_jiffy | \
      scripts/gendwarfksyms/gendwarfksyms \
        --debug --dump-dies vmlinux.o
  ...
  gendwarfksyms: process_symbol: loops_per_jiffy
  variable base_type unsigned long byte_size(8) encoding(7)
  ...

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c | 159 ++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 81df3e2ad3ae..35fd1dfeeadc 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -3,8 +3,20 @@
  * Copyright (C) 2024 Google LLC
  */
 
+#include <stdarg.h>
 #include "gendwarfksyms.h"
 
+#define DEFINE_GET_ATTR(attr, type)                                    \
+	static bool get_##attr##_attr(Dwarf_Die *die, unsigned int id, \
+				      type *value)                     \
+	{                                                              \
+		Dwarf_Attribute da;                                    \
+		return dwarf_attr(die, id, &da) &&                     \
+		       !dwarf_form##attr(&da, value);                  \
+	}
+
+DEFINE_GET_ATTR(udata, Dwarf_Word)
+
 static bool get_ref_die_attr(Dwarf_Die *die, unsigned int id, Dwarf_Die *value)
 {
 	Dwarf_Attribute da;
@@ -67,6 +79,109 @@ static void process(const char *s)
 		fputs(s, stderr);
 }
 
+#define MAX_FMT_BUFFER_SIZE 128
+
+static void process_fmt(const char *fmt, ...)
+{
+	char buf[MAX_FMT_BUFFER_SIZE];
+	va_list args;
+
+	va_start(args, fmt);
+
+	if (checkp(vsnprintf(buf, sizeof(buf), fmt, args)) >= sizeof(buf))
+		error("vsnprintf overflow: increase MAX_FMT_BUFFER_SIZE");
+
+	process(buf);
+	va_end(args);
+}
+
+#define MAX_FQN_SIZE 64
+
+/* Get a fully qualified name from DWARF scopes */
+static char *get_fqn(Dwarf_Die *die)
+{
+	const char *list[MAX_FQN_SIZE];
+	Dwarf_Die *scopes = NULL;
+	bool has_name = false;
+	char *fqn = NULL;
+	char *p;
+	int count = 0;
+	int len = 0;
+	int res;
+	int i;
+
+	res = checkp(dwarf_getscopes_die(die, &scopes));
+	if (!res) {
+		list[count] = get_name_attr(die);
+
+		if (!list[count])
+			return NULL;
+
+		len += strlen(list[count]);
+		count++;
+
+		goto done;
+	}
+
+	for (i = res - 1; i >= 0 && count < MAX_FQN_SIZE; i--) {
+		if (dwarf_tag(&scopes[i]) == DW_TAG_compile_unit)
+			continue;
+
+		list[count] = get_name_attr(&scopes[i]);
+
+		if (list[count]) {
+			has_name = true;
+		} else {
+			list[count] = "<anonymous>";
+			has_name = false;
+		}
+
+		len += strlen(list[count]);
+		count++;
+
+		if (i > 0) {
+			list[count++] = "::";
+			len += 2;
+		}
+	}
+
+	free(scopes);
+
+	if (count == MAX_FQN_SIZE)
+		warn("increase MAX_FQN_SIZE: reached the maximum");
+
+	/* Consider the DIE unnamed if the last scope doesn't have a name */
+	if (!has_name)
+		return NULL;
+done:
+	fqn = xmalloc(len + 1);
+	*fqn = '\0';
+
+	p = fqn;
+	for (i = 0; i < count; i++)
+		p = stpcpy(p, list[i]);
+
+	return fqn;
+}
+
+static void process_fqn(Dwarf_Die *die)
+{
+	process(" ");
+	process(get_fqn(die) ?: "");
+}
+
+#define DEFINE_PROCESS_UDATA_ATTRIBUTE(attribute)                           \
+	static void process_##attribute##_attr(Dwarf_Die *die)              \
+	{                                                                   \
+		Dwarf_Word value;                                           \
+		if (get_udata_attr(die, DW_AT_##attribute, &value))         \
+			process_fmt(" " #attribute "(%" PRIu64 ")", value); \
+	}
+
+DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
+DEFINE_PROCESS_UDATA_ATTRIBUTE(byte_size)
+DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
+
 bool match_all(Dwarf_Die *die)
 {
 	return true;
@@ -93,6 +208,49 @@ int process_die_container(struct state *state, Dwarf_Die *die,
 	return 0;
 }
 
+static int process_type(struct state *state, Dwarf_Die *die);
+
+static void process_type_attr(struct state *state, Dwarf_Die *die)
+{
+	Dwarf_Die type;
+
+	if (get_ref_die_attr(die, DW_AT_type, &type)) {
+		check(process_type(state, &type));
+		return;
+	}
+
+	/* Compilers can omit DW_AT_type -- print out 'void' to clarify */
+	process("base_type void");
+}
+
+static void process_base_type(struct state *state, Dwarf_Die *die)
+{
+	process("base_type");
+	process_fqn(die);
+	process_byte_size_attr(die);
+	process_encoding_attr(die);
+	process_alignment_attr(die);
+}
+
+#define PROCESS_TYPE(type)                         \
+	case DW_TAG_##type##_type:                 \
+		process_##type##_type(state, die); \
+		break;
+
+static int process_type(struct state *state, Dwarf_Die *die)
+{
+	int tag = dwarf_tag(die);
+
+	switch (tag) {
+	PROCESS_TYPE(base)
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
@@ -119,6 +277,7 @@ static void process_subprogram(struct state *state, Dwarf_Die *die)
 static int __process_variable(struct state *state, Dwarf_Die *die)
 {
 	process("variable ");
+	process_type_attr(state, die);
 	return 0;
 }
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog

