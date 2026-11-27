Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743272;
	b=xWZiSlbHJF5f5/XYrKZzfeRETi4abz9+uxPtLeMg21ZabfzyxgoFSoNm2jDxg+bdvRAp
	 7EdzKSnnYSudqCbMt2ZsGlwG5K+ki7minqB00G6nsbX9Ta12aMtZBFqXQSBPMEa7ee/HK
	 in+SNP4tIw0NvL1nY8FDhxzeuD2feoxtZix4jK0WLhRXQTqo2se/q8s26VOZnsg65Zd3K
	 vA20mc4c3n32kuyRst9DceAEN7bXrN3BqwFVgwamW0D8NNkAa9CwpmclCkHYc2bC7gsW8
	 OfJAgR7dUlgEyZ4HsVN/liimH+YehjPaefLuanV1M4MO1s+qQHmYIVocTkxZ68kBC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=l7RO/X9hrpGm7U7ZvUyWBLz5rvKWH6VnYdq6Izp1zz4=;
	b=yKYWcyu0myofllDnZOmiMDb85I90q0Mr1Kvwg0VzVXXGaCgLFLQ9GU2FUbAPtn2pu1NQ
	 Aepvw7GPKkD7ALqgKm9lswgSyo+PaT4UFUfFuRTKpZ1XvYlx2g6MSKfNREuU1Xf32D6fg
	 aMl4fC4loLIL+1iBmpiYcKHWvKv+VxYyZMUEUSOXLndp8tiMEANN9aZcMH89vJemsdZ4y
	 gvHKeEXOCMjjUHKgM3zQpzYx98ob96BC2zSusTGBJglPB76LoQnjfGGYM+ssGg1FOaxqt
	 FLzjGH7s4RqQnbf2mvTkTTsB7HEItKk9dfu1WYGlEWfSewDiYQ3LO6onBVic+4bEgrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eOqIMfC9;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC0606A31C
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 01:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECDC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=eOqIMfC9
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so8773732a12.3
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 17:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795743269; x=1796348069; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7RO/X9hrpGm7U7ZvUyWBLz5rvKWH6VnYdq6Izp1zz4=;
        b=eOqIMfC9wrhBH24wtxRU5QJCk3tNQjYHjeoTSxta7NhXULS1hi5AA7FJCYX6rbpOUD
         yQCBNwinDH8LJ1FrCIFnd6hiD72+EVQ+61O2+q9HfYYN7AAtDjUhKKl3GmbOBmXvL/5I
         k3TE/Dmi/v4i0PwEBkjF05Hr6XOYWyxw8QkEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795743269; x=1796348069;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7RO/X9hrpGm7U7ZvUyWBLz5rvKWH6VnYdq6Izp1zz4=;
        b=trkKpyJtL8eyD1B2/28aE7L6aqTa/VW3KmNH0s8Kvnz/RrHA0XnzuvoJBPDTaI5h3z
         1qgqWpCaZ/erThRcfTmeb8TZYAO67b1IDsSxwVMIA/zWPI+KKqpBUo88WKIkwTokZd2v
         +e99KpONsoblm/HFEgxi07H89sA6NyEN2K0lwC0DUfgyLDkag7YGlKl4ANggqa8bIaUW
         mgxwuKkd3DlopUL6hH1VTCe+bVvPh2o7dXLkr7Y2kq3oF30Ghnnn0QdiUO4M2ruywu5B
         xdoxzgPioXCcHPBitdouhLVOiyjYDy92C/hYSgiAUw4sa7EUPPCtDrTi9qCHgQ8zCE67
         8LEA==
X-Forwarded-Encrypted: i=1; AL+hErGrKX6Pz2fJh4XsNG225ojefwbUgcVJM7XEuXmVqqZKPIt+sGTV7zpLAy3usNTH7o+2qrt+A/o/OeEp9IZF@vger.kernel.org
X-Gm-Message-State: APuU4Z++ACljhLg/N/vvKzkK/NwHcIIzOVCxh2EliToccMtTrd9sWU7Q
	Mb1EMLVmMqwd5JK2526vHsxQCNAcqdRRy90iSXvrYBMll3VTlu5xjyQHO0EFWBB4QSoeqX1244M
	IBBzumBipUA==
