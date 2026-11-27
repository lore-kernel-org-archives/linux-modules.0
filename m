Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737635;
	b=YJ5WpxmLuRpp3LOZ3grCZdX5k+z1A3ygPTlLNGeQIpTUEahjVxcNMIzoYUMmlmQFXVrb
	 RZn1CaeO+kcDrtjD9eEZxYNoH+KruWowUP+kWjrwrI5tu41oDWSSmi1ZmYAKI2gN7fsSl
	 iJMIz7AzbLoqTinitdBumYzAVTkcpQ7EAR1W2hcidO2wxf//vdhGmuIxVkByj8d2qK0Qp
	 j12iVhXCqf59QjYgCyOK4C0kcNkd5+ICC3SpKUmzk8cW0CSNbALds6sY0uKp8FBX8k8Ba
	 hsfEmiVHJlUW1f3OB4TX9ZVNkQR5iLDWzGgGpjmlSvE+uw2gfWVeaMMzE9n2XPIeFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ZS4M9vzsoQEiDgKwhqmCLRfcE4xcofQNd8Smal4Rhqg=;
	b=DHKhfVZEg0d6NQVXZrm+O/F5XbbaPQTbWG+GgzmZeBu9vSAkEeu196lgBgC+N7T+B76G
	 vNoUp6Gi8CutgvHnhgiCgWTCr/AUXUWv76npAdctVAz06N4/TYkwmU/y0S1nYQqHysu/H
	 WFkAuJnVPhCYMZirQX5oGG4wqTRXlobbNCWqhbCWhXibyJmBTihvEvPyzWmRrII2DBuVA
	 qrhpVQF+r1NpRsvd2LAtr4jxEMqXIL6MDI7VnZo8502iU9gDkDhekka1sYKLRaSdGYYbI
	 rYRXE5BHFseLvVspcbz5McKdEyfq7Lz/uURX283h1df7RT/jLLo9BAeDsLUaM0gXcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Mt/KSgkg";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D70606A329
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 00:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D70606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mt/KSgkg
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so4716938f8f.2
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 16:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795737633; x=1796342433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZS4M9vzsoQEiDgKwhqmCLRfcE4xcofQNd8Smal4Rhqg=;
        b=Mt/KSgkgl/l8dOWLOaIpHloyZ7dZtF3/CXDAJJ0CGVbt7VtLnH1tepmGQ2fxU88Flp
         ackkEtdBNcLKC5WsIcEOZJfUoN474zaIan+b/Yf4Foz15TV2Mw40t+WUETLRQvmHSH83
         T3NGMqxX4kxwN2d4njAkHHMU9aiiHevy3lOlOA9Ci7HOw8P6ma6VauG3tRruX3l1gMmZ
         J6M0xQ3fyeOevSCT90SfNBsSI2HO8v+2wiS17qFviqlqI4a5Gse12RmMEKy6icqIRoLO
         EbzTeTK5lmDtpzTkWQ9mL5wDe+mqONuqrBS/8RtqwLcHMMMAeMcDyt26iXOppJC8J8z3
         JyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795737633; x=1796342433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZS4M9vzsoQEiDgKwhqmCLRfcE4xcofQNd8Smal4Rhqg=;
        b=VD01PwjCKRbnY25n7lQ9Ec7om1a+bN26hcpXMq0jMdy9j+xKYEvuo4NxfY5F//TDeN
         zSxR/z3U/CSp3Cds+O7KBAoiSN88vWRTMKQsMwi9F4xO1O2a+zDcUzMxMnEeMbDFV6bN
         G1n8hu6gMemHkT7LQBqYl2O9Ft4gUdzU2+oVrAi96hPCzMp51sIf68uxAk2OdALOhZYp
         tWBm4+A0dBQOo9W+8L8f+kqth2RQyQ0ah4HpAs8uXgPunP2x30kpFE36ZYN+i2AcUgIc
         Fv40MEiN5DbYgTVgRW3Ip9cA9iIPn278qRqk5acM2lANQkSPFZlHlWHZnsSWR4BA4Dc4
         IIoA==
X-Forwarded-Encrypted: i=1; AL+hErGj5VYE8HQqLVoZbencSECXtZDdU8jrs1JK8lt4OXz+ZcSBUAMNr3fhyKRyJkqC69hrk0DCsRTZlssfJSRk@vger.kernel.org
X-Gm-Message-State: APuU4Z8vzUMUPOQzgrRLA8Sk7/FENYLatdiX+uzaQZ4iWCQ29Seq3QtE
	D2IEcgIF2zMN8XQiAmsc/ZOVXvRmHKC48XmwPJlTTjqYhixkcCOyogp7kNu1OaXkCfI=
