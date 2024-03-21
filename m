Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A11332A1
	for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039041; cv=none; b=TBkIu7l6XN7kchUfWiyyoImA0jclPTP7aLzVAZq6m05hDNKUZ5n0jTPwIL6nskKsr0bT6f5eqILWvvNPEh/iqiPF1vCoqeg8pe+/N/oWfJBxmzD64PYahMnBOQG6+WQpiCeuJNwnWd/nMyvup/WjeJIIu4381/5CIw6Q6WsyZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039041; c=relaxed/simple;
	bh=ir6xyZtmAUC+Ybm5fW49pWbbkzfCfz5BPQNom35E7HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hexTeOcTlkFicGU/+TfbLmX7cd9hW6UgKWurATl43f93d9X6PaZLS+Bpu4O6vEblvhKLGJ6AZHatPr+uWLUuf4wtwIp99nHYY2HR+wqTVxlqYIzycwD7k+X8ZWH9x9okUpDO4mzouwxTcAdPrmluvcHOieHixv4HkadyG+5mwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M97DhcGW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M97DhcGW"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso1633586276.2
        for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039039; x=1711643839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsF8xuW3B4rJ7bvWaC3URPqDGHFVTOJU/Md9c+vki8=;
        b=M97DhcGW8hPCwutq/KjsElSFPJnWXH/25nt2pMe8zJPNVhhFUTwq6282ZNUp3MIMIf
         ud9EZrXxH5mpYspVXQaHAkvufZYzu7iAL8y3m1T1clfrO1mHw7DXuDG3S+0/9rAtql90
         2AjFb4iLI0tKvfe+2U3EIjHIEhtDFIrFowoLpxNCPGQV5hYtfhc8jGDE3XxhD4oXVu6R
         cI3Vp/jnnZVuCg9ZWBOeAhp8IGzgCCo7HUf/GeuXN7py9MY51z2w0RJ7YrX4bxvMlIqu
         6tHlyxNugquJvYPmKOAXkbCwr3CPMWqLXJ5kvBR6BER8iN9VXJk49w4t041PFILta3Ew
         KOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039039; x=1711643839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsF8xuW3B4rJ7bvWaC3URPqDGHFVTOJU/Md9c+vki8=;
        b=Hms9waUi2pvlGXtXaBXvbH0AN2FkDmtOsBKn9N55Gqj6n9dOlhNXB1g9QadxrSbC1h
         KbfAH3wq1NNeTN6K6yC3Xx4wJjCvDcU6elYnkWjYo19DN5J1Z/oppI1TeQlj+j2DvrXH
         K0L0Dpp5xUHKwOIKotMSDhzxvQcaBlOtOcUO53dkHaF1+i4LI5BryA0oewEc/qGjg/ek
         8vGitKJIiveMq9JPLeBLj5B0zY8Zp1ximVNJ7wmGQNOOQ1x1Xp/uAneSnst26S+KjRKp
         PpOuIAXu/kwg+xL+/jCIWpis5ZVsoY74Gn6/S2z1T8zbq4DpX1VeSRQnDvQz3i3FUUiI
         4/HA==
X-Forwarded-Encrypted: i=1; AJvYcCWsPuiY7Fnj8xp9U2g+YRwXFetQUsSgYW9TkIIYmXb2a5MPDTV6iSUW8phphKav3J9b3Ro6tCNAORVf+5ibbGtQyxUOUPHJ1wv9/Ml1ew==
X-Gm-Message-State: AOJu0Yy0k4Xw+XLF43lpTje2ghzyM9l0EAn0aVN52rAvbGDt/TIcjH1j
	e4HVe2s3nw21/1aH3jn/EhuvZRvpI76DiRGUWndYFsW2NJXs/bNy9WKw6rYJd4tZF57WjbGJmY8
	3oA==
X-Google-Smtp-Source: AGHT+IGrkFj5aE/qI6dA3cr3f2zIJD/myHIxBhs84G4EmxlJsslBgaCO9HAP/2XOVSrMpqDkAxdrZ+lOSbY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1207:b0:dc6:b982:cfa2 with SMTP id
 s7-20020a056902120700b00dc6b982cfa2mr1182860ybu.8.1711039038760; Thu, 21 Mar
 2024 09:37:18 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:26 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-5-surenb@google.com>
Subject: [PATCH v6 04/37] scripts/kallysms: Always include __start and __stop symbols
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
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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
2.44.0.291.gc1ea87d7ee-goog

