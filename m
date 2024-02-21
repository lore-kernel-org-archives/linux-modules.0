Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F61272C7
	for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544469; cv=none; b=KKgS/ztM4u3ew4Zm16wLJ4BBzcjM7lJSUf24R2Hr+9mRFv8leZ6NnBCbqup+VDbrSKWUxTWFqJR7fhek8jJphyO4E+rClo8+0eoGJFipd6es0fmUJaYEhLDnAo+TSBIc/A5WYWxv28zdGdEiyf6Y3CAFKVb4nNh3FAenY8YOw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544469; c=relaxed/simple;
	bh=HEHmOJCie8+J7RJiRgymV6TXHRXRZD3Kg9mNxHhJkjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhYFz2IHYxOlQWncrX6sR+E3kEMJgAd6IYQ1lxjfQcQnAxRs3OSgDQpt9y0tlp29A/dov93HNdA5ZR5Gxkkf6OBmOlnkY+IPPkJGeydoK3sLMnVWQWJN5USXIGfzFR5CnLz9JD1UVtTfrA1Oh9v4bgpto6ItmncMGu+TvCUlzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H37z25x5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H37z25x5"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6086574258fso20090777b3.3
        for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544465; x=1709149265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNOJH11gO16gI1CGV9wD1JhhI3G0pl89I4/43bWDXAE=;
        b=H37z25x5wvEqUwzd/42xA/Op9Kb8Fd0bYv549DTrI2TY1FrCrkQmoYqACVMpDfqD4y
         OspB1oI6aB9HGWr2ol/P7wMiZw9MX2tFLcqPdJGAzby6B3v0elGYlsRr4FshFxpVDOBZ
         AJ1VLsD2PiTfLGyj9LG7ysU5bHCjMwgDXL+25UFC1aurZBEQpx3AB67ny16u57cPH2yX
         U/lQgoA+pKGM4aoHvqMFfedUkwH2/NcRsRLY+mgM4itaBDL1aKqg4idbJYagOSPcLGtq
         buHUA1yS57dInoD8oYhGZjYyo0cXPDzWMUwuEJ900z20bs+j9uzayLp55OTSZz1uViN6
         wZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544465; x=1709149265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNOJH11gO16gI1CGV9wD1JhhI3G0pl89I4/43bWDXAE=;
        b=UbUwfUy8umliQJDOFTqS8eKMdzAlnWAf9TgSRow1hMCTvj9jMf2brrWYTJd1kFwYx4
         qDzDYqe4erUnqGJ2XYq0RL42Eb2RNM9XvcmGUCYKADit5m8xIQOEzUN3clLUt1XAaaAv
         Mp+NxejUoafNI8pUo3mpI1UzcJW+Hz/7LdWsrQgHOBH5Miz+vY4ORjdSTEYC9w/NQ/+h
         W11/31V+zFD/efv5MBvNoGeWJX26NwKENXOyGuKDEkAYYwOV9AJa03OYc+l1Jc09tB1s
         FmCdrD5zQMQfG7ceCxPeCYrEI13uJJDFg883E6t3STM/DSM2JZjw7pLKronLfuTBdTzz
         csqA==
X-Forwarded-Encrypted: i=1; AJvYcCUR9Pz3meT3NkJgjzwxdTSoizUF0UMJ+X9l2EbTvipnkk9ab2091xZhlB36AVDGRbSfwdE4VVQUy59OqK87NCbBB+rdG+u6o5QM7QTOQg==
X-Gm-Message-State: AOJu0YxpFHb+RHkNycm9n1KaDYGKBaY80S/h827a1XlIkqUMrIG4teS4
	fpbOw2KiMrHPJz4se9svnlFKYSZuu+VqqQxt5YO9DxUaDg6y3wK+oa6hL0VHSeoH9sUzMAeVyKj
	mYA==
X-Google-Smtp-Source: AGHT+IFw1HW6rh2zXq6oVisO+flBpM8PZrPAxomjgm47RtsfgtCbzompT9Q8/PbN9Jjx8wnIh7u82HkUv1c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:528e:0:b0:608:94cb:6f6 with SMTP id
 g136-20020a81528e000000b0060894cb06f6mr174090ywb.7.1708544465320; Wed, 21 Feb
 2024 11:41:05 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:17 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-5-surenb@google.com>
Subject: [PATCH v4 04/36] scripts/kallysms: Always include __start and __stop symbols
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..47978efe4797 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -204,6 +204,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -211,6 +216,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.44.0.rc0.258.g7320e95886-goog

