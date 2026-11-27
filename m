Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795737628;
	b=ZB9DUGxEIFwYnYKDm021S/YU/xCUYo3zcxpkRXR/XkNvqWI/2rrC5roCyPfGO2r7C8Yw
	 45ISHrfZvjJqgzLJ5opAqvJ/0Zd2slgDOSvjKzPlELYGvD+YziicfmwSjw6CIoILdGrvV
	 p0xtA1KanNXxEkw9crUzfdGJH9KWugfHf7qPLjVUbIRNeDHDJQDlZDr7/WvGderQZCgd7
	 RO7hi7Bpl62nyXgxVUm7NhYn23Q9+kRnrDh/gGySp/ZUV8PStIoAABk8jVBip16uBF4RD
	 I7Zte7Yt+c6C2m1la9llEeUPkHJTqE6SnvarMz8nsBK/NfFeqo+47xccXQv+dZ9IxTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795737628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=grCsO3t7RryGcMPafQtIp1Wlmc4uzvXZdwkseXZWrL0=;
	b=byaMY+PRvXUkqMcfylFxldQJ6PnkiTHwEsFtyD6SmT3cPXckGzrGZ6EaxR7/nsxmt9qD
	 G2m3JZmo+dmkY7HdkhWHv+KgyfXEFCn/dkhtd9ywfTSt3W/2RGghDVGKzO07/LQS9YJzD
	 eUNZ7rvFrueG46p4zv3qm5Gj51xoLqf41iRitH0bjLSiJZpB2vl+1nh6/trsnrFZpyfbK
	 vc9ec1/Y4ZmN5szozod6auXELkl2wfFJmnANv5tWkAC/lRI+QMUXE3kwAchCM0oCWgi3A
	 1/GZkr0kWVovNdxA/FKrbNaBowZaGXvbFsHiV9x2cAMZCbocAVD5t2bZdyYDoBPHStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSrGWmtl;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7016606A335
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 00:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7016606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSrGWmtl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso69678925e9.3
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 16:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795737626; x=1796342426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grCsO3t7RryGcMPafQtIp1Wlmc4uzvXZdwkseXZWrL0=;
        b=MSrGWmtlhNLglpMFRWJl/dqQlIErt6p1MGUFWUMmrsXndLcPAgmxiS+8kNJjPo4ac3
         7QN7ZlxF+2o+5K/N1d7m1RQOY8zmMbfvw+mkoGuVOEJsmrH5EAIAWWh8dxrELztM6abx
         WuZmBMt6dvWcClGKKt47oB7oKTgmS0Mdv64A2UcnunLj7aS/jA0bnXweEcqpskaHkAv+
         4Rce/UZer4QSscJvlmxu5ldP3bmkpL3Axo4u45YfPkFfSPKb4+pvDdVyctlvy0A8slEM
         H6z/42yIMcL1xquwdVCcJ4SpQDq9zdlklDP1k8uLBlJ4W0Fz4GNdSCF5i/YQ/QdO6hYS
         yMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795737626; x=1796342426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grCsO3t7RryGcMPafQtIp1Wlmc4uzvXZdwkseXZWrL0=;
        b=TjK528sihyIq+aCfirB+KJFWpUzVu9gyF7uLll3/vlDqhhIWNMSflc9o6o/MHvVCil
         rHY/YlldjU43G3GbGCfUZhtXx9GlpFgeRQtHztshW8/3Fy2nQxESOeVHNz2nrffpALxQ
         tNtOtmKxekCruprtd3e3iY1bnGDNvkdD/WCWQjItZd4OLmsOymU+m0mvz+8MkZonT6gl
         Vms/FERAYib0/NMoHtW7qQ5hGRKm/3Z0EP2y3O03SMwYeo7Y05yGEBDA7AOOpXFvFls1
         fw4zay+zNVCk6mL7xi8RTMVFI/18zPFv8MAoEBZfcX3eTtPY+ro4dl7NoTa4TaENAlT0
         TJGw==
X-Forwarded-Encrypted: i=1; AL+hErFtGXX2qkjBlNUlZPwH0kcaNwz48Mx5P5dj0c3XwTeIHDJ3h229DbvIbySVEEPNriK4vYMiUf403e+BgjPY@vger.kernel.org
X-Gm-Message-State: APuU4Z+TOjzxdVu8ySpaaXpFVS/HRwAn4vt3FmvvRfNLSM/ZHpFh4DCF
	2NgRdKSgoYBkhIfdAmk2TylerLwVBnyxc3aDYUh3z4M1NYzE6wxt4tD4
