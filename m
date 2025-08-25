Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C342D130A;
	Mon, 25 Aug 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113366; cv=none; b=b498WRHdO3mUHiWmJWojX1hrh2Tg+qKgeJi7JaHN9jCpE0zys8/umLg5I9KKHesex8mxc8tppVAuvRbST4T6NaWc31XpGjCP3N9Fx7BKW+PSuTWQyaKotWBqCAaRLymyLrijG69haxBv044sOuMFNH0msgvcIgxVjBFpKY7eiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113366; c=relaxed/simple;
	bh=fS7tcc3pbTtPPamWit3eOd5Xqy7QnEiA95Q4HrebIfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab4pPEZzyv353XiTqgd9ZVk+v/2q4FahHZCUmZVL5dK1Rf01WSBVpZRxzeO1RMmftFpds7VDTaKlzh3IcZ7ibdNBFgsXzJBxQE7arvbXXjr0cohMT3lXjphiKG0MrX849CZlfpbSkLsdugdjpWB6dJO0EhBrM7vuvwec/xfoQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9+VOXXS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9+VOXXS"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so88987a12.0;
        Mon, 25 Aug 2025 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113364; x=1756718164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0BMKCDKNzT45IkwjHH8qIV9wptfqQdqs3ianpNZIF8=;
        b=O9+VOXXS9/gkYCBse5LYrNSwN4gtYLPeRG7hPkuAC58TulvcE+MtCeh1S90prvt6xj
         ZwjE+j1cQvwKZuW3jZ3JjA0d+Vxb7LsX4RnidehkeJl6PTWC1/OnA37KlWp93kDfCltE
         uHc0IZ4zDsqWVqIAEZA8EHBQWUKjtEm3yNN6bHCR5Xt0M9b5BZwQrMXA56Ri39r5rZkf
         1q3wl/bxr/S2C/ic3RN01s/KFq6+bV5tuq79Nq4nT5ApmfeDh7yrISGPVB9lNeCVfdZP
         MPwMgcrLheo7f/Joj/7hsjWmjdptnb7M6/MT4/5QyDI9wrKwmuOqx937gRp1YeH3sU0h
         uuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113364; x=1756718164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0BMKCDKNzT45IkwjHH8qIV9wptfqQdqs3ianpNZIF8=;
        b=Dn6Kwt1EFsK7tF4aT7fSmbejsBPQBiCCl/6Vr6F+2jl75NDg1pmUTNlG2e7lXUaexZ
         XcIZro1GfXBA1cibVAf1oAFFru4/vXuJBt12IBbdn+tmU87hsAfLoOU7ETwxSUYv6v5e
         78OulvX/zmFhLGe3ogTYvp5jpM/2e4eZEb1d4GM0Ekbt4DS580k6W8CuwfMPQTROaX+Y
         Bwt8wc2aI8ixdDvuRZuzwUbhdyf3mfLzncXqG87bkOAWLQQDP9/gH3jI5K5EM0gyVmrX
         ZHxRfnMKWymJ/O+uUOwt1qTNi/SC9TjnauzmyxI29027LzKBJSOu48jKuDGJEFD8qquO
         dglg==
X-Forwarded-Encrypted: i=1; AJvYcCVbvWNQJyC4Jb/5eCZcD1Pn2d0nVyqK949asjeVPa6s0PVeK0z1g7HXBxy29pxvk9jOU/uqUxuPn2AwTC4=@vger.kernel.org, AJvYcCWXsIoRp3/HJPS2m+x2A4DZv34SJ1fcjdJMdrUe2dkJUfEUCLGKkkew4wRhjxghL8+SpaYRusb2KlFM6zRiGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpJ0yvPnl7GzcwTCCHbSd+4k1//2fL3ck9uWnutjgehXVj9ne
	5yHs3mIWNBh5lvcfF543upkIeiOKccQGs5V1olSagwYrPLhtfjNb+JiO
X-Gm-Gg: ASbGncvNbZ+W8YfAQhGmiTF6V0razPBz/InLsu8RnbEemLGpoPYglgEhBhVPMAxASVs
	5liDEpHik1XDIyL3t2E1q4TWay8VX+eTOrX1N4oBmFU+ypd803oqFvq63rpr44TwhS7LMqorPdQ
	ZN6GbMLnA4lV/lxpRREyHw98MxfwEonyVWCtnk1OOZH3zHi8PQtjALlrKe05fjILzF/rf8vbads
	JsnAiH0rOskjLGjUS7lZia8qtzubOKDQqp/GZ9wrijFNsW9nzFk5ekgTPyDR34b67+/tvulqxib
	0V2rBn+CUpN85PB/etw6O0KiiTutcLMtuSjy8NnlptMXl7UetyB0hZYIPY07Qev5zkN0uYVAH/a
	Lwnd0MDvctNMQRCHDiiz63Wyke+JYCENvRqVJho4LmaavHvSvTmbkn28eSov1afOrnAS0lAeOCC
	M=
X-Google-Smtp-Source: AGHT+IFiMVR6n5YCwf3x1l6BkQWj7LzzSrKOIaeNlshr8fQWRjk2TwLMdhbhLrPE9XefhDQGzaEqHA==
X-Received: by 2002:a17:902:cf09:b0:231:9817:6ec1 with SMTP id d9443c01a7336-24632a36020mr137426105ad.17.1756113364450;
        Mon, 25 Aug 2025 02:16:04 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b1525sm62792245ad.54.2025.08.25.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:04 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 4/4] module: separate vermagic and livepatch checks
Date: Mon, 25 Aug 2025 17:15:35 +0800
Message-ID: <20250825091545.18607-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825091545.18607-1-wangjinchao600@gmail.com>
References: <20250825091545.18607-1-wangjinchao600@gmail.com>
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

This makes the module loading sequence more logical:
- First verify module vermagic
- Then check livepatch-specific requirements

No functional changes, just clearer code organization.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a426bd8a18b5..d30bffeef63e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2571,7 +2571,7 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 
 }
 
-static int check_modinfo(struct module *mod, struct load_info *info, int flags)
+static int check_modinfo_vermagic(struct module *mod, struct load_info *info, int flags)
 {
 	const char *modmagic = get_modinfo(info, "vermagic");
 	int err;
@@ -2590,10 +2590,6 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 		return -ENOEXEC;
 	}
 
-	err = check_modinfo_livepatch(mod, info);
-	if (err)
-		return err;
-
 	return 0;
 }
 
@@ -3334,7 +3330,11 @@ static int early_mod_check(struct load_info *info, int flags)
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

