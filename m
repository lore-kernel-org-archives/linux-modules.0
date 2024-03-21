Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00E137772
	for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039068; cv=none; b=U019Zw0L0LXeYrbu4WSXxji8X2ETItKo5phyOfSrzquDu+7eXMDsUkmdNUK/BIXIf1U+XPISPdJMwZbAFf0CwgDfTrHSXN8dGcCHlZdGjBQdaqzkc/RdCxucCzg70A3s4W0v74nOnE42oGnFpwCxTmMHJJ1I/zE3F71asHn4gLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039068; c=relaxed/simple;
	bh=z2eJy0t2bdkmakMZRyMHx8Zh+sPp3sJo51GJl0bffFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jkGbzA7Br9qvw3vJOfJSATsDFiQosZVRSbHMkv8KHy5fsKTEcPEjQPMZ0qq3cODFUgIks4X6p1jN+q8LtUPmshvj1tuaTzxbaYqaQbyAqLsyNFf2yCKAOYvP+HKp3n9J/rFPsDZsH045a7lhOXL6mv9DflGDB5/NBfHR2ChR43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZLKKUlE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZLKKUlE"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a605154d0so14619797b3.0
        for <linux-modules@vger.kernel.org>; Thu, 21 Mar 2024 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039065; x=1711643865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=UZLKKUlElHdKoVJnA/LuY9jg0NkLB6vwXGStqPA0YRImOU2pNXToNXs195ZQ14UFnE
         6onBZfh8TAgJmvp8XA/p2OGTeR/GUt/kR8bCSNWH92aBG2quY3p/Qi1ZSC8mtE6ZBO3l
         K1XRas9hGxHmr5SkJoIRnY6GEBSo4iulor1QSg5BgONy/LA8s3mCAKHtpsC5J03hx/I4
         nwK3N0U94Fg0Qb4tcU98nek/fDUhyCE5I21YMkIf4aY59K9MsfCjo0xN+JfnPhpoOgVT
         27QbJ+Ck8zsrqK4prKa0qFBd6qQdXFiUfIPyvdszYIbAtOHnH0V8/QuVgJUo4e5Pe0Gj
         Kh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039065; x=1711643865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=JiNWGU7pGKTCc0KpkmEkdYLdXeBOb6Qo+r9vERrs7u9SvjFph/mnpeODn/JSjgqRda
         jAsdNTmdSWZdVXGjKJhKxHyNnzrinmsQufoUj5Yc7RVdNb5Ktgenu9NZ67BP+RsXXXXl
         FwBG3mfCpoNIVHUrY9hORiq8fo90ze2TLJuSWy7YskzIPegm8Ik21Pd8wpDk2e9CzrCl
         UskrssdWCdiH5M7FFyiyS0q1/lI7JLMypK/rcSPmr4gA17tO1NihKNGmXe4fZ1jWImWs
         64csU8TaGec0/a+tuJMuckQ9E7ARsMyIznaPGqT4O7n7UPa10P/S4mohELu6xdGtv8fp
         ZDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3KO4U8mzGXPUDFdRF+6RVY1Lcyol44OcOFSkPEIFLKl9gXHeQcwRP0oM3Tq7I3rnjmhMxsDWon6tYPblwR9kMZxwSSa8MNWhBvjreZQ==
X-Gm-Message-State: AOJu0Yw4Gxko7938y93LH6OQZMcmrYWZoqVg3xdMhDSf4GzSVwRenKqs
	CawyV/YqU80pTFxXxedyJCvs1dbPnYAktwP/Jim8PgqjchiItkOfxs1JLfl0DzvHzu1XT3WF/AE
	Lmw==
X-Google-Smtp-Source: AGHT+IEpbeHGmaH4ZP6HrzXLjRbRGOQFlxFrFvHpCJT+qt/SUASA+RVr+wlFFHpwWsqOIXtYDNaLSozJTUQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:b06:b0:60c:cf91:53e0 with SMTP id
 cj6-20020a05690c0b0600b0060ccf9153e0mr3628ywb.1.1711039064823; Thu, 21 Mar
 2024 09:37:44 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:38 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-17-surenb@google.com>
Subject: [PATCH v6 16/37] mm: percpu: increase PERCPU_MODULE_RESERVE to
 accommodate allocation tags
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

As each allocation tag generates a per-cpu variable, more space is required
to store them. Increase PERCPU_MODULE_RESERVE to provide enough area. A
better long-term solution would be to allocate this memory dynamically.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..62b5eb45bd89 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define PERCPU_MODULE_RESERVE		(8 << 12)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.44.0.291.gc1ea87d7ee-goog

