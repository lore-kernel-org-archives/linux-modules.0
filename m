Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A722802E
	for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307699; cv=none; b=puxheM0CGKnEUhMatObgnY6bquNpRt1ZmRQzDMwa7pXl8tZuEEYSDkwAgOSqdOxD7iVktdVsTfo8qU2RosKE7Oj0tayyqPwTMZNXueRXTJK9i54T0CxFN0sQbG43iXizwd1nGIphrRq75c2oCXbjbXkGrmB0HBJgpMSEfTn6tlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307699; c=relaxed/simple;
	bh=xIC33Ds3wrL8SIvJ8KBatwbWfEydHQpWtWqC0C2qx6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hgpe6MdI50XLPF9VLHn0/+Ug92yfvD2pyWHp+gb6QwGQHvHGqUgbYIZOkz1/LYyAxYO3SqPco0gwBybf4BKC+OSrifBnCKc1UIT3yOU+9urWqrfU/tFfG+unxJhbGw16XBPr0mGZoa1zmiY9qkBdW1NYNFh56b9evvV1ngbHj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xspS63on; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xspS63on"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso43939276.0
        for <linux-modules@vger.kernel.org>; Wed, 30 Oct 2024 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730307695; x=1730912495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YBwsUDgAdTeQCLcgQc+Qk068GyPLXcdvsLeO9HYQh0=;
        b=xspS63ont+lXKHZkvoQfHIhM17gBNlww9prmKUrrDOWtDzQom2P7EOHswPDc/K05PD
         +5liyxpp3k1BsAFEIpFFHJj54WnSZ4+8cCeaH+mUkc6zbD0rIS9TlsIGVu5S/VHyRwaV
         UhG7LJslNjvgiNpoAjgIrmR9sK1fcnCKPnJAShTmY/DWRMP25MZu55b7uVdufJRZFxIE
         b4Zcbqoeb1KG+xdUeKXe+PvpzkWFrEVQKoCHChdNhzkWA2Jr11rAk3BmQKxmR8r3sbUb
         0AgLNC+iudYzR+mmOeRANNSWnqwgEiiphodbIJUD8O76ilT+VJblAVVJu55uIPI1UyA7
         XaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307695; x=1730912495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YBwsUDgAdTeQCLcgQc+Qk068GyPLXcdvsLeO9HYQh0=;
        b=P7O3WJz02fDbKzoSUfM8whoq3u5TpSjoyHKOtkNVozO9H4p09/IP9qz4x7FzIrSe7t
         xXhjfzixAJpu3SeM3gppYBl76TBz5RzlEjYhr79PwdH9cZPt99F01e4RhMYq79cmnyBl
         PdS1TUHdc62KJLKVzT9+RfcknHihe/op4PcdjRnIbc3zRcoQhcPd1jD6nMp9BTztDtyQ
         qanBqFFT5np4YLmsIinlA1Rayg5lFrlL0lUZ3fD20gaX4Qt1g+sSE65UJmT5TXbi6CHU
         MURSg4573VhCJzjdwRptEvu2hzpQsV5ZM8jWnLsbtWhRe9+WszRMachEdN2P2eKkdMni
         DEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCURVioFwEU1vdIkNokT3kj+zcLwz1r/FYIzs1/A+X4RMrkSZaUZuO44y2hV0XFq2BftSSwJvI02yA0IaeYT@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHV34OG0370TQYNyRk91Gm/EpiQ6FGrnAIhZxMlxS7oVOnHbd
	EjIAG7BvBdUlDtubprLDXdMb1s24YypewbIIGgD2bd106zDblBxkHXi16SrSqawC+QXxSLcY43j
	gCinAx0h/MG2FdkkL5gwOy9kTmw==
X-Google-Smtp-Source: AGHT+IE5N4F+yBKgAiGWwpIZX+v9/JaGuSiuwDTn5vO4PPtFOZwMpFGYjEvGwDPhlJdza5xz+VoXNAcDPdUeiIdM2wo=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:ab43:0:b0:e28:fc1b:66bb with SMTP
 id 3f1490d57ef6-e30e5b33241mr64276.6.1730307695222; Wed, 30 Oct 2024 10:01:35
 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:01:14 +0000
In-Reply-To: <20241030170106.1501763-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5798; i=samitolvanen@google.com;
 h=from:subject; bh=xIC33Ds3wrL8SIvJ8KBatwbWfEydHQpWtWqC0C2qx6s=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOlKaWH33//oqv/7Ra7uz4kFO377/7IqSVBQnqG2VeKnU
 tr/fxrHOkpZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBETNkYGSbMZY9K9pnCfHvp
 1hZ7/qIl/SvPlTqXGHe5Frz0FihfxM7IcOPgZ8nTt4I69zdeKd72da20umP4Q1XBrQcke+bJ+dV xMgEA
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030170106.1501763-28-samitolvanen@google.com>
Subject: [PATCH v5 07/19] gendwarfksyms: Expand subroutine_type
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

Add support for expanding DW_TAG_subroutine_type and the parameters
in DW_TAG_formal_parameter. Use this to also expand subprograms.

Example output with --dump-dies:

  subprogram (
    formal_parameter pointer_type {
      const_type {
        base_type char byte_size(1) encoding(6)
      }
    }
  )
  -> base_type unsigned long byte_size(8) encoding(7)

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c         | 84 ++++++++++++++++++++++++++-
 scripts/gendwarfksyms/gendwarfksyms.h |  4 ++
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 1d67ee18a388..7e6b477d7c12 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -211,6 +211,15 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(byte_size)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
 
