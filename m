Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B738F1D0F46
	for <linux-modules@vger.kernel.org>; Mon, 14 Oct 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938215; cv=none; b=f3BxJf7UN/ODZ72HmBlHtOaTt3yLvAsj1NyhgYsFbak7QRi7lNXj9pr9ZsXk9QmPjtHlk4LFLg/wEUQvUU8mnkORLAuZ81kq2GJ8Aq75ROFwBQ6JFDp35+VDRpObke57O/B3peF5WBr05uY7rf+nSKBf8n8cl1gcv8EO8jzEhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938215; c=relaxed/simple;
	bh=WyPp5GR9nupFuOlmPfHdOFY1s2UJmv4QO9RmmtWeFdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHPzMoLZnwvH3srMOF3sTdMvxRrZmEjX5baEFX+mtFVtYZKl0hOgn8xHJAzgYnltMU3x4jyB0KtJeURZWuL0VzoQ9J+kbLYsmlHNwmYlY/8zabzCpiFcjAjhXCPj8HDG5brNuV8bjp/P/PvGN8AkfX2cdS4+Tk5W1Wb6ql4jDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BixPJo1U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BixPJo1U"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so85741917b3.3
        for <linux-modules@vger.kernel.org>; Mon, 14 Oct 2024 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938213; x=1729543013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBL7Vs4MVDC9S11JwgZ8NOTxmnHjmsqVGP9nKZ/sLKY=;
        b=BixPJo1U8Nkgk5wwILfszlCYdTGZZ3HQJeoN35OeGfLSvXmfhRNz0HzB8ezpupfJTp
         3jt82WqGldh0ipsA6TdAv7XQZzBww21AOJuvcUaIDF1MZAgNm5WPbuWiKo8pMXA4diaJ
         rsjDnwrFuk83+I23OWNi4VBcRhpDQJyqtDPkV4XElJCzUNeS8a9dksoZRBUdCofOBSWp
         Ns1h80t2ZqjUrSo+XVHazawkx1EjcGu4imaGhMaOjwAFVYG+/oo3zf13gzUprUS4LMeA
         Ech0jhwMfocq/GExYP6d8NOlHaAeKax+dj4gtKzMCjtMjLCTsrkVzmoVlTfGTUfAPnM7
         vrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938213; x=1729543013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBL7Vs4MVDC9S11JwgZ8NOTxmnHjmsqVGP9nKZ/sLKY=;
        b=JTSNJ+EEcZW7wSsyoAayDNByRgQfdkDwfoFjcSK7AgyiHiL6lP+d2WsgTr7cQmS7BL
         44CKrS5nGDKf+n8tDspcyUTiZRifW3uQ232MRO1Kot5BBN+WgFp2S057Jum7PTEScP81
         fawlUmjyRV33mEtULXKRIKDzLIz7I2vJz8tVx2/JUmjN07UOF3atdli3cxt9GyqmLy9N
         YDA+TjOOseNpq4thxhltTwDzND47XRwUCFWhBu5Wu4eJhvyIqW0oHrH3083arAAeJjM5
         cqrsORUcqTrq6YNS+Qht8LFVZcTY/i85HSZm+nBsvoBGu3xK4L4EGxiecpGI18I9Qz3U
         3eeA==
X-Forwarded-Encrypted: i=1; AJvYcCVNlNczzETGr2RifI5ff1fTWcHjEJ+PfBeh6d6KBiuMQ553zCuHyXztx6+uWy0vZXgDCbi3WJyxmflb63tD@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNYSJJrWSy5oKabFtVnNRnuJ+h+vd/onW40Je1cGCXzrXUCDR
	moWB2H/36AywcERkU4Gi4y+bMbqIzs+ivNxAxrzPJpJePpAyQIvr0giTclOOHtUoG970FwR4JY6
	zCA==
X-Google-Smtp-Source: AGHT+IF2H6wJeGtAPLdmfc0iDyPr+v9IGwfu4WR2zrx8HQDicf0QvWblIiwnCcZ6i4e+0edwH2bII6UptCk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:915:bdd7:e08a:7997])
 (user=surenb job=sendgmr) by 2002:a05:690c:7446:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-6e347b4b2edmr460147b3.6.1728938212594; Mon, 14 Oct 2024
 13:36:52 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:36:42 -0700
In-Reply-To: <20241014203646.1952505-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014203646.1952505-2-surenb@google.com>
Subject: [PATCH v3 1/5] maple_tree: add mas_for_each_rev() helper
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add mas_for_each_rev() function to iterate maple tree nodes in reverse
order.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/maple_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index c2c11004085e..e7e2caa1a95a 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_for_each_rev() - Iterate over a range of the maple tree in reverse order.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__min: minimum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range for the
+ * entry.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_for_each_rev(__mas, __entry, __min) \
+	while (((__entry) = mas_find_rev((__mas), (__min))) != NULL)
+
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 enum mt_dump_format {
 	mt_dump_dec,
-- 
2.47.0.rc1.288.g06298d1525-goog

