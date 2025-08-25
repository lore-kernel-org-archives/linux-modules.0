Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840902D0C72;
	Mon, 25 Aug 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113360; cv=none; b=D4AIusnI5kMYAd7e0psouo0j3uM3OzRUg3/10e7Sj2bVTFnBp8dh1dSaxG1QTeaeUdWnYO/S/r3U/X7JFLPXCLTzJmqiBgAQBMSUM+ud4PGmhPH9YF3/MVmrSiIZNP6e/dHeZHjVRNT6TvZ9AvoOpZwJV6TaVG5llG6C7isq6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113360; c=relaxed/simple;
	bh=8jjYGS5PeFKcozsVZLXrvKIwWo7k8S7vhYJP/tMr/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaWEnaKspLNPh9wFaE6PJdsFMntJshudZWS8Wi0Gircm537o7LqEONbOOlq+qesMriu7BLkwPiyErUOGR2PCxfXX743Z6GFGgRGkNht8iziAs08DFZVK/iWR/cV4MKYZA/zR8ZqW3bndZYzqHCZgF6nT/cltn59atFJ4wboH+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tnz870b+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tnz870b+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458272c00so47785505ad.3;
        Mon, 25 Aug 2025 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113359; x=1756718159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAU8pFNlFHyGhl4ZEBlmiIHJhRLnwySKV8rZz4maxqE=;
        b=Tnz870b+4ZyUktpooIoWxXM/7kq5tPZ6G9y9wAx4tAQ4AepBYizP9RSyUTyn5Uw6zi
         SR5ygkLf9VzhtK+WP+P4UjwPNBJZHqd/JTrVJQ/x1wTUDMmTV5HcdybfkIG8nmhZwZJ9
         2mb4mfvHv/BzJs54Q+kT4cAChIsTrOt+PN8X96QaH9yCDDar981M5blI/kDKaS2Pljn/
         zknK5zrJ0Ex7HS630UxtS6sa/bEM/5m3FyjQytPfiQ/mQbZawj7spStoiJWLdnprMZud
         FZlxT11gwjnoDTm9qKa6YujUHv0hkXJaBEyqPF6+YvXdrhSyTfRV9yWOHbrpCPBEQC7Y
         Ai5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113359; x=1756718159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAU8pFNlFHyGhl4ZEBlmiIHJhRLnwySKV8rZz4maxqE=;
        b=fCLkQtedCiRrEApRyJD4SqOnRSdtK26g1U6G0h5h3Ki2vPLtlbz4MNsnsWoeIm2V2j
         B3NGeU4LRZ58ByFckJlCcZiEReCQ1zcfTYxHjEFM1pmMCFrbiw9wUGJxaVfF22xtdUmb
         Zzmu8rPZczF0Wmfu40c2/LZsuk8L5BdwjGIkmtiaxbQMSBoWyHjhk60liqEjsIDT9tDW
         ssVISVHIRXZbbIG7WkldrL3rR8i8LtVjpouWhyBY4wEK2pnYXBtd97diocnXrTZaDxcR
         GNfCPpvej/QOYeZi8irzHnsJEcKC9d5h2OhN50j5TzSBCxLmRzSsaSiHiJ527/pLSSEN
         Ojfw==
X-Forwarded-Encrypted: i=1; AJvYcCUcm8vGXu86gO9hSZj3Vy+RgPvwBuAy8vJcMRuHmOlf9VD7OkI42GI18gJNEbGp57Fuwy6gAtt9u63E7Ig=@vger.kernel.org, AJvYcCV7anEzbckqjCCKiCx2X9UpWUsCh/yDwUTV5c58SfaMlBf2wRHMqqL8MlkoQYRLpPjwRRRDOIY9HlLGXuNb6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcuLWABR5PLbtIN9FAIdpvNG4rgg98GjAqLmF09GTxnHE/YF3
	8v+KtzXDopGh08Y2lR4dJQjlv2MwEk2dTiIGmNAQlNwD+Ru3FSnCYoHU
X-Gm-Gg: ASbGnctB6YT8IXWtoaYDN1fBOOc41qsOWk69ypXmLJwtQp28SsECM05drJZUh9rDL5n
	XauYvphY+2dnnGyiRXJU1Xm7WPek+dqEYBVtlNm4l8tZBZYagZzS/jjUjN6vo210xQSMdnlCHww
	Z09rbNn9uu/2TlVi4K8lnB9lWCoLkKqtPj26iYSf9zX1zI3J8FG/rE0o252X3zc8rTex9O3HkEA
	kfYGoAvPz7sFiKwXypIphbuEhIjdoWF9akPPDM/SAanWxU8RvO2eAAQXdRa78/CDOB2HAUYa6IN
	rZWmDqDG/dMXhBTSz73EccIQK9tRYqi4gnKfUY+iiUDK8qE45f+U2RUqPPl83moZHeU4RV94jKY
	HF+S2eDFLAgHXzYDsxJUGpduI9ITT8ZZ1DBo/puMjC4FM34LQ/L1eClzdp9GFpaG5OLYhyBYKgv
	s=
X-Google-Smtp-Source: AGHT+IEg7ykv7ujiyp9Mc0OjHNZy9+fuqP5eB4cL+6mJPmvrW2dGXYWnsywrHVst3J50rChKKyiemA==
X-Received: by 2002:a17:902:f689:b0:246:d98e:64e with SMTP id d9443c01a7336-246d98e0aa8mr35280235ad.36.1756113358626;
        Mon, 25 Aug 2025 02:15:58 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b1525sm62792245ad.54.2025.08.25.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:15:58 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 2/4] module: show why force load fails
Date: Mon, 25 Aug 2025 17:15:33 +0800
Message-ID: <20250825091545.18607-3-wangjinchao600@gmail.com>
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

Include reason in error message when force loading is disabled.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..a426bd8a18b5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
 	return 0;
 #else
+	pr_err("%s force load is not supported\n", reason);
 	return -ENOEXEC;
 #endif
 }
-- 
2.43.0

