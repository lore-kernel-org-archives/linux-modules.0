Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641673403E9
	for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137769; cv=none; b=IfUijyGhnF5OD2ppc0ZWuqCof5HjuVppFc3ZAZjIs53D4gDoVdd0w9OO0vmIfog6/PdWeM0K5VqYMh7LjDKe28cQPfoDXdpcWM20Uw78u3ER6SwVg1pywmQtqye3Qi1Ztn+SWfZX9Zm5bIHqkpdG0GG/fIJh98a4MEP3ZuWiyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137769; c=relaxed/simple;
	bh=gz51FBCWhizVrU+7SLeOKliZNk1p8rWeS98CiQ+wXUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNWLGF0YlWwimAYB4Uor7+yNnb02ZWvMaVPvDWNkONjg/lhKZaI9WgBJcJ10WhhS+VPJRuNtMB34RBrA6IvOEaquk9/uabx7wE5dqwCw1veeyFl7AgcyWJyRiKIEKMBu41+mcmwXRtH4H8x31mg40/iG+O7l5l9Zh+4YZQEgsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMvGMq1K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMvGMq1K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49e668491f3so3414595e9.1
        for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137765; x=1789742565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNkJ+Y4UNh/VmhAHfWRxswemkYstE9GZTmx6wz4UC8Q=;
        b=TMvGMq1KXCQ8s+RpmILsIeGf8K0plpbDc3xU0HxW5q69wJ4IuhPeLCr5JbpsWff46R
         R339YRUVqRi6/PFpgzO+b+Us8b3f0Fv3RavXH/rvTME6crQSeuZQX5fhsYwkFumrKmhE
         MEMcuIHBwGYYUdn5MYSsoLeQRLHg/AjEpHokj7Aaii7ap4k7cJKFOQG/tiZUWjFTnYaP
         lsPtlukinpLRNsdB7EuXrUMMC5LQpfj6AItmxEaYlmVgQ+Cj3hNca/7UM3Qz9RNHGCD0
         a+6gAPL2hEEwWw9sRZRHyAcQZxk+Xn8ONLqvZvqEgWqJuBbWYpFcDFky37P6I126tOtP
         Fcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137765; x=1789742565;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNkJ+Y4UNh/VmhAHfWRxswemkYstE9GZTmx6wz4UC8Q=;
        b=nBIV+zPbFlMizsq8jeZ9gyW+tkJwF+LJCSEu+xNxKlRgk3646U+1crKZ2nO6jJeno8
         N8O8GufSJpjQQmU76q4GQ8nnRyCWRy+/alp7+0D2kmWvGF/PfF4GY28tT/cpVsA1CCj0
         zsf/nkzFD0C7Sv0i7HX1eJLuelZvq8aoWJK90LMxjJ83LWcVj8vyLEs1zmoiJ5j81Hs4
         bnr+d6Ewj12/TRfo1VLk6w1OP7zdJP7eeig4IX2KzJth9qCZZrhZO3+NwtZU2rTbZ7LF
         YlxtFKtWzMsqF42gnirAMwwkXgl0n8gMNLH0lUyllxm3WD5R/gaFt70EgerVxR6y1w0f
         4wXA==
X-Forwarded-Encrypted: i=1; AKwUvBymBk8tPymqBCyNJsApYb8st06PDgA7aPnVIYcz/6i5hpR4qvLE10w9tezz5jxYQgQev3T+s5FTahyRdnlS@vger.kernel.org
X-Gm-Message-State: AFuF++l6OSxPFF5iGwUvrXxyej8yrYstxy6e5FOeyFXPFiD+H8aOIDT7
	ulQzTBXWbXsa86tEczDtCBweb/BxPHtW4PHw9kqv1XaDOGZSUYbdi4IY337ozSZeVLk=
X-Gm-Gg: AYBFou30Jwglh2ZN04aexd1cXwDa5/TMZwKiDN8puwqHFiuIdCba80z1cYeH3XiHOuN
	aY13PlYHnvYub0YkMrotujbl4pKPqMSHfwzbqbsGLT3K4B/JaSqjuQGQJmv5qvEnfIF0QyVac+I
	9o2DO72ojFdpniNtJn46MmTZRFn9nu0L6hDLC6qEZek2Zk1bLuOgGq2x8wkZQP2FTI3WdIkFg+R
	fOV9tE1eglwALTbbK/WdHlSY4DXrdTRxwcqU3upAZnHbq4ViU2OIrAonPvFYzHWJ3/ao7YCpshM
	NxEtLA7j9IKXgEj53DTQUKtiD/n+iIlEcUFLaCQidc2620NThPLk6T/xt3PtiotPqCis7ecfbhu
	pzGqewstouEAOEG5F4Efit3Q1WZEFi/ycWMcDu+Jy5UKAj04PhrcWrJEy8I4JlTcOaigxy6/qBY
	PxCyJ3I1Yg4HEJL4z4185FWcwm0w4wXdXJshN2nzycnmYrtwkiho+P4wk4siyYqtZpXGRnD3kQ9
	D2fh8zDRtle+ekr
X-Received: by 2002:a05:600c:e557:20b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49e619836d6mr35798025e9.1.1789137765611;
        Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Fri, 11 Sep 2026 16:40:32 +0200
Message-ID: <20260911-module-include-elf-v2-2-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Several s390 files use declarations that are provided indirectly through
linux/module.h -> linux/elf.h:

* arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.h,
* drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
  put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/nospec-branch.c | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..b62da9e81e79 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <asm/nospec-branch.h>
 
 int nobp = IS_ENABLED(CONFIG_KERNEL_NOBP);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 4d274a2ee84d..402b8a225d6b 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>

-- 
2.55.0