X-Gm-Gg: AZFdTZdLKj4/6SBhUhOAnMhV9a409gh6/Rdqd5t9qo92a9q3Dmaqp25trxOMlBVRpXv
	WASwSelo7Be2hReUi/1/nL+E1R+amyXMMLIlZXDdPug1qJUOADvHSernEPoXwCahsTezHAmKqUz
	V4y4difR8/p0GxIgbJBfE86MCooi6uCSyceF+SG7z1v9PNOFlnpZI8vAtd+iglZMN2Wuqk5wGBg
	M9ZFCxnZPWI+sJ79yfaNWk+w5pGQqKQ/BQEgkH2vIGD8CipE0MrFKM3pIU2H4QUd5kjfQVmSWSF
	k1SNowOwcgqnKZ1Qb3OpQEoVlQppS3mKS/lIlwl4qG5g0KkE7OHUwtpSjh1QhShtSJH1jA+VCyA
	hM2+1TkYs/TVc2vwoVc4ZPmHvnu1TgNaUEQUT7SO3sKFOHOei+DtZIrGbCGHtAvfj9nVDoPLa+t
	TMfq9i4VzLQyq4NH4RTZT+e5UMbljPDJRo/2Z5WmnmS8Q/tdl02Uiv8IqgQjc817uMvFmg774fb
	tpWU8U72ZVFxxyAXoJPAOUDr6HsCFE9oQse5Qa2uBeADLHi88KXUokVvhCq5eEtjCjJkPg7lSD0
	FIB7Gx4oj9pDyJaldOsuBj3sa+Ql6KBGzk0aGU8hPfFmu3WZ5h2a2oPADTfTwAPLtOFKNijnX5n
	FNXY=
X-Received: by 2002:a17:907:b053:20b0:c49:8fa2:4a22 with SMTP id a640c23a62f3a-c513acaefdfmr1273297266b.41.1795743269232;
        Thu, 26 Nov 2026 17:34:29 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec5115sm802173866b.51.2026.11.26.17.34.29
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 17:34:29 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d28f75d62so1236557066b.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 17:34:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFnU49ybPxWoHoSO8Md6H2XuTRdKo4th7J5IoKODSaPx6Fx/PPZ+B7VfozmKTy7nrvWhY2C/VtDfvcbTEDw@vger.kernel.org
X-Received: by 2002:a17:907:c491:b0:c25:91bc:ff55 with SMTP id
 a640c23a62f3a-c513ab0c6b4mr1782417166b.23.1795743268984; Thu, 26 Nov 2026
 17:34:28 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Nov 2026 20:34:27 -0500
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wjcmmgrJy6rknMOTJ76O92QSAMSUaUPKC6N=pASPsxPmA@mail.gmail.com>
References: <20261127000015.3662267-1-julianbraha@gmail.com>
 <20261127000015.3662267-2-julianbraha@gmail.com> <CAHk-=wjcmmgrJy6rknMOTJ76O92QSAMSUaUPKC6N=pASPsxPmA@mail.gmail.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 20:34:26 -0500
X-Gmail-Original-Message-ID: <CAHk-=wif1CNqxe19O=oCy87TZ_KQoGcoCaOchn-dk11hKoGbOQ@mail.gmail.com>
X-Gm-Features: Aa3M54polP77YZQv9cchX6_j00EPygNp2BPE71doDMsazM4Dd6ppL9CR6_Xn25s
Message-ID: <CAHk-=wif1CNqxe19O=oCy87TZ_KQoGcoCaOchn-dk11hKoGbOQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] scripts: add bit count parameter back to host hash functions
To: Julian Braha <julianbraha@gmail.com>
Cc: nathan@kernel.org, nsc@kernel.org, samitolvanen@google.com, ljs@kernel.org, 
	david.laight.linux@gmail.com, sashal@kernel.org, lzsx618@gmail.com, 
	zuoan.penguin@gmail.com, petr.pavlu@suse.com, jani.nikula@intel.com, 
	xur@google.com, sidnayyar@google.com, robertusdchris@gmail.com, 
	acourbot@nvidia.com, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Nov 2026 at 17:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> NOTE NOTE NOTE! This is untested crap.  It shows the *concept*.  It
