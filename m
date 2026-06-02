Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC13CB8E6
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440529; cv=none; b=URln4cgTDAY7iIw8wT56M6XN3vVdY2fHF4Cr+jVW9VcAij8aOjsT3geh1tRlgu2m6sTszr50gBzl8EkzgO8U7OyHs9JXOVUj69qANjmpdfFTtzIXfWldzIwRX8S4MEo7egXEFaFC6EV+F+xovnW+AUMh9xNSdrWxKboXi5vuw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440529; c=relaxed/simple;
	bh=UEhkyuT+BoyqFKDfW8oKnsP6vZUUYVyVd65DI+YPTOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfOY2fjqcboM1OENiCfiiMP8MrzwIaGHduz8WmAhrHvg0IdTa/SjKS9F4DfOoZJpayYLNe+0XPoTrZD4CrdoWjOydsA8veMNSDY93cjI+EgwQ2LtJRy8EtAxm129rZ1jSNaTuUFqeGlIs2uTWo7UcmvScEfizjESNB/EWFb1Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQbipdQU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQbipdQU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b613a17bso1870715e9.3
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440525; x=1781045325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
        b=dQbipdQUF7C0ZAS7AX1csTfSROtCgiDIMKgzdaQxWAVa5+enX93B4lu2XRh0l9flEE
         0Hxq2TQBtk9CRW/z7ePTyk7YZLqCxeuBjHwL24/OF5paH4Ui0dwRx79B3yUAtjuCFdw6
         JLxnTXt0KSFUTABL7vCCLeY6aLtyekXvI/3Gco7wfcNeOxEYiwBHjCiwfG35HZr2la0m
         h1EOe+ZE4hUTUInZcDgN2a6w5cJ2kj5ivClLzr3LygVpTcuuiLG2EjpPBUrAW4N56pST
         uh5AVYDq/QP+59SNwG8Bv1fwKjNgQZsC+cjagVO7v9ylz0JbTDduA41rFhBuehgMOH9T
         aA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440525; x=1781045325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
        b=lI3NF+BwLZGwT4VB4hxdxvDw4OwZ0E9yyTTHeAtqNDP4iYT0x2em9BrPrWaHWU58sv
         T/cIgWyP26IH8TapXprMAMxefr0wuR5ci2EAa+Xuc2L4Y8/31KhYArg7dHFpSpCCFj52
         7zE/hDz8Too1MibpdJdw/r7bsT8hL6/dNbJkRKq037vTMVMGJQ7AfdPC57Ksm3dZd4/j
         Alzo5i6HESkkqf2YNLeJHAXwUV7RDzc5rUh6p/Q1QzHk5d91xi3OlXiH6ShUTelYuQSv
         rbAI6lSHZGyqNvLrPkdsduEjKN1Z/J55geU5IGrQ6LT7CQAcPgJYSwDCXSS4QfpxhqO+
         JaeA==
X-Forwarded-Encrypted: i=1; AFNElJ8ACTNb7Kp57+opkU7gMcAj5iuymMtg+new6IQqV3TnXosdqq+/glmVyulBq5YBVEIxly4JF+kde4NrlYuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsftKMHNIcB31hCZO3qG1Wr9OqkHWkXQNC3h2cgzkIqeQFcWc
	cQKBgrneCJGpsfV1OIrJGOjsbyn+ZbDv5JUlL8u1Aoi2K0r1LGOhT/N9
X-Gm-Gg: Acq92OEi1+y4VV+OWrC9qbmWWCr9dhaPpBud7U4vq9lLuXzeWL2mY7n2CDfdVbl0owp
	7HIJWfW/wZYZ6HV/u7Sr5enRryLiNEgy340Ml1uKVOYoaBEfioOCaHCaEm/p9Xot417lZsoA+n4
	/sqru7drxCfUTek997CwQ4bnhfzCmg/4QRaLLlf8uKQOSdwS+yyTy5x/Z0SOq43AZtm5LOKT0IT
	DMdNZF/7zTbYKC/MCpqToAS5Cmie6yHUbusYQylvyUPUx/U4hEKOUq/0AyWyDiDd9IalORZ48AM
	wZlJ09AaC5yu9kx4kbPlf1q6VpClEcVwyGe429SNKjd6z5Y/alCVEpRpSEOKc+34ZqQP+TJJcfm
	5hk2r5ro1Y3C6xIcpmumF6yiKSC9DazB2ysaVxO6TDnTQohwY6A9euZ51XEJHS7nS5Hmr5/My7y
	JO024f9GNIKY86CL0kznvK0JCwCXmpU0ITJVqHsXFMJQ==
X-Received: by 2002:a05:600c:444c:b0:490:b58b:a4a5 with SMTP id 5b1f17b1804b1-490b60e0a19mr10858865e9.31.1780440524578;
        Tue, 02 Jun 2026 15:48:44 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:09 +0000
Subject: [PATCH v4 12/25] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-12-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1065;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UEhkyuT+BoyqFKDfW8oKnsP6vZUUYVyVd65DI+YPTOw=;
 b=oyNMvL7qSBs9lqVN4LVgnejy7txyYF8Shv9mWgJ+0KrkNEc3NqHoPNa6IT5raJlG3MwcHq7XR
 qlFV9dpli+hD8ELBygRyFABvmf4T8xIJ2ymzMxgsM8PRk4Z5FJyAeGg
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: include linux/array_size.h, correct commit subject
    review after sob
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 78c22c6d2312..867e3978675f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -121,11 +121,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

