Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666B2B5E8
	for <linux-modules@vger.kernel.org>; Tue, 24 Oct 2023 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvFNewWr"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A110F
	for <linux-modules@vger.kernel.org>; Tue, 24 Oct 2023 06:46:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03390793fso1012317276.3
        for <linux-modules@vger.kernel.org>; Tue, 24 Oct 2023 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155206; x=1698760006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fObhDXE+DfK48fbfXMStFHtHAmn90M4M91A2l4CxzLM=;
        b=fvFNewWrJ6myhtkKXKjtJz8cIzAVhMdqhSo1R8XR3dG9lbaEcu40daF7zkrLWvYyQC
         Q2mL5UdAfr3rTWRWlr7tfdubTPhnHuVlp5zfkMCb4p6DfWKYLDBpBxDlbioDo5ZTgZRX
         euVcheUfciQ/xmzBww2SzGQeOg/W9/euwxB82yYhQc374RWE0GnNoLePR3bCXEmQF965
         czbTs9HHTypXYJ2KkiNNw3L6nBcF2t1cFnXO3xI713cVEfoux04p9ykMWFJOpeasDkxe
         oENd442Qp97odp3mOJiUNzAJ2X+NUsAxZWMiaMCRtwsD93S0RYHH/4mfaXmqRw/S4P2K
         tOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155206; x=1698760006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fObhDXE+DfK48fbfXMStFHtHAmn90M4M91A2l4CxzLM=;
        b=OZsih/wnOYiYPTtwxHdzaBmz+MMR3sP6wo1STUlKlpR4xb7oIrpVF9l+JDlRZRiLNM
         SgsZKO4J7C+JvtMCMMzCergG18IU+LPojI27w8ps6XvlAWlCdXJQjOI9vnub78dfP+aD
         9SDNo85xt+dxXmogSBP8Grqhwl/WsmrafDjx3Yfe4yDJSwjYXRvVFdojxFkag8S0tO3N
         WwWO2oZrWR+EBqDb789agL5zK78DN0VVol/v8Ruac0nhhyq6E9zAl3llGGXPPW/cnzJj
         IUlb+0IZ0qNzijqHwAIaD8lGFb5d/xaso69QuSsz6EJrEapgnqBL5s08WtXxUBRRlVF6
         l3OA==
X-Gm-Message-State: AOJu0Yyu93y3F9lrkt0p7v9y++v8wLbutvLILFTXVbk+Das8uOMvEHOV
	2PcLpDCOC9OXCGXcv4BBEaA6iFCtYS4=
X-Google-Smtp-Source: AGHT+IGzqDmmVKWAX0qOLCG4zSSOu2XUUgzUKaIXDvA8+3j+t9o+p5RCbsfa+aQ1r6gMSAIrcYIsUr6/0f0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:5008:0:b0:da0:2b01:7215 with SMTP id
 e8-20020a255008000000b00da02b017215mr55818ybb.10.1698155205957; Tue, 24 Oct
 2023 06:46:45 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:45:59 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-3-surenb@google.com>
Subject: [PATCH v2 02/39] scripts/kallysms: Always include __start and __stop symbols
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
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
2.42.0.758.gaed0368e0e-goog

