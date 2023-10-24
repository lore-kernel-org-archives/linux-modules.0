Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAF37147
	for <linux-modules@vger.kernel.org>; Tue, 24 Oct 2023 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHIE4ELn"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A681FF9
	for <linux-modules@vger.kernel.org>; Tue, 24 Oct 2023 06:47:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so675194276.0
        for <linux-modules@vger.kernel.org>; Tue, 24 Oct 2023 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155273; x=1698760073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XaYZQGGekpRYWKofo5TkfncjTV9EZU0daTUjtZ9a4ek=;
        b=HHIE4ELn/5FDRwwPSu1FimOOlWIoBT0SXYAlapDwK696rYwJRqYYvP1VsY70F6KqG/
         I9K7bwFQZHbeynjoDLosHrXkL/LdbOr7OrJ8e5XcBgqnqlpNjOdghs1kVayxc8LZs5ev
         feVfAgz26vy8MwJTE1kubaG6vP1QWtwSDkTOoS7HRyUvlWDc8MJIY+op+dvxWJOBpyHD
         XMM/SjC6js85yyZK/CiMBKD9iJGb7w4KqOQjcm9/k9zuUBK3LZKQNmlmgbAC94qMnT2S
         l2pJhb57WwSKX7rnKyibQi1WhZHr4thOX4Njf/vE5SbshA4jOvwCNneOcvJSd0hVCKyZ
         fnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155273; x=1698760073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaYZQGGekpRYWKofo5TkfncjTV9EZU0daTUjtZ9a4ek=;
        b=osF/kjpO0GPErT+2QE89h3RkO/S7h+V62HLtBvcQqUINhgDeBjqU7b9xGom1/5iJAO
         JXZjt9VkE2wAYlxyIxniO0CPa6hrJeWIusTSRu23F7KaPY5j0eKSQzvPR3EbHkV9kDx6
         Krpe1n927YhLyaSbQ9uEr9uWRcHQuRhvuq2yTJw5WYduKavPKck4XnxZt9lFVf7YTRf9
         izQMzr41Xz+j/E45M6ePWVcIIsgqQNTU86LVtZC3by7wTNRcE5tJkandJKb8UsLxjNWC
         SyaNCAzV1pGCgljUa4wyKi7Svo4mSjtvwolpyf5avdEwUmb8N+7hRyoWAtbtSGY1g40q
         KUZQ==
X-Gm-Message-State: AOJu0YwXA6bxguP+68UOKf7E3ebVksujHh0nB9wZre2IzN/mSc3KeuFk
	SK9pSXdd95E0rhXFKG1JZQfGnT27ZjY=
X-Google-Smtp-Source: AGHT+IH/jHMj6SPf+djqQdMpidZEKeSxKuOmMnfBX0O2HbLM+zTXwQbpAuHKC7+8B6veMY9hNUZcoYeVJwM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a05:6902:168c:b0:d9a:e6ae:ddb7 with SMTP id
 bx12-20020a056902168c00b00d9ae6aeddb7mr221434ybb.7.1698155273022; Tue, 24 Oct
 2023 06:47:53 -0700 (PDT)
Date: Tue, 24 Oct 2023 06:46:29 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-33-surenb@google.com>
Subject: [PATCH v2 32/39] arm64: Fix circular header dependency
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

Replace linux/percpu.h include with asm/percpu.h to avoid circular
dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/include/asm/spectre.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 9cc501450486..75e837753772 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -13,8 +13,8 @@
 #define __BP_HARDEN_HYP_VECS_SZ	((BP_HARDEN_EL2_SLOTS - 1) * SZ_2K)
 
 #ifndef __ASSEMBLY__
-
-#include <linux/percpu.h>
+#include <linux/smp.h>
+#include <asm/percpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/virt.h>
-- 
2.42.0.758.gaed0368e0e-goog