X-Gm-Gg: AZFdTZeGF1CeY2bjDgddJdhSlVRfux640JYbyqBvk9wXUcVmea329CX92SktvvJjL4L
	TWiwl/thlXV1TZb8hGPSWopOx6l14VwTv1/fuxVEyuNKP4Ub39CLgN79cg/W+wFGyiWGpvy53+f
	WZBEKn6P+cByUZv+LROkDi25cQnS1+xeD4DzpZTcHd0BIm9GABXtuIgzOBmL+lK2PE6X2u3t+jz
	nOitGpL0tPTEqI4eUWPrikHNngo+NlADNwcPE45ZEr2aVKWqeBp8NaO3h8rMvBCoocGlYHBc25i
	was9F7Ol8IoRef7RKdH4RaPAbqiOaDVsjQgwcrZ5+r8262HfQiTve9jqfRn/gI5E+HAor+emfaf
	F75r/CbtCm2QAP+/o6uGpQ6Jy4cVN6ynThcfKB70ZaYMocxcgCUERWwCaXj8kczb9QEDIsWMHWR
	xTrb3KiI2a+RCYY12Rq21XC1o3XeI9nhYOOYWsO+3RoVEr9TJaAAfJdT0Ty4DIfoCREw5ZEtiFc
	qJUrbpFZRH0F+4RiBc4/b1TiSjI3o3F69QrdV4lQmJjnP0jA/KQi3A/hB0qIp7E5+jfvZKk0fs2
	/RWL43OXn1poYo84zFDn8S4clXZS4imIW08gtLphBhncCaryJfPExLsMk3c4gRMoEC3zAYUtjF4
	IoOdjKYEKlFiujH2mjA==
X-Received: by 2002:a05:6000:2505:b0:4af:7577:65b2 with SMTP id ffacd0b85a97d-4be44a3a2ddmr3371887f8f.52.1795737632762;
        Thu, 26 Nov 2026 16:00:32 -0800 (PST)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm45536616f8f.29.2026.11.26.16.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:00:32 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: samitolvanen@google.com,
	torvalds@linux-foundation.org,
	ljs@kernel.org,
	david.laight.linux@gmail.com,
	sashal@kernel.org,
	lzsx618@gmail.com,
	zuoan.penguin@gmail.com,
	petr.pavlu@suse.com,
	jani.nikula@intel.com,
	xur@google.com,
	sidnayyar@google.com,
	robertusdchris@gmail.com,
	acourbot@nvidia.com,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH 4/5] scripts: add bit count parameter back to the host hash table functions
