Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573901BE860
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743585; cv=none; b=kKU5EFWpB26T+XN7q/yTKVBEAHCO7nRtCVXr0W0cFZdlEhGgO7yCy4lby+eB6xWtPiTGH35xVE/44hAxUOnZepUfItdKtAndbECzeoENi4VZMupZC6rhdjlNuCWBpe3lYzF7yMyO59Mr4c9AmGI1nTgaWmZ1hiJNHzZ4vSyQoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743585; c=relaxed/simple;
	bh=6usSpOjyoB85v1SyjtEau1KushdvZAC0dNnzubRF5CM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2oz/RNtBUhZpGPQq7bIm7OidSfW+XnssJESMT20dcNf8B55E4xHzHIA59m37V2V4z3egcnZsxGjEkL4KLy+88Vgsd5zzuZgTZTeN6pcf1I8fgQv3+WDH8byyA/R0OrxZXJdhMr1iuCorLlh7kPtOzvzC4/Jys+4GUySBLu4oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jO236v+7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO236v+7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so20930677b3.3
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743582; x=1724348382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sPCSdATuewk8L2vh2ELF65Db7EveWl5UV4XCGQQVag=;
        b=jO236v+7UYB3Gp+aCNM29b3TpE4gidBBH3dSFfKxespEXI18DasXqFlUe5j3cJSgLn
         nCNM4xZm9D6VmU3pja6jIglkRNAQDgseFpgHWgXPK9of/TvX2hmMfEixuc4bcxBvWw2R
         3d4jgcyjyZBgaUQ3w7y7EivtNUuzurIL9s2uAJux9vHy9lOG5GNXck1URya4yfVtooIb
         96ZC3XCr86EhpzCuS9ujjzicSsszrPxjzzzJPkOc+fQG4IhY5NdDyCW0rDLR445KNwzV
         f7ITApuAL8tXX4YDxAFPYu8zEcLR6iYkyG3hTPXGTU8bmLDhGteu1Nt/ukQw75yVC1DD
         N7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743582; x=1724348382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sPCSdATuewk8L2vh2ELF65Db7EveWl5UV4XCGQQVag=;
        b=SGia8Ezat4HyHeHSJTJsZVKhad2WI0u7lAotMr0Lf2a6mdQzSF2apdRaIgx+szX/wm
         RpKQfidOP6wl6vGUna3uqtbkG7aaO1DG3dQTYhpgAsEoqiWs2rJAvCsK6kwbjwEZRpIB
         qs+f64YD/gXGpozPJ/MjKWQspUrGJVQNCozE6lrz09TMsHl9B0COLjN5p3mVLTG4ky6L
         kXzORBjq99HVKeTGkob4MXZTBZ6Mi+RREV75cIOtbWoUtB/l5QvmeihHC0xxZBgjjbzz
         z4bjtACMsjq6GNu1FbjYAvGqa5+j7Z2rCfW3JB9BBTKnusMSpFtxBGHfUh291uIb9wLC
         u/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWNR6poBmiXH3JgQqmpFFX2CkXfiULCSGFGtcwQyB7fZzcctuf+E1ZmzMEY4YqHjpzvpOodJB7phBRHI8SsxOR4VWNR2ZMAQsqyrSk6Ag==
X-Gm-Message-State: AOJu0Yzc9ki9/8CY9DsS+hfkjFgT29zI3X1kSvjAJt7HBmQcXKk1CaWk
	OfWDFBJZpRbQhfPwjpLkt24nWYrW646LVaEgZ6sLEmS0Y0F37W/632hHl1VaqVcNOOOaAaH/PCv
	dR/yBPo8AOjoOCUbKkmSVTH+arA==
X-Google-Smtp-Source: AGHT+IGwomnqFK9vxpKveGL73310JYatfAzfvmWx1tXBSFjJAlloAq4/X3L67g58vXf4su4on0aLpKym7vCztU318gc=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:b206:0:b0:e11:7039:ff92 with SMTP
 id 3f1490d57ef6-e1180f85427mr578276.11.1723743582318; Thu, 15 Aug 2024
 10:39:42 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:39:20 +0000
