Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31E4302E7
	for <linux-modules@vger.kernel.org>; Tue,  7 Jul 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438732; cv=none; b=VKg6XcOwbdK94CLYAoATUuxgrZmwWuQdTBfa54DnPWrqPp13lKYIJVgcy/YAKw5lu80NXZIHKinvxlSCLpTZolxf0c55CuKVF6A25BJIAeDyjoabuG2H0zlXCsBFLs4mJE0aEf2hb6uJXK3EUWuZ4GzZkLjm1P7WNb7hqJmHpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438732; c=relaxed/simple;
	bh=Oe/4C5CNRzZ9YU+v00jSZhbg5LdWqb5vYdjw2GlJdww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMOxiD1biRsg6Q95MFo1uD/qHH60r3FO8VZ47reEFLWdkdJxv7ZG6sUJ3sFw9kUWwZWaVfogs7lrmdBVIzWbl4wReRkzeHlRZvL2/FwmBEUWh5uw0qcD5TTivRz313apTgvb6rGaK3keTEFjr35nSie4vJGDTuVnC7iDUY4XYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqHnx8tO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqHnx8tO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ba701891so34703265e9.3
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438729; x=1784043529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=gqHnx8tOtAcoHiz3oAs3aB1L+Zu8szD5/Nn64u7BhvYizMm6qbB43NcEfFjZz8V2RV
         NVHCVdiB4waFJVd+XrgkkJ4gSHzMg1xUUNLsKqlKM6d+WlmM06WXyVN5rvocTwPUx9co
         l0CkFFkMcwXAQ6eMGUnEy+FGP5ndnKJv0J8AVqT5pcEKrmGNLrl48TMbRpSp0gAU1D3S
         C8tld9YhfkrvYEcHccNNSvOh4i/7Sj8fLu6mOFaghaOMB4mcEu/hRdAiuSK4/fMW5mDY
         x301TVi1FyPzKB30Blo/7MenwtFbFwLQvyx7k31rDt8EHNHifJyBYtl5RXmggc+B+UdK
         UD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438729; x=1784043529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=JIdBEBp10nINLFaiboQ+aRlT7tMs0SwRPB+1SNBo3PKIPrySzSZuGYu/tDPrW35bo3
         Fkw+fjrxENHm5WlBxk+o8ekdUYb/osK+IZ21S2BAOz1gdDNT0EELQA0ktVfmZ88SUSrp
         rAJRs21HZnDuvxhFPmMChehTEt6gjLAcdC9A+3kHyXEpCNeCvi9IW7qNUvISmp/WABiv
         /LmT8VFxZ+OeuHayLjy1MdY4XJl/nQnxPJ8uQSH8o+tPSh57qk4Ipz0mK/CSciXs/a2f
         say5uBL002NgFHw4zqa7F6y1qEKVAt2235a7QzefdQ+VzABqksbSVbJrDYFb3mAse4cf
         dD3g==
X-Forwarded-Encrypted: i=1; AHgh+RrhMSIPvqzszc0RbE4hLe7iPhG7H9gBD8yXkeLRm3za++UX8IKZtDUnRNsw9/PnZqbqwV4VGyrjS/IsXR5l@vger.kernel.org
X-Gm-Message-State: AOJu0YwAY4AAzWgJhjSPmSu0mz8cu09Rzb1/B9zdoJMIqnsdO8HNzMQp
	l0CEs0KMle1oHpWE2NYDyRzBjpuZhFYcOsxu3eS6Pvw/EEBwGsxoYypQ+YZxkUncR9E=
X-Gm-Gg: AfdE7cljSD4Ux5oIbkmGfANpLB2VmuKerEeSNl8tMg65KkyIGVL/Ph+YiNG07x85bly
	EUVwvTWRnDycaR4HMHkVUrZKBV12V/rbPVectStqRHBq6xVowoi8MK1R6VUB/iqPPcYMYPfKdmA
	LLOy18WPeCQq0pctdJ1N4FJiodeRhcKsmxL1yD0DmP3IWelNTrRDzV3585lxAjG0irGSsMeoROu
	47RST3iryaMVIYXS4h2G+WJ/PMrkYab+KYbCAZ8TglUyfWng7+kQMcxNNbUyUJsehIb0z4XwhBg
	M8QPBJ6BygIFOCOM7DoaOPIK7r5Vx9JwAT8/f80fUwCCskZcLjX0Kd3Xa9z4k4i2vsfYxGZ+Wa2
	KLQJQVK0tnAJjsr4GO27lyp6gZRvQW5QNY343/vPRML4uQPY6rge1EtMTxa+zNNeqldr9UpXGEW
	b/m/4Pv6PVXb53vaMVXBJ60Fmf75r9zU57P7XkyakPnkU16yYbGTO9fEQHF8lmM+lsBz2bsd1by
	DmKS3Vd5hNRvw==
X-Received: by 2002:a05:600c:3514:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493df05f8d4mr59362085e9.11.1783438728542;
        Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:47 -0700 (PDT)
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
Subject: [PATCH 2/4] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:05 +0200
Message-ID: <20260707153819.4172541-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index e6a264c996ce..4fe3ead4a091 100644
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
2.54.0

