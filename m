Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F552741C7
	for <linux-modules@vger.kernel.org>; Mon,  5 May 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480251; cv=none; b=tr58ZwoX1LEsU2vL+YXh59vU27UB7mA/iuXuaxGa+h7cC2c51m4SSZaHpBAiP8bmEonEFlhf3eiMEbPhQvIoKqTwPqqaNIz1dZ/k/Bu5fQMim3Vk4x1WD21Z35zvwQkNxpNkFt/2Q621RrYzOPvDwAy30ILoZQ25weNN15PbMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480251; c=relaxed/simple;
	bh=BMC1eT/RW0qYKHRo26wre0JMFNFS6Nb4HECC0KqU2LQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VBRmsPk8XNgYWfcAJjuoLLqD64Z5v9912tTptmcInYYmy7FeVG4Ys5+cuFlrLWMIqPayVPBrnrvkrFiTS+swn19b58dXq37uMZmPdecBl2pb4cQ2m3ZboJZ3Wy9NbZiWXdiX8o7V8//mS3rnG2zdlvcHLtp5Y1h0yroT1RjNUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylPwRu0l; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylPwRu0l"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0b2de67d6aso5010684a12.1
        for <linux-modules@vger.kernel.org>; Mon, 05 May 2025 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746480249; x=1747085049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jC/VZcGrZa9gXKD1hXGwhYDV2p45vd0X27pWQ6osP7g=;
        b=ylPwRu0lWih8WReUK01TL3g9mQu6WfSePYwH2Rrd0uoD8bbK6aN7qYj0b9RtE3yM8N
         mfl8tH9TXlu4OTxTtBv6bxHrsbVQZS5YUnlNgKUm0y3lTAR3NwpTbAFgytOdh1hTUmZx
         Pp2yM5ULZD+hBaEmZEs2f+Md8aXt4uXonr5kehSKdxGpnXZvqEAuIvhjargj7tuWe5gp
         gzWM/XCQsKdJWu5o7LfeU/WcijUQhHd9A2JF9/xD4SucrD+dLilUfA4OgmKXTLx4yhuf
         2gJvH/rbIbAMPNHt6AR5TOJDOMdIoj8fpymzh0oog8kmwJmPLA0+6QVIPODX3fRUTsIl
         chtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746480249; x=1747085049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC/VZcGrZa9gXKD1hXGwhYDV2p45vd0X27pWQ6osP7g=;
        b=My8LLLgt+3cbN6QHL0fTvL6xiRsfGida4VIaKpCDhQ6RCy3jbq1RaMyJlsW0RRRWFD
         t2zFvl/ltQ+CAxBmigG+jygpkJFH3TMKy0zTOAoe6B8z8HFJtBPUDPIMOjS4e6WqjKSz
         x8Wxhbw99ChGW8+UgdVcHYr9+mkK9GrKumzoQ3lSd3UKMhHWyo1yi9us+aAs1mmBMFVy
         sGRTFrz/ZAA20wBjTqyKeJ/oMi+Zqj0s7y75W/yAcolatQ/4ql+Par5Kbzmx2HX9H2x3
         23vN+nS75Nd5nlXS1EZTOS6D5sLp+QnWBm+dyBOs3j8II4LCFboXc4gcDNhIZkQCAj3W
         KNtg==
X-Forwarded-Encrypted: i=1; AJvYcCVMNbxVJ3a9RbeKeav25iBsWYoVH4MgSIpOuxikxdcm/0avHCjIHlREo7aAhGCDx3u+Zmxktwl6DlzzzOLb@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFjF5HqQuFh+Pl3uHZGt8MixFqQEZdeaQdH8bLEx9V4WN62q7
	7IBgRbTMEaI+B5ocKM3dKan3K6NN7AceK66k3qVnrwLvZb+DYoVOmCVW2yyQ2rQ5Ko0TCQn0qBV
	Z2EcXgzvTov4F/PTwtnNII8B6iQ==
X-Google-Smtp-Source: AGHT+IHxEC//lhdl50TJGWOgJZvYzQz7UxUELZNKIrK0n3Gj3rXoLO1CenyTo5RcKY7BUjhcP4DyBTN76KDLLYT3nss=
X-Received: from pjbsb6.prod.google.com ([2002:a17:90b:50c6:b0:2ef:82c0:cb8d])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:544e:b0:30a:204e:3271 with SMTP id 98e67ed59e1d1-30a7e0b50c9mr722731a91.17.1746480249164;
 Mon, 05 May 2025 14:24:09 -0700 (PDT)