+/* Match functions -- die_match_callback_t */
+#define DEFINE_MATCH(type)                                     \
+	static bool match_##type##_type(Dwarf_Die *die)        \
+	{                                                      \
+		return dwarf_tag(die) == DW_TAG_##type##_type; \
+	}
+
+DEFINE_MATCH(formal_parameter)
+
 bool match_all(Dwarf_Die *die)
 {
 	return true;
@@ -223,19 +232,28 @@ int process_die_container(struct state *state, struct die *cache,
 	Dwarf_Die current;
 	int res;
 
+	/* Track the first item in lists. */
+	if (state)
+		state->first_list_item = true;
+
 	res = checkp(dwarf_child(die, &current));
 	while (!res) {
 		if (match(&current)) {
 			/* <0 = error, 0 = continue, >0 = stop */
 			res = checkp(func(state, cache, &current));
 			if (res)
-				return res;
+				goto out;
 		}
 
 		res = checkp(dwarf_siblingof(&current, &current));
 	}
 
-	return 0;
+	res = 0;
+out:
+	if (state)
+		state->first_list_item = false;
+
+	return res;
 }
 
 static int process_type(struct state *state, struct die *parent,
@@ -255,6 +273,40 @@ static void process_type_attr(struct state *state, struct die *cache,
 	process(cache, "base_type void");
 }
 
+static void process_list_comma(struct state *state, struct die *cache)
+{
+	if (state->first_list_item) {
+		state->first_list_item = false;
+	} else {
+		process(cache, " ,");
+		process_linebreak(cache, 0);
+	}
+}
+
+/* Comma-separated with DW_AT_type */
+static void __process_list_type(struct state *state, struct die *cache,
+				Dwarf_Die *die, const char *type)
+{
+	const char *name = get_name_attr(die);
+
+	process_list_comma(state, cache);
+	process(cache, type);
+	process_type_attr(state, cache, die);
+	if (name) {
+		process(cache, " ");
+		process(cache, name);
+	}
+}
+
+#define DEFINE_PROCESS_LIST_TYPE(type)                                       \
+	static void process_##type##_type(struct state *state,               \
+					  struct die *cache, Dwarf_Die *die) \
+	{                                                                    \
+		__process_list_type(state, cache, die, #type " ");           \
+	}
+
+DEFINE_PROCESS_LIST_TYPE(formal_parameter)
+
 /* Container types with DW_AT_type */
 static void __process_type(struct state *state, struct die *cache,
 			   Dwarf_Die *die, const char *type)
@@ -289,6 +341,29 @@ DEFINE_PROCESS_TYPE(shared)
 DEFINE_PROCESS_TYPE(volatile)
 DEFINE_PROCESS_TYPE(typedef)
 
+static void __process_subroutine_type(struct state *state, struct die *cache,
+				      Dwarf_Die *die, const char *type)
+{
+	process(cache, type);
+	process(cache, " (");
+	process_linebreak(cache, 1);
+	/* Parameters */
+	check(process_die_container(state, cache, die, process_type,
+				    match_formal_parameter_type));
+	process_linebreak(cache, -1);
+	process(cache, ")");
+	process_linebreak(cache, 0);
+	/* Return type */
+	process(cache, "-> ");
+	process_type_attr(state, cache, die);
+}
+
+static void process_subroutine_type(struct state *state, struct die *cache,
+				    Dwarf_Die *die)
+{
+	__process_subroutine_type(state, cache, die, "subroutine_type");
+}
+
 static void process_base_type(struct state *state, struct die *cache,
 			      Dwarf_Die *die)
 {
@@ -359,8 +434,11 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	PROCESS_TYPE(rvalue_reference)
 	PROCESS_TYPE(shared)
 	PROCESS_TYPE(volatile)
+	/* Subtypes */
+	PROCESS_TYPE(formal_parameter)
 	/* Other types */
 	PROCESS_TYPE(base)
+	PROCESS_TYPE(subroutine)
 	PROCESS_TYPE(typedef)
 	default:
 		debug("unimplemented type: %x", tag);
@@ -390,7 +468,7 @@ static void process_symbol(struct state *state, Dwarf_Die *die,
 static int __process_subprogram(struct state *state, struct die *cache,
 				Dwarf_Die *die)
 {
-	process(cache, "subprogram");
+	__process_subroutine_type(state, cache, die, "subprogram");
 	return 0;
 }
 
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 206ba8e3f1a8..d01fc1488f76 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -63,6 +63,7 @@ extern int dump_dies;
 #define checkp(expr) __check(expr, __res < 0)
 
 /* Consistent aliases (DW_TAG_<type>_type) for DWARF tags */
+#define DW_TAG_formal_parameter_type DW_TAG_formal_parameter
 #define DW_TAG_typedef_type DW_TAG_typedef
 
 /*
@@ -157,6 +158,9 @@ void die_map_free(void);
 struct state {
 	struct symbol *sym;
 	Dwarf_Die die;
+
+	/* List expansion */
+	bool first_list_item;
 };
 
 typedef int (*die_callback_t)(struct state *state, struct die *cache,
-- 
2.47.0.163.g1226f6d8fa-goog

