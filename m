Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14EC3B5303
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477131; cv=none; b=DuTHgpvdo8ubf3olTzv07iQZqbjTbuUF+LJR1VWLm9tXjMs3LXkUSjs5f53W0GPh6lwKd4CJiEW1CTJ1IM1m5/v3BFlv1BF/eGjypTHA2jBJy+2Nf8UFPJHjk/+zl4nZim4fvo80Jn2BqeQi6jfhnIft/tFvkUxlgaZJ52YTuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477131; c=relaxed/simple;
	bh=x84mdEzo7hGPjR/NYVWAEdiwl+S1LrXalF/kCz4ObuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqfU5926jgzILGjmji9HsHb7EFTLTC+BH4nXpk5owTv4uJZS2xNTHxacX9XfU3um48xcEHVXyQBJpZC8fULAkwRuz1HP1S6xKzjIxfl28xbLHFsvT4uNgN8lN2r88SarZrAn0Zh6iA2uj8dyIh7rItFUdHbtYy4sgsFDVLD/Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUpGacN9; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUpGacN9"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-499f6e0bbabso148994b6e.0
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477125; x=1784081925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+tWcMUoovy9fhmIt15bIV8vcOiTTbrzk0g8aDClvzU=;
        b=cUpGacN9tRsBwXrh5PqTyXtsdfHR3XRkn9/j7t3iXyZIpRIyGo11QgJCVrE6ej5bYT
         o8jPrYYyalx5CIdnTKYLG3fFooAKvqBFmCBKcmYh0rNybdrCMFtdeYMGruGtR166+81C
         BmmaQWhyjVut4xIv5ubUiwmVk4JIoNe/6aT7bxw94VW2XF3RD9bha8uzpJYP+349jzPG
         T0Y9YjDL0OhhSNKYXxSdgRvuwybDgnt0Y65+HnL1P2OopaPPw9vnlj/ylNLRGhEkbtqt
         z+8N6JGxwwhHDCL23aMySCfqPoZWcKbkpz5DjSB6HlNQxZYJsv1gJwBLiR6+Dwr13wsT
         62dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477125; x=1784081925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+tWcMUoovy9fhmIt15bIV8vcOiTTbrzk0g8aDClvzU=;
        b=bgIFt2M4+ZdpdeoeV+8tkq0Cg1kgey8AXCwR2dN9awQ+8YQ13tMKlkd4XwQEzB7jfE
         f2agDmktDlcomti0nFireiZlFyGC5kaIV4zvgDt4JUBfFju/NPKKnP4p3tk4xXOqYDop
         gD8XgblzBci+V3D9/jO/yh85tLEfXsGgFrHIKU/VpNI/WnIQYudbIP1dBusvTvkTS7/v
         DhpnhFHNcjfd6dCGp4BA0zx4I3K4WP28jIoRgsyZuHKlfmz4oXEa20sivoGxCQdhzexH
         ToFjAnFf780KtW6Xt+IhdH1/z1JAh++pfrDbahv3zrbtVIkn1EBDzezM8dXAj1wA7mZa
         EBkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OGe4Lv8+OvhJqGOX5uhfjHiOWH0zKVvhD/cyvco+4cScE5MLzIkchWaQe+vjOS07gJbYKKksbiw2uOKlU@vger.kernel.org
X-Gm-Message-State: AOJu0YzTazY56nvx+hx6v17jGX0XZN8hnd7ijVEoog6FWTKWg6ympP3b
	oTfpfJrxIVElRZI1stY+Gvpxy63ms89adRPr23Z0YHAyolhhQZaFinz8L9zHBg==
X-Gm-Gg: AfdE7clilMMfX1qwjNE/aHw9mSjVdlcsWqcEVOaKw4TOWWFQkYLygwBG4+S2PlcB1Is
	ts2nvk9bkrXqS2IGs72ZD9uX4I4hTfq3uUAC2DhGemkXvWqEGZNE9PuWSkQN4lu1gALkAGNoVtR
	RUdw4P/8+qk/lroW0t7vNXNF+OUOIAWg7qP3od8ndSd2YDCuCcAG2uWTdN8LlXV62Z4dvYgEuQC
	8PQmixoUcY3IBxj58z2I9xmrkh8bDFTj8eyx6frLhVh1w/BAQiFkmOrHEu4z5c7nc5o3IN9Od7r
	r7fHvGnIFCvji8IxNQ/AFrzxcrilbWaufXZvJiUuMefmlTv0pDsLeAI5o/XtRoDq5lygftAGywJ
	0OLD6mau/+LBQLo4DtFgLkv+SyGY9Ft0gAMwkD6zVoABnRUrRqmplhBmxpOVSewDHt+5lC2UrXp
	z4qW/wQH2grdmRdJ929OF5D7cWdpPgUUjnsKnO+pRvp0n3g/AX4kc=
X-Received: by 2002:a05:6808:c3e9:b0:49b:dcb8:e2b5 with SMTP id 5614622812f47-4a2031a6787mr416421b6e.19.1783477124787;
        Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:11 -0600
Subject: [PATCH v6 11/24] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-11-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=x84mdEzo7hGPjR/NYVWAEdiwl+S1LrXalF/kCz4ObuI=;
 b=TVncpAifs+aOm9EOV2um20M9XK9Z1sHPPRKEV6GBYmmZOlkbuXaoVE3Tmhtle2n/KiIbg4PGk
 /LU+iPNi0+RChSjgg5OL9l/UjA4Som2XihR5K5pxfUf7olt/oz10Exq
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cd6b6c710ee2..efe12fac6363 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -554,7 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 

-- 
2.55.0

