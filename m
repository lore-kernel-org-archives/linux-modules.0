Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F601A2866
	for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115563; cv=none; b=HcSsa5mG7IbY/7H8VHL4P+NHF/nfmfOYzJArAp0F+I5bAXeJ7vLXdcko830zXmvyh41ku+jiqR+AUs5aSWF4w6xup1Lzf4Gm5J8XDC0RcXOH2LuGQNe7irYUFuNo0OkQyaOfZxOMNhxjxyUZNqO+//GtSYAXrH3c7J4nLoWoEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115563; c=relaxed/simple;
	bh=YnxRLubYaRu5LmAQuXzMlCDLmcU4MfVwQeLF/vCiIvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jz3Wi7WMZQyxkPWhqpt5qekZcPnu9zqya1DAd4PjBgBeaST44RWP0+8uEXuw9YDG4nI4Iq+oq2veudbqY7oWDfWz3jtz/HjFbWSFzNLfmFUxWU+hzf+UumKmv5JpJY/H90YwPaTgnRYBAbhMErO0hMNfAvx0Wn/idkPDFjq/4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNa6NkvD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNa6NkvD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7b696999c65so2999147a12.3
        for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727115560; x=1727720360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QY5Hy6t2hyco5Zb7/L0lbrSBcXnpHdZW8dyGEzKIpI=;
        b=mNa6NkvDDYsyzamhyHd7KZK2QiILEoVlXSM+cUxteSGkDk9CSRdt6Ouqw6ZBb9DDxr
         C8BMP0fYy2n3xsjcFW6NbJv+iCWFEbHCwJVTFRlWAN7fkPPt5GwCulQYlo8N7E8G7Yk4
         zPvr9htKiqlTJrpqPWyYM74/eTuAhDxdswIsGJf7BB5K3dd7o7JG5tZjU8Mq7rlp+9q4
         mlD5sOs5RBH+beCigRLC9ZZMIKAehKVxwAPnpmD2d8jJkMxarUJczlRCmo+LkKpUij9u
         cbmom7xeBG3yXJFbfsk0kjZBhDfJ3s8sTBbI4jiqSL7RPsBMZ9Oh2UyFgjrq68lzc5zl
         4NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115560; x=1727720360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QY5Hy6t2hyco5Zb7/L0lbrSBcXnpHdZW8dyGEzKIpI=;
        b=iBNGcwkjT3MBOkYFeKinipGL/UO1nz3HjdUYSCqj95offB3bNMVl661RI1tazpiZI6
         aX1qS22qGHpF6up0iTKJTWWdgKHmGBRxx0u37+CEjP/G/P35Vgrq5zTvNtdepyp4KMwa
         ElRvFErhxE+VkS/HMivZZah5qeoXLwAYiOTHWjRbeh49IryLVzDu2rhiqHJKObSIh5Uw
         hdjFLKCv/AbyTvAAlxoJB0IyxLFLTv17QiTwrq5a9k/w7wJJzHgYmKgI5oc7ETd7swZL
         r4x7hUI+aliQLmy2EPb2dUX4XK1TarfVachMGfXMPBnv+ffFfLqe8MdMtlv4j1+hpijk
         QTFw==
X-Forwarded-Encrypted: i=1; AJvYcCVyNHIFfwNmzj+IKXRmcXOyhz4nRiZ8SLiDOQCldp8+YtZBzSqgF3BZZb/99s4sRzepv/wBp5pSBfTzB53Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLyc24CyOBk16dY5lP6LvuoMVfRzsNaKla5SZWuAGWwZs1EAB
	qBVxKNY9poFwTO/pDXv5NAOAIEoRark8GI7ZB94s6crdwp/thh79I+ovkp+DQ5GW3dOiGK3d6Sb
	dOI6Xl3D+ue6H4I6XMZxI4cQZXg==
X-Google-Smtp-Source: AGHT+IF/yPm3Q7gCKUFaoUWev9k41igxQNUBQ8slxggC77S4yv3VXQoOTiBlJiL8f1t8waF428RuZmoZyGvu8Yp1D1o=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:b254:0:b0:7db:16b4:7a2a with SMTP
 id 41be03b00d2f7-7dcd3c474ebmr12955a12.2.1727115560447; Mon, 23 Sep 2024
 11:19:20 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:18:54 +0000
In-Reply-To: <20240923181846.549877-22-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=5712; i=samitolvanen@google.com;
 h=from:subject; bh=YnxRLubYaRu5LmAQuXzMlCDLmcU4MfVwQeLF/vCiIvY=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkfN3L1la67YPFtm47e9Yi7NkxCfamzy4XMLl5lj5m9K
 /rKixeLOkpZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE5r9nZNj8/vKiVccm/U9+
 vSH6zSWe6dpHn4hdKnzyTGDmnadP9eYbMDJ8stzpP0lousu3Q983X/VX5Gp0Fm4uvLfoveO/3H0 7CyUZAQ==
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923181846.549877-30-samitolvanen@google.com>
Subject: [PATCH v3 08/20] gendwarfksyms: Expand subroutine_type
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
---
 scripts/gendwarfksyms/dwarf.c         | 84 ++++++++++++++++++++++++++-
 scripts/gendwarfksyms/gendwarfksyms.h |  4 ++
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 50ef58591c83..5bdab5b80ca2 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -209,6 +209,15 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
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
@@ -221,19 +230,28 @@ int process_die_container(struct state *state, struct die *cache,
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
@@ -253,6 +271,40 @@ static void process_type_attr(struct state *state, struct die *cache,
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
@@ -287,6 +339,29 @@ DEFINE_PROCESS_TYPE(shared)
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
@@ -357,8 +432,11 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
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
@@ -388,7 +466,7 @@ static void process_symbol(struct state *state, Dwarf_Die *die,
 static int __process_subprogram(struct state *state, struct die *cache,
 				Dwarf_Die *die)
 {
-	process(cache, "subprogram");
+	__process_subroutine_type(state, cache, die, "subprogram");
 	return 0;
 }
 
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 81b8989efa22..d5186472f705 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -63,6 +63,7 @@ extern int dump_dies;
 #define checkp(expr) __check(expr, __res < 0)
 
 /* Consistent aliases (DW_TAG_<type>_type) for DWARF tags */
+#define DW_TAG_formal_parameter_type DW_TAG_formal_parameter
 #define DW_TAG_typedef_type DW_TAG_typedef
 
 /*
@@ -155,6 +156,9 @@ void die_map_free(void);
 struct state {
 	struct symbol *sym;
 	Dwarf_Die die;
+
+	/* List expansion */
+	bool first_list_item;
 };
 
 typedef int (*die_callback_t)(struct state *state, struct die *cache,
-- 
2.46.0.792.g87dc391469-goog

