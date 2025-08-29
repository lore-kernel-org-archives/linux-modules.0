Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D72D878D;
	Fri, 29 Aug 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457407; cv=none; b=pJLaRNCyi7K+ZwYjxzoey2q2S7gDHQyxkX90SYTcMkPMF68pWtcJNTQtKLhrsQN4vekpatHdpf6CpgkJjlsrECBEWpKOH5h4nGisAdx0HDTZ67noRl+0JPUN6wL1uNCgiaQ/Vm47xeEd57ClNes6L/R4MhTpeVlHpVLLZrhcpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457407; c=relaxed/simple;
	bh=fpaE0d595CwgrDFlhfV+X1m/1hWBH32tbRMD/0YcFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl0AivRyRmquD3TLAbloztrTAVDMMnOPfvUTn1DsCQtWWKRWyI274EDBcnK3Qdf/rniStWN2U3Q6NxSoFRh4wYwEzE6uac38rKL0TlliBGcvSzlkOyx2pKVo7LZIspdhgE92YDmItYo2qAJT8jnpeGMAVtHNTIPIkKJhgIIBgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+xC8hKv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+xC8hKv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445806df50so15326845ad.1;
        Fri, 29 Aug 2025 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457403; x=1757062203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ud+6Xa1z1jB5TLuiA3lgD5kenmdYlZUP1Al5nUROhw=;
        b=C+xC8hKvVDIAOR43Wn5Q6D/W8OJcNwUXj13YpN0ChTBWWRc6TsGKqlWR9EZr45hHHq
         9SZzup5BkaT63acvSdaCmFSbYMFWRCh24o5znl8qEf8kxhUYkdaEM34yO1pjCla1M4AU
         fSeIdNELjBfIH3HY1wkGTEcncVpdywe79E24DAvkKVMDmSzCnK2VKAd2//szFCcQVSVw
         U0as2AbYD+y3ZEavYEk113JdSBJdwj3/C388w10rD/M2EWAOYGUNeRHO4M00DEhrtshr
         qGg0T4p0i76VhkTOKeJl89qeHgPOG2bokPPipqv1jPOZ6h9LBwhbKz+pmVa1pXlUFZal
         nRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457403; x=1757062203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ud+6Xa1z1jB5TLuiA3lgD5kenmdYlZUP1Al5nUROhw=;
        b=xPOI3oxkA4FccHenvDT2eGQSKbP5NLQiGTiqfMkV6+wH6A1vlwR0Ej9eVcqqIQ+5JS
         x5tdOlwCpPuBhRFJQBt32BmdNlx282+YrxQ8/VSFgWBrs+/zlLBJapp8oB5kgggOej41
         hbJ+0n9Kz+LkeNuecwrzVLTqwIYHU9pRMuOTBoft55y7x294abx54pcnkyxCzrc2IK5a
         JgD/qECeUstyJTjGseN2LY3wj+OYjAdghaX/gZhr4lT3t8bbtuzVAWClIXMDYWpVJbrV
         4yWQMfuJIGuviBTwC8saUHVoylKV9VhaQPLWChH6qVFYcp//wEQgAhXnnW4JCzEyw3Xk
         zzGA==
X-Forwarded-Encrypted: i=1; AJvYcCU8yUw1JT6QI1JOTElX2RMI2ld0NkTemd9dCdqRTdG/hKTiT6mA6x1Qy0pn6ny5h3Ez7PVlC7k7VwFEmuw=@vger.kernel.org, AJvYcCUkmcWNIjLj3VSlKkzEROVOqPUts9ofMN9U2jCO+zOEAu0uwRtCZU8xd62vHDTHcSpqFku7G9/dQJQe2MNt0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZjFaFci7pSqUZg4GIm3NEFzBqp7BD5A85bZlzvlEjfBkwdnB
	7SeHXjBkWNe0ct+7DdJVa7hQtc1HsR/0bAssRw6R6ls7sEqso67njhZX
X-Gm-Gg: ASbGncsZKwHt6XPl99v0egO4930T1zXjGXkmb/nEbwt1IFB5qK0vjMqUdgrp6tpD5zV
	LthZdS8mxZ6bY1+0XwibWn2SinryHGGM6F7e59XcAdYxQFWju5d480NxJDTzNzNZIqJfgZHlIsp
	9eKjaX9EMqCag9hs+5+jOSglRGtRW+QfvdZlu72ZBJnaXpqr1K3uhOMZt60VuOz62gLzg+DSHwj
	n+QNsyJndtkBD2S9QU0CESYA4F2ZruJ+riA2gcRbjuh8SFh+ChrmzX6ghxEumkmu28CLVoMFbd+
	HQeJ8SBxVDa47zD2ERhM1Qa4awLoo8SnO+WtC+W1HE7svqXAlscjIb1DvthWZcQIN8oHJKo3WVD
	CI21NPIBLMdJDWg5H2dmz5S/7syPA2+G73/5lOSAartnfxCiZNpqAwbF3q0fP
X-Google-Smtp-Source: AGHT+IGJjVrZjcGLD+aYNVVvBsvvvll4RulQAnH99m3XElYYX9NlW09W3j3ChREh88K6yxVOoh/PQQ==
X-Received: by 2002:a17:902:f607:b0:248:e0a2:aa2d with SMTP id d9443c01a7336-248e0a2b173mr64242025ad.25.1756457402912;
        Fri, 29 Aug 2025 01:50:02 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702980sm18561865ad.13.2025.08.29.01.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:50:02 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 4/4] module: separate vermagic and livepatch checks
Date: Fri, 29 Aug 2025 16:49:13 +0800
Message-ID: <20250829084927.156676-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829084927.156676-1-wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename check_modinfo() to check_modinfo_vermagic() to clarify it only
checks vermagic compatibility.

Move livepatch check to happen after vermagic check in early_mod_check(),
creating proper separation of concerns.
No functional changes, just clearer code organization.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e7484c6ce6e3..98a678a18300 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2571,7 +2571,8 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 
 }
 
-static int check_modinfo(struct module *mod, struct load_info *info, int flags)
+static int check_modinfo_vermagic(struct module *mod, struct load_info *info,
+				  int flags)
 {
 	const char *modmagic = get_modinfo(info, "vermagic");
 	int err;
@@ -2590,10 +2591,6 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 		return -ENOEXEC;
 	}
 
-	err = check_modinfo_livepatch(mod, info);
-	if (err)
-		return err;
-
 	return 0;
 }
 
@@ -3334,7 +3331,11 @@ static int early_mod_check(struct load_info *info, int flags)
 	if (!check_modstruct_version(info, info->mod))
 		return -ENOEXEC;
 
-	err = check_modinfo(info->mod, info, flags);
+	err = check_modinfo_vermagic(info->mod, info, flags);
+	if (err)
+		return err;
+
+	err = check_modinfo_livepatch(info->mod, info);
 	if (err)
 		return err;
 
-- 
2.43.0