Date: Fri, 27 Nov 2026 00:00:14 +0000
Message-ID: <20261127000015.3662267-5-julianbraha@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127000015.3662267-1-julianbraha@gmail.com>
References: <20261127000015.3662267-1-julianbraha@gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This partially reverts commit 0a3128e75108 ("kconfig: add macros useful
for hashtable").
 
As Linus noted when reporting the 'make oldconfig' performance issue,
when the kernel's internal hash table implementation was copied over for
Kconfig to use, it also improperly simplified the parameters of
DECLARE_HASHTABLE() and DEFINE_HASHTABLE() to take "sizes" instead of the
actual number of bits, and passed '(key) % HASH_SIZE(table)' to
hash_head() instead of using the high hash bits.

Let's revert these simplifications:
1. DECLARE_HASHTABLE() and DEFINE_HASHTABLE() will take the bit count, and
2. hash_head() will call hash_min() to select a bucket using the high bits

Note that HASH_BITS should call ilog2() but that drags in a ton more
dependencies, so instead just use __builtin_ctzll() to count the leading
zeroes since the hash table size can only be a power of 2.

Add back hash_min() from the in-kernel implementation to select hash_32()
for keys of up to 4 bytes and hash_long() for wider keys.

Accordingly, update the callers of DECLARE_HASHTABLE() and
DEFINE_HASHTABLE(). In genksyms, use uint32_t for the CRC key in
__add_symbol(). This gives insertion and lookup the same key size on
64-bit hosts.

Fixes: 0a3128e75108 ("kconfig: add macros useful for hashtable")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/all/CAHk-=wi_GuySe0L-uCAM2+nScCLYGBp5BLi6UUPR1gALmNM_3w@mail.gmail.com/
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Originally, I copied over log.h to use ilog2() as the in-kernel
HASH_BITS does, but then we need to bring over and adjust a bunch of other
header dependencies like fls.h and fls64.h and then __fls.h and so on.

If anyone hates the trailing zeroes hack, I am open to suggestions.
---
 scripts/gendwarfksyms/die.c           |  2 +-
 scripts/gendwarfksyms/gendwarfksyms.h |  2 +-
 scripts/gendwarfksyms/kabi.c          |  2 +-
 scripts/gendwarfksyms/symbols.c       |  4 ++--
 scripts/gendwarfksyms/types.c         |  2 +-
 scripts/genksyms/genksyms.c           |  4 ++--
 scripts/include/hashtable.h           | 24 ++++++++++++++++++------
 scripts/kconfig/expr.c                |  2 +-
 scripts/kconfig/internal.h            |  8 ++++----
 scripts/kconfig/symbol.c              |  2 +-
 scripts/kconfig/util.c                |  2 +-
 scripts/mod/modpost.c                 |  2 +-
 12 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/scripts/gendwarfksyms/die.c b/scripts/gendwarfksyms/die.c
index 79d738e69ce5..32b0be8fca78 100644
--- a/scripts/gendwarfksyms/die.c
+++ b/scripts/gendwarfksyms/die.c
@@ -9,7 +9,7 @@
 #define DIE_HASH_BITS 16
 
 /* {die->addr, state} -> struct die * */
-static DEFINE_HASHTABLE(die_map, 1 << DIE_HASH_BITS);
+static DEFINE_HASHTABLE(die_map, DIE_HASH_BITS);
 
 static unsigned int map_hits;
 static unsigned int map_misses;
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index c987acbbf1ef..58d6b20d504e 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -208,7 +208,7 @@ void die_map_free(void);
 
 /* A cache for addresses we've already seen. */
 struct cache {
-	DECLARE_HASHTABLE(cache, 1 << CACHE_HASH_BITS);
+	DECLARE_HASHTABLE(cache, CACHE_HASH_BITS);
 };
 
 void cache_set(struct cache *cache, unsigned long key, int value);
diff --git a/scripts/gendwarfksyms/kabi.c b/scripts/gendwarfksyms/kabi.c
index 35c70a6230d9..9589de2aaba4 100644
--- a/scripts/gendwarfksyms/kabi.c
+++ b/scripts/gendwarfksyms/kabi.c
@@ -87,7 +87,7 @@ struct rule {
 };
 
 /* { type, target } -> struct rule */
-static DEFINE_HASHTABLE(rules, 1 << RULE_HASH_BITS);
+static DEFINE_HASHTABLE(rules, RULE_HASH_BITS);
 
 static inline unsigned int rule_values_hash(enum kabi_rule_type type,
 					    const char *target)
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index a87444611bbd..2fac17ecac21 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -9,9 +9,9 @@
 #define SYMBOL_HASH_BITS 12
 
 /* struct symbol_addr -> struct symbol */
-static DEFINE_HASHTABLE(symbol_addrs, 1 << SYMBOL_HASH_BITS);
+static DEFINE_HASHTABLE(symbol_addrs, SYMBOL_HASH_BITS);
 /* name -> struct symbol */
-static DEFINE_HASHTABLE(symbol_names, 1 << SYMBOL_HASH_BITS);
+static DEFINE_HASHTABLE(symbol_names, SYMBOL_HASH_BITS);
 
 static inline unsigned int symbol_addr_hash(const struct symbol_addr *addr)
 {
diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index db55c8ae57f8..864ad6ee5c3e 100644
--- a/scripts/gendwarfksyms/types.c
+++ b/scripts/gendwarfksyms/types.c
@@ -100,7 +100,7 @@ static void type_expansion_append(struct type_expansion *type, const char *s,
  * const char *name -> struct type_expansion *
  */
 #define TYPE_HASH_BITS 12
-static DEFINE_HASHTABLE(type_map, 1 << TYPE_HASH_BITS);
+static DEFINE_HASHTABLE(type_map, TYPE_HASH_BITS);
 
 static int __type_map_get(const char *name, struct type_expansion **res)
 {
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 01bea2d91d7a..fe45a9cb6938 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -24,7 +24,7 @@
 #include "genksyms.h"
 /*----------------------------------------------------------------------*/
 
-static DEFINE_HASHTABLE(symbol_hashtable, 1U << 12);
+static DEFINE_HASHTABLE(symbol_hashtable, 12);
 static FILE *debugfile;
 
 int cur_line = 1;
@@ -228,7 +228,7 @@ static struct symbol *__add_symbol(const char *name, enum symbol_type type,
 			    struct string_list *defn, int is_extern,
 			    int is_reference)
 {
-	unsigned long h;
+	uint32_t h;
 	struct symbol *sym;
 	enum symbol_status status = STATUS_UNCHANGED;
 
diff --git a/scripts/include/hashtable.h b/scripts/include/hashtable.h
index fa60976eae37..069fde323419 100644
--- a/scripts/include/hashtable.h
+++ b/scripts/include/hashtable.h
@@ -3,17 +3,29 @@
 #define HASHTABLE_H
 
 #include "array_size.h"
+#include "hash.h"
 #include "list.h"
 
-#define HASH_SIZE(name) (ARRAY_SIZE(name))
+#define DEFINE_HASHTABLE(name, bits)						\
+	struct hlist_head name[1 << (bits)] =					\
+			{ [0 ... ((1 << (bits)) - 1)] = HLIST_HEAD_INIT }
+
+#define DECLARE_HASHTABLE(name, bits)						\
+	struct hlist_head name[1 << (bits)]
 
-#define DECLARE_HASHTABLE(name, size)		struct hlist_head name[size]
+#define HASH_SIZE(name) (ARRAY_SIZE(name))
+/*
+ * HACK: Since the hash table length is always power-2, just count the
+ * trailing zeroes to avoid pulling in the log header (and dependencies.)
+ */
+#define HASH_BITS(name) __builtin_ctzll(HASH_SIZE(name))
 
-#define DEFINE_HASHTABLE(name, size)						\
-	DECLARE_HASHTABLE(name, size) =						\
-			{ [0 ... ((size) - 1)] = HLIST_HEAD_INIT }
+/* Use hash_32 when possible to allow for fast 32bit hashing on 64bit hosts. */
+#define hash_min(val, bits)							\
+	(sizeof(val) <= 4 ? hash_32(val, bits) : hash_long(val, bits))
 
-#define hash_head(table, key)		(&(table)[(key) % HASH_SIZE(table)])
+#define hash_head(table, key)							\
+	(&(table)[hash_min(key, HASH_BITS(table))])
 
 static inline void __hash_init(struct hlist_head *ht, unsigned int sz)
 {
diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 5938b775a3fc..8dc73acb08ad 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -16,7 +16,7 @@
 
 #define DEBUG_EXPR	0
 
-DEFINE_HASHTABLE(expr_hashtable, EXPR_HASHSIZE);
+DEFINE_HASHTABLE(expr_hashtable, EXPR_HASH_BITS);
 
 static struct expr *expr_eliminate_yn(struct expr *e);
 
diff --git a/scripts/kconfig/internal.h b/scripts/kconfig/internal.h
index f7e660dbd299..d40fa33991a6 100644
--- a/scripts/kconfig/internal.h
+++ b/scripts/kconfig/internal.h
@@ -4,16 +4,16 @@
 
 #include <hashtable.h>
 
-#define SYMBOL_HASHSIZE		(1U << 14)
+#define SYMBOL_HASH_BITS	14
 
-extern DECLARE_HASHTABLE(sym_hashtable, SYMBOL_HASHSIZE);
+extern DECLARE_HASHTABLE(sym_hashtable, SYMBOL_HASH_BITS);
 
 #define for_all_symbols(sym) \
 	hash_for_each(sym_hashtable, sym, node)
 
-#define EXPR_HASHSIZE		(1U << 14)
+#define EXPR_HASH_BITS		14
 
-extern DECLARE_HASHTABLE(expr_hashtable, EXPR_HASHSIZE);
+extern DECLARE_HASHTABLE(expr_hashtable, EXPR_HASH_BITS);
 
 void expr_invalidate_all(void);
 
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index e46228d6348e..b3135d18fe61 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -971,7 +971,7 @@ bool sym_is_choice_value(const struct symbol *sym)
 	return !list_empty(&sym->choice_link);
 }
 
-DEFINE_HASHTABLE(sym_hashtable, SYMBOL_HASHSIZE);
+DEFINE_HASHTABLE(sym_hashtable, SYMBOL_HASH_BITS);
 
 struct symbol *sym_lookup(const char *name, int flags)
 {
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index d2d17d9d37b9..5c3f6f99c453 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -14,7 +14,7 @@
 #include "lkc.h"
 
 /* hash table of all parsed Kconfig files */
-static DEFINE_HASHTABLE(file_hashtable, 1U << 11);
+static DEFINE_HASHTABLE(file_hashtable, 11);
 
 struct file {
 	struct hlist_node node;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 92bcd2b3a08e..c46dc74d6880 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -234,7 +234,7 @@ struct symbol {
 	char name[];
 };
 
-static DEFINE_HASHTABLE(symbol_hashtable, 1U << 10);
+static DEFINE_HASHTABLE(symbol_hashtable, 10);
 
 /**
  * Allocate a new symbols for use in the hash of exported symbols or
-- 
2.56.0

