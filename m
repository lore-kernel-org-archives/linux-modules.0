Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C71A0BFA
	for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115558; cv=none; b=GzAU9WT56f0N5yGaKKlfNbkwt4OJJ+FRbdjvZrXBed1niVq0eev/gxNXL5rZi1ki/nlgd6K8PBSY+/aCKc5IFOb6b4NuorXer0co0RJM08x1bR2OoS1rXaMilxy8p3Rh2gIjkcdbAuzzwRa360J77kNDhYN2lnLWutQLhFQww/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115558; c=relaxed/simple;
	bh=GbyHjS/k/0UBxuQfH5qKmPuM8OYbP33sr4avDOXFg3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KRUegzQ22iozK4mfgEyMcJ4aJqjoaP7k1UaPzafj0zzuWg0PPZjEPeQmG84Jd467qyHGlTojZL5NbTG7nhIgVYr+8V26E2/+d0BcmWt12uJG4VAx7WnYMMuVIx34ru+8/L7wkTEnENffAe8ZqcALk91Q2RhnQaBGDrhDzAQs1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RiWwqCyh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RiWwqCyh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2073498f269so48998345ad.3
        for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 11:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727115555; x=1727720355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPrJDICBXYLS7hoF/6RDIfXDH4cTMyv4XmP564TgqI4=;
        b=RiWwqCyhu4EuXDUDAkZSkwv/29ms2J33mGwtXC6r8EkkDoSn5/fBz23L0uxcjbyndW
         S2naHeAQ+8uxsssvupCqc9S/NEYY/OE0z+HoDcuwOYSc27K5PxiHSi7OXas80vl2nDev
         YBjuLvm8Sc9gjv4sqi/fkoeHOVkYxnXqfVK5MwGBscpyKIeC0pNqSsnKbo13pZI0X8Ef
         uPwDd9oR+8xbzCVFguGA6u+KhrvfNeEy1yhbKrBhqfgTiZAVeOU9DLjNAeB0ljwT7GvT
         HKHwKFY7gxkNeas9DYvurubSR0zQu01GU+3fKL7Ew1NC4fLttlwayr33jdZJVnAgGPa7
         N4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115555; x=1727720355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPrJDICBXYLS7hoF/6RDIfXDH4cTMyv4XmP564TgqI4=;
        b=fmt0AwKmuY/7CxkeWFU1wcIK0p+e14mD1U8pcC+tMtr+12J9mA18laiopM87CsP3Hq
         nAWz2641CEwIsC3vfSu7p0xbKU6ATrfVBmHgKpEpnJxtmYH9azKILbY1rGCNwt9cupYk
         PQT9qJAe+7Q0NslaXO6B0ZD6uMojyQFUnPsd1W5D17MhiJKgJHxAKXZRKwqScFfw6TJi
         kIu4TmU2YnVkuj+Two8q8E9LNTq0RedI7wxbs9Oz29fDuwozoAiefhyLVRzAsoUTWtQo
         yFIdgINm/a+0bLmNsOVN/vlcshMCYqPyODmdrTVNO8HJRHpFiF+acoK3Om1ixH+PpSaU
         HzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnz9I7+a8n2aWgm+ujt3FSTsVvdO+4cQUkILR4BbsBogOqdEe6hlXYW3icBFrTDe/0xeGWdSRvu/lfAbf/@vger.kernel.org
X-Gm-Message-State: AOJu0YyFy+kO1m7k+Ya6qMIzHMt6dlEiPvETHXeY+jedNKwlqkVzKvjE
	dbn8CIWaSmCHBHP66z3IhrLAg8WBjYGfwI6EGwoBc5aFhZYsLa8tl52UnX6Wk1XDS7xQmhR8gei
	RVDLocHB1SR3rxpUwGT95IiAV+g==
X-Google-Smtp-Source: AGHT+IFWuUmLh9cRh/+AIUM5wokytnEB2uaC2zfDXPBYXdPOKNJd0AL34leCOqvmOWiVODyI1j3o2Kp2PQWysHFMxXc=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:cecc:b0:206:928c:bfc3 with
 SMTP id d9443c01a7336-208d97edb36mr549915ad.2.1727115554899; Mon, 23 Sep 2024
 11:19:14 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:18:51 +0000
In-Reply-To: <20240923181846.549877-22-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239; i=samitolvanen@google.com;
 h=from:subject; bh=GbyHjS/k/0UBxuQfH5qKmPuM8OYbP33sr4avDOXFg3k=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkfN3KET7PbXJP06HuxEV8mzzyunPy+Tz85bWbf55paX
 tEdrn6/o5SFQYyDQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAExk7WqG/z7t5zWFZK8eT1lT
 KS5uw2SVH1PBsWQ2U/oL51ufdk9J/cbI0LBwwXJuu8TrbsyRHgJnKzjr3u/1vPp/v+LujVu/2St YMwEA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923181846.549877-27-samitolvanen@google.com>
Subject: [PATCH v3 05/20] gendwarfksyms: Expand base_type
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
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
---
 scripts/gendwarfksyms/dwarf.c | 157 ++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 81df3e2ad3ae..3e9e8500f448 100644
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
@@ -67,6 +79,107 @@ static void process(const char *s)
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
@@ -93,6 +206,49 @@ int process_die_container(struct state *state, Dwarf_Die *die,
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
@@ -119,6 +275,7 @@ static void process_subprogram(struct state *state, Dwarf_Die *die)
 static int __process_variable(struct state *state, Dwarf_Die *die)
 {
 	process("variable ");
+	process_type_attr(state, die);
 	return 0;
 }
 
-- 
2.46.0.792.g87dc391469-goog

