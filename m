Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E36198E7A
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647119; cv=none; b=DMi5qLnyKsH1sWhCyD24otkbaFiXdnVDC+Dkq3UzVvDEYoqL5CwjaSHJHgAniIZOZasSo0WiQU4c3+0V04t+5aUqT7pVuGTmuYTPqJ33cTh5GqwkaYrFLKN25VwWHUwItyY1utWhJ/KRzFNmVd/RRMKu8Qg/koZLtY0N37vgzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647119; c=relaxed/simple;
	bh=H5KOAGVfXZJmk+NFA/+tTZJYgSeCRqBkuPOyQyavQG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qfBW94dvHPfjt4OmcXhEbwgQSXYMc5AQP/fXiKd3KStUmzMepgfzsaIueiWhoBYzgL6eQx0cL/TuFm1p3AJpqobs2UERHxBDdMXWxfNtrjnOqNqLQusWPP1E/cOhGennAkXZ4IOrqt0QN+TAD5G8PKjKRXRntklqM6XP5PUOKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvO3rxY5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvO3rxY5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb36d7f5fso93250717b3.1
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647116; x=1719251916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+S9saSNPIU2DvcxL2+Yd4Qfr8i4F6S0XsoNHIuu5T8=;
        b=AvO3rxY5Rqoo/3Loe7xBdFJkw1ArGorxUiNemlXstklNlSWR3hcDEsxEl2BOLJLNCj
         xMcv5ZsSl6ZmL3tW97My7zcMjTX+wfZWhJyX71WvvCvCzP+WWed/xKNQyMQlO7rH4H1G
         fZ6Or8kaM6BR6GSHqWA703wNHg6Nxl+iIwAEG3fNHa/ROiKijEDUgt1AThhcY2TLedux
         tBO41Un9nfjV9UxlBb6eU84v5FeBvzWueud9yX1pvO3p0K7p3UoAB2wI8JzxpKD6JP3m
         1eOHKLawLl4uxld6X/43/EDxCRGj5mTq4q5KwZ2V/wX/3won/9j04Ap20GcavI58dCO6
         yMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647116; x=1719251916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+S9saSNPIU2DvcxL2+Yd4Qfr8i4F6S0XsoNHIuu5T8=;
        b=JAkkEMUVwQz3Js91ap8a50lG9z3jMpg3EcdrKFBTjzWL06cTM/nG6JR2tsysulUjjL
         nQwid+p+JYtKZJmZyWcyVP5ofAbVSUiJSxDqryBVuwTKjuZh/Xg2Gshy9wxIbZkhrJ4V
         E0lYDnmB0yoX27/K6KYEUeMLW/QqJZ2CKOIU35/3XW6aPXzUPmKLZN1ABRqXnvly5oZc
         u0t85gJ2Ss9Sho2GPkTCOX+89oesZZUG8UNwhDUe2RMXp1/SIxFi6BHE12gtpkKu0UeR
         VPI+Tgi7TDHAT9laiT7jwazggqg8XJQeoTi42mR+mW0o7cFu7JrIunIaLXBYGf6qrhDS
         XNAw==
X-Forwarded-Encrypted: i=1; AJvYcCV0GbziNbO2CLmp5I9qhTlXyiGmvFKxERxe0Rb9YgKteKfflKWPJuhbHUDS/O5+pLRjc8I5k/clT41Ah/n4GVJPlHUjxN1+QyfHwPVwEA==
X-Gm-Message-State: AOJu0YwjXBX0BEpqmp2tRfSWpGDBthCFBMYgPup+K1rHv4ZCx0/CPzvo
	Pu8kxxwxhJiL0LC/ff+FCwTIPxjDSWadu0zv++rZ9Hq/mcx6P0M+9WbQobgDTwJaX2cxggpgNHA
	KkIFhq7JWAqF7NNPRzg7TLdIn5g==
X-Google-Smtp-Source: AGHT+IFjn+P7dntCkJGcXDizaFOTyUC5TJtnxV3JuDKw8gokiADeudVJlIIDrCQw9XX+W0DpQxsG2TQfoKQpJcPc50A=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:690c:4805:b0:61b:e8a2:6f4a with
 SMTP id 00721157ae682-6321f394015mr24272597b3.0.1718647116640; Mon, 17 Jun
 2024 10:58:36 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:25 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=samitolvanen@google.com;
 h=from:subject; bh=H5KOAGVfXZJmk+NFA/+tTZJYgSeCRqBkuPOyQyavQG4=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk7XOzd3feUM+aCz1uQk58MOC7SFsXRgcHVJ
 2Cr3YT25d6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5OwAKCRBMtfaEi7xW
 7i7sC/9IKFDIzWVj80laMn3YewIUn9B0VnVGxVyfYcDHFQBNvs8TwXJp1/r7rwaf4jCShPXU/fo
 VvEjLjpFPq7PcGpp6Ms+UbfYLbjSWuWqk9M/nG4styfZY47IL8nKll3iYCYWbjF634wrvtxmK/e
 zkRnjlNKVJjoo3JNsNVbOwyzDYqxjpNzpj6Snx2zqWF1U1XJUGGSx9SHMnPr+ribEOTmQg8iLwM
 fw6jrr/SKxQ74+mguDDA2vKa5bNIFyG0k7LNa2x7dusc/InRuJg0FM1EDOpb1YPhZUTn6juIxvh
 lkRMZ6KeNDnQ55vwScYhMyURHfLMnO7Yb8Ob+hVz0EQpAtDQHV2qkUUVYwaDqWArOYtMWizh2HO
 co7oRCSLSpMI0/5M9qyhR9cCzHFHeZRMT+SibSvpki7tB66F8g2Wz9/QcMQa7/cB1yeetc6cuhj oeHQIkrcSRnmuTClrAAJu+MKgs8Ybaa8Ud9TXo4kXqj4qZSm6EN85YTqiroM6oj8OFh04=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-23-samitolvanen@google.com>
