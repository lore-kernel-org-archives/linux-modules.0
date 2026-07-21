Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFF3B83E0
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667438; cv=none; b=JH77gPBTiqm8UWUvNWGnVZVTFkor/VIF3nQEFaUkvIpLJOLUgqgMPFY9YN6+EgZhjdWIbXpi0XrveHtkKW+xJUHH1bJ8wckRC4GQ2dhnyatEFwNvm/k34ixA+QUrbglRHVthoAMUqHY0YnQ5I33V3tQJYQ+Z7fJmxYW96BGFCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667438; c=relaxed/simple;
	bh=es+00dI5lNkwt/sa4qLfcgHP71hLrTUzt4kFdW0j2uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DC7WL+d7wJCo3isp+w4JThy66krQ5BjzKx0LJdVMU2Jvp5JYIMGUPV79ihrnVMHUZ4MLPJGtZ5Xyb0vUueykfv6PhTzdl7gMxTXNnbCgv0bpHUL7VrlklUPamJsdTIIp5ezzCJUYMTUcrmUWPr9F+sVkIs1D68P2eADrT8651QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjjRIREA; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjjRIREA"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso721034a34.3
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667435; x=1785272235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAocSYnxkpWO75UswebGg35q6tA7nY7bmvBjycg9mYY=;
        b=sjjRIREABcpUpXY0URoY5OWAPcBZMF6zJfEzrchH8s6xVHLVopqz3hP/OPMFk6Unyl
         81s51gEq09E2Oxk3Uct480L+O/ez9kgpq6XPHCLOYlI8bsX1Z6ynUrEdfIeS7cNYqrTh
         HDz8AbveBw+s2SLBZ67Dk4w0QXUe0xdlgtnJJFVDTaEu1Y4iQRYfQNCwnmaYAemfXHeA
         kEqdDFikLJELWgm+k/0QyJEjNBcfgdNdmPcjBl9Lx2egEfIxo6wxI037J9amB0A9plzC
         pEBHtegEMn/Z5f4ETaH5PQuollT0f10zVERQN1S3y3b4ko2YzPeHdHfisguCyXc82/gE
         eDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667435; x=1785272235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAocSYnxkpWO75UswebGg35q6tA7nY7bmvBjycg9mYY=;
        b=NkZlRAt4pIWAnpGW/K4v1UZapQVFx3GfPElRKDKKq+T/1K2xFzCucYMDbPr6Au/vTz
         tu9AU2hc4Z7HgOpbMMFrdhsV6KD62TFrW6QrweV+WjUNfG8A7Pwa0k2oyKc0qPvlbNKb
         z6IlS8F15ribHm0V4nuY7sUwFN6aSwUY44OHBavM0o1AoTpsVgIhUEXUC+QuzbSMB5hl
         jPpJf6rO13XSKK2E/ZQ2UyImN4/5U05TZzqJfDXaXhWu67qrH0n67IVT6R/P3IMLUe5c
         dQRI/zVJkwn6ciAgaUuxZD5KW8kTtMJY1j69isro47e3iUPUxfRaYEWYp3pAWGzQYPvG
         c8rw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7dwLFvwbwMXNnjkuxFce3a0xxPdgnZIyMxZFeTLphdfV9Bvq7Tuiei6d96sreZtqMESLRXOPSTAsJ7Ml3@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLOXa8JDu9+l3achv/2u5ZF4zVz6ld78BO1+XggIq7TIxupAX
	OxEzFiO68zOAAtbH2IL4BhcrBMP1c8wEMTo3+n6OLct9rFb7hgSFmSBckY4vGA==
X-Gm-Gg: AfdE7cmL42uaAb7ZXIXRYK9O0dajD93+VubzUuvQVPp7UEd/h/cg0q9vcZ8ZL42sDeI
	g1JIePBr4zfMF9hwktUG/dLQ0vom6LVbS/Z4eAS7Ngko3cFjdDXvAsU1xb0He8u1B/XPK3GN4pe
	b8jKoEDY0yOvVt/98t0Vzg4IXV4XsfNwejuRWHYRSA+8f0jwPaU/UDvh46hNzKzVh5nbquKYaLE
	vUwdRvukgWcYig61+CdQAB0BCgtYDqRx3aGLzDne/+RHCm7yyuSy+5J49eZy3ueCsUQK/j8edLE
	ooUARsY8y+ITiN4MPz29DTkaLEkGeVIlTabW68GzjqdCIDNrQ5S+GKMKI/HKOgD8G80r625UM+o
	ibKRLT/rJGUwM6NyDetO1Q6+LnqwoQyTJPXFI8DQCDhPluh+3UqKEqgcFamWLY2Z24Ji5abNZNP
	clFzVkB9/9/N4aX/vLkSy/m6aZDBkLf02kVq8i07hUOcLIrTXrMUlazIFv2MlHfEaDsXik28sMG
	1tg6kncbshdT9ek1p68yqt1OA==
X-Received: by 2002:a05:6830:dc2:b0:7e9:b537:1032 with SMTP id 46e09a7af769-7eda4e4a0d1mr10236409a34.31.1784667435133;
        Tue, 21 Jul 2026 13:57:15 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:52 -0600
Subject: [PATCH v7 03/29] drm: Fix incorrect ccflags-y spelling inside
 Makefile
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-3-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1097;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=es+00dI5lNkwt/sa4qLfcgHP71hLrTUzt4kFdW0j2uE=;
 b=OISPXRmljhHYEheJg69+sy9dq795LswJjyP2tozw2g6htoU6Pia5NBf9EwQ+pEa9lAVL6Pfb0
 IHWJ4VHNv3oBIjyfxg/R8nN7AW2ofYOryMj8dbmU4ZDrQcwAKV1DvJL
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Fix a longstanding spelling error in the DRM Makefile by changing
'CFLAGS-y' to 'ccflags-y'. This fixes CONFIG_DRM_USE_DYNAMIC_DEBUG
dependent addition of -DDYNAMIC_DEBUG_MODULE, which is needed to enable
dyndbg-does-drm-debug when only DYNAMIC_DEBUG_CORE is enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..b0d0a85cbd4f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn

-- 
2.55.0

