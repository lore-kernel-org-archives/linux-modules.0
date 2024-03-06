Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF051474A0
	for <linux-modules@vger.kernel.org>; Wed,  6 Mar 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749521; cv=none; b=pBVhM1aCzVMJv1cIVStbHtp7S6JQEd/fnYe8DrmARKLwSF7GtlD66tRQBnEYuJNzpi40hFrw4l140vpHGPHp0LbaDPVSw1viAou6XBZkmkfDrol0+wAUDVU+lAg3GwbdAohsUakJ4nulOun4pw4Dh/BqcNC1YtpFaslA0oUAaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749521; c=relaxed/simple;
	bh=Dv0eI32ABhCg/c3ioBN2YUnGdkO8o8M10k34MMBgAyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WU8F98SKUW/4S2WC7/ZYnh+G5TnCKgHH0Pvcqzj+0htqey+W3A9CJVI8PJF+1YjLy1T7C64Tb2nCwQl0IIAVWPuex3mIEPFeuvOpPtYTRWu0q0EWGJOQLQ3WhejikKdGpxD69ViG3kb/OUaOrZ+xcP1yANjmnDYt4d0czhRXaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zbliseqw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zbliseqw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so11715698276.0
        for <linux-modules@vger.kernel.org>; Wed, 06 Mar 2024 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749517; x=1710354317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZwja06se4PI5NvmXw6g0w6FqOSRgAaf+Zh29a7Axs=;
        b=ZbliseqwaEa+vFlbwJFZ4qt5t9Pd2WQg3OKci0yjhtfGWEz9MYfNtDl3cWYuBnOVGJ
         MvLDfFb393YjCeEYwxcLWQhScVKFjrSG0YvY8jxk4Kx7tdtNziFGdAptuDnQFh4lXH7p
         OIgm789hYKJANxzsAfpPalLO/BanSQ/Vw3tpJjMoA9oF5niM6oEkXyipv4k9TsP3sWga
         b7CoAxBU3vW1oXrx9n7EehWALeBythb4o4IQ4DubRo969NG0rY2QpvtvTyZxwG4XIRr0
         Zx9yF0X89RAfuB6Wjz/gMr63PcUn/Y8w9w/nN771Cd/wfj5eS3Oa0wdFBcsMvBNcgKFC
         ytpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749517; x=1710354317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHZwja06se4PI5NvmXw6g0w6FqOSRgAaf+Zh29a7Axs=;
        b=D+2Fqh7ZiFtK53hFm0mT9QankB/9ieSjTu8CEGpGpDUQCA1MOFa5vmtzLg+qBilWJO
         DKxrLTIJm5FbRQ5s4bizMlOGwf+ul24atjO5kEqNmpaA7PGH6v2g6XL2EiGoUFbpU0Sa
         A+5STIBCdc9qZJkVll+A0GK9zw+eH+vgcKZyOXAyTitGV2e2oWHZr49w5YayDFcXmuqa
         txfwxBiPNAZC/digIW2WLdlTlA7RMtOuh93mefcMuwFHS43cErfO5T4i6oNh8DNmGrr6
         9uhSmbpgwz60VW5NfeKA6CX0XvBlaYk1LwY1lPlXT4PCcBHQiJ8WrHc+yxeagwwYx/v0
         rmtg==
X-Forwarded-Encrypted: i=1; AJvYcCU6cJzweSJIgYzrG6tugzU6RSFdiQTgNqSQrl1uSSeK2y3IORRLB5Tqt6bNFCTdnWx7vAJ3Ob1O2YiPtPghCLMGMW1D0wKa8mPIkz1LHg==
X-Gm-Message-State: AOJu0YysFMYRXk/baI4c1km9Ri7452cvDI9LmgPPbiDs2FSG84/IIziu
	t4voFBuTmNC5RJgbwkUjbHCtOufVQWPB3bAcMzGjDmsfmAHOpIMOcDptv/M72CTAc02zYDy17Hs
	lBQ==
X-Google-Smtp-Source: AGHT+IEY0dq37W/YL8K/UAYJglAS6s8iwOM7lJC17R20EwJUoGE14Vwyo3M1UA8Agcy0JGlj8awomXhRYvE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:18c9:b0:dcd:5e5d:458b with SMTP id
 ck9-20020a05690218c900b00dcd5e5d458bmr4001383ybb.3.1709749516858; Wed, 06 Mar
 2024 10:25:16 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:13 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-16-surenb@google.com>
Subject: [PATCH v5 15/37] lib: introduce early boot parameter to avoid
 page_ext memory overhead
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The highest memory overhead from memory allocation profiling comes from
page_ext objects. This overhead exists even if the feature is disabled
but compiled-in. To avoid it, introduce an early boot parameter that
prevents page_ext object creation. The new boot parameter is a tri-state
with possible values of 0|1|never. When it is set to "never" the
memory allocation profiling support is disabled, and overhead is minimized
(currently no page_ext objects are allocated, in the future more overhead
might be eliminated). As a result we also lose ability to enable memory
allocation profiling at runtime (because there is no space to store
alloctag references). Runtime sysctrl becomes read-only if the early boot
parameter was set to "never". Note that the default value of this boot
parameter depends on the CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
configuration. When CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n
the boot parameter is set to "never", therefore eliminating any overhead.
CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y results in boot parameter
being set to 1 (enabled). This allows distributions to avoid any overhead
by setting CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n config and
with no changes to the kernel command line.
We reuse sysctl.vm.mem_profiling boot parameter name in order to avoid
introducing yet another control. This change turns it into a tri-state
early boot parameter.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index cb5adec4b2e2..617c2fbb6673 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -116,9 +116,46 @@ static bool alloc_tag_module_unload(struct codetag_type *cttype,
 	return module_unused;
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
+static bool mem_profiling_support __meminitdata = true;
+#else
+static bool mem_profiling_support __meminitdata;
+#endif
+
+static int __init setup_early_mem_profiling(char *str)
+{
+	bool enable;
+
+	if (!str || !str[0])
+		return -EINVAL;
+
+	if (!strncmp(str, "never", 5)) {
+		enable = false;
+		mem_profiling_support = false;
+	} else {
+		int res;
+
+		res = kstrtobool(str, &enable);
+		if (res)
+			return res;
+
+		mem_profiling_support = true;
+	}
+
+	if (enable != static_key_enabled(&mem_alloc_profiling_key)) {
+		if (enable)
+			static_branch_enable(&mem_alloc_profiling_key);
+		else
+			static_branch_disable(&mem_alloc_profiling_key);
+	}
+
+	return 0;
+}
+early_param("sysctl.vm.mem_profiling", setup_early_mem_profiling);
+
 static __init bool need_page_alloc_tagging(void)
 {
-	return true;
+	return mem_profiling_support;
 }
 
 static __init void init_page_alloc_tagging(void)
@@ -158,6 +195,8 @@ static int __init alloc_tag_init(void)
 	if (IS_ERR_OR_NULL(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
+	if (!mem_profiling_support)
+		memory_allocation_profiling_sysctls[0].mode = 0444;
 	register_sysctl_init("vm", memory_allocation_profiling_sysctls);
 	procfs_init();
 
-- 
2.44.0.278.ge034bb2e1d-goog