Subject: [PATCH 06/15] gendwarfksyms: Expand type modifiers and typedefs
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for expanding DWARF type modifiers, such as pointers,
const values etc., and typedefs. These types all have DW_AT_type
attribute pointing the underlying type, and thus produce similar
output.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/gendwarfksyms/gendwarfksyms.h |  3 ++
 tools/gendwarfksyms/types.c         | 54 +++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/gendwarfksyms/gendwarfksyms.h b/tools/gendwarfksyms/gendwarfksyms.h
index ea5a9fbda66f..d5ebfe405445 100644
--- a/tools/gendwarfksyms/gendwarfksyms.h
+++ b/tools/gendwarfksyms/gendwarfksyms.h
@@ -50,6 +50,9 @@ extern bool no_cache;
 		__res;                                          \
 	})
 
+/* Consistent aliases (DW_TAG_<type>_type) for DWARF tags */
+#define DW_TAG_typedef_type DW_TAG_typedef
+
 /*
  * symbols.c
  */
diff --git a/tools/gendwarfksyms/types.c b/tools/gendwarfksyms/types.c
index 78046c08be23..27169c77937f 100644
--- a/tools/gendwarfksyms/types.c
+++ b/tools/gendwarfksyms/types.c
@@ -189,6 +189,38 @@ static int process_type_attr(struct state *state, struct cached_die *cache,
 	return check(process(state, cache, "base_type void"));
 }
 
+/* Container types with DW_AT_type */
+static int __process_type(struct state *state, struct cached_die *cache,
+			  Dwarf_Die *die, const char *type)
+{
+	check(process(state, cache, type));
+	check(process_fqn(state, cache, die));
+	check(process(state, cache, " {"));
+	check(process_type_attr(state, cache, die));
+	check(process(state, cache, "}"));
+	check(process_byte_size_attr(state, cache, die));
+	return check(process_alignment_attr(state, cache, die));
+}
+
+#define DEFINE_PROCESS_TYPE(type)                                              \
+	static int process_##type##_type(                                      \
+		struct state *state, struct cached_die *cache, Dwarf_Die *die) \
+	{                                                                      \
+		return __process_type(state, cache, die, #type "_type ");      \
+	}
+
+DEFINE_PROCESS_TYPE(atomic)
+DEFINE_PROCESS_TYPE(const)
+DEFINE_PROCESS_TYPE(immutable)
+DEFINE_PROCESS_TYPE(packed)
+DEFINE_PROCESS_TYPE(pointer)
+DEFINE_PROCESS_TYPE(reference)
+DEFINE_PROCESS_TYPE(restrict)
+DEFINE_PROCESS_TYPE(rvalue_reference)
+DEFINE_PROCESS_TYPE(shared)
+DEFINE_PROCESS_TYPE(volatile)
+DEFINE_PROCESS_TYPE(typedef)
+
 static int process_base_type(struct state *state, struct cached_die *cache,
 			     Dwarf_Die *die)
 {
@@ -233,6 +265,11 @@ static void state_init(struct state *state)
 	state->crc = 0xffffffff;
 }
 
+#define PROCESS_TYPE(type)                                       \
+	case DW_TAG_##type##_type:                               \
+		check(process_##type##_type(state, cache, die)); \
+		break;
+
 static int process_type(struct state *state, struct cached_die *parent,
 			Dwarf_Die *die)
 {
@@ -254,9 +291,20 @@ static int process_type(struct state *state, struct cached_die *parent,
 	}
 
 	switch (tag) {
-	case DW_TAG_base_type:
-		check(process_base_type(state, cache, die));
-		break;
+	/* Type modifiers */
+	PROCESS_TYPE(atomic)
+	PROCESS_TYPE(const)
+	PROCESS_TYPE(immutable)
+	PROCESS_TYPE(packed)
+	PROCESS_TYPE(pointer)
+	PROCESS_TYPE(reference)
+	PROCESS_TYPE(restrict)
+	PROCESS_TYPE(rvalue_reference)
+	PROCESS_TYPE(shared)
+	PROCESS_TYPE(volatile)
+	/* Other types */
+	PROCESS_TYPE(base)
+	PROCESS_TYPE(typedef)
 	default:
 		debug("unimplemented type: %x", tag);
 		break;
-- 
2.45.2.627.g7a2c4fd464-goog

