Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFB29DB81
	for <linux-modules@vger.kernel.org>; Wed, 30 Apr 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049260; cv=none; b=Uk1IiwhUnNB71vjBAlnvtFXTSM8reIgqGuodirlmayQ72+M1Aj6dp/MVFbn3qdehIxGJtoct/8d9gBQ88HU6/yMsa1IFebanRoSrmHk3LPlxfZL7HJIfiJXD+/LdfkP9lu9WyPOaaECh9VXlSOkxVL/vrwBm6PtJP6rq9L1/MB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049260; c=relaxed/simple;
	bh=NugwJ2EAbfyS2hOmEh53DRrt4jtmrUq5uiPJk9sMyvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LklwAm5NkWJQTHyoQHaqMs+l3/muYgdNjgQkFW+5++LY+OmmCP7R7r9YVsEAy4HcP3mIqPVrUOWy1vgzFxvLy/2MVEy9qQdJfyDxiABHYYy9w05EI5kgsAYazXETrUy9BKe4P0/mjI1vESNfFzibLJdLgRMDTsCHqoooXsr32wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLHeSiyy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLHeSiyy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-227ed471999so2419475ad.3
        for <linux-modules@vger.kernel.org>; Wed, 30 Apr 2025 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746049258; x=1746654058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0wg72VP+xfWBCWqXGdsH9xJWL3ReO7P3OtwjDvLDRA=;
        b=mLHeSiyyDHcGsdJJQD8xbeh7UJVQ3FLXxle3PoY4UFnjTl6Uj11mzE3K3qu0YZ77ew
         8EKF1DZntdHItT/DqK4OPRQdVq8/rRfL/OoZSkCQjcemX3ScnYQgkoyOiVxDa25J4cIk
         K9voNXffvptWB4PM6bzAIJuFbJZSPEaJruWbmdKsJBJ8XIvHkpLxFkg2VKwu522sa+8J
         IUUfDbhH5LA0zgLNXnnN9/t/g2GHE3TZK2tu22gsN3U/LM3MXNk+xmzOqAOjEBSk72ec
         kwhKFWzmEKFbDQvvhll8NHeGhgrg1WqEm9Pl3a2Hg/Wbv4Nm18BHEQaZWSqIwtQtM8SB
         Vthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746049258; x=1746654058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0wg72VP+xfWBCWqXGdsH9xJWL3ReO7P3OtwjDvLDRA=;
        b=g7lOhkNvrxo0Wrf3vAw98VGsUxegIKNB3BPd+2x2Pzi8j2Jk5MuTTw1L6wI9N4EEZo
         y8U164IQBEhdsYRQbLSsMUC52dQtHPJcsnfiHVXCWJnm8h431/+0pjLu3p6ixW2HiqqE
         +8eE5PYbf53jheTdtyiiBf6IdDY6Bydp/9cOAulPdBuuEcdM5phbLjjHIiLK84IeFf9J
         61Kjeq1ELD+uvfB5/F6XnZk05Axpc/u5eAIVr1lFAvDACKeCU2JVu51ZIBWSJEzhQ0Mk
         9109RdQ9anhVuaLNz9rQQl4ffg8xWu9ViM2+iPEiV6H53zTb4lZR1O32ocTtB/M5j2T+
         Y30Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6Em7nm7pxKA6j1calb7cOPvn/Q/JCcXt4ob6V5+sJKBtvYw14fKQCYNIHxHNMG54jcwUaXyhbqs32OImh@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZTUekTFkPKybrd/HGuSjRjlbPTblYneYRFyksaYz4gkeuZae
	4bJpjDfElfgz2sCl5p+o1oXI9fnPcaembUP3WrHoJcxx4zXayDdkmpj7cYBXSxQ91hthcvr+JEq
	cDBhEwu0Oy7JY2x+ph3FiRpyyWw==
X-Google-Smtp-Source: AGHT+IFmNjTg46QUuI9pZ6ComxQoEkoxNQLVPQK6W2Q4FMpSU0ZrS5Vkdowl6cN4/D79sGMc5bh05TwdGSTrVoEB/4k=
X-Received: from plrp19.prod.google.com ([2002:a17:902:b093:b0:21f:56e1:c515])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da90:b0:223:66bb:8995 with SMTP id d9443c01a7336-22e08429875mr1067655ad.20.1746049258046;
 Wed, 30 Apr 2025 14:40:58 -0700 (PDT)
Date: Wed, 30 Apr 2025 21:40:52 +0000
In-Reply-To: <20250430214049.2658716-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430214049.2658716-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=7551; i=samitolvanen@google.com;
 h=from:subject; bh=NugwJ2EAbfyS2hOmEh53DRrt4jtmrUq5uiPJk9sMyvs=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBlCMx4lHvCbeSsn2naTzbyTf9QmFW+ce+hW8sLFG7drZ
 buabu+O6yhlYRDjYJAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQATUfjN8D97QdVMlX7meZOm
 zTo7b6Z55VmTOiXWpi0R81Yz2eZaSfxlZHjf865blmFbfPmTpJOraoKsT1adUmlfU/oic5HWVP3 fm5gA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430214049.2658716-8-samitolvanen@google.com>
Subject: [PATCH 2/4] gendwarfksyms: Add a kABI rule to override byte_size attributes
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
2.49.0.906.g1f30a19c02-goog