In-Reply-To: <20240815173903.4172139-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=10779; i=samitolvanen@google.com;
 h=from:subject; bh=6usSpOjyoB85v1SyjtEau1KushdvZAC0dNnzubRF5CM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmvj05/oGe5klinNb5fzf3qC/b17XaP5+AUar/1
 rfb+HhZKKSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZr49OQAKCRBMtfaEi7xW
 7knjC/9Rj2rfRBLkbJQwNXdd+nLnKm+A7ijeY86ZAot9zhxhsC+79B78LgVqGAM763CtUyRBomL
 HoVlsjF+VA8PgDH2FYjBG7AneizoXz+8X3I6nutdyvpcjvCjdvLGdWM/sg5WMSMRh1GC1tlfSFd
 jzNdwm0xuaBDj/KRkaAag8d2mf8vWUH6H3wrKfPLb+pJrFh+N0jLSun+8aWCvueKV18lNC7E+RA
 QkMEDucNM1meSnviUaK9lTKvvJ4Js5cEwv1uwR561At+8NNGMowtw7Owh0Mwi7DeEvHOgTos08P
 84Nju5yb8MVr4ibghgyWlHay6Cxn9fWsKsYomxZ4yoO9AFM21g4/BbNTa2q1aF1p2sxvIor1+IM
 QVk0eXSaJ4ucxSXxMpFYik77snFO1eFSx6Bp0+ipixkC3/HR7aMRWZfe/X+M0QQkTukH72nwFPG JWo674hXsfpS95FMkR8Io242ryKuayIhchn/NpPgF4PtEI8OaDI/0trSYUe5vLA87aoL4=
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815173903.4172139-37-samitolvanen@google.com>
Subject: [PATCH v2 16/19] gendwarfksyms: Add support for reserved structure fields
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Distributions that want to maintain a stable kABI need the ability to
add reserved fields to kernel data structures that they anticipate
will be modified during the ABI support timeframe, either by LTS
updates or backports.

With genksyms, developers would typically hide changes to the reserved
fields from version calculation with #ifndef __GENKSYMS__, which would
result in the symbol version not changing even though the actual type
of the reserved field changes. When we process precompiled object
files, this is again not an option.

To support stable symbol versions for reserved fields, change the
union type processing to recognize field name prefixes, and if the
union contains a field name that starts with __kabi_reserved, only use
the type of that field for computing symbol versions. In other words,
let's assume we have a structure where we want to reserve space for
future changes:

  struct struct1 {
    long a;
    long __kabi_reserved_0; /* reserved for future use */
  };
  struct struct1 exported;

gendwarfksyms --debug produces the following output:

  variable structure_type struct1 {
    member base_type long int byte_size(8) encoding(5) data_member_location(0),
    member base_type long int byte_size(8) encoding(5) data_member_location(8),
  } byte_size(16);
  #SYMVER exported 0x67997f89