X-Gm-Gg: AZFdTZeydES8gp3moIAMiyVbgkRdg6A5BwND2xMlfIrm/AAsGR3aB+IDwMNtfgsCg/0
	mbF6ygudDVYje8UARgIEIt6bdtpo3IzKALL+e3jt1XwwLSNPRMQu4Kyy/lxn9hNkeCxbL7il2/D
	1Jseu4nOGzMPyLm0sD45Mp1f0CPPfCgGJXGIPVGN2DXNwN7dZMW73EOW4jzycBZGb7NEHAsWpL6
	AMtFVsIx+cr9LUiPxp6c4TfHO9g7PYPyfDurzcDTVbKa3zK51eJs6hfjYcFLrvYepehrf8tHkty
	FoZZfJxcOhBXBNzbgeq9DU5oWwCyC4ozcOYx2x6fPbrlMbGxvGq9HwiDPfIIDUp9jytvqWfXRQY
	WLKgUaS9r+RqoVcObIGCNPzQmAiV1d7lNKgwykVQZ3VPNGBNCd5ytMeseGUmsCKFp7/cNxpC15X
	oZNLI//IJ2XXeUGJ27WzVS80Y6Yj6e2JvExO4vq8Ngs0XFlYrxz/Ke1htA41NUv+BAEjbGnlyif
	okkTTL7vNPM62xWf0yqxCVayu2R/OT7PQjbkfPK875DYu+8XGX+97BGt1AI4I2WhEGqPQ36l4jh
	hfufrvlavQ4wry5xesC+CS1aHVpFJGL2eWrC3QU9rHl6DXIj6KYy/rKAACQ6KfHkF4ei/4V01dI
	7aztQXtNKvYF6H9cUlw==
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr439906585e9.26.1795737626227;
        Thu, 26 Nov 2026 16:00:26 -0800 (PST)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm45536616f8f.29.2026.11.26.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:00:25 -0800 (PST)
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
Subject: [PATCH 1/5] scripts: add bit count parameter back to host hash functions
Date: Fri, 27 Nov 2026 00:00:11 +0000
Message-ID: <20261127000015.3662267-2-julianbraha@gmail.com>
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