Date: Mon,  5 May 2025 21:24:04 +0000
In-Reply-To: <20250505212401.3379699-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250505212401.3379699-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7598; i=samitolvanen@google.com;
 h=from:subject; bh=BMC1eT/RW0qYKHRo26wre0JMFNFS6Nb4HECC0KqU2LQ=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBmSOkUCH3/PEvJ+fC/Q5kZlYcOMx/o6J2qUDjw04Ny38
 LX1z5rHHaUsDGIcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAie5kY/imt7vkuO808r+an
 hlrBD5bF9is3xTiynHEIvaz8oHPavDhGhseTFFhrJszZzTbxbutsYcGFX3d+thVSsv7ybOqJk4z LxVgB
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505212401.3379699-8-samitolvanen@google.com>
Subject: [PATCH v2 2/4] gendwarfksyms: Add a kABI rule to override byte_size attributes
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

A data structure can be partially opaque to modules if its
allocation is handled by the core kernel, and modules only need
to access some of its members. In this situation, it's possible
to append new members to the structure without breaking the ABI,
as long as the layout for the original members remains unchanged.
For example, consider the following struct:

  struct s {
          unsigned long a;
          void *p;
  };

gendwarfksyms --stable --dump-dies produces the following type
expansion:

  variable structure_type s {
    member base_type long unsigned int byte_size(8) encoding(7) a
      data_member_location(0) ,
    member pointer_type {
      base_type void
    } byte_size(8) p data_member_location(8)
  } byte_size(16)

To append new members, we can use the KABI_IGNORE() macro to
hide them from gendwarfksyms --stable:

  struct s {
          /* old members with unchanged layout */
          unsigned long a;
          void *p;

          /* new members not accessed by modules */
          KABI_IGNORE(0, unsigned long n);
  };

However, we can't hide the fact that adding new members changes
the struct size, as seen in the updated type string:

  variable structure_type s {
    member base_type long unsigned int byte_size(8) encoding(7) a
      data_member_location(0) ,
    member pointer_type {
      base_type void
    } byte_size(8) p data_member_location(8)
  } byte_size(24)

In order to support this use case, add a kABI rule that makes it
possible to override the byte_size attribute for types:

  /*
   * struct s allocation is handled by the kernel, so
   * appending new members without changing the original
   * layout won't break the ABI.
   */
  KABI_BYTE_SIZE(s, 16);

This results in a type string that's unchanged from the original
and therefore, won't change versions for symbols that reference
the changed structure.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c            | 14 ++++++++++++-
 scripts/gendwarfksyms/examples/kabi.h    |  7 +++++++
 scripts/gendwarfksyms/examples/kabi_ex.c |  2 ++
 scripts/gendwarfksyms/examples/kabi_ex.h | 22 +++++++++++++++++++++
 scripts/gendwarfksyms/gendwarfksyms.h    |  1 +
 scripts/gendwarfksyms/kabi.c             | 25 ++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index eed247d8abfc..13ea7bf1ae7d 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -228,12 +228,24 @@ static void process_fqn(struct die *cache, Dwarf_Die *die)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(accessibility)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(bit_size)
-DEFINE_PROCESS_UDATA_ATTRIBUTE(byte_size)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(data_bit_offset)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(data_member_location)
 DEFINE_PROCESS_UDATA_ATTRIBUTE(discr_value)
 
+static void process_byte_size_attr(struct die *cache, Dwarf_Die *die)
+{
+	Dwarf_Word value;
+	unsigned long override;
+
+	if (get_udata_attr(die, DW_AT_byte_size, &value)) {
+		if (stable && kabi_get_byte_size(cache->fqn, &override))
+			value = override;
+
+		process_fmt(cache, " byte_size(%" PRIu64 ")", value);
+	}
+}
+
 /* Match functions -- die_match_callback_t */
 #define DEFINE_MATCH(type)                                     \
 	static bool match_##type##_type(Dwarf_Die *die)        \
diff --git a/scripts/gendwarfksyms/examples/kabi.h b/scripts/gendwarfksyms/examples/kabi.h
index 97a5669b083d..86f4428e0479 100644
--- a/scripts/gendwarfksyms/examples/kabi.h
+++ b/scripts/gendwarfksyms/examples/kabi.h
@@ -89,6 +89,13 @@
 #define KABI_ENUMERATOR_VALUE(fqn, field, value) \
 	__KABI_RULE(enumerator_value, fqn field, value)
 