To take the reserved field into use, a distribution would replace it
with a union, with one of the fields keeping the __kabi_reserved name
prefix for the original type:

  struct struct1 {
    long a;
    union {
      long __kabi_reserved_0;
      struct {
          int b;
          int v;
      };
    };

gendwarfksyms --debug now produces the following output:

  variable structure_type struct1 {
    member base_type long int byte_size(8) encoding(5) data_member_location(0),
    member union_type <unnamed> {
      member base_type long int byte_size(8) encoding(5),
      member structure_type <unnamed> {
        member base_type int byte_size(4) encoding(5) data_member_location(0),
        member base_type int byte_size(4) encoding(5) data_member_location(4),
      } byte_size(8),
    } byte_size(8) data_member_location(8),
  } byte_size(16);
  #SYMVER exported 0x66916c41

But with --stable, gendwarfksyms only uses the reserved field for the
version calculation, thus leaving the symbol version unchanged:

  variable structure_type struct1 {
    member base_type long int byte_size(8) encoding(5) data_member_location(0),
    member base_type long int byte_size(8) encoding(5) data_member_location(8),
  } byte_size(16);
  #SYMVER exported 0x67997f89

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/dwarf.c             | 148 +++++++++++++++++++++-
 scripts/gendwarfksyms/examples/reserved.c |  66 ++++++++++
 scripts/gendwarfksyms/gendwarfksyms.h     |  18 +++
 3 files changed, 229 insertions(+), 3 deletions(-)
 create mode 100644 scripts/gendwarfksyms/examples/reserved.c

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index bf28946c321e..d6252194692d 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -274,8 +274,12 @@ int process_die_container(struct state *state, struct die *cache,
 
 	res = checkp(dwarf_child(die, &current));
 	while (!res) {
-		if (match(&current))
-			check(func(state, cache, &current));
+		if (match(&current)) {
+			/* <0 = error, 0 = continue, >0 = stop */
+			res = checkp(func(state, cache, &current));
+			if (res)
+				return res;
+		}
 		res = checkp(dwarf_siblingof(&current, &current));
 	}
 
@@ -490,7 +494,145 @@ static int __process_structure_type(struct state *state, struct die *cache,
 
 DEFINE_PROCESS_STRUCTURE_TYPE(class)
 DEFINE_PROCESS_STRUCTURE_TYPE(structure)
-DEFINE_PROCESS_STRUCTURE_TYPE(union)
+
+static bool is_reserved_member(Dwarf_Die *die)
+{
+	const char *name = get_name(die);
+
+	return name && !strncmp(name, RESERVED_PREFIX, RESERVED_PREFIX_LEN);
+}
+
+static int __process_reserved_struct(struct state *state, struct die *cache,
+				     Dwarf_Die *die)
+{
+	Dwarf_Die type;
+
+	/*
+	 * If the union member is a struct, expect the placeholder type to
+	 * be the first member, i.e.:
+	 *
+	 * union {
+	 * 	type replaced_member;
+	 * 	struct {
+	 * 		type placeholder; // <- type
+	 * 	}
+	 * };
+	 *
+	 * Stop processing if this member isn't reserved.
+	 */
+	if (!is_reserved_member(die))
+		return NOT_RESERVED;
+
+	if (!get_ref_die_attr(die, DW_AT_type, &type)) {
+		error("structure member missing a type?");
+		return -1;
+	}
+
+	check(process_type(state, cache, &type));
+	return RESERVED;
+}
+
+static int __process_reserved_union(struct state *state, struct die *cache,
+				    Dwarf_Die *die)
+{
+	int res = NOT_RESERVED;
+	Dwarf_Die type;
+
+	if (!get_ref_die_attr(die, DW_AT_type, &type)) {
+		error("union member missing a type?");
+		return -1;
+	}
+
+	/*
+	 * We expect a union with two members. Check if either of them
+	 * has the reserved name prefix, i.e.:
+	 *
+	 * union {
+	 * 	...
+	 * 	type memberN; // <- type, N = {0,1}
+	 *	...
+	 * };
+	 *
+	 * The member can also be a structure type, in which case we'll
+	 * check the first structure member.
+	 *
+	 * Stop processing after we've seen two members.
+	 */
+	if (is_reserved_member(die)) {
+		check(process_type(state, cache, &type));
+		return RESERVED;
+	}
+
+	if (dwarf_tag(&type) == DW_TAG_structure_type)
+		res = checkp(process_die_container(state, cache, &type,
+						   __process_reserved_struct,
+						   match_member_type));
+	if (res != RESERVED && ++state->reserved.members < 2)
+		return 0; /* Continue */
+
+	return res;
+}
+
+static int process_reserved(struct state *state, struct die *cache,
+			    Dwarf_Die *die)
+{
+	if (!stable)
+		return NOT_RESERVED;
+
+	/*
+	 * To maintain a stable kABI, distributions may choose to reserve
+	 * space in structs for later use by adding placeholder members,
+	 * for example:
+	 *
+	 * struct s {
+	 * 	u64 a;
+	 *	// placeholder
+	 * 	u64 __kabi_reserved_0;
+	 * };
+	 *
+	 * When the reserved member is taken into use, the type change
+	 * would normally cause the symbol version to change as well, but
+	 * if the replacement uses the following convention, gendwarfksyms
+	 * continues to use the placeholder type for versioning instead,
+	 * thus maintaining the same symbol version:
+	 *
+	 * struct s {
+	 * 	u64 a;
+	 *	union {
+	 * 		// replaced member
+	 * 		struct t b;
+	 * 		struct {
+	 * 			// original placeholder
+	 * 			u64 __kabi_reserved_0;
+	 * 		};
+	 * 	};
+	 * };
+	 *
+	 * I.e., as long as the replaced member is in a union, and the
+	 * placeholder has a __kabi_reserved name prefix, we'll continue
+	 * to use the placeholder type (here u64) for version calculation
+	 * instead of the union type.
+	 *
+	 * Note that the user is responsible for ensuring that the
+	 * replacement type is ABI compatible with the placeholder type.
+	 */
+	state->reserved.members = 0;
+
+	return checkp(process_die_container(state, cache, die,
+					    __process_reserved_union,
+					    match_member_type));
+}
+
+static int process_union_type(struct state *state, struct die *cache,
+			      Dwarf_Die *die)
+{
+	if (checkp(process_reserved(state, cache, die)) == RESERVED)
+		return 0;
+
+	return check(__process_structure_type(state, cache, die, "union_type ",
+					      ___process_structure_type,
+					      match_all));
+}
 
 static int process_enumerator_type(struct state *state, struct die *cache,
 				   Dwarf_Die *die)
diff --git a/scripts/gendwarfksyms/examples/reserved.c b/scripts/gendwarfksyms/examples/reserved.c
new file mode 100644
index 000000000000..1e8de7ccd7d2
--- /dev/null
+++ b/scripts/gendwarfksyms/examples/reserved.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Google LLC
+ *
+ * Reserved data structure field example. See dwarf.c:process_reserved
+ * for details.
+ *
+ * $ gcc -g -c examples/reserved.c
+ *
+ * With --stable, only the reserved field placeholder is used for calculating
+ * symbol versions.
+ *
+ * $ echo exported0 | ./gendwarfksyms --stable --dump-dies reserved.o
+ * variable structure_type struct0 {
+ *   member base_type int byte_size(4) encoding(5) data_member_location(0),
+ *   member base_type long int byte_size(8) encoding(5) data_member_location(8),
+ * } byte_size(16)
+ *
+ * $ echo exported1 | ./gendwarfksyms --stable --dump-dies reserved.o
+ * variable structure_type struct1 {
+ *   member base_type int byte_size(4) encoding(5) data_member_location(0),
+ *   member base_type long int byte_size(8) encoding(5) data_member_location(8),
+ * } byte_size(16)
+ *
+ * $ echo exported2 | ./gendwarfksyms --stable --dump-dies reserved.o
+ * variable structure_type struct2 {
+ *   member base_type int byte_size(4) encoding(5) data_member_location(0),
+ *   member base_type long int byte_size(8) encoding(5) data_member_location(8),
+ * } byte_size(16)
+ */
+
+struct struct0 {
+	int a;
+	union {
+		long __kabi_reserved_0;
+		struct {
+			int b;
+			int c;
+		};
+	};
+};
+
+struct struct1 {
+	int a;
+	union {
+		struct {
+			int b;
+			int c;
+		};
+		long __kabi_reserved_1;
+	};
+};
+
+struct struct2 {
+	int a;
+	union {
+		unsigned long b;
+		struct {
+			long __kabi_reserved_1;
+		};
+	};
+};
+
+struct struct0 exported0;
+struct struct1 exported1;
+struct struct2 exported2;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 05b5c01b1c2a..963a07167892 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -220,12 +220,27 @@ extern void cache_clear_expanded(struct expansion_cache *ec);
 /*
  * dwarf.c
  */
+
+/* See dwarf.c:process_reserved */
+#define RESERVED_PREFIX "__kabi_reserved"
+#define RESERVED_PREFIX_LEN (sizeof(RESERVED_PREFIX) - 1)
+
 struct expansion_state {
 	bool expand;
 	bool in_pointer_type;
 	unsigned int ptr_expansion_depth;
 };
 
+enum reserved_status {
+	/* >0 to stop DIE processing */
+	NOT_RESERVED = 1,
+	RESERVED
+};
+
+struct reserved_state {
+	int members;
+};
+
 struct state {
 	Dwfl_Module *mod;
 	Dwarf *dbg;
@@ -235,6 +250,9 @@ struct state {
 	/* Structure expansion */
 	struct expansion_state expand;
 	struct expansion_cache expansion_cache;
+
+	/* Reserved members */
+	struct reserved_state reserved;
 };
 
 typedef int (*die_callback_t)(struct state *state, struct die *cache,
-- 
2.46.0.184.g6999bdac58-goog

