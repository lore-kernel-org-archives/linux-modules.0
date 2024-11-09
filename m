Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022A13AD26
	for <linux-modules@vger.kernel.org>; Sat,  9 Nov 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731171071; cv=none; b=Qh887T/d94ZcmtkTpyjIKJLtEY6XzmnGwGCYWl/DW4nQzHs7YAXX997pAC4YwsxgNKJfBESVu5P8n4l3NZSSUypPfoxLZpKFuFH+hvaj8jfDoc9Sg35DbqO9wdjdazmaAhGu57AUUpf8qDsSxoTw9XH4Epsb/SXVN0LIV3Pr6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731171071; c=relaxed/simple;
	bh=2Qp1HJqt1ZkkVbLZBqVG7b1YcQk5xk99M+jagErontM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bzh6+dp7HUjU1xYGyBKY+5XRvGhxhgk0LJbnfe7I7io2ayYIL1K8rG+xYuFmor172pzdgv5Z9Y3mMWbF1xfaeftIKJwOqV9g2lCDppm6O7Zqg7ZVi720DpOzZffg9fpqhtosrCMJ/QcaWlVae0HirVIojqOyClfpea4G5KznuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmC24uVC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmC24uVC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so27012595e9.3
        for <linux-modules@vger.kernel.org>; Sat, 09 Nov 2024 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731171068; x=1731775868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtOUB1qrhJ6BZVMlrSnOsiJoY3zuyj+h662J62NlIZ8=;
        b=JmC24uVCQiygRkKOSdI5T9cbPc34vmSe7tm74qwWY/jpe2j3jx+03voS4OVgWVlsGn
         k6SG5/pafEOEfvHyBgld4WLjCqANZx82YSSCFnR7xaVpmtsea0OgqPRvmIJIMzDK2t3n
         /J45lSfOkVswfPyYIMGGkb5i+xSrMgETl3XL5xpzvmD22qEMh3dLKtXXhXhb/pr0u1uz
         M/e2UEyxZIoLQBoOc1eqNW+QSpEyXspnqNQeqgIE7p70kOt0uQVC7as9drgbHwCycRWW
         gGH6vFfqc/gdkVtvCVobw9jb7GGaXAcVhU1olGfgn17AXmK/Djti1VEHzEw+FJIWygB6
         Byug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731171068; x=1731775868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtOUB1qrhJ6BZVMlrSnOsiJoY3zuyj+h662J62NlIZ8=;
        b=a9g1Vx/HchcZIKF5PnH12dJJmGkrZQ+qr+qKnhE55U4TN4S7I9HZm/kNNNrHR5OOtj
         gDu+YnZcyEofECxQHnKvG/2W5dCm9ffSvGUotXkKfU16x1xPWT4QTQrm6CfJuIB16Unu
         BisCFfVf4/56NAuO8djRDAZpHFfZmgdhv81jk9dFdsQZk70mtWKLKOsACjQmeNYkGJgd
         pVYJB+BGzjFloFbecW7NnJ7BuHARoGtdenCS+mq7s1mWdlbxtXlyMtjiFIepEyIF4fr1
         1L7upNB8eYkZQ3Bm84FmBwgW25vjlJXQbO+d4F9Wy3jK45JOnoLfe9waDpTL4kvBw9U5
         EHpw==
X-Forwarded-Encrypted: i=1; AJvYcCXpZnlVP0boXkKurGdg65tQZUlCNclgkXeqsE4uhS/hyrWmm15laJWv+BlG2HZDC6QO3Z4wUg6cxEEXt6o4@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiQe/Z8uhaf3TcoVTwvuPrJKSy63HdrMSoJEAP9xpqe3ADUn/
	P0TapXudAs/+kWYeJMAZRBrz+wsUB9cYeAZccToUbvKAIcCglqTRLwZBN67y
X-Google-Smtp-Source: AGHT+IHCYbKRMwsggnkoNFwqEo1JPGKjWiRBZ4/4TLrwk8t19gagLV8L6CxtG+vLZKRI5ulJMaqHsw==
X-Received: by 2002:a05:600c:4590:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-432b7515c33mr56797555e9.23.1731171067595;
        Sat, 09 Nov 2024 08:51:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:a05:3bf:6eb7:59e0:a3c6:6ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1f8sm154140235e9.30.2024.11.09.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 08:51:07 -0800 (PST)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	linux-modules@vger.kernel.org
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH kmod] README: List strip CLI command option for summary
Date: Sat,  9 Nov 2024 17:50:29 +0100
Message-ID: <20241109165101.20762-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As addendum to kmod #220 "summary: List buildtype and strip options" [1].

With passing --strip the summary will list:

  User defined options
    buildtype        : release
    strip            : true

For details see the meson CLI command options in [2].

Link: https://github.com/kmod-project/kmod/issues/220 [1]
Link: https://mesonbuild.com/Commands.html [2]
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README.md b/README.md
index 5169890a88a9..3c1ddbfb0a39 100644
--- a/README.md
+++ b/README.md
@@ -56,6 +56,10 @@ For end-user and distributions builds, it's recommended to use:
 
     meson setup --buildtype release builddir/
 
+Further binary size can be reduced by using strip CLI command:
+
+     meson setup --buildtype release --strip builddir/
+
 Alternatively you can try autotools build.
 NOTE: The autotools build is slated for removal with kmod v35
 
-- 
2.45.2