+/*
+ * KABI_BYTE_SIZE(fqn, value)
+ *   Set the byte_size attribute for the struct/union/enum fqn to
+ *   value bytes.
+ */
+#define KABI_BYTE_SIZE(fqn, value) __KABI_RULE(byte_size, fqn, value)
+
 /*
  * KABI_RESERVE
  *   Reserve some "padding" in a structure for use by LTS backports.
diff --git a/scripts/gendwarfksyms/examples/kabi_ex.c b/scripts/gendwarfksyms/examples/kabi_ex.c
index 0b7ffd830541..b73ee5399a59 100644
--- a/scripts/gendwarfksyms/examples/kabi_ex.c
+++ b/scripts/gendwarfksyms/examples/kabi_ex.c
@@ -28,3 +28,5 @@ struct ex2c ex2c;
 struct ex3a ex3a;
 struct ex3b ex3b;
 struct ex3c ex3c;
+
+struct ex4a ex4a;
diff --git a/scripts/gendwarfksyms/examples/kabi_ex.h b/scripts/gendwarfksyms/examples/kabi_ex.h
index 1736e0f65208..092c8cb7bcd7 100644
--- a/scripts/gendwarfksyms/examples/kabi_ex.h
+++ b/scripts/gendwarfksyms/examples/kabi_ex.h
@@ -260,4 +260,26 @@ _Static_assert(sizeof(struct ex3a) == sizeof(struct ex3c), "ex3a size doesn't ma
  * STABLE-NEXT: } byte_size(16)
  */
 
+/*
+ * Example: An ignored field added to an end of a partially opaque struct,
+ * while keeping the byte_size attribute unchanged.
+ */
+
+struct ex4a {
+	unsigned long a;
+	KABI_IGNORE(0, unsigned long b);
+};
+
+/*
+ * This may be safe if the structure allocation is managed by the core kernel
+ * and the layout remains unchanged except for appended new members.
+ */
+KABI_BYTE_SIZE(ex4a, 8);
+
+/*
+ * STABLE:      variable structure_type ex4a {
+ * STABLE-NEXT:   member base_type [[ULONG]] byte_size(8) encoding(7) a data_member_location(0)
+ * STABLE-NEXT: } byte_size(8)
+ */
+
 #endif /* __KABI_EX_H__ */
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 2feec168bf73..2db49c2ad50e 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -287,6 +287,7 @@ void generate_symtypes_and_versions(FILE *file);
  * kabi.c
  */
 
+bool kabi_get_byte_size(const char *fqn, unsigned long *value);
 bool kabi_is_enumerator_ignored(const char *fqn, const char *field);
 bool kabi_get_enumerator_value(const char *fqn, const char *field,
 			       unsigned long *value);
diff --git a/scripts/gendwarfksyms/kabi.c b/scripts/gendwarfksyms/kabi.c
index badf8d46b154..61620ff647bd 100644
--- a/scripts/gendwarfksyms/kabi.c
+++ b/scripts/gendwarfksyms/kabi.c
@@ -54,11 +54,19 @@
  */
 #define KABI_RULE_TAG_ENUMERATOR_VALUE "enumerator_value"
 
+/*
+ * Rule: byte_size
+ * - For the fqn_field in the target field, set the byte_size
+ *   attribute to the value in the value field.
+ */
+#define KABI_RULE_TAG_BYTE_SIZE "byte_size"
+
 enum kabi_rule_type {
 	KABI_RULE_TYPE_UNKNOWN,
 	KABI_RULE_TYPE_DECLONLY,
 	KABI_RULE_TYPE_ENUMERATOR_IGNORE,
 	KABI_RULE_TYPE_ENUMERATOR_VALUE,
+	KABI_RULE_TYPE_BYTE_SIZE,
 };
 
 #define RULE_HASH_BITS 7
@@ -127,6 +135,10 @@ void kabi_read_rules(int fd)
 			.type = KABI_RULE_TYPE_ENUMERATOR_VALUE,
 			.tag = KABI_RULE_TAG_ENUMERATOR_VALUE,
 		},
+		{
+			.type = KABI_RULE_TYPE_BYTE_SIZE,
+			.tag = KABI_RULE_TAG_BYTE_SIZE,
+		},
 	};
 
 	if (!stable)
@@ -308,6 +320,19 @@ bool kabi_get_enumerator_value(const char *fqn, const char *field,
 	return false;
 }
 
+bool kabi_get_byte_size(const char *fqn, unsigned long *value)
+{
+	struct rule *rule;
+
+	rule = find_rule(KABI_RULE_TYPE_BYTE_SIZE, fqn);
+	if (rule) {
+		*value = get_ulong_value(rule->value);
+		return true;
+	}
+
+	return false;
+}
+
 void kabi_free(void)
 {
 	struct hlist_node *tmp;
-- 
2.49.0.967.g6a0df3ecc3-goog