This partially reverts commit f93d6bfbd2f7 ("kconfig: use hash table to
reuse expressions").

As reported by Linus [1], when the kernel's internal hash and hash table
implementations were copied over for Kconfig to use, several functions
were simplified to remove their second 'bits' parameter. But the usage of
this simplified implementation led to poor hash table performance due to
using the lower bits despite hash_32() putting the significant bits in the
high bits of the result.

Let's revert the parameter simplification: the host versions of hash_32()
and hash_ptr() will take the number of high bits, as is done in the
kernel's internal implementation.

Accordingly, adjust the callers of 'hash_32()' and 'hash_ptr()' to use
the additional parameter. This is a pure refactor (no functional changes),
so pass 32 to preserve the existing behavior.

Link: https://lore.kernel.org/all/CAHk-=wi_GuySe0L-uCAM2+nScCLYGBp5BLi6UUPR1gALmNM_3w@mail.gmail.com/ [1]
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 scripts/gendwarfksyms/cache.c         | 4 ++--
 scripts/gendwarfksyms/die.c           | 2 +-
 scripts/gendwarfksyms/gendwarfksyms.h | 2 +-
 scripts/gendwarfksyms/kabi.c          | 2 +-
 scripts/gendwarfksyms/symbols.c       | 2 +-
 scripts/include/hash.h                | 8 ++++----
 scripts/kconfig/expr.c                | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/gendwarfksyms/cache.c b/scripts/gendwarfksyms/cache.c
index 1c640db93db3..a4d18a9489e3 100644
--- a/scripts/gendwarfksyms/cache.c
+++ b/scripts/gendwarfksyms/cache.c
@@ -18,14 +18,14 @@ void cache_set(struct cache *cache, unsigned long key, int value)
 	ci = xmalloc(sizeof(*ci));
 	ci->key = key;
 	ci->value = value;
-	hash_add(cache->cache, &ci->hash, hash_32(key));
+	hash_add(cache->cache, &ci->hash, hash_32(key, 32));
 }
 
 int cache_get(struct cache *cache, unsigned long key)
 {
 	struct cache_item *ci;
 
-	hash_for_each_possible(cache->cache, ci, hash, hash_32(key)) {
+	hash_for_each_possible(cache->cache, ci, hash, hash_32(key, 32)) {
 		if (ci->key == key)
 			return ci->value;
 	}
diff --git a/scripts/gendwarfksyms/die.c b/scripts/gendwarfksyms/die.c
index 052f7a3f975a..4e390a6295a3 100644
--- a/scripts/gendwarfksyms/die.c
+++ b/scripts/gendwarfksyms/die.c
@@ -16,7 +16,7 @@ static unsigned int map_misses;
 
 static inline unsigned int die_hash(uintptr_t addr, enum die_state state)
 {
-	return hash_32(addr_hash(addr) ^ (unsigned int)state);
+	return hash_32(addr_hash(addr) ^ (unsigned int)state, 32);
 }
 
 static void init_die(struct die *cd)
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index 32cec8f7695a..f4f21d6090e7 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -95,7 +95,7 @@ extern int symtypes;
 
 static inline unsigned int addr_hash(uintptr_t addr)
 {
-	return hash_ptr((const void *)addr);
+	return hash_ptr((const void *)addr, 32);
 }
 
 enum symbol_state {
diff --git a/scripts/gendwarfksyms/kabi.c b/scripts/gendwarfksyms/kabi.c
index e3c2a3ccf51a..2d941ee13c9b 100644
--- a/scripts/gendwarfksyms/kabi.c
+++ b/scripts/gendwarfksyms/kabi.c
@@ -92,7 +92,7 @@ static HASHTABLE_DEFINE(rules, 1 << RULE_HASH_BITS);
 static inline unsigned int rule_values_hash(enum kabi_rule_type type,
 					    const char *target)
 {
-	return hash_32(type) ^ hash_str(target);
+	return hash_32(type, 32) ^ hash_str(target);
 }
 
 static inline unsigned int rule_hash(const struct rule *rule)
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index 42cd27c9cec4..b4110b0e12ce 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -15,7 +15,7 @@ static HASHTABLE_DEFINE(symbol_names, 1 << SYMBOL_HASH_BITS);
 
 static inline unsigned int symbol_addr_hash(const struct symbol_addr *addr)
 {
-	return hash_32(addr->section ^ addr_hash(addr->address));
+	return hash_32(addr->section ^ addr_hash(addr->address), 32);
 }
 
 static unsigned int __for_each_addr(struct symbol *sym, symbol_callback_t func,
diff --git a/scripts/include/hash.h b/scripts/include/hash.h
index efa904368a62..ae0d3fc8d470 100644
--- a/scripts/include/hash.h
+++ b/scripts/include/hash.h
@@ -15,14 +15,14 @@ static inline unsigned int hash_str(const char *s)
 /* simplified version of functions from include/linux/hash.h */
 #define GOLDEN_RATIO_32 0x61C88647
 
-static inline unsigned int hash_32(unsigned int val)
+static inline unsigned int hash_32(unsigned int val, unsigned int bits)
 {
-	return 0x61C88647 * val;
+	return bits ? (val * GOLDEN_RATIO_32) >> (32 - bits) : 0;
 }
 
-static inline unsigned int hash_ptr(const void *ptr)
+static inline unsigned int hash_ptr(const void *ptr, unsigned int bits)
 {
-	return hash_32((unsigned int)(unsigned long)ptr);
+	return hash_32((unsigned int)(unsigned long)ptr, bits);
 }
 
 #endif /* HASH_H */
diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 2b91d16bf14f..ea93016b68d4 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -35,7 +35,7 @@ static struct expr *expr_lookup(enum expr_type type, void *l, void *r)
 	struct expr *e;
 	int hash;
 
-	hash = hash_32((unsigned int)type ^ hash_ptr(l) ^ hash_ptr(r));
+	hash = hash_32((unsigned int)type ^ hash_ptr(l, 32) ^ hash_ptr(r, 32), 32);
 
 	hash_for_each_possible(expr_hashtable, e, node, hash) {
 		if (e->type == type && e->left._initdata == l &&
-- 
2.56.0