> might even work.  But it might also do unspeakable things to your pets.
> Don't trust my word for it.  Look at the code and test it.

Some more testing shows that it needs at least something like this on
top..

With this it *might* actually work.  But when I say "some more testing",
that "some" is still carrying a lot of weight.  Not a lot of, IOW.

I did say it was untested crap.  I guess I'm more of a "high-level
concepts guy" than detail-oriented.

Users? I like to call them "Test subjects" or "Victims".

              Linus

---


diff --git a/scripts/include/hashtable.h b/scripts/include/hashtable.h
index 0d8bb8eb178c..78d63eb96fc4 100644
--- a/scripts/include/hashtable.h
+++ b/scripts/include/hashtable.h
@@ -12,10 +12,14 @@
 	} name

 #define HASHTABLE_DEFINE(name, bits) \
-	HASHTABLE_DECLARE(name, bits) =	{ { [0 ... ((1 << (bits)) - 1)] =
HLIST_HEAD_INIT } }
+	HASHTABLE_DECLARE(name, bits) = { { [0 ... ((1 << (bits)) - 1)] =
HLIST_HEAD_INIT } }
+
+/* Define a table already declared extern with HASHTABLE_DECLARE() */
+#define HASHTABLE_DEFINE_EXTERN(name) \
+	typeof(name) name = { { [0 ... HASH_SIZE(name) - 1] = HLIST_HEAD_INIT } }

 #define HASH_BITS(name) (sizeof((name).hash_bits))
-#define HASH_SIZE(name) (1ul << HASH_BITS(name))
+#define HASH_SIZE(name) ARRAY_SIZE((name).hlist)

 #define hash_head(table, key)	(&(table).hlist[(unsigned)(key) >>
(32-HASH_BITS(table))])

@@ -31,7 +35,7 @@ static inline void __hash_init(struct hlist_head
*ht, unsigned int sz)
  * hash_init - initialize a hash table
  * @table: hashtable to be initialized
  */
-#define hash_init(table) __hash_init(table, HASH_SIZE(table))
+#define hash_init(table) __hash_init((table).hlist, HASH_SIZE(table))

 /**
  * hash_add - add an object to a hashtable
@@ -59,7 +63,7 @@ static inline void hash_del(struct hlist_node *node)
  */
 #define hash_for_each(table, obj, member)				\
 	for (int _bkt = 0; _bkt < HASH_SIZE(table); _bkt++)		\
-		hlist_for_each_entry(obj, &table[_bkt].hlist, member)
+		hlist_for_each_entry(obj, &(table).hlist[_bkt], member)

 /**
  * hash_for_each_safe - iterate over a hashtable safe against removal of
@@ -71,7 +75,7 @@ static inline void hash_del(struct hlist_node *node)
  */
 #define hash_for_each_safe(table, obj, tmp, member)			\
 	for (int _bkt = 0; _bkt < HASH_SIZE(table); _bkt++)		\
-		hlist_for_each_entry_safe(obj, tmp, &table[_bkt].hlist, member)
+		hlist_for_each_entry_safe(obj, tmp, &(table).hlist[_bkt], member)

 /**
  * hash_for_each_possible - iterate over all possible objects hashing to the
diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index 27278830de98..26b0a64b5cb5 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -16,7 +16,7 @@

 #define DEBUG_EXPR	0

-HASHTABLE_DEFINE(expr_hashtable, EXPR_HASH_BITS);
+HASHTABLE_DEFINE_EXTERN(expr_hashtable);

 static struct expr *expr_eliminate_yn(struct expr *e);

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index dec65c0d1181..2afe2be78a29 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -971,7 +971,7 @@ bool sym_is_choice_value(const struct symbol *sym)
 	return !list_empty(&sym->choice_link);
 }

-HASHTABLE_DEFINE(sym_hashtable, SYMBOL_HASH_BITS);
+HASHTABLE_DEFINE_EXTERN(sym_hashtable);

 struct symbol *sym_lookup(const char *name, int flags)
 {
